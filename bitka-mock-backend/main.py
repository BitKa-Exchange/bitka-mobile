from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import auth
import ledger
import market_data
import orders
import users

app = FastAPI(
    title="Bitka API",
    version="1.0.0",
    description="Complete Trading Platform API"
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include all routers
app.include_router(auth.router)
app.include_router(ledger.router)
app.include_router(market_data.router)
app.include_router(orders.router)
app.include_router(users.router)

@app.get("/")
async def root():
    return {
        "success": True,
        "message": "Bitka API is running",
        "version": "1.0.0",
        "endpoints": {
            "auth": "/auth",
            "ledger": "/ledger",
            "market_data": "/marketdata",
            "orders": "/orders",
            "users": "/users"
        }
    }

@app.get("/health")
async def health_check():
    return {
        "success": True,
        "status": "healthy"
    }