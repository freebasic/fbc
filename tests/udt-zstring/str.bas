#include "fbcunit.bi"
#include once "uzstring-fixed.bi"
#include once "chk-zstring.bi"

#define ustring UZSTRING_FIXED

SUITE( fbc_tests.udt_zstring_.str_ )

	#macro check( dtype, value )
	
		scope
			dim t as dtype = value
			dim w as zstring * 50 = str( t )
			dim u as ustring = str( t )
			dim r as zstring * 50 = u
			CU_ASSERT_ZSTRING_EQUAL( w, r )
		end scope

	#endmacro

	TEST( numeric )

		check( byte, -128 )
		check( byte, -0 )
		check( byte, 127 )

		check( ubyte, 0 )
		check( ubyte, 128 )
		check( ubyte, 255 )

		check( short, -32768 )
		check( short, 0 )
		check( short, 32767 )

		check( ushort, 0 )
		check( ushort, 32768 )
		check( ushort, 65535 )

		check( long, -2147483648ll )
		check( long, 0 )
		check( long, 2147483647ull )

		check( ulong, 0 )
		check( ulong, 2147483648ull )
		check( ulong, 4294967295ull )

		check( longint, (-9223372036854775807ll-1ll) )
		check( longint, 0 )
		check( longint, 9223372036854775807ull )

		check( ulongint, 0 )
		check( ulongint, 9223372036854775808ull )
		check( ulongint, 18446744073709551615ull )

		check( single, -1.5 )
		check( single, -1.0 )
		check( single, -1.0 )
		check( single, -0.5 )
		check( single,  0.0 )
		check( single,  0.5 )
		check( single,  1.0)
		check( single,  1.5 )
		check( single,  2.0 )
		check( single,  2.5 )

		check( double, -1.5 )
		check( double, -1.0 )
		check( double, -1.0 )
		check( double, -0.5 )
		check( double,  0.0 )
		check( double,  0.5 )
		check( double,  1.0)
		check( double,  1.5 )
		check( double,  2.0 )
		check( double,  2.5 )

	END_TEST

	TEST( default )
		
		dim s1 as zstring * 10 = chr(12)
		dim s2 as zstring * 10 = chr(12)
		dim s3 as zstring * 10 = str( s1 )

		dim u1 as ustring = chr(12)
		dim u2 as ustring = chr(12)
		dim u3 as ustring = str( s1 )
		dim u4 as ustring = wstr( u1 )

		dim s4 as zstring * 10 = str( u1 )

		dim r1 as zstring * 10 = u1
		dim r2 as zstring * 10 = u2
		dim r3 as zstring * 10 = u3
		dim r4 as zstring * 10 = u4

		#macro check_group( g )

			CU_ASSERT_ZSTRING_EQUAL( g, s1 )
			CU_ASSERT_ZSTRING_EQUAL( g, s2 )
			CU_ASSERT_ZSTRING_EQUAL( g, s3 )
			CU_ASSERT_ZSTRING_EQUAL( g, s4 )

			CU_ASSERT_ZSTRING_EQUAL( g, r1 )
			CU_ASSERT_ZSTRING_EQUAL( g, r2 )
			CU_ASSERT_ZSTRING_EQUAL( g, r3 )
			CU_ASSERT_ZSTRING_EQUAL( g, r4 )

		#endmacro

		check_group( s1 )
		check_group( s2 )
		check_group( s3 )
		check_group( s4 )
		check_group( r1 )
		check_group( r2 )
		check_group( r3 )
		check_group( r4 )

	END_TEST

END_SUITE
