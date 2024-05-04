from Crypto.Cipher import AES

# Dane wejściowe (w formacie hex)
key_hex = "000102030405060708090a0b0c0d0e0f"
text_hex = "abbd76827348723486cceffeeaaabb97"

# Konwersja danych z hex na bajty
key = bytes.fromhex(key_hex)
plaintext = bytes.fromhex(text_hex)

# AES w trybie ECB (bez IV)
cipher = AES.new(key, AES.MODE_ECB)

# Szyfrowanie
ciphertext = cipher.encrypt(plaintext)

# Konwersja zaszyfrowanego tekstu na format hex
ciphertext_hex = ciphertext.hex()
print("Ciphertext (hex):", ciphertext_hex)
