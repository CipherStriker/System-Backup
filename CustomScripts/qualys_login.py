import requests
import sys

# 1. Configuration
# Note: The BASE_URL depends on your Qualys platform (e.g., US Platform 1, EU Platform 2, etc.)
BASE_URL = "https://qualysapi.qg2.apps.qualys.com"  # Replace with your specific platform URL

# Check if arguments were provided
if len(sys.argv) < 3:
    print("Usage: python script.py <username> <password>")
    sys.exit(1)
else:
    USERNAME = sys.argv[1]
    PASSWORD = sys.argv[2]

def get_qualys_session():
    # The endpoint for session management in API v2
    login_url = f"{BASE_URL}/api/2.0/fo/session/"

    # Mandatory Header: Qualys requires the 'X-Requested-With' header for all v2 calls
    headers = {
        "X-Requested-With": "Python Session Script"
    }

    # Payload for the POST request
    payload = {
        "action": "login",
        "username": sys.argv[1],
        "password": sys.argv[2]
    }

    try:
        # Perform the POST request to log in
        response = requests.post(login_url, headers=headers, data=payload)

        # Check if the login was successful (HTTP 200)
        if response.status_code == 200:
            # Extract the 'QualysSession' cookie from the response
            session_cookie = response.cookies.get("QualysSession")

            if session_cookie:
                print("Login Successful!")
                print(f"Session Cookie: {session_cookie}")
                return session_cookie
            else:
                print("Login succeeded but 'QualysSession' cookie was not found.")
        else:
            print(f"Login Failed. Status Code: {response.status_code}")
            print(f"Response: {response.text}")

    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    cookie = get_qualys_session()
