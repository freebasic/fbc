' TEST_MODE : COMPILE_ONLY_FAIL

#ifdef __FB_64BIT__
	#error "32bit-only test"
#endif

declare sub f overload( byval as integer ptr )
declare sub f overload( byval as any ptr )

dim as long ptr p
f( p )
