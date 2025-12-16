from fastapi import APIRouter, HTTPException, Header
from pydantic import BaseModel, EmailStr, Field
from typing import Optional
from datetime import datetime, timedelta
import uuid
import jwt

router = APIRouter(prefix="/v1/auth", tags=["Auth"])

# Secret key for JWT (in production, use environment variable)
SECRET_KEY = "mock_secret_key_change_in_production"
ALGORITHM = "HS256"

# Mock database
mock_users_db = {
    "abc@gmail.com": {
        "id": str(uuid.uuid4()),
        "email": "abc@gmail.com",
        "password": "123456",
        "name": "Mock User"
    }
}
mock_refresh_tokens = {}

# Pydantic Models
class LoginRequest(BaseModel):
    email: EmailStr
    password: str

class RegisterRequest(BaseModel):
    email: EmailStr
    password: str = Field(..., min_length=8)
    name: Optional[str] = None

class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    expires_in: int

class RefreshRequest(BaseModel):
    refresh_token: str

# Helper functions
def create_access_token(user_id: str) -> str:
    expire = datetime.utcnow() + timedelta(minutes=15)
    payload = {
        "sub": user_id,
        "exp": expire,
        "type": "access"
    }
    return jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)

def create_refresh_token(user_id: str) -> str:
    expire = datetime.utcnow() + timedelta(days=7)
    token_id = str(uuid.uuid4())
    payload = {
        "sub": user_id,
        "exp": expire,
        "type": "refresh",
        "jti": token_id
    }
    token = jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)
    mock_refresh_tokens[token_id] = {"user_id": user_id, "revoked": False}
    return token

def verify_token(token: str, token_type: str = "access") -> dict:
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        if payload.get("type") != token_type:
            raise HTTPException(status_code=401, detail="Invalid token type")
        return payload
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail="Token has expired")
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401, detail="Invalid token")

def get_current_user(authorization: Optional[str] = Header(None)) -> str:
    """Extract and verify user from Authorization header"""
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Missing or invalid authorization header")
    
    token = authorization.split(" ")[1]
    payload = verify_token(token, "access")
    return payload["sub"]

# Endpoints
@router.post("/login", status_code=200)
async def login(request: LoginRequest):
    """Login endpoint"""
    user = mock_users_db.get(request.email)
    
    if not user or user["password"] != request.password:
        raise HTTPException(
            status_code=401,
            detail={"success": False, "error": {"code": "INVALID_CREDENTIALS"}, "message": "Invalid email or password"}
        )
    
    access_token = create_access_token(user["id"])
    refresh_token = create_refresh_token(user["id"])
    
    return {
        "success": True,
        "data": {
            "access_token": access_token,
            "refresh_token": refresh_token,
            "token_type": "bearer",
            "expires_in": 900
        },
        "message": "Login successful"
    }

@router.post("/register", status_code=201)
async def register(request: RegisterRequest):
    """Registration endpoint"""
    if request.email in mock_users_db:
        raise HTTPException(
            status_code=409,
            detail={"success": False, "error": {"code": "EMAIL_EXISTS"}, "message": "Email already registered"}
        )
    
    user_id = str(uuid.uuid4())
    mock_users_db[request.email] = {
        "id": user_id,
        "email": request.email,
        "password": request.password,
        "name": request.name
    }
    
    return {
        "success": True,
        "data": {
            "user_id": user_id
        },
        "message": "User registered successfully"
    }

@router.post("/refresh", status_code=200)
async def refresh_token(request: RefreshRequest):
    """Refresh token endpoint"""
    try:
        payload = verify_token(request.refresh_token, "refresh")
        token_id = payload.get("jti")
        
        if not token_id or token_id not in mock_refresh_tokens:
            raise HTTPException(status_code=401, detail="Invalid refresh token")
        
        if mock_refresh_tokens[token_id]["revoked"]:
            raise HTTPException(status_code=401, detail="Refresh token has been revoked")
        
        user_id = payload["sub"]
        access_token = create_access_token(user_id)
        new_refresh_token = create_refresh_token(user_id)
        
        mock_refresh_tokens[token_id]["revoked"] = True
        
        return {
            "success": True,
            "data": {
                "access_token": access_token,
                "refresh_token": new_refresh_token,
                "token_type": "bearer",
                "expires_in": 900
            },
            "message": "Token refreshed successfully"
        }
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(
            status_code=401,
            detail={"success": False, "error": {"code": "INVALID_TOKEN"}, "message": str(e)}
        )

@router.post("/logout", status_code=200)
async def logout(authorization: Optional[str] = Header(None)):
    """Logout endpoint"""
    get_current_user(authorization)
    return {
        "success": True,
        "data": None,
        "message": "Logout successful"
    }

@router.get("/.well-known/jwks.json", status_code=200)
async def get_jwks():
    """JWKS endpoint"""
    return {
        "keys": [
            {
                "kty": "RSA",
                "use": "sig",
                "kid": "mock-key-id-1",
                "alg": "RS256",
                "n": "mock_modulus_value",
                "e": "AQAB"
            }
        ]
    }
