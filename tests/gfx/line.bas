# include "fbcunit.bi"
#include once "fbgfx.bi"

SUITE( fbc_tests.gfx.line_ )

	const SCREEN_W = 64
	const SCREEN_H = 32

	TEST( linestyle )
	
		CU_ASSERT( screenres( SCREEN_W, SCREEN_H, 32, , fb.GFX_NULL ) = 0 )

		dim style as ulong = &b1000000011110000
		dim c0 as ulong = rgb(0,0,0)
		dim c1 as ulong = rgb(0,255,0)
		dim c2 as ulong 

		for i as integer = 0 to 31		
			line (i, i) - (SCREEN_W-1, i), c1, , style
		next

		'' 1000000011110000100000001111000010000000111100001000000011110000
		'' 0100000001111000010000000111100001000000011110000100000001111000
		'' 0010000000111100001000000011110000100000001111000010000000111100
		'' 0001000000011110000100000001111000010000000111100001000000011110
		'' 0000100000001111000010000000111100001000000011110000100000001111
		'' ...

		for y as integer = 0 to SCREEN_H-1
			for x as integer = y to SCREEN_W-1
				c2 = c0
				if( x >= y ) then
					dim index as integer = (x - y) mod 16
					if( (style and (&h8000ul shr index)) <> 0 ) then
						c2 = c1
					end if 
				end if
				CU_ASSERT( point( x, y ) = c2 )
			next
		next
	END_TEST

END_SUITE
