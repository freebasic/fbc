#pragma once

#if defined( __FB_64BIT__ ) and (not defined( __FB_WIN32__))
	'' On 64bit Linux/BSD systems (but not 64bit Windows), C's long is
	'' 64bit like FB's integer.
	'' Note: Using 64bit Integer here instead of LongInt, to match fbc's
	'' mangling: on 64bit Linux/BSD, Integer is mangled to C's long.
	type clong as integer
	type culong as uinteger
#else
	'' On 32bit systems and 64bit Windows, C's long is 32bit like FB's long.
	'' Note: Using 32bit Long here instead of 32bit/64bit Integer, because
	'' this is also used for 64bit Windows where Integer isn't 32bit.
	type clong as long
	type culong as ulong
#endif
