' TEST_MODE : COMPILE_ONLY_FAIL

#ifndef __FB_64BIT__
	#error "64bit-only test"
#endif

'' FB_ARRAYDIM_UNKNOWN = &h8000000000000000 currently, so for 64bit where array
'' subscripts are 64bit, it must be disallowed or else it'd be confused with
'' '...' being given.
dim shared array(&h8000000000000000 to &h8000000000000000) as integer
