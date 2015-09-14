' TEST_MODE : COMPILE_ONLY_FAIL

'' string literals are ZSTRING VARs, not compatible with STRINGs
dim byref i as string = "abc"
