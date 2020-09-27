#ifndef __FBC_INT_MATH_BI__ 
#define __FBC_INT_MATH_BI__

# if __FB_LANG__ = "qb"
# error not supported in qb dialect
# endif

'' DISCLAIMER!!!
''
''   1) this header documents runtime library internals and is subject to change without notice
''

'' declarations must follow ./src/rtlib/fb_math.h
''                          ./src/rtlib/fb_rnd.c

'' move built-ins out of the global namespace
#undef rnd
#undef randomize

#if defined( __FB_CYGWIN__) or defined(__FB_WIN32__)
#inclib "advapi32"
#endif

namespace FBC

enum FB_RND_ALGORITHMS
	FB_RND_AUTO
	FB_RND_CRT
	FB_RND_FAST
	FB_RND_MTWIST
	FB_RND_QB
	FB_RND_REAL
end enum

type FB_RNDINTERNALS
	dim algorithm as ulong           '' algorithm number see FB_RND_ALGORITHMS
	dim length as ulong              '' length of Mersennse Twister states in (number of ulongs)
	dim stateblock as ulong ptr      '' Mersenne Twister state (pointer array)
	dim stateindex as ulong ptr ptr  '' Mersenne Twister current index
	dim iseed as ulong ptr           '' Current state for FB_RND_FAST & FB_RND_QB

	'' function pointer for internal proc called by fb_Rnd()
	dim rndproc as function cdecl ( byval n as single = 1.0 ) as double

	'' function pointer for internal proc called by fb_Rnd32()
	dim rndproc32 as function cdecl ( ) as ulong
end type

extern "rtlib"

	declare sub randomize alias "fb_Randomize" ( byval seed as double = -1.0, byval algorithm as long = FB_RND_AUTO )
	declare function rnd alias "fb_Rnd" ( byval n as single = 1.0 ) as double
	declare function rnd32 alias "fb_Rnd32" ( ) as ulong

	declare sub rndGetInternals alias "fb_RndGetInternals" ( byval info as FB_RNDINTERNALS ptr )

	#if __FB_MT__

	declare sub mathLock alias "fb_MathLock" ()
	declare sub mathUnlock alias "fb_MathUnlock" ()

	#endif

end extern

end namespace

#endif
