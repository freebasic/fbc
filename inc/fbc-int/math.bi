#ifndef __FBC_INT_MATH_BI__ 
#define __FBC_INT_MATH_BI__

# if __FB_LANG__ = "qb"
# error not supported in qb dialect
# endif

'' fbmath.bi provides definitions for:
'' - FB.FB_RND_ALGORTITMS

#include once "fbmath.bi"

'' DISCLAIMER!!!
''
''   1) this header documents runtime library internals and is subject to change without notice
''

'' declarations must follow ./src/rtlib/fb_math.h
''                          ./src/rtlib/fb_rnd.c

'' Remove RANDOMIZE & RND from the global namespace 
'' otherwise 'using fb' won't work with new declarations
'' in the fb namespace
#if defined( ..RANDOMIZE )
	#undef ..RANDOMIZE
#endif
#if defined( ..RND )
	#undef ..RND
#endif

#if defined( __FB_CYGWIN__) or defined(__FB_WIN32__)
#inclib "advapi32"
#endif

namespace FBC

const FB_RND_MAX_STATE = 624

type FB_RNDSTATE
	dim algorithm as ulong           '' algorithm number see FB_RND_ALGORITHMS
	dim length as ulong              '' length of dynamically allocated state array in bytes

	'' function pointer for internal proc called by fb_Rnd()
	dim rndproc as function cdecl ( byval n as single = 1.0 ) as double

	'' function pointer for internal proc called by fb_Rnd32()
	dim rndproc32 as function cdecl ( ) as ulong

	union
		dim iseed64 as ulongint      '' 64-bit seed / state value (for future use)
		dim iseed32 as ulong         '' seed & current state for FB_RND_FAST & FB_RND_QB
	end union

	dim index32 as ulong ptr     '' FB_RND_MTWIST or FB_RND_REAL pointer index

	'' state vector
	dim state32( FB_RND_MAX_STATE ) as ulong
end type

extern "rtlib"

	'' declare built-in RANDOMIZE, RND, & RND32 in the FB namespace
	declare sub randomize alias "fb_Randomize" ( byval seed as double = -1.0, byval algorithm as long = FB.FB_RND_AUTO )
	declare function rnd alias "fb_Rnd" ( byval n as single = 1.0 ) as double
	declare function rnd32 alias "fb_Rnd32" ( ) as ulong

	'' get a pointer to the internal global state for RND()
	declare function rndGetState alias "fb_RndGetState" ( ) as FB_RNDSTATE ptr

	#if __FB_MT__

	declare sub mathLock alias "fb_MathLock" ()
	declare sub mathUnlock alias "fb_MathUnlock" ()

	#endif

end extern

end namespace

#endif
