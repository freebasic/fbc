# include "fbcu.bi"
#include once "fbgfx.bi"

'' rgb() and point() should produce ULong's, such that the colors values can be
'' compared without worrying about sign-extension on 64bit.

namespace fbc_tests.gfx.point_

const SCREEN_W = 16
const SCREEN_H = 16

private sub test cdecl( )
	CU_ASSERT( screenres( SCREEN_W, SCREEN_H, 32, , fb.GFX_NULL ) = 0 )

	line (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,255,0), bf
	CU_ASSERT( point( 0, 0 ) = rgb(0,255,0) )

	line (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf
	CU_ASSERT( point( 0, 0 ) = rgb(255,0,0) )

	#assert( typeof( point( 0, 0 ) ) = typeof( ulong ) )
	#assert( typeof( rgb(0,0,0)    ) = typeof( ulong ) )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/gfx/point" )
	fbcu.add_test( "test", @test )
end sub

end namespace
