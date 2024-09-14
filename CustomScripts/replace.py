import sys
import os

filename = sys.argv[1]
abs_path = os.path.abspath(filename)

# Define the text to be replaced and the new text
old_text = sys.argv[2]
new_text = sys.argv[3]

# Read the contents of the file
with open(abs_path, 'r') as file:
    print (abs_path)
    content = file.read()

# Replace the text
content = content.replace(old_text, new_text)

# Write the modified content back to the file
with open(abs_path, 'w') as file:
    file.write(content)
