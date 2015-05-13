' TEST_MODE : COMPILE_ONLY_FAIL

dim as any ptr p
#ifdef __FB_64BIT__
	print clng( p )
#else
	print clngint( p )
#endif
