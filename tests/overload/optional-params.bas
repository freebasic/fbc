#include "fbcunit.bi"

SUITE( fbc_tests.overload_.optional_params )

	TEST_GROUP( regression1 )
		function f overload( byval i as integer, byref s as string ) as integer
			function = 1
		end function
		function f overload( byval i as integer, byval j as integer = 0, byval k as integer = 0, byval l as integer = 0, byval m as integer = 0, byval n as integer = 0 ) as integer
			function = 2
		end function

		TEST( default )
			CU_ASSERT( f( 0, "hi"          ) = 1 )
			CU_ASSERT( f( 0                ) = 2 )
			CU_ASSERT( f( 0, 0             ) = 2 )
			CU_ASSERT( f( 0, 0, 0          ) = 2 )
			CU_ASSERT( f( 0, 0, 0, 0       ) = 2 )
			CU_ASSERT( f( 0, 0, 0, 0, 0    ) = 2 )
			CU_ASSERT( f( 0, 0, 0, 0, 0, 0 ) = 2 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( regression2 )
		function f overload( p1 as ulongint, p2 as integer, p3 as integer = 0, p4 as integer = 0 ) as integer
			function = 1
		end function
		function f overload( p1 as ulongint, p2 as string ) as integer
			function = 2
		end function

		TEST( default )
			CU_ASSERT( f( 1,   2       ) = 1 )
			CU_ASSERT( f( 1,   2, 3    ) = 1 )
			CU_ASSERT( f( 1,   2, 3, 4 ) = 1 )
			CU_ASSERT( f( 1, "2"       ) = 2 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( regression3 )
		function f overload( p1 as integer, p2 as integer, p3 as integer = 0, p4 as integer = 0 ) as integer
			function = 1
		end function
		function f overload( p1 as integer, p2 as string ) as integer
			function = 2
		end function

		TEST( default )
			CU_ASSERT( f( 1,   2       ) = 1 )
			CU_ASSERT( f( 1,   2, 3    ) = 1 )
			CU_ASSERT( f( 1,   2, 3, 4 ) = 1 )
			CU_ASSERT( f( 1, "2"       ) = 2 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( regression4 )
		function f overload( p1 as integer, p2 as integer, p3 as integer = 0, p4 as integer = 0 ) as integer
			function = 1
		end function
		function f overload( p1 as integer, p2 as string, p3 as integer = 0, p4 as integer = 0 ) as integer
			function = 2
		end function

		TEST( default )
			CU_ASSERT( f( 1,   2       ) = 1 )
			CU_ASSERT( f( 1,   2, 3    ) = 1 )
			CU_ASSERT( f( 1,   2, 3, 4 ) = 1 )
			CU_ASSERT( f( 1, "2"       ) = 2 )
			CU_ASSERT( f( 1, "2", 3    ) = 2 )
			CU_ASSERT( f( 1, "2", 3, 4 ) = 2 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( noParams1 )
		function f overload( ) as integer
			function = 1
		end function
		function f overload( p1 as integer = 0 ) as integer
			function = 2
		end function

		TEST( default )
			CU_ASSERT( f( 0 ) = 2 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( noParams2 )
		function f overload( p1 as integer = 0 ) as integer
			function = 1
		end function
		function f overload( ) as integer
			function = 2
		end function

		TEST( default )
			CU_ASSERT( f( 0 ) = 1 )
		END_TEST
	END_TEST_GROUP

END_SUITE
