' TEST_MODE : COMPILE_ONLY_FAIL

#ifdef __FB_64BIT__
	'' FB_ARRAYDIM_UNKNOWN = &h80000000000000 currently, so for 64bit where
	'' array subscripts are 64bit, it must be disallowed or else it'd be
	'' confused with '...' being given.
	dim shared array(&h80000000000000 to &h80000000000000) as integer
#else
	foo bar baz
#endif
