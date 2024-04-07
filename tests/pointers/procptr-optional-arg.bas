#include "fbcunit.bi"

SUITE( fbc_tests.pointers.procptr_optional_arg )

	function f1( byval arg as long ) as long
		return 1000+arg
	end function
	function f2( byval arg as long = 2 ) as long
		return 2000+arg
	end function
	function f3( byval arg as long = 3 ) as long
		return 3000+arg
	end function

	TEST( default )
	    '' default initializers are stored with the function pointer
		var pf1 = procptr( f1 )
		var pf2 = procptr( f2 )
		var pf3 = procptr( f3 )

		CU_ASSERT( pf1(1) = 1001 ) '' f1(1)
		CU_ASSERT( pf2()  = 2002 ) '' f2(2)
		CU_ASSERT( pf3()  = 3003 ) '' f3(3)

		CU_ASSERT( pf2(5) = 2005 ) '' f2(5)
		CU_ASSERT( pf3(6) = 3006 ) '' f3(6)

		'' swap proc addresses, but not initializers
		'' because function pointer declaration is still
		'' same as originally typed

		swap pf2, pf3
		CU_ASSERT( pf1(1) = 1001 ) '' f1(1)
		CU_ASSERT( pf2()  = 3002 ) '' f3(2)
		CU_ASSERT( pf3()  = 2003 ) '' f2(3)

		CU_ASSERT( pf1(4) = 1004 ) '' f1(1)
		CU_ASSERT( pf2(5) = 3005 ) '' f3(5)
		CU_ASSERT( pf3(6) = 2006 ) '' f2(6)

		swap pf1, pf2
		CU_ASSERT( pf1(1) = 3001 ) '' f3(1)
		CU_ASSERT( pf2()  = 1002 ) '' f1(2)
		CU_ASSERT( pf3()  = 2003 ) '' f2(3)

		CU_ASSERT( pf1(4) = 3004 ) '' f3(1)
		CU_ASSERT( pf2(5) = 1005 ) '' f1(2)
		CU_ASSERT( pf3(6) = 2006 ) '' f2(3)
	END_TEST

	function f4( byval f as function( byval arg as long = 4 ) as long ) as long
		return f()
	end function

	TEST( fptr_arg )
		var pf1 = procptr( f1 )
		var pf2 = procptr( f2 )
		var pf3 = procptr( f3 )

		CU_ASSERT( f4(pf1) = 1004 )
		CU_ASSERT( f4(pf2) = 2004 )
		CU_ASSERT( f4(pf3) = 3004 )
	END_TEST

	Type T
		s1 As Sub( byval compare as long, byval value As Long=123 )
		s2 As Sub( byval compare as long, byval value As Long=456 )
		s3 As Sub( byval compare as long, byval value As Long=789 )
	End Type

	sub check_field ( byval compare as long, byval value as long )
		CU_ASSERT( compare = value )
	end sub

	TEST( fptr_field )
		dim x as T = ( @check_field, @check_field, @check_field )
		x.s1(123)
		x.s2(456)
		x.s3(789)
	END_TEST

END_SUITE
