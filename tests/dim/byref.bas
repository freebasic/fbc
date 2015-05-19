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

		'' Initialized from other reference
		dim byref ri2 as integer = ri
		CU_ASSERT( ri2 = 456 ) : CU_ASSERT( @ri2 = @i )

		'' More complex expression
		var pi = new integer[3]
		CU_ASSERT( pi[0] = 0 )
		CU_ASSERT( pi[1] = 0 )
		CU_ASSERT( pi[2] = 0 )

		dim byref ri3 as integer = pi[1]

		pi[1] = 111
		CU_ASSERT( ri3 = 111 )
		CU_ASSERT( pi[0] = 0 )
		CU_ASSERT( pi[1] = 111 )
		CU_ASSERT( pi[2] = 0 )

		'' Reference as lhs of assignment
		ri3 = 222
		CU_ASSERT( ri3 = 222 )
		CU_ASSERT( pi[0] = 0 )
		CU_ASSERT( pi[1] = 222 )
		CU_ASSERT( pi[2] = 0 )

		ri = 100
		CU_ASSERT( i = 100 )
		ri += 2
		CU_ASSERT( i = 102 )

		delete pi
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/dim/byref" )
	fbcu.add_test( "simpleVars", @simpleVars.test )
end sub

end namespace
