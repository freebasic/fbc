# include "fbcu.bi"

namespace fbc_tests.const_.ovl

	function foo overload (byval bar as integer ptr ptr) as integer
	        return 1
	end function

	function foo overload (byval bar as const integer ptr ptr) as integer
	        return 2
	end function
	
	function foo overload (byval bar as integer const ptr ptr) as integer
	        return 3
	end function

	function foo overload (byval bar as const integer const ptr ptr) as integer
	        return 4
	end function

	function foo overload (byref bar as integer) as integer
	        return 5
	end function

	function foo overload (byref bar as const integer) as integer
	        return 6
	end function
	
	sub testy cdecl ( )
		dim i as integer = 1
		dim ci as const integer = 2
		dim pi as integer ptr = @i

		dim p1 as integer ptr ptr
		dim p2 as const integer ptr ptr
		dim p3 as integer const ptr ptr
		dim p4 as const integer const ptr ptr
		       
		cu_assert_equal( 1, foo( p1 ) )
		cu_assert_equal( 2, foo( p2 ) )
		cu_assert_equal( 3, foo( p3 ) )
		cu_assert_equal( 4, foo( p4 ) )

		cu_assert_equal( 5, foo( i ) )
		cu_assert_equal( 6, foo( ci ) )

	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("tests.const.ovl")
		fbcu.add_test("ovl", @testy)
	
	end sub
	
end namespace
	
