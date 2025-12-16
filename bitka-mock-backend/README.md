

# Bitka API: Complete Trading Platform

A complete trading platform API built with FastAPI, providing services for authentication, ledger management, market data, order handling, and user management.

## 🚀 Features

* **Authentication (`auth.py`)**: JWT-based authentication with endpoints for login, registration, token refresh, and logout.
* **Ledger (`ledger.py`)**: Account and transaction management endpoints (debit, credit, transfer) with support for idempotency.
* **Market Data (`market_data.py`)**: Endpoints for retrieving symbol lists, OHLCV candles, trade ticks, and orderbook snapshots.
* **Orders (`orders.py`)**: Functionality to create, list, retrieve, and cancel trading orders (market and limit).
* **Users (`users.py`)**: Endpoints for fetching and updating user profiles, as well as changing passwords.
* **Core (`main.py`)**: Initializes the FastAPI application and includes all defined routers with CORS enabled.

## ⚙️ Installation

The API requires Python 3.8+ and the dependencies listed in `requirements.txt`.

### 1. Clone the Repository

```bash
git clone <repository_url>
cd <repository_name>

### 2\. Install Dependencies

You will need to set up a Python virtual environment and install the required packages.

#### 🪟 Windows (Command Prompt/PowerShell)

```powershell
# Create a virtual environment
python -m venv venv

# Activate the virtual environment
.\venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

#### 🐧 Linux/macOS (Terminal)

```bash
# Create a virtual environment
python3 -m venv venv

# Activate the virtual environment
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

-----

## ▶️ Running the API

Use `uvicorn` to serve the application, which is configured for development with hot-reloading.

### 🪟 Windows (Command Prompt/PowerShell)

Ensure your virtual environment is activated (`.\venv\Scripts\activate`).

```powershell
uvicorn main:app --port 8000 --reload
```

#### 🐧 Linux/macOS (Terminal)

Ensure your virtual environment is activated (`source venv/bin/activate`).

```bash
uvicorn main:app --port 8000 --reload
```

-----

## 🌐 API Endpoints

Once running, the API will be available at `http://127.0.0.1:8000`.

  * **Health Check**: `GET /health`
  * **Root**: `GET /`
  * **Interactive Docs (Swagger UI)**: `http://127.0.0.1:8000/docs`
  * **ReDoc**: `http://127.0.0.1:8000/redoc`

### Key Endpoint Groups

| Module | Base Path | Description | Example Endpoint |
| :--- | :--- | :--- | :--- |
| `auth.py` | `/v1/auth` | User authentication and token management. | `POST /v1/auth/login` |
| `ledger.py` | `/v1/ledger` | Account and transaction operations. | `POST /v1/ledger/transactions` |
| `market_data.py` | `/v1/marketdata` | Public and authenticated market data retrieval. | `GET /v1/marketdata/candles` |
| `orders.py` | `/v1/orders` | Trading order creation and retrieval. | `POST /v1/orders` |
| `users.py` | `/v1/users` | User profile management. | `GET /v1/users/me` |

-----

## 🛠️ Technology Stack

  * **Framework**: FastAPI
  * **ASGI Server**: Uvicorn
  * **Security**: PyJWT
  * **Validation**: Pydantic, email-validator

-----

## 📝 Mock Data and Security Note

This repository uses **mock databases** (`mock_users_db`, `mock_orders`, `mock_accounts`, etc.) and a placeholder JWT secret (`SECRET_KEY = "mock_secret_key_change_in_production"`).

**This code is for demonstration and development purposes only and is NOT production-ready.** For a production environment, you must:

1.  Replace mock databases with a persistent, secure database.
2.  Change `SECRET_KEY` to a strong, securely stored environment variable.
3.  Implement proper password hashing (e.g., using `passlib` or similar) instead of plaintext passwords.

<!-- end list -->

```

Would you like me to generate a new file named `install.bat` for the Windows installation instructions?
```