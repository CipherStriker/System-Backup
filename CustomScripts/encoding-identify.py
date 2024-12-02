import base64
import binascii
import re
import string

def is_base16(s):
    try:
        base64.b16decode(s, casefold=True)
        return True
    except binascii.Error:
        return False

def is_base32(s):
    try:
        base64.b32decode(s, casefold=True)
        return True
    except binascii.Error:
        return False

def is_base64(s):
    try:
        base64.b64decode(s, validate=True)
        return True
    except binascii.Error:
        return False

def is_base58(s):
    base58_alphabet = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
    return all(c in base58_alphabet for c in s)

def is_base62(s):
    base62_alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    return all(c in base62_alphabet for c in s)

def is_base85(s):
    try:
        base64.b85decode(s)
        return True
    except binascii.Error:
        return False

def is_base91(s):
    base91_alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
    return all(c in base91_alphabet for c in s)

def is_base64url(s):
    base64url_alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"
    try:
        s += '=' * (4 - len(s) % 4)  # Add padding if necessary
        base64.urlsafe_b64decode(s)
        return all(c in base64url_alphabet or c == '=' for c in s)
    except binascii.Error:
        return False

def is_rot_n(s, n, charset):
    return all(c in charset or c.isspace() for c in s)

def is_rot13(s):
    return is_rot_n(s, 13, string.ascii_letters)

def is_rot5(s):
    return is_rot_n(s, 5, string.digits)

def is_rot18(s):
    return is_rot13(s) and is_rot5(s)

def is_rot47(s):
    rot47_charset = "".join(chr(i) for i in range(33, 127))
    return is_rot_n(s, 47, rot47_charset)

def identify_encoding(s):
    if is_base16(s):
        return "Base16 (Hexadecimal)"
    elif is_base32(s):
        return "Base32"
    elif is_base64(s):
        return "Base64"
    elif is_base58(s):
        return "Base58"
    elif is_base62(s):
        return "Base62"
    elif is_base85(s):
        return "Base85 (Ascii85)"
    elif is_base91(s):
        return "Base91"
    elif is_base64url(s):
        return "Base64URL"
    elif is_rot13(s):
        return "ROT13"
    elif is_rot5(s):
        return "ROT5"
    elif is_rot18(s):
        return "ROT18"
    elif is_rot47(s):
        return "ROT47"
    else:
        return "Unknown encoding"

if __name__ == "__main__":
    user_input = input("Enter the string to identify its encoding: ")
    encoding = identify_encoding(user_input)
    print(f"The encoding of the input string is: {encoding}")
