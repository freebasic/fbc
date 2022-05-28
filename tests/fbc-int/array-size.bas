#include "fbcunit.bi"
#include "fbc-int/array.bi"

SUITE( fbc_tests.fbc_int.array_size )

	type UDT
		__ as uinteger
	end type

	#macro check_array( T )
		scope
			dim a( ) as T
			CU_ASSERT_EQUAL( fb.ArrayLen( a() ), 0 )
			CU_ASSERT_EQUAL( fb.ArraySize( a() ), 0 )

			redim a( 0 to 9 ) as T
			CU_ASSERT_EQUAL( fb.ArrayLen( a() ), 10 )
			CU_ASSERT_EQUAL( fb.ArraySize( a() ), 10 * sizeof( T ) )

			redim a( 10 to 19 ) as T
			CU_ASSERT_EQUAL( fb.ArrayLen( a() ), 10 )
			CU_ASSERT_EQUAL( fb.ArraySize( a() ), 10 * sizeof( T ) )

			redim a( 10 to 24 ) as T
			CU_ASSERT_EQUAL( fb.ArrayLen( a() ), 15 )
			CU_ASSERT_EQUAL( fb.ArraySize( a() ), 15 * sizeof( T ) )

			redim a( 10 to 14 ) as T
			CU_ASSERT_EQUAL( fb.ArrayLen( a() ), 5 )
			CU_ASSERT_EQUAL( fb.ArraySize( a() ), 5 * sizeof( T ) )
		end scope

		scope
			dim a( any, any ) as T
			CU_ASSERT_EQUAL( fb.ArrayLen( a() ), 0 )
			CU_ASSERT_EQUAL( fb.ArraySize( a() ), 0 )

			redim a( 0 to 9, 0 to 4 ) as T
			CU_ASSERT_EQUAL( fb.ArrayLen( a() ), 50 )
			CU_ASSERT_EQUAL( fb.ArraySize( a() ), 50  * sizeof( T ) )

			redim a( 10 to 19, 10 to 14 ) as T
			CU_ASSERT_EQUAL( fb.ArrayLen( a() ), 50 )
			CU_ASSERT_EQUAL( fb.ArraySize( a() ), 50  * sizeof( T ) )

			redim a( 10 to 19, 10 to 24 ) as T
			CU_ASSERT_EQUAL( fb.ArrayLen( a() ), 150 )
			CU_ASSERT_EQUAL( fb.ArraySize( a() ), 150  * sizeof( T ) )

			redim a( 5 to 9, 10 to 14 ) as T
			CU_ASSERT_EQUAL( fb.ArrayLen( a() ), 25 )
			CU_ASSERT_EQUAL( fb.ArraySize( a() ), 25  * sizeof( T ) )
		end scope

		scope
			dim a( any, any, any ) as T
			CU_ASSERT_EQUAL( fb.ArrayLen( a() ), 0 )
			CU_ASSERT_EQUAL( fb.ArraySize( a() ), 0 )

			redim a( 0 to 9, 0 to 4, 0 to 3 ) as T
			CU_ASSERT_EQUAL( fb.ArrayLen( a() ), 200 )
			CU_ASSERT_EQUAL( fb.ArraySize( a() ), 200  * sizeof( T ) )

			redim a( 10 to 19, 10 to 14, 0 to 3 ) as T
			CU_ASSERT_EQUAL( fb.ArrayLen( a() ), 200 )
			CU_ASSERT_EQUAL( fb.ArraySize( a() ), 200  * sizeof( T ) )

			redim a( 10 to 19, 10 to 24, 0 to 3 ) as T
			CU_ASSERT_EQUAL( fb.ArrayLen( a() ), 600 )
			CU_ASSERT_EQUAL( fb.ArraySize( a() ), 600  * sizeof( T ) )

			redim a( 5 to 9, 10 to 14, 0 to 3 ) as T
			CU_ASSERT_EQUAL( fb.ArrayLen( a() ), 100 )
			CU_ASSERT_EQUAL( fb.ArraySize( a() ), 100  * sizeof( T ) )
		end scope
	#endmacro

	TEST( standard_types )
		check_array( integer<8> )
		check_array( uinteger<8> )
		check_array( integer<16> )
		check_array( uinteger<16> )
		check_array( integer<32> )
		check_array( uinteger<32> )
		check_array( integer<64> )
		check_array( uinteger<64> )

		check_array( single )
		check_array( double )

		check_array( string )
		check_array( any ptr )
		check_array( zstring ptr )
		check_array( wstring ptr )

		check_array( zstring * 4 )
		check_array( wstring * 4 )

		check_array( UDT )
	END_TEST

END_SUITE
