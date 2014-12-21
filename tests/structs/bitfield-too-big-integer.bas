' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	#ifdef __FB_64BIT__
		a : 65 as integer
	#else
		a : 33 as integer
	#endif
end type
