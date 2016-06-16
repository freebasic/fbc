# include "fbcu.bi"

namespace fbc_tests.const_.byval_ok
		
	type vec
		as integer x, y, z
	end type
	
	sub b( byval x as vec )
		cu_assert( x.x = 1 )
		cu_assert( x.y = 2 )
		cu_assert( x.z = 3 )
	end sub
	
	sub test cdecl( )
		dim as const vec foo = (1, 2, 3)
		b( foo )
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.const.byval_ok")
		fbcu.add_test("const to byval is ok", @test)
	
	end sub
	
end namespace
