' TEST_MODE : COMPILE_ONLY_FAIL

dim shared i as integer
#ifdef __FB_64BIT__
	dim shared a as long = @i
#else
	dim shared a as longint = @i
#endif
