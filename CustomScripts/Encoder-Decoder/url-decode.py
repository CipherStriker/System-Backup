import urllib.parse
import sys
# Function to decode URL encoded string
def url_decode(url_encoded):
    decoded_string = urllib.parse.unquote(url_encoded)
    return decoded_string

# Example usage
encoded_string = sys.argv[1]
decoded_string = url_decode(encoded_string)
#print("Encoded string:", encoded_string)
print("Decoded string:", decoded_string)
