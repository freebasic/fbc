' TEST_MODE : COMPILE_ONLY_OK

'' a is a dynamic array, but b shouldn't be. If b was made dynamic, this wouldn't compile.
extern as integer a(), b(0 to 1)
