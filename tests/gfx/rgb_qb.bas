#lang "qb"
#include "fbcunit.bi"

SUITE( fbc_tests.gfx.rgb_qb )

	dim shared c(1 to 5) as __ubyte

	SUITE_INIT
		c(1) = 0
		c(2) = 1
		c(3) = 127
		c(4) = 128
		c(5) = 255
		'' return success
		tests.fbc_tests.rgb_qb.init = 0
	END_SUITE_INIT

	#define RGB_OLD(r,g,b) ((__culng(r) __shl 16) or (__culng(g) __shl 8) or __culng(b) or (&HFF000000))

	TEST( MacroRGB_ )
		for ridx as integer = 1 to 5
			dim r as __ubyte
			r = c(ridx)
			for gidx as integer = 1 to 5
				dim g as __ubyte
				g = c(gidx)
				for bidx as integer = 1 to 5
					dim b as __ubyte
					b = c(bidx)
					CU_ASSERT_EQUAL( __RGB(r,g,b), RGB_OLD(r,g,b) )
				next
			next
		next

		CU_ASSERT_EQUAL( __sizeof( __RGB(0,0,0) ), __sizeof( __ulong ) )
	END_TEST

	#define RGBA_OLD(r,g,b,a) ((__culng(r) __shl 16) or (__culng(g) __shl 8) or __culng(b) or (__culng(a) __shl 24))

	TEST( MacroRGBA )
		for ridx as integer = 1 to 5
			dim r as __ubyte
			r = c(ridx)
			for gidx as integer = 1 to 5
				dim g as __ubyte
				g = c(gidx)
				for bidx as integer = 1 to 5
					dim b as __ubyte
					b = c(bidx)
					for aidx as integer = 1 to 5
						dim a as __ubyte
						a = c(aidx)
						CU_ASSERT_EQUAL( __RGBA(r,g,b,a), RGBA_OLD(r,g,b,a) )
					next
				next
			next
		next

		CU_ASSERT_EQUAL( __sizeof( __RGBA(0,0,0,0) ), __sizeof( __ulong ) )
	END_TEST

END_SUITE
