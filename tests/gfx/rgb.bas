#include "fbcunit.bi"
#include once "fbgfx.bi"

SUITE( fbc_tests.gfx.rgb_ )

	dim shared c(1 to 5) as ubyte = { 0, 1, 127, 128, 255 }

	#define RGB_OLD(r,g,b) ((cuint(r) shl 16) or (cuint(g) shl 8) or cuint(b) or (&HFF000000))

	TEST( MacroRGB_ )
		for ridx as integer = 1 to 5
			var r = c(ridx)
			for gidx as integer = 1 to 5
				var g = c(gidx)
				for bidx as integer = 1 to 5
					var b = c(bidx)
					CU_ASSERT_EQUAL( RGB(r,g,b), RGB_OLD(r,g,b) )
				next
			next
		next

		CU_ASSERT_EQUAL( sizeof( RGB(0,0,0) ), sizeof( ulong ) )
	END_TEST

	#define RGBA_OLD(r,g,b,a) ((cuint(r) shl 16) or (cuint(g) shl 8) or cuint(b) or (cuint(a) shl 24))

	TEST( MacroRGBA )
		for ridx as integer = 1 to 5
			var r = c(ridx)
			for gidx as integer = 1 to 5
				var g = c(gidx)
				for bidx as integer = 1 to 5
					var b = c(bidx)
					for aidx as integer = 1 to 5
						var a = c(aidx)
						CU_ASSERT_EQUAL( RGBA(r,g,b,a), RGBA_OLD(r,g,b,a) )
					next
				next
			next
		next

		CU_ASSERT_EQUAL( sizeof( RGBA(0,0,0,0) ), sizeof( ulong ) )
	END_TEST

END_SUITE
