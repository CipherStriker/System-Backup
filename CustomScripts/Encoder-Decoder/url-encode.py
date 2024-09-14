import urllib.parse
import sys

def url_encode(input_string):
    # Use urllib.parse.quote to URL encode the input string
    encoded_string = urllib.parse.quote(input_string)
    return encoded_string

# Example usage
if __name__ == "__main__":
    # Test string with special characters
    test_string = sys.argv[1]
    encoded_result = url_encode(test_string)
    
   # print("Original string:", test_string)
    print("URL encoded string:", encoded_result)
