' TEST_MODE : COMPILE_AND_RUN_OK

'' invalid multi-byte sequence
dim as string s1 = chr(&hC4 , &hEE)

'' previously, this would crash in fbc 1.08.1 on linux due to unhandled error
'' of the conversion in the rtlib 
dim as string s2 = lcase(Wstr(s1))

'' Under the hood, mbstowcs() which is used for the conversion behaves differently
'' on at least linux versus windows. !!!TODO!!! is this locale dependent?

#if defined( __FB_WIN32__ )
	assert( asc(s2, 1) = 228 )
	assert( asc(s2, 2) = 238 )
#else
	assert( asc(s2, 1) = asc("?") )
	assert( asc(s2, 2) = asc("?") )
#endif
