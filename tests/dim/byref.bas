#include "fbcu.bi"

namespace fbc_tests.dim_.byref_

namespace simpleVars
	'' Globals
	dim shared gi as integer = 123

	'' Normal syntax
	dim shared byref gr1 as integer = gi
	dim shared byref gr2 as integer = gi, byref gr3 as integer = gi
	'var shared byref gr4 = gi, byref gr5 = gi

	'' Multdecl syntax
	dim shared byref as integer gr6 = gi, gr7 = gi

	function fByval( byval i as integer ) as integer
		function = i
	end function

	sub fByref( byref i as integer )
		i += 1
	end sub

	sub test cdecl( )
		'' Globals
		scope
			CU_ASSERT( gr1 = 123 ) : CU_ASSERT( @gr1 = @gi )
			CU_ASSERT( gr2 = 123 ) : CU_ASSERT( @gr2 = @gi )
			CU_ASSERT( gr3 = 123 ) : CU_ASSERT( @gr3 = @gi )
			'CU_ASSERT( gr4 = 123 ) : CU_ASSERT( @gr4 = @gi )
			'CU_ASSERT( gr5 = 123 ) : CU_ASSERT( @gr5 = @gi )
			CU_ASSERT( gr6 = 123 ) : CU_ASSERT( @gr6 = @gi )
			CU_ASSERT( gr7 = 123 ) : CU_ASSERT( @gr7 = @gi )
		end scope

		scope
			'' Normal syntax
			dim i as integer = 456
			dim byref r1 as integer = i, byref r2 as integer = i
			var byref r3 = i, byref r4 = i

			CU_ASSERT( r1 = 456 ) : CU_ASSERT( @r1 = @i )
			CU_ASSERT( r2 = 456 ) : CU_ASSERT( @r2 = @i )
			CU_ASSERT( r3 = 456 ) : CU_ASSERT( @r3 = @i )
			CU_ASSERT( r4 = 456 ) : CU_ASSERT( @r4 = @i )
		end scope

		scope
			'' Multdecl syntax
			var i = 123
			dim byref as integer r1 = i, r2 = i, r3 = i
			CU_ASSERT( r1 = 123 ) : CU_ASSERT( @r1 = @i )
			CU_ASSERT( r2 = 123 ) : CU_ASSERT( @r2 = @i )
			CU_ASSERT( r3 = 123 ) : CU_ASSERT( @r3 = @i )
		end scope

		scope
			'' Initialized from other reference
			dim i as integer = 111
			dim byref ri1 as integer = i
			dim byref ri2 as integer = ri1
			CU_ASSERT( ri1 = 111 ) : CU_ASSERT( @ri1 = @i )
			CU_ASSERT( ri2 = 111 ) : CU_ASSERT( @ri2 = @i )
		end scope

		scope
			'' More complex expression
			var p = new integer[3]
			CU_ASSERT( p[0] = 0 )
			CU_ASSERT( p[1] = 0 )
			CU_ASSERT( p[2] = 0 )

			dim byref r as integer = p[1]

			p[1] = 111
			CU_ASSERT( r = 111 )
			CU_ASSERT( p[0] = 0 )
			CU_ASSERT( p[1] = 111 )
			CU_ASSERT( p[2] = 0 )

			delete p
		end scope

		scope
			'' Reference as lhs of assignment
			var i = 111
			var byref ri = i
			CU_ASSERT( ri = 111 )

			ri = 222
			CU_ASSERT( i = 222 )

			'' Self-ops
			ri += 2
			CU_ASSERT( i = 224 )
		end scope

		scope
			'' Passing as procedure arguments
			var i = 111
			var byref ri = i
			CU_ASSERT( fByval( ri ) = 111 )
			fByref( ri )
			CU_ASSERT( i = 112 )
		end scope
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/dim/byref" )
	fbcu.add_test( "simpleVars", @simpleVars.test )
end sub

end namespace
