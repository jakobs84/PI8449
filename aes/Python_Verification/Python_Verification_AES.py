#!/usr/bin/env python3

# Ten skrypt jest demonstracją szyfrowania danych przy użyciu algorytmu AES-128 w trybie ECB.

# pip install pycryptodome
from Crypto.Cipher import AES

# Dane wejściowe (w formacie hex)
key_hex = "000102030405060708090a0b0c0d0e0f"
text_hex = "abbd76827348723486cceffeeaaabb97"

# Konwersja danych z hex na bajty
key = bytes.fromhex(key_hex)
plaintext = bytes.fromhex(text_hex)

# Inicjalizacja szyfru AES w trybie ECB dla szyfrowania
cipher_encrypt = AES.new(key, AES.MODE_ECB)

# Szyfrowanie
ciphertext = cipher_encrypt.encrypt(plaintext)
ciphertext_hex = ciphertext.hex()

# Inicjalizacja szyfru AES w trybie ECB dla deszyfrowania
cipher_decrypt = AES.new(key, AES.MODE_ECB)

# Deszyfrowanie
decrypted_text = cipher_decrypt.decrypt(ciphertext)
decrypted_text_hex = decrypted_text.hex()

# Wyświetlanie wyników
print("Text         (hex):", text_hex)
print("Key          (hex):", key_hex)
print("Ciphertext   (hex):", ciphertext_hex)
print("Decrypted    (hex):", decrypted_text_hex)