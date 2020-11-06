#ifndef __FBMATH_BI__ 
#define __FBMATH_BI__

# if __FB_LANG__ = "qb"
# error not supported in qb dialect
# endif

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

namespace FB

	''
	'' built-in random number generators
	'' to be used with:
	''    RANDOMIZE seed, algorithm
	''
	enum FB_RND_ALGORITHMS
		FB_RND_AUTO
		FB_RND_CRT
		FB_RND_FAST
		FB_RND_MTWIST
		FB_RND_QB
		FB_RND_REAL
	end enum

	extern "rtlib"
		'' declare built-in RANDOMIZE, RND, & RND32 in the FB namespace
		declare sub randomize alias "fb_Randomize" ( byval seed as double = -1.0, byval algorithm as long = FB.FB_RND_AUTO )
		declare function rnd alias "fb_Rnd" ( byval n as single = 1.0 ) as double
		declare function rnd32 alias "fb_Rnd32" ( ) as ulong
	end extern

end namespace

#endif '' __FBMATH_BI__
