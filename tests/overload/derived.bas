#include "fbcunit.bi"

SUITE( fbc_tests.overload_.derived )

	type A
		as integer dummy
	end type

	type B extends A
	end type

	type C extends B
	end type

	TEST_GROUP( derivedResolveTobase )
		function f overload( i as integer ) as integer
			function = &h1
		end function 

		function f overload( a as A ) as integer
			function = &hA
		end function

		function f overload( b as B ) as integer
			function = &hB
		end function 

		TEST( default )
			dim as integer i
			CU_ASSERT( f( i ) = &h1 )

			dim as A xa
			CU_ASSERT( f( xa ) = &hA )

			dim as B xb
			CU_ASSERT( f( xb ) = &hB )

			'' There is no C overload, it should use the B one
			dim as C xc
			CU_ASSERT( f( xc ) = &hB )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( derivedResolveToExactSelf )
		function f overload( i as integer ) as integer
			function = &h1
		end function 

		function f overload( a as A ) as integer
			function = &hA
		end function

		function f overload( b as B ) as integer
			function = &hB
		end function 

		function f overload( c as C ) as integer
			function = &hC
		end function 

		TEST( default )
			dim as integer i
			CU_ASSERT( f( i ) = &h1 )

			dim as A xa
			CU_ASSERT( f( xa ) = &hA )

			dim as B xb
			CU_ASSERT( f( xb ) = &hB )

			dim as C xc
			CU_ASSERT( f( xc ) = &hC )
		END_TEST
	END_TEST_GROUP

END_SUITE
