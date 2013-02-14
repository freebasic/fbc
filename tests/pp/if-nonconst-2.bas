' TEST_MODE : COMPILE_ONLY_FAIL

dim as integer i

'' non-constant, type mismatch
#if i = "123"
#endif
