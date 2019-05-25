#include "fbcunit.bi"
#include once "uzstring-fixed.bi"
#include once "chk-zstring.bi"

#define ustring UZSTRING_FIXED

SUITE( fbc_tests.udt_zstring_.conversion )

	#macro check( datatype, func, value )

		scope
			dim t as zstring * 50 = str( #value )
			dim u as ustring = t

				CU_ASSERT_EQUAL( func( t ), func( u ) )

			#if #datatype = "double"
				CU_ASSERT_DOUBLE_EQUAL( func( t ), value, 0 )
				CU_ASSERT_DOUBLE_EQUAL( func( u ), value, 0 )
				CU_ASSERT_DOUBLE_EQUAL( func( t ), func( value ), 0 )
				CU_ASSERT_DOUBLE_EQUAL( func( u ), func( value ), 0 )
			#elseif #datatype = "single"
				CU_ASSERT_SINGLE_APPROX( func( t ), value, 0 )
				CU_ASSERT_SINGLE_APPROX( func( u ), value, 0 )
				CU_ASSERT_SINGLE_APPROX( func( t ), func( value ), 0 )
				CU_ASSERT_SINGLE_APPROX( func( u ), func( value ), 0 )
			#else
				CU_ASSERT_EQUAL( func( t ), value )
				CU_ASSERT_EQUAL( func( u ), value )
				CU_ASSERT_EQUAL( func( t ), func( value ) )
				CU_ASSERT_EQUAL( func( u ), func( value ) )
			#endif
			
		end scope

	#endmacro

	TEST( cbool_ )
		check( boolean, cbool, false )
		check( boolean, cbool, true )
	END_TEST

	TEST( cbyte_ )
		check( byte, cbyte, -128 )
		check( byte, cbyte, -1 )
		check( byte, cbyte, 0 )
		check( byte, cbyte, 127 )
	END_TEST

	TEST( cubyte_ )
		check( ubyte, cubyte, 0 )
		check( ubyte, cubyte, 127 )
		check( ubyte, cubyte, 128 )
		check( ubyte, cubyte, 255 )
	END_TEST

	TEST( cshort_ )
		check( short, cshort, -32768 )
		check( short, cshort, -1 )
		check( short, cshort, 0 )
		check( short, cshort, 32767 )
	END_TEST

	TEST( cushort_ )
		check( ushort, cushort, 0 )
		check( ushort, cushort, 32767 )
		check( ushort, cushort, 32768 )
		check( ushort, cushort, 65535 )
	END_TEST

	TEST( clng_ )
		check( long, clng, -2147483648 )
		check( long, clng, -1 )
		check( long, clng, 0 )
		check( long, clng, 2147483647 )
	END_TEST

	TEST( culng_ )
		check( ulong, culng, 0 )
		check( ulong, culng, 2147483647 )
		check( ulong, culng, 2147483648 )
		check( ulong, culng, 4294967295 )
	END_TEST


#if sizeof(integer) = 4
	TEST( cint_ )
		check( integer, cint, -2147483648 )
		check( integer, cint, -1 )
		check( integer, cint, 0 )
		check( integer, cint, 2147483647 )
	END_TEST

	TEST( cuint_ )
		check( uinteger, cuint, 0 )
		check( uinteger, cuint, 2147483647 )
		check( uinteger, cuint, 2147483648 )
		check( uinteger, cuint, 4294967295 )
	END_TEST
#else
	TEST( cint_ )
		check( integer, cint, -9223372036854775808ll )
		check( integer, cint, -1 )
		check( integer, cint, 0 )
		check( integer, cint, 9223372036854775807ll )
	END_TEST

	TEST( cuint_ )
		check( uinteger, cuint, 0 )
		check( uinteger, cuint, 9223372036854775807 )
		check( uinteger, cuint, 9223372036854775808 )
		check( uinteger, cuint, 18446744073709551615 )
	END_TEST
#endif

	TEST( clngint_ )
		check( longint, clngint, -9223372036854775808 )
		check( longint, clngint, -1 )
		check( longint, clngint, 0 )
		check( longint, clngint, 9223372036854775807 )
	END_TEST

	TEST( culngint_ )
		check( ulongint, culngint, 0 )
		check( ulongint, culngint, 9223372036854775807 )
		check( ulongint, culngint, 9223372036854775808 )
		check( ulongint, culngint, 18446744073709551615 )
	END_TEST

	TEST( csng_ )
		check( single, csng, 1.1754943508e-38! )
		check( single, csng, 3.4028234664e+38! )
		check( single, csng, 0.9999999404! )
		check( single, csng, 1.0000001192! )
		check( single, csng, -1.5! )
		check( single, csng, -1! )
		check( single, csng, -0.5! )
		check( single, csng, 0! )
		check( single, csng, 0.5! )
		check( single, csng, 1! )
		check( single, csng, 1.5! )
		check( single, csng, +1! )
	END_TEST

	TEST( cdbl_ )
		check( double, cdbl, 2.2250738585072014d-308# )
		check( double, cdbl, 1.7976931348623157d+308# )
		check( double, cdbl, -1.5# )
		check( double, cdbl, -1# )
		check( double, cdbl, -0.5# )
		check( double, cdbl, 0# )
		check( double, cdbl, 0.5# )
		check( double, cdbl, 1# )
		check( double, cdbl, 1.5# )
		check( double, cdbl, +1# )
	END_TEST

END_SUITE

