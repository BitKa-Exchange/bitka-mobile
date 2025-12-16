from fastapi import APIRouter, HTTPException, Header, Query
from pydantic import BaseModel
from typing import Optional, List, Literal
from datetime import datetime
import uuid
from auth import get_current_user

router = APIRouter(prefix="/v1/orders", tags=["Orders"])

# Mock database
mock_orders = {}

# Models
class CreateOrderRequest(BaseModel):
    symbol: str
    side: Literal["buy", "sell"]
    order_type: Literal["market", "limit"]
    quantity: str
    price: Optional[str] = None
    time_in_force: Optional[str] = "GTC"

class CreateOrderResponse(BaseModel):
    order_id: str
    status: str

class Order(BaseModel):
    order_id: str
    user_id: str
    symbol: str
    side: str
    order_type: str
    quantity: str
    price: Optional[str]
    filled_quantity: str
    status: str
    time_in_force: str
    created_at: str
    updated_at: str

class OrderList(BaseModel):
    orders: List[Order]
    pagination: dict

class CancelOrderRequest(BaseModel):
    reason: Optional[str] = None

class CancelOrderResponse(BaseModel):
    order_id: str
    status: str

# Endpoints
@router.post("", status_code=201)
async def create_order(
    request: CreateOrderRequest,
    authorization: Optional[str] = Header(None),
    idempotency_key: Optional[str] = Header(None, alias="Idempotency-Key")
):
    """Create order"""
    user_id = get_current_user(authorization)
    
    # Check idempotency
    if idempotency_key:
        for order in mock_orders.values():
            if order.get("idempotency_key") == idempotency_key:
                return {
                    "success": True,
                    "data": {
                        "order_id": order["order_id"],
                        "status": order["status"]
                    }
                }
    
    # Validate
    if request.order_type == "limit" and not request.price:
        raise HTTPException(status_code=400, detail="Price required for limit orders")
    
    # Create order
    order_id = str(uuid.uuid4())
    now = datetime.utcnow().isoformat()
    
    order = {
        "order_id": order_id,
        "user_id": user_id,
        "symbol": request.symbol,
        "side": request.side,
        "order_type": request.order_type,
        "quantity": request.quantity,
        "price": request.price,
        "filled_quantity": "0",
        "status": "pending",
        "time_in_force": request.time_in_force,
        "created_at": now,
        "updated_at": now,
        "idempotency_key": idempotency_key
    }
    
    mock_orders[order_id] = order
    
    return {
        "success": True,
        "data": {
            "order_id": order_id,
            "status": "pending"
        }
    }

@router.get("")
async def list_orders(
    authorization: Optional[str] = Header(None),
    page: int = Query(1, ge=1),
    per_page: int = Query(25, ge=1, le=100),
    symbol: Optional[str] = None,
    status: Optional[str] = None,
    user_id: Optional[str] = None
):
    """List orders"""
    current_user = get_current_user(authorization)
    
    orders = []
    for order in mock_orders.values():
        if symbol and order["symbol"] != symbol:
            continue
        if status and order["status"] != status:
            continue
        if user_id and order["user_id"] != user_id:
            continue
        orders.append(order)
    
    start = (page - 1) * per_page
    end = start + per_page
    
    return {
        "success": True,
        "data": {
            "orders": orders[start:end],
            "pagination": {
                "page": page,
                "per_page": per_page,
                "total": len(orders),
                "pages": (len(orders) + per_page - 1) // per_page
            }
        }
    }

@router.get("/{order_id}")
async def get_order(
    order_id: str,
    authorization: Optional[str] = Header(None)
):
    """Get order by id"""
    get_current_user(authorization)
    
    if order_id not in mock_orders:
        raise HTTPException(status_code=404, detail="Order not found")
    
    return {
        "success": True,
        "data": mock_orders[order_id]
    }

@router.delete("/{order_id}")
async def cancel_order(
    order_id: str,
    authorization: Optional[str] = Header(None),
    idempotency_key: Optional[str] = Header(None, alias="Idempotency-Key"),
    request: Optional[CancelOrderRequest] = None
):
    """Cancel order"""
    get_current_user(authorization)
    
    if order_id not in mock_orders:
        raise HTTPException(status_code=404, detail="Order not found")
    
    order = mock_orders[order_id]
    
    if order["status"] in ["filled", "cancelled"]:
        return {
            "success": True,
            "data": {
                "order_id": order_id,
                "status": order["status"]
            }
        }
    
    order["status"] = "cancelled"
    order["updated_at"] = datetime.utcnow().isoformat()
    
    return {
        "success": True,
        "data": {
            "order_id": order_id,
            "status": "cancelled"
        }
    }