' TEST_MODE : COMPILE_ONLY_FAIL

'' string literals are VARs, but while references can't point to literals,
'' this shouldn't be allowed either
dim byref i as string = "abc"
