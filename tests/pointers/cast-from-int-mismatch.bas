' TEST_MODE : COMPILE_ONLY_FAIL

#ifdef __FB_64BIT__
	dim as long l
	print cast( any ptr, l )
#else
	dim as longint ll
	print cast( any ptr, ll )
#endif
