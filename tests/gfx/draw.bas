# include "fbcunit.bi"
#include once "fbgfx.bi"

SUITE( fbc_tests.gfx.draw_ )

	TEST( RememberPenPositionForXCommand )
		const SCREEN_W = 20
		const SCREEN_H = 20

		CU_ASSERT( screenres( SCREEN_W, SCREEN_H, 32, , fb.GFX_NULL ) = 0 )

		CU_ASSERT( point(  0,  0 ) = rgb(0,0,0) )
		CU_ASSERT( point(  4,  4 ) = rgb(0,0,0) )
		CU_ASSERT( point(  9,  9 ) = rgb(0,0,0) )
		CU_ASSERT( point( 14, 14 ) = rgb(0,0,0) )
		CU_ASSERT( point( 19, 19 ) = rgb(0,0,0) )

		const BORDERCOLOR = rgb(255,0,0)
		const FILLCOLOR = rgb(255,255,255)

		dim fillcommand as string = "P " & FILLCOLOR & "," & BORDERCOLOR
		draw "BM 4,4 C" & BORDERCOLOR & " R10 D10 L10 U10 BM +1,1 X" & @fillcommand

		CU_ASSERT( point(  0,  0 ) = rgb(0,0,0)  )
		CU_ASSERT( point(  4,  4 ) = BORDERCOLOR )
		CU_ASSERT( point(  9,  9 ) = FILLCOLOR   )
		CU_ASSERT( point( 14, 14 ) = BORDERCOLOR )
		CU_ASSERT( point( 19, 19 ) = rgb(0,0,0)  )
	END_TEST

	TEST( rememberPenPositionFromXCommand )
		const SCREEN_W = 20
		const SCREEN_H = 20

		CU_ASSERT( screenres( SCREEN_W, SCREEN_H, 32, , fb.GFX_NULL ) = 0 )

		CU_ASSERT( point(  0,  0 ) = rgb(0,0,0) )
		CU_ASSERT( point(  4,  4 ) = rgb(0,0,0) )
		CU_ASSERT( point(  9,  9 ) = rgb(0,0,0) )
		CU_ASSERT( point( 14, 14 ) = rgb(0,0,0) )
		CU_ASSERT( point( 19, 19 ) = rgb(0,0,0) )

		const BORDERCOLOR = rgb(255,0,0)
		const FILLCOLOR = rgb(255,255,255)

		dim movecommand as string = "BM 4,4"
		draw "X" & @movecommand & " C" & BORDERCOLOR & " R10 D10 L10 U10 BM +1,1 P " & FILLCOLOR & "," & BORDERCOLOR

		CU_ASSERT( point(  0,  0 ) = rgb(0,0,0)  )
		CU_ASSERT( point(  4,  4 ) = BORDERCOLOR )
		CU_ASSERT( point(  9,  9 ) = FILLCOLOR   )
		CU_ASSERT( point( 14, 14 ) = BORDERCOLOR )
		CU_ASSERT( point( 19, 19 ) = rgb(0,0,0)  )
	END_TEST

END_SUITE
