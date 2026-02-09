import requests
import json

# 1. Configuration
# Ensure this matches your platform (e.g., qg2, qg3, etc.)
BASE_URL = "https://qualysapi.qg2.apps.qualys.com" 
USERNAME = "<Enter your username>"
PASSWORD = "<Enter your passwd>"

def get_qualys_session():
    # CORRECTED: The endpoint must be /fo/session/ for login actions
    login_url = f"{BASE_URL}/api/2.0/fo/session/"

    headers = {
        "X-Requested-With": "Python Session Script"
    }

    # Payload for the POST request
    # NOTE: 'requests' automatically URL-encodes these values for you
    payload = {
        "action": "login",
        "username": USERNAME,
        "password": PASSWORD
    }

    try:
        print(f"--- Sending Request to {login_url} ---")
        response = requests.post(login_url, headers=headers, data=payload)

        # 1. Print Status Code
        print(f"\n[Status Code]: {response.status_code}")

        # 2. Print All Response Headers
        print("\n[Response Headers]:")
        for key, value in response.headers.items():
            print(f"  {key}: {value}")

        # 3. Print All Cookies
        print("\n[Cookies Received]:")
        for cookie in response.cookies:
            print(f"  {cookie.name}: {cookie.value}")

        # 4. Print Response Body (Raw Text)
        print("\n[Response Body]:")
        print(response.text)

        # Logical Check for Success
        if response.status_code == 200:
            session_cookie = response.cookies.get("QualysSession")
            if session_cookie:
                print("\nResult: Login Successful!")
                return session_cookie
            else:
                print("\nResult: Login status 200 but QualysSession cookie missing.")
        else:
            print(f"\nResult: Login Failed with status {response.status_code}")

    except Exception as e:
        print(f"\nAn error occurred: {e}")

if __name__ == "__main__":
    cookie = get_qualys_session()
