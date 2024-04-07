' TEST_MODE : COMPILE_ONLY_FAIL

#pragma reserve (asm,extern) symbol

'' duplicate definition error
#pragma reserve (extern) symbol
