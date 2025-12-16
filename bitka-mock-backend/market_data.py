from fastapi import APIRouter, HTTPException, Header, Query
from pydantic import BaseModel
from typing import Optional, List
from datetime import datetime, timedelta
import uuid
from auth import get_current_user
import random

router = APIRouter(prefix="/v1/marketdata", tags=["MarketData"])

# Mock data
mock_symbols = {
    "BTC-THB": {"symbol": "BTC-THB", "base": "BTC", "quote": "THB", "active": True},
    "ETH-THB": {"symbol": "ETH-THB", "base": "ETH", "quote": "THB", "active": True},
    "BTC-USDT": {"symbol": "BTC-USDT", "base": "BTC", "quote": "USDT", "active": True},
}

# Models
class Symbol(BaseModel):
    symbol: str
    base: str
    quote: str
    active: bool

class SymbolList(BaseModel):
    symbols: List[Symbol]
    pagination: dict

class Candle(BaseModel):
    timestamp: str
    open: str
    high: str
    low: str
    close: str
    volume: str

class CandleSeries(BaseModel):
    symbol: str
    interval: str
    candles: List[Candle]

class Tick(BaseModel):
    timestamp: str
    price: str
    quantity: str
    side: str

class TickList(BaseModel):
    symbol: str
    ticks: List[Tick]

class OrderbookLevel(BaseModel):
    price: str
    quantity: str

class OrderbookSnapshot(BaseModel):
    symbol: str
    timestamp: str
    bids: List[OrderbookLevel]
    asks: List[OrderbookLevel]

class OrderbookUpdate(BaseModel):
    symbol: str
    timestamp: str
    side: str
    price: str
    quantity: str

# Endpoints
@router.get("/symbols")
async def list_symbols(
    authorization: Optional[str] = Header(None),
    page: int = Query(1, ge=1),
    per_page: int = Query(50, ge=1, le=100),
    active: Optional[bool] = None
):
    """List available symbols"""
    get_current_user(authorization)
    
    symbols = list(mock_symbols.values())
    if active is not None:
        symbols = [s for s in symbols if s["active"] == active]
    
    start = (page - 1) * per_page
    end = start + per_page
    
    return {
        "success": True,
        "data": {
            "symbols": symbols[start:end],
            "pagination": {
                "page": page,
                "per_page": per_page,
                "total": len(symbols),
                "pages": (len(symbols) + per_page - 1) // per_page
            }
        }
    }

@router.get("/candles")
async def get_candles(
    authorization: Optional[str] = Header(None),
    symbol: str = Query(...),
    interval: str = Query(...),
    start: Optional[str] = None,
    end: Optional[str] = None,
    limit: int = Query(100, ge=1, le=1000)
):
    """Get candles (OHLCV)"""
    get_current_user(authorization)
    
    if symbol not in mock_symbols:
        raise HTTPException(status_code=404, detail="Symbol not found")
    
    # Generate mock candles
    candles = []
    base_price = 1000000 if "BTC" in symbol else 50000
    now = datetime.utcnow()
    
    for i in range(limit):
        timestamp = (now - timedelta(minutes=i)).isoformat()
        price = base_price + random.uniform(-1000, 1000)
        candles.append(Candle(
            timestamp=timestamp,
            open=f"{price:.2f}",
            high=f"{price + random.uniform(0, 500):.2f}",
            low=f"{price - random.uniform(0, 500):.2f}",
            close=f"{price + random.uniform(-200, 200):.2f}",
            volume=f"{random.uniform(1, 100):.4f}"
        ))
    
    return {
        "success": True,
        "data": {
            "symbol": symbol,
            "interval": interval,
            "candles": candles
        }
    }

@router.get("/ticks")
async def get_ticks(
    authorization: Optional[str] = Header(None),
    symbol: str = Query(...),
    start: Optional[str] = None,
    end: Optional[str] = None,
    limit: int = Query(500, ge=1, le=1000)
):
    """Get trades (ticks)"""
    get_current_user(authorization)
    
    if symbol not in mock_symbols:
        raise HTTPException(status_code=404, detail="Symbol not found")
    
    # Generate mock ticks
    ticks = []
    base_price = 1000000 if "BTC" in symbol else 50000
    now = datetime.utcnow()
    
    for i in range(limit):
        timestamp = (now - timedelta(seconds=i)).isoformat()
        ticks.append(Tick(
            timestamp=timestamp,
            price=f"{base_price + random.uniform(-1000, 1000):.2f}",
            quantity=f"{random.uniform(0.01, 1):.4f}",
            side=random.choice(["buy", "sell"])
        ))
    
    return {
        "success": True,
        "data": {
            "symbol": symbol,
            "ticks": ticks
        }
    }

@router.get("/orderbook/{symbol}")
async def get_orderbook(
    symbol: str,
    authorization: Optional[str] = Header(None),
    depth: int = Query(20, ge=1, le=100)
):
    """Get orderbook snapshot"""
    get_current_user(authorization)
    
    if symbol not in mock_symbols:
        raise HTTPException(status_code=404, detail="Symbol not found")
    
    # Generate mock orderbook
    base_price = 1000000 if "BTC" in symbol else 50000
    bids = []
    asks = []
    
    for i in range(depth):
        bids.append(OrderbookLevel(
            price=f"{base_price - (i * 100):.2f}",
            quantity=f"{random.uniform(0.1, 5):.4f}"
        ))
        asks.append(OrderbookLevel(
            price=f"{base_price + (i * 100):.2f}",
            quantity=f"{random.uniform(0.1, 5):.4f}"
        ))
    
    return {
        "success": True,
        "data": {
            "symbol": symbol,
            "timestamp": datetime.utcnow().isoformat(),
            "bids": bids,
            "asks": asks
        }
    }

@router.get("/orderbook/{symbol}/history")
async def get_orderbook_history(
    symbol: str,
    authorization: Optional[str] = Header(None),
    start: Optional[str] = None,
    end: Optional[str] = None,
    limit: int = Query(100, ge=1, le=1000)
):
    """Get orderbook history"""
    get_current_user(authorization)
    
    if symbol not in mock_symbols:
        raise HTTPException(status_code=404, detail="Symbol not found")
    
    snapshots = []
    updates = []
    
    return {
        "success": True,
        "data": {
            "snapshots": snapshots,
            "updates": updates
        }
    }
