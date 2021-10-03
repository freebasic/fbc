' TEST_MODE : COMPILE_AND_RUN_OK

'' invalid multi-byte sequence
dim as string s1 = chr(&hC4 , &hEE)

'' previously, this would crash in fbc 1.08.1 due to unhandled error
'' of the conversion in the rtlib 
dim as string s2 = lcase(Wstr(s1))  

assert( asc(s2, 1) = 228 )
assert( asc(s2, 2) = 238 )
