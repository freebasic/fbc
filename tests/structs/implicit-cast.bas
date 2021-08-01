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

	TEST_GROUP( cast_zstring )

		function p overload( byref z as const wstring ) byref as zstring
			static z1 as zstring * 20 = "zstring"
			return z1
		end function
		
		function p( byref s as const string ) as string
			return "string"
		end function

		type T
			__ as integer
			declare operator cast() byref as zstring
		end type
		operator T.cast() byref as zstring
			static z1 as zstring * 20 = "123"
			return z1
		end operator

		TEST( default )
			dim x as T
			CU_ASSERT( left( x, 1 ) = "1" )		
			CU_ASSERT( right( x, 1 ) = "3" )
			CU_ASSERT( p( x ) = "string" )
		END_TEST

	END_TEST_GROUP

	TEST_GROUP( cast_wstring )

		function p overload( byref z as const wstring ) byref as wstring
			static w1 as wstring * 20 = "wstring"
			return w1
		end function
		
		function p( byref s as const string ) as string
			return "string"
		end function

		type T
			__ as integer
			declare operator cast() byref as wstring
		end type
		operator T.cast() byref as wstring
			static w1 as wstring * 20 = "123"
			return w1
		end operator

		TEST( default )
			dim x as T
			CU_ASSERT( left( x, 1 ) = "1" )		
			CU_ASSERT( right( x, 1 ) = "3" )
			CU_ASSERT( p( x ) = "wstring" )
		END_TEST

	END_TEST_GROUP
	
END_SUITE
