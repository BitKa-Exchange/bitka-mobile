from fastapi import APIRouter, HTTPException, Header, Query
from pydantic import BaseModel, Field
from typing import Optional, List, Literal
from datetime import datetime
from decimal import Decimal
import uuid
from auth import get_current_user

router = APIRouter(prefix="/v1/ledger", tags=["Ledger"])

# Mock database
mock_accounts = {}
mock_transactions = {}

# Pydantic Models
class LedgerAccount(BaseModel):
    account_id: str
    user_id: str
    asset: str
    balance: str
    available_balance: str
    held_balance: str
    created_at: str
    updated_at: str

class AccountList(BaseModel):
    accounts: List[LedgerAccount]
    pagination: dict

class TransactionStatus(str):
    PENDING = "pending"
    COMPLETED = "completed"
    FAILED = "failed"
    REVERSED = "reversed"

class LedgerTransaction(BaseModel):
    transaction_id: str
    idempotency_key: Optional[str]
    transaction_type: Literal["debit", "credit", "transfer"]
    from_account_id: Optional[str]
    to_account_id: Optional[str]
    asset: str
    amount: str
    status: str
    description: Optional[str]
    metadata: Optional[dict]
    created_at: str
    updated_at: str

class TransactionList(BaseModel):
    transactions: List[LedgerTransaction]
    pagination: dict

class CreateTransactionRequest(BaseModel):
    transaction_type: Literal["debit", "credit", "transfer"]
    from_account_id: Optional[str] = None
    to_account_id: Optional[str] = None
    asset: str
    amount: str
    description: Optional[str] = None
    metadata: Optional[dict] = None

class CreateTransactionResponse(BaseModel):
    transaction_id: str
    status: str

# Helper functions
def get_or_create_account(user_id: str, asset: str) -> LedgerAccount:
    """Get or create a ledger account for user and asset"""
    account_key = f"{user_id}:{asset}"
    
    if account_key not in mock_accounts:
        account_id = str(uuid.uuid4())
        now = datetime.utcnow().isoformat()
        mock_accounts[account_key] = LedgerAccount(
            account_id=account_id,
            user_id=user_id,
            asset=asset,
            balance="0.00",
            available_balance="0.00",
            held_balance="0.00",
            created_at=now,
            updated_at=now
        )
    
    return mock_accounts[account_key]

def update_balance(account_id: str, amount: Decimal, is_debit: bool):
    """Update account balance"""
    for account in mock_accounts.values():
        if account.account_id == account_id:
            current_balance = Decimal(account.balance)
            if is_debit:
                new_balance = current_balance - amount
                if new_balance < 0:
                    raise HTTPException(status_code=400, detail="Insufficient balance")
            else:
                new_balance = current_balance + amount
            
            account.balance = str(new_balance)
            account.available_balance = str(new_balance)
            account.updated_at = datetime.utcnow().isoformat()
            break

# Endpoints
@router.get("/accounts")
async def list_accounts(
    authorization: Optional[str] = Header(None),
    page: int = Query(1, ge=1),
    per_page: int = Query(25, ge=1, le=100),
    user_id: Optional[str] = None,
    asset: Optional[str] = None
):
    """List ledger accounts"""
    current_user = get_current_user(authorization)
    
    # Filter accounts
    accounts = []
    for account in mock_accounts.values():
        if user_id and account.user_id != user_id:
            continue
        if asset and account.asset != asset:
            continue
        accounts.append(account)
    
    # Pagination
    start = (page - 1) * per_page
    end = start + per_page
    paginated_accounts = accounts[start:end]
    
    return {
        "success": True,
        "data": {
            "accounts": paginated_accounts,
            "pagination": {
                "page": page,
                "per_page": per_page,
                "total": len(accounts),
                "pages": (len(accounts) + per_page - 1) // per_page
            }
        }
    }

@router.get("/accounts/{account_id}")
async def get_account(
    account_id: str,
    authorization: Optional[str] = Header(None)
):
    """Get ledger account by id"""
    current_user = get_current_user(authorization)
    
    for account in mock_accounts.values():
        if account.account_id == account_id:
            return {
                "success": True,
                "data": account
            }
    
    raise HTTPException(status_code=404, detail="Account not found")

@router.get("/transactions")
async def list_transactions(
    authorization: Optional[str] = Header(None),
    page: int = Query(1, ge=1),
    per_page: int = Query(25, ge=1, le=100),
    account_id: Optional[str] = None,
    asset: Optional[str] = None,
    status: Optional[str] = None,
    from_date: Optional[str] = Query(None, alias="from"),
    to_date: Optional[str] = Query(None, alias="to")
):
    """List transactions"""
    current_user = get_current_user(authorization)
    
    # Filter transactions
    transactions = []
    for tx in mock_transactions.values():
        if account_id and tx.from_account_id != account_id and tx.to_account_id != account_id:
            continue
        if asset and tx.asset != asset:
            continue
        if status and tx.status != status:
            continue
        transactions.append(tx)
    
    # Pagination
    start = (page - 1) * per_page
    end = start + per_page
    paginated_transactions = transactions[start:end]
    
    return {
        "success": True,
        "data": {
            "transactions": paginated_transactions,
            "pagination": {
                "page": page,
                "per_page": per_page,
                "total": len(transactions),
                "pages": (len(transactions) + per_page - 1) // per_page
            }
        }
    }

@router.post("/transactions", status_code=201)
async def create_transaction(
    request: CreateTransactionRequest,
    authorization: Optional[str] = Header(None),
    idempotency_key: Optional[str] = Header(None, alias="Idempotency-Key")
):
    """Create a transaction (debit/credit/transfer)"""
    current_user = get_current_user(authorization)
    
    # Check idempotency
    if idempotency_key:
        for tx in mock_transactions.values():
            if tx.idempotency_key == idempotency_key:
                return {
                    "success": True,
                    "data": {
                        "transaction_id": tx.transaction_id,
                        "status": tx.status
                    }
                }
    
    # Validate transaction type
    if request.transaction_type == "debit" and not request.from_account_id:
        raise HTTPException(status_code=400, detail="from_account_id required for debit")
    
    if request.transaction_type == "credit" and not request.to_account_id:
        raise HTTPException(status_code=400, detail="to_account_id required for credit")
    
    if request.transaction_type == "transfer":
        if not request.from_account_id or not request.to_account_id:
            raise HTTPException(status_code=400, detail="Both from_account_id and to_account_id required for transfer")
    
    # Create transaction
    transaction_id = str(uuid.uuid4())
    amount = Decimal(request.amount)
    now = datetime.utcnow().isoformat()
    
    try:
        # Update balances
        if request.transaction_type == "debit":
            update_balance(request.from_account_id, amount, is_debit=True)
        elif request.transaction_type == "credit":
            update_balance(request.to_account_id, amount, is_debit=False)
        elif request.transaction_type == "transfer":
            update_balance(request.from_account_id, amount, is_debit=True)
            update_balance(request.to_account_id, amount, is_debit=False)
        
        status = "completed"
    except Exception as e:
        status = "failed"
    
    transaction = LedgerTransaction(
        transaction_id=transaction_id,
        idempotency_key=idempotency_key,
        transaction_type=request.transaction_type,
        from_account_id=request.from_account_id,
        to_account_id=request.to_account_id,
        asset=request.asset,
        amount=request.amount,
        status=status,
        description=request.description,
        metadata=request.metadata,
        created_at=now,
        updated_at=now
    )
    
    mock_transactions[transaction_id] = transaction
    
    return {
        "success": True,
        "data": {
            "transaction_id": transaction_id,
            "status": status
        }
    }

@router.get("/transactions/{transaction_id}")
async def get_transaction(
    transaction_id: str,
    authorization: Optional[str] = Header(None)
):
    """Get transaction by id"""
    current_user = get_current_user(authorization)
    
    if transaction_id in mock_transactions:
        return {
            "success": True,
            "data": mock_transactions[transaction_id]
        }
    
    raise HTTPException(status_code=404, detail="Transaction not found")