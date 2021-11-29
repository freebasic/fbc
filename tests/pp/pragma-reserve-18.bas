' TEST_MODE : COMPILE_ONLY_FAIL

#pragma reserve (extern,asm) symbol

'' duplicate definition error
#pragma reserve (asm) symbol
