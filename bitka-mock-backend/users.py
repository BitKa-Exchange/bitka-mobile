from fastapi import APIRouter, HTTPException, Header
from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime
from auth import get_current_user, mock_users_db

router = APIRouter(prefix="/v1/users", tags=["Users"])

# Models
class UserProfile(BaseModel):
    user_id: str
    email: str
    name: Optional[str]
    created_at: str
    updated_at: str

class UpdateProfileRequest(BaseModel):
    name: Optional[str] = None
    email: Optional[EmailStr] = None

class ChangePasswordRequest(BaseModel):
    old_password: str
    new_password: str

# Endpoints
@router.get("/me")
async def get_current_user_profile(
    authorization: Optional[str] = Header(None)
):
    """Get current user profile"""
    user_id = get_current_user(authorization)
    
    # Find user
    for email, user in mock_users_db.items():
        if user["id"] == user_id:
            return {
                "success": True,
                "data": {
                    "user_id": user["id"],
                    "email": user["email"],
                    "name": user.get("name"),
                    "created_at": user.get("created_at", datetime.utcnow().isoformat()),
                    "updated_at": user.get("updated_at", datetime.utcnow().isoformat())
                }
            }
    
    raise HTTPException(status_code=404, detail="User not found")

@router.patch("/me")
async def update_current_user_profile(
    request: UpdateProfileRequest,
    authorization: Optional[str] = Header(None)
):
    """Update current user profile"""
    user_id = get_current_user(authorization)
    
    # Find and update user
    for email, user in mock_users_db.items():
        if user["id"] == user_id:
            if request.name:
                user["name"] = request.name
            if request.email:
                user["email"] = request.email
            user["updated_at"] = datetime.utcnow().isoformat()
            
            return {
                "success": True,
                "data": {
                    "message": "Profile updated successfully"
                }
            }
    
    raise HTTPException(status_code=404, detail="User not found")

@router.get("/{id}")
async def get_user_profile(
    id: str,
    authorization: Optional[str] = Header(None)
):
    """Get user profile by ID"""
    get_current_user(authorization)
    
    for email, user in mock_users_db.items():
        if user["id"] == id:
            return {
                "success": True,
                "data": {
                    "user_id": user["id"],
                    "email": user["email"],
                    "name": user.get("name"),
                    "created_at": user.get("created_at", datetime.utcnow().isoformat()),
                    "updated_at": user.get("updated_at", datetime.utcnow().isoformat())
                }
            }
    
    raise HTTPException(status_code=404, detail="User not found")

@router.post("/me/change-password")
async def change_password(
    request: ChangePasswordRequest,
    authorization: Optional[str] = Header(None)
):
    """Change password"""
    user_id = get_current_user(authorization)
    
    # Find user
    for email, user in mock_users_db.items():
        if user["id"] == user_id:
            if user["password"] != request.old_password:
                raise HTTPException(status_code=401, detail="Invalid old password")
            
            user["password"] = request.new_password
            user["updated_at"] = datetime.utcnow().isoformat()
            
            return {
                "success": True,
                "data": None,
                "message": "Password changed successfully"
            }
    
    raise HTTPException(status_code=404, detail="User not found")
