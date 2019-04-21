#include "fbcunit.bi"

SUITE( fbc_tests.wstring_.len_ )

	'' len( [w]str( literal ) ) is evaluated at compile time
	'' check that the compile time calculation matches the
	'' run time library calculation

	const LIT_A1 = "abcdef"
	const LIT_W1 = wstr( "abcdef" )
	const LIT_W2 = !"bcd\u0065\u0066\u0067"
	const LIT_W3 = !"\u0063\u0064\u0065\u0065\u0067\u0068"

	const CODE_LEN = 6

	const TEST_LEN = 32
	const TEST_SIZ = TEST_LEN * len( wstring )

	#macro do_test( init_string )

		scope
			dim s as wstring * TEST_LEN
			dim ps as wstring ptr
			
			s = init_string
			ps = @s
			
			CU_ASSERT( len( s ) = CODE_LEN )
			CU_ASSERT( len( *ps ) = CODE_LEN )

			CU_ASSERT( len( s ) = len( init_string ) )
			
			CU_ASSERT( sizeof( s ) = TEST_SIZ )
			
			CU_ASSERT( len( *ps ) = len( init_string ) )
			
			CU_ASSERT( len( ps ) = len( any ptr ) )
			
			CU_ASSERT( sizeof( ps ) = sizeof( any ptr ) )
		end scope

	#endmacro

	TEST( literal )

		do_test( "abcdef" )
		do_test( wstr( "abcdef" ) )
		do_test( !"bcd\u0065\u0066\u0067" )
		do_test( !"\u0063\u0064\u0065\u0065\u0067\u0068" )

	END_TEST

	TEST( literal_const )

		do_test( LIT_A1 )
		do_test( LIT_W1 )
		do_test( LIT_W2 )
		do_test( LIT_W3 )

	END_TEST

END_SUITE
