decrypted_text = "ENCRYPTIONISFUNPASSWORD"
	  #"************FUN********"
pattern_text = "*****************SSWO**"
count = 0

# Loop through both strings and compare characters at the same position
for i in range(min(len(decrypted_text), len(encrypted_text))):
    if decrypted_text[i] == encrypted_text[i]:
        count += 1

# Check if count exceeds the threshold
if count > 2:
    print(decrypted_text)
    print(encrypted_text)
