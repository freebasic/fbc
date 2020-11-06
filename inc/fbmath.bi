#ifndef __FBMATH_BI__ 
#define __FBMATH_BI__

# if __FB_LANG__ = "qb"
# error not supported in qb dialect
# endif

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

end namespace

#endif '' __FBMATH_BI__
