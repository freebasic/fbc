' TEST_MODE : COMPILE_ONLY_FAIL

#ifndef __FB_64BIT__
	#error "64bit-only test"
#endif

declare sub f overload( byval as integer ptr )
declare sub f overload( byval as any ptr )

dim as longint ptr p
f( p )
