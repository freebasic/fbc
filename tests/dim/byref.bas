#include "fbcu.bi"

namespace fbc_tests.dim_.byref_

namespace simpleVars
	dim shared gi as integer = 123
	dim shared byref grgi as integer = gi

	sub test cdecl( )
		'' Normal syntax
		dim i as integer = 456
		dim byref ri as integer = i
		dim byref rgi as integer = gi

		CU_ASSERT( grgi = 123 ) : CU_ASSERT( @grgi = @gi )
		CU_ASSERT( ri = 456 )   : CU_ASSERT( @ri = @i )
		CU_ASSERT( rgi = 123 )  : CU_ASSERT( @rgi = @gi )

		'' Multdecl syntax
		dim byref as integer r1 = i, r2 = i, r3 = i
		CU_ASSERT( r1 = 456 ) : CU_ASSERT( @r1 = @i )
		CU_ASSERT( r2 = 456 ) : CU_ASSERT( @r2 = @i )
		CU_ASSERT( r3 = 456 ) : CU_ASSERT( @r3 = @i )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/dim/byref" )
	fbcu.add_test( "simpleVars", @simpleVars.test )
end sub

end namespace
