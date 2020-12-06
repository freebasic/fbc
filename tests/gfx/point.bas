# include "fbcunit.bi"
#include once "fbgfx.bi"

'' We have to ensure that we can compare RGBA color values without running into
'' issues such as sign-extension on 64bit. For example, the RGBA value
'' &hFF000000 in a signed 32bit type would be sign-extended to
'' &hFFFFFFFFFF000000 on 64bit when used as the operand of a UOP or BOP, and
'' then it would compare unequal to the value &h00000000FF000000 in a 64bit
'' type.
''
'' Rgb()/Rgba() return a UInteger, of which the upper 32bit will always be
'' unused on the 64bit port. Since they will always return an RGBA value, ULong
'' could be used aswell, but it doesn't really matter, and we can keep using
'' UInteger which is our default for unsigned calculations on 64bit anyways.
''
'' Point() returns an Integer, which hold an RGBA value or a palette index.

SUITE( fbc_tests.gfx.point_ )

	const SCREEN_W = 16
	const SCREEN_H = 16

	TEST( rgba_ )
		CU_ASSERT( screenres( SCREEN_W, SCREEN_H, 32, , fb.GFX_NULL ) = 0 )

		line (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,255,0), bf
		CU_ASSERT( point( 0, 0 ) = rgb(0,255,0) )
		CU_ASSERT( point( 0, 0 ) = &hFF00FF00 )
		CU_ASSERT( point( 0, 0 ) = cint( rgb(0,255,0) ) )
		CU_ASSERT( cuint( point( 0, 0 ) ) = rgb(0,255,0) )
		CU_ASSERT( cuint( point( 0, 0 ) ) = &hFF00FF00u )

		CU_ASSERT( culng( point( 0, 0 ) ) =        rgb(0,255,0)   )
		CU_ASSERT(        point( 0, 0 )   = culng( rgb(0,255,0) ) )
		CU_ASSERT( culng( point( 0, 0 ) ) = culng( rgb(0,255,0) ) )

		line (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf
		CU_ASSERT( point( 0, 0 ) = rgb(255,0,0) )
		CU_ASSERT( point( 0, 0 ) = &hFFFF0000 )
		CU_ASSERT( point( 0, 0 ) = cint( rgb(255,0,0) ) )
		CU_ASSERT( cuint( point( 0, 0 ) ) = rgb(255,0,0) )
		CU_ASSERT( cuint( point( 0, 0 ) ) = &hFFFF0000u )

		CU_ASSERT( culng( point( 0, 0 ) ) =        rgb(255,0,0)   )
		CU_ASSERT(        point( 0, 0 )   = culng( rgb(255,0,0) ) )
		CU_ASSERT( culng( point( 0, 0 ) ) = culng( rgb(255,0,0) ) )

		#assert( typeof( point( 0, 0 ) ) = typeof( ulong ) )
		#assert( typeof( rgb(0,0,0)    ) = typeof( ulong ) )
	END_TEST

END_SUITE
