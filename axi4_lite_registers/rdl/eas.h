
//Condensed map of encryption and decryption execution


// Addres Key registers
KEY_0       @ 0x0;
KEY_1       @ 0x4;
KEY_2       @ 0x8;
KEY_3       @ 0xC;
// Addres  Input text registers
I_TEXT_0    @ 0x10;
I_TEXT_1    @ 0x14;
I_TEXT_2    @ 0x18;
I_TEXT_3    @ 0x1C;
// Addres  Encrypted text registers
ENCRYPTED_0 @ 0x20;
ENCRYPTED_1 @ 0x24;
ENCRYPTED_2 @ 0x28;
ENCRYPTED_3 @ 0x2C;
// Addres  Decrypted text registers
DECRYPTED_0 @ 0x30;
DECRYPTED_1 @ 0x34;
DECRYPTED_2 @ 0x38;
DECRYPTED_3 @ 0x3C;
SYSTEM_ID   @ 0x40;

   


// Key
000102030405060708090a0b0c0d0e0f

// Text
abbd76827348723486cceffeeaaabb97

// Decrypted
6CD1BB8881F268DECFB4918591D579D2


// **************************
// Section ENCRYPT
// Checking connection with an FPGA
devmem2 0xff200040 w 

//Entering the key to Key registers
devmem2 0xff200000 w 0x0c0d0e0f
devmem2 0xff200004 w 0x08090a0b
devmem2 0xff200008 w 0x04050607
devmem2 0xff20000C w 0x00010203

//Entering the text to Input text registers
devmem2 0xff200010 w 0xeaaabb97
devmem2 0xff200014 w 0x86cceffe
devmem2 0xff200018 w 0x73487234
devmem2 0xff20001C w 0xabbd7682

//Encryption text
devmem2 0xff200020 w 
devmem2 0xff200024 w 
devmem2 0xff200028 w 
devmem2 0xff20002C w 

Read at address  0xFF200020 (0xb6f4d020): 0x91D579D2
Read at address  0xFF200024 (0xb6fae024): 0xCFB49185
Read at address  0xFF200028 (0xb6ff3028): 0x81F268DE
Read at address  0xFF20002C (0xb6fc502c): 0x6CD1BB88


DECRYPT

// **************************
// Section DECRYPT
// Checking connection with an FPGA
devmem2 0xff200040 w 

//Entering the key to Key registers
devmem2 0xff200000 w 0x0c0d0e0f
devmem2 0xff200004 w 0x08090a0b
devmem2 0xff200008 w 0x04050607
devmem2 0xff20000C w 0x00010203


//Entering the decrypted text to Input text registers
devmem2 0xff200010 w 0x91D579D2
devmem2 0xff200014 w 0xCFB49185
devmem2 0xff200018 w 0x81F268DE
devmem2 0xff20001C w 0x6CD1BB88

//Decryption text
devmem2 0xff200030 w 
devmem2 0xff200034 w 
devmem2 0xff200038 w 
devmem2 0xff20003C w 


Read at address  0xFF200030 (0xb6fe9030): 0xEAAABB97
Read at address  0xFF200034 (0xb6f69034): 0x86CCEFFE
Read at address  0xFF200038 (0xb6f72038): 0x73487234
Read at address  0xFF20003C (0xb6f6203c): 0xABBD7682
