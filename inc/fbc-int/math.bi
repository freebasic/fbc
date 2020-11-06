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

'' fbmath.bi provides definitions for:
'' - FB.FB_RND_ALGORTITMS
'' - fb.RANDOMIZE
'' - fb.RND
'' - fb.RND32

#include once "fbmath.bi"

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

	'' built-in RANDOMIZE & RND & RND32
	declare sub randomize alias "fb_Randomize" ( byval seed as double = -1.0, byval algorithm as long = FB.FB_RND_AUTO )
	declare function rnd alias "fb_Rnd" ( byval n as single = 1.0 ) as double
	declare function rnd32 alias "fb_Rnd32" ( ) as ulong

	'' get a pointer to the internal global state for RND()
	declare function rndGetState alias "fb_RndGetState" ( ) as FB_RNDSTATE ptr

	'' generic procedure to initialize a built-in PRNG with user allocated FB_RNDSTATE
	declare sub rndCtxInit cdecl alias "fb_RndCtxInit" _
		( _
			byval seed as ulongint = 0, _
			byval algorithm as long = FB.FB_RND_AUTO _
		)

	'' procedures to initialize a user allocated FB_RNDSTATE for a specific generator
	declare sub rndCtxInitCRT32 cdecl alias "fb_RndCtxInitCRT32" ( byval seed as ulongint = 0 )
	declare sub rndCtxInitFAST32 cdecl alias "fb_RndCtxInitFAST32" ( byval seed as ulongint = 0 )
	declare sub rndCtxInitMTWIST32 cdecl alias "fb_RndCtxInitMTWIST32" ( byval seed as ulongint = 0 )
	declare sub rndCtxInitQB32 cdecl alias "fb_RndCtxInitQB32" ( byval seed as ulongint = 0 )
	declare sub rndCtxInitREAL32 cdecl alias "fb_RndCtxInitREAL32" ( byval seed as ulongint = 0 )

	#if __FB_MT__

	declare sub mathLock alias "fb_MathLock" ()
	declare sub mathUnlock alias "fb_MathUnlock" ()

	#endif

end extern

end namespace

#endif
