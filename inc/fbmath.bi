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

	''
	'' "FAST" PRNG from 'Numerical recipes in C' chapter 7.1
	''
	type RndFAST32
		iseed as ulong = 327680
		declare function rnd() as double
		declare function rnd32() as ulong
	end type

	private function RndFAST32.rnd32() as ulong
		this.iseed = this.iseed * 1664525 + 1013904223
		return this.iseed
	end function

	private function RndFAST32.rnd() as double
		return this.rnd32()/cdbl(4294967296ull)
	end function

	''
	'' Middle Square Weyl Sequence PRNG / Bernard Widynski / 20 May 2020
	'' https://arxiv.org/abs/1704.00358v5
	'' 
	''
	type RndMSWS32
		s as ulongint = &hb5ad4eceda1ce2a9ull
		w as ulongint
		x as ulongint
		declare function rnd() as double
		declare function rnd32() as ulong
	end type

	private function RndMSWS32.rnd32() as ulong
		with this
			.x *= .x
			.w += .s
			.x += .w
			.x = ( .x shl 32 ) or ( .x shr 32 )
			return .x
		end with
	end function

	private function RndMSWS32.rnd() as double
		return this.rnd32()/cdbl(4294967296ull)
	end function

	''
	'' Squares: A Fast Counter Based PRNG / Bernard Widynski / 5 May 2020
	'' https://arxiv.org/abs/2004.06278
	''
	type RndSquares32
		key as ulongint = &hb5ad4eceda1ce2a9ull
		ctr as ulongint
		declare function rnd() as double
		declare function rnd32() as ulong
	end type

	private function RndSquares32.rnd32() as ulong
		dim as ulongint x = this.key * this.ctr
		dim as ulongint y = x
		dim as ulongint z = y + key
		x = x * x + y
		x = ( x shr 32 ) or ( x shl 32 )
		x = x * x + z
		x = ( x shr 32 ) or ( x shl 32 )
		this.ctr += 1
		return (x * x + y) shr 32
	end function

	private function RndSquares32.rnd() as double
		return this.rnd32()/cdbl(4294967296ull)
	end function

	''
	'' *Really* minimal PCG32 code / (c) 2014 M.E. O'Neill / pcg-random.org
	'' Licensed under Apache License 2.0 (NO WARRANTY, etc. see website)
	''
	type RndPCG32
		state as ulongint
		inc_ as ulongint
		declare function rnd() as double
		declare function rnd32() as ulong
	end type

	private function RndPCG32.rnd32() as ulong
		with this
			var oldstate = this.state
			'' Advance internal state
			.state = oldstate * 6364136223846793005ULL + ( .inc_ or 1 )
			'' Calculate output function (XSH RR), uses old state for max ILP
			dim as ulong xorshifted = ((oldstate shr 18u) xor oldstate) shr 27u
			dim as ulong rot = oldstate shr 59u
			return (xorshifted shr rot) or (xorshifted shl ((-rot) and 31))
		end with
	end function

	private function RndPCG32.rnd() as double
		return this.rnd32()/cdbl(4294967296ull)
	end function

	''
	'' xoroshiro128** Written in 2018 by David Blackman and Sebastiano Vigna (vigna@acm.org)
	'' http://prng.di.unimi.it/xoroshiro128starstar.c
	''
	'' Note the extra outer parentheses
	'' also note: #define's won't respect namespaces
	#define __FB_ROTL__(x,k) ( (x shl k) or (x shr(64-k)) ) 
 
	type Rndxoroshiro128
		as ulongint s(0 To 1) = { 1, 0 }
		declare function rnd() as double
		declare function rnd64() as ulongint
	end type
 
	private function Rndxoroshiro128.rnd64() as ulongint
		dim as ulongint s0, s1, result
		s0 = this.s(0)
		s1 = this.s(1)
		result = __FB_ROTL__(s0*5,7)*9
		s1 xor= s0
		this.s(0) = __FB_ROTL__(s0,24) xor s1 xor (s1 shl 16)
		this.s(1) = __FB_ROTL__(s1,37)
		return result
	end function
 
	private function Rndxoroshiro128.rnd() as double
		return cdbl(this.rnd64() shr 11)/cdbl(2^53)
	end function

end namespace

#endif '' __FBMATH_BI__
