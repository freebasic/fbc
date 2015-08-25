#pragma once

'' FB does not have a built-in data type corresponding to C's long double,
'' so this provides the extra declarations for use by bindings.
#ifdef __FB_64BIT__
	'' GCC x86_64 & aarch64: sizeof(long double) = 16
	type clongdouble
		__(0 to 16-1) as ubyte
	end type
	#assert sizeof( clongdouble ) = 16
#elseif defined( __FB_ARM__ )
	'' GCC arm: sizeof(long double) = 8
	type clongdouble
		__(0 to 8-1) as ubyte
	end type
	#assert sizeof( clongdouble ) = 8
#else
	'' GCC x86: sizeof(long double) = 12
	type clongdouble
		__(0 to 12-1) as ubyte
	end type
	#assert sizeof( clongdouble ) = 12
#endif
