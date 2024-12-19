import os


def egcd(a, b):
    x, y, u, v = 0, 1, 1, 0
    while a != 0:
        q, r = b // a, b % a
        m, n = x - u * q, y - v * q
        b, a, x, y, u, v = a, r, u, v, m, n
    gcd = b
    return gcd, x, y


def modinv(a, m):
    gcd, x, y = egcd(a, m)
    if gcd != 1:
        return None
    else:
        return x % m


def affine_encrypt(text, key):
    return "".join(
        [
            chr(((key[0] * (ord(t) - ord("A")) + key[1]) % 26) + ord("A"))
            for t in text.upper().replace(" ", "")
        ]
    )


def affine_decrypt(cipher, key):
    mod_inverse = modinv(key[0], 26)
    if mod_inverse is None:
        return None  # Key[0] and 26 must be coprime
    return "".join(
        [
            chr(((mod_inverse * (ord(c) - ord("A") - key[1])) % 26) + ord("A"))
            for c in cipher
        ]
    )


def main():
    #affine_encrypted_text = "FAJSRWOXLAXDQZAWNDDVLSU"
    #pattern_text = "************FUN********"
    affine_encrypted_text = input("Enter the encrypted text : ")
    pattern_text = input("Enter the pattern text : ")
    
    #print("Trying all possible key combinations:")
    print()

    for a in range(1, 21):  # Loop for key[0]
        for b in range(1, 21):  # Loop for key[1]
            key = (a, b)
            decrypted_text = affine_decrypt(affine_encrypted_text, key)
            if decrypted_text is not None:
                #print(f"Key: {key} -> Decrypted Text: {decrypted_text}")
                # Loop through both strings and compare characters at the same position
                count=0
                for i in range(min(len(decrypted_text), len(pattern_text))):
                    if decrypted_text[i] == pattern_text[i]:
                        count += 1
                        # Check if count exceeds the threshold
                        if count > 2:
                            print(decrypted_text)
                            print(pattern_text)
                            #decrypted_text=""



if __name__ == "__main__":
    main()
