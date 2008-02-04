# include "fbcu.bi"

namespace fbc_tests.const_.ovl

	'' ----------
	
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
	
	sub test1 cdecl ( )
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

	'' ----------
	
	function foo2 overload ( byref a as integer, byref b as integer ) as integer
		return 1
	end function

	function foo2 overload ( byref a as integer, byref b as const integer ) as integer
		return 2
	end function

	function foo2 overload ( byref a as const integer, byref b as integer ) as integer
		return 3
	end function

	function foo2 overload ( byref a as const integer, byref b as const integer ) as integer
		return 4
	end function

	sub test2 cdecl ( )
		dim a as integer = 1
		dim b as const integer = 2

		'' Test exact match
		cu_assert_equal( 1, foo2( a, a ) )
		cu_assert_equal( 2, foo2( a, b ) )
		cu_assert_equal( 3, foo2( b, a ) )
		cu_assert_equal( 4, foo2( b, b ) )

	end sub

	'' ----------
	
	function foo3 overload ( byref a as integer, byref b as const integer ) as integer
		return 2
	end function

	function foo3 overload ( byref a as const integer, byref b as const integer ) as integer
		return 4
	end function

	sub test3 cdecl ( )
		dim a as integer = 1
		dim b as const integer = 2

		'' Test partial matches by const
		cu_assert_equal( 2, foo3( a, a ) )
		cu_assert_equal( 2, foo3( a, b ) )
		cu_assert_equal( 4, foo3( b, a ) )
		cu_assert_equal( 4, foo3( b, b ) )

	end sub

	'' ----------
	
	function foo4 overload ( byref a as const integer, byref b as integer ) as integer
		return 3
	end function

	function foo4 overload ( byref a as const integer, byref b as const integer ) as integer
		return 4
	end function

	sub test4 cdecl ( )
		dim a as integer = 1
		dim b as const integer = 2

		'' Test partial matches by const
		cu_assert_equal( 3, foo4( a, a ) )
		cu_assert_equal( 4, foo4( a, b ) )
		cu_assert_equal( 3, foo4( b, a ) )
		cu_assert_equal( 4, foo4( b, b ) )

	end sub

	'' ----------
	
	private sub ctor () constructor
	
		fbcu.add_suite("tests.const.ovl")
		fbcu.add_test("ovl_1", @test1)
		fbcu.add_test("ovl_2", @test2)
		fbcu.add_test("ovl_3", @test3)
		fbcu.add_test("ovl_4", @test4)
	
	end sub
	
end namespace
	
