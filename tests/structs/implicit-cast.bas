#include "fbcunit.bi"

SUITE( fbc_tests.structs.implicit_cast )

	TEST_GROUP( cast_string )

		function p overload( byref z as const wstring ) as string
			return "wstring"
		end function
		
		function p( byref s as const string ) as string
			return "string"
		end function

		type T
			__ as integer
			declare operator cast() as string
		end type
		operator T.cast() as string
			return "123"
		end operator

		TEST( default )
			dim x as T
			CU_ASSERT( left( x, 1 ) = "1" )		
			CU_ASSERT( right( x, 1 ) = "3" )
			CU_ASSERT( p( x ) = "string" )
		END_TEST

	END_TEST_GROUP
	
END_SUITE
