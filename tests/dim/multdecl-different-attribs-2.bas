' TEST_MODE : COMPILE_ONLY_FAIL

'' a is a dynamic array, but b shouldn't be
dim as integer a(), b(0 to 1)

redim b(0 to 1)
