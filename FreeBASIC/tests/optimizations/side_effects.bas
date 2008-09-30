# include "fbcu.bi"

namespace fbc_tests.optimizations.side_effects

	function modify_a( byref a as integer ) as integer
		a += 1
		return 1
	end function

	sub test_side_effects cdecl( )

		dim as integer a = 0, b

		b = 0 * modify_a( a )
		b = modify_a( a ) * 0

		b = 0 and modify_a( a )
		b = modify_a( a ) and 0

		b = -1 or modify_a( a )
		b = modify_a( a ) or -1

		b = modify_a( a ) imp -1

		b = modify_a( a ) mod 1
		b = modify_a( a ) mod -1


		CU_ASSERT_EQUAL( a, 9 )

	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.optimizations.side_effects")
		fbcu.add_test("Optimizing expressions with side-effects", @test_side_effects)
		
	end sub

end namespace
