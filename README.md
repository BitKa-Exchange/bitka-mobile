

# Bitka - Project Setup Guide

This guide explains how to run the Bitka Flutter application alongside its local mock backend.

## 📂 Directory Structure

  * **`lib/`**: Contains the Flutter application code.
  * **`bitka-mock-backend/`**: Contains the local server scripts acting as the mock database and API.

-----

## ⚡ Quick Start

You must start the **Mock Backend** first, so the Flutter app has an API to connect to.

### 1\. Start the Mock Backend

The backend runs locally to simulate authentication, wallet transactions, and market data.

1.  Open a terminal and navigate to the backend folder:

    ```bash
    cd bitka-mock-backend
    ```

2.  **Set up and Run:**

      * **Windows:**

        ```powershell
        python -m venv venv
        .\venv\Scripts\activate
        pip install -r requirements.txt
        uvicorn main:app --port 8000 --reload
        ```

      * **macOS / Linux:**

        ```bash
        python3 -m venv venv
        source venv/bin/activate
        pip install -r requirements.txt
        uvicorn main:app --port 8000 --reload
        ```

    > *The server is now running at `http://127.0.0.1:8000`.*

-----

### 2\. Configure & Run the Flutter App

1.  Open a **new** terminal window and navigate to the project root.

2.  **Install Dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Configure Connection (`.env`):**
    Create a file named `.env.development` in the root directory. Add the `BASE_URL` variable corresponding to your device:

      * **For Android Emulator:**

        ```text
        BASE_URL=http://10.0.2.2:8000
        ```

        *(Note: `10.0.2.2` is the special alias for the host's localhost in Android Studio).*

      * **For iOS Simulator:**

        ```text
        BASE_URL=http://127.0.0.1:8000
        ```

      * **For Physical Devices:**

        ```text
        BASE_URL=http://YOUR_PC_IP_ADDRESS:8000
        ```

        *(Replace `YOUR_PC_IP_ADDRESS` with your computer's local IP, e.g., `192.168.1.50`).*

4.  **Run the App:**

    ```bash
    flutter run
    ```

-----

## 🔑 Test Credentials

The mock database is pre-filled with this user for testing:

  * **Email:** `abc@gmail.com`
  * **Password:** `123456`

-----

## ⚠️ Common Issues

  * **Connection Refused / Network Error:**
      * Verify the backend terminal is still running.
      * Double-check your `.env.development` file. If you are on Android, you **cannot** use `localhost` or `127.0.0.1`; you must use `10.0.2.2`.
  * **Changes not reflecting:**
      * If you edit the `.env` file, perform a full restart of the app (stop and run `flutter run` again), as Hot Restart does not reload environment variables.