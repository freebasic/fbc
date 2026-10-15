# include "fbcunit.bi"
#include once "fbgfx.bi"

'' After CIRCLE the graphics cursor must be at the supplied center
'' (documented behaviour, and what QB does). With a negative start or
'' end angle CIRCLE draws radius lines, which used to leave the cursor
'' at the end of the arc instead (github #454).

SUITE( fbc_tests.gfx.circle_cursor )

	const SCREEN_W = 64
	const SCREEN_H = 64
	const CX = 32
	const CY = 32

	'' Draw a circle/arc, then plot at the cursor with STEP(0,0): the
	'' marker must land on the center
	sub check( byval start as single, byval end_ as single )
		dim as ulong red = rgb(255, 0, 0), green = rgb(0, 255, 0)
		cls
		circle (CX, CY), 10, red, start, end_
		pset step(0, 0), green
		CU_ASSERT( point( CX, CY ) = green )
	end sub

	TEST( fullCircle )
		CU_ASSERT( screenres( SCREEN_W, SCREEN_H, 32, , fb.GFX_NULL ) = 0 )
		check( 0.0, 3.141593 * 2 )
	END_TEST

	TEST( arcWithoutRadiusLines )
		CU_ASSERT( screenres( SCREEN_W, SCREEN_H, 32, , fb.GFX_NULL ) = 0 )
		check( 1.0, 2.0 )
	END_TEST

	TEST( negativeStartAngle )
		CU_ASSERT( screenres( SCREEN_W, SCREEN_H, 32, , fb.GFX_NULL ) = 0 )
		check( -1.0, 2.0 )
	END_TEST

	TEST( negativeEndAngle )
		CU_ASSERT( screenres( SCREEN_W, SCREEN_H, 32, , fb.GFX_NULL ) = 0 )
		check( 1.0, -2.0 )
	END_TEST

	TEST( bothNegative )
		CU_ASSERT( screenres( SCREEN_W, SCREEN_H, 32, , fb.GFX_NULL ) = 0 )
		check( -5.0, -2.0 )
	END_TEST

END_SUITE
