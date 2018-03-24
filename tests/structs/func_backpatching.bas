#include "fbcunit.bi"

SUITE( fbc_tests.structs.func_backpatching )

	type foo as foo_

	declare function fun ( byval cnt as integer, _
						   byval a as integer, byval b as integer, byval c as integer ) as foo ptr

	type foo_
		a as byte
		b as short
		c as integer
	end type

	private _
	function fun ( byval cnt as integer, _
				   byval a as integer, byval b as integer, byval c as integer ) as foo ptr

		static as foo res
		
		if( cnt = 0 ) then
			with res
				.a = a: .b = b: .c = c
			end with
			function = @res
		else
			function = fun( cnt - 1, a, b, c )
		end if

	end function

	private _
	sub changestack( byval a as integer = 1, byval b as integer = 2, byval c as integer = 3 )
		dim as integer i, array(1 to 100)
		for i = 1 to 100
			array(i) = -i
		next
	end sub

	TEST( all )
		dim as foo ptr res = fun( 10, 1, 2, 3 )
		
		changestack( )
		
		CU_ASSERT_EQUAL( res->a, 1 )
		CU_ASSERT_EQUAL( res->b, 2 )
		CU_ASSERT_EQUAL( res->c, 3 )
	END_TEST

END_SUITE

