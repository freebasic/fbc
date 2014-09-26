' TEST_MODE : COMPILE_ONLY_OK

'' a is a dynamic array, but b shouldn't be
dim as integer a(), b(0 to 1)

redim a(0 to 1)
