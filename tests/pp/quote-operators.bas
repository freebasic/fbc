#include "fbcunit.bi"

SUITE( fbc_tests.pp.quote_operators )

	TEST( direct )

		'' previously, these operators where joined together
		'' because the lexer was skipping the whitespace in
		'' between the operators.

		'' do a test for common operators and check
		'' that whitespace is preserved for certain cases

		#macro check( arg, compare )
			scope
				dim s as string
				s = __fb_quote__( arg )
				CU_ASSERT_EQUAL( s, compare )
			end scope
		#endmacro

		check(1 = 2, "1 = 2" )
		check(1 + 2, "1 + 2" )
		check(1 - 2, "1 - 2" )
		check(1 / 2, "1 / 2" )
		check(1 \ 2, "1 \ 2" )
		check(1 * 2, "1 * 2" )
		check(1 ^ 2, "1 ^ 2" )

		check(1 < 2, "1 < 2" )
		check(1 > 2, "1 > 2" )

		check(1 <> 2, "1 <> 2" )
		check(1 <= 2, "1 <= 2" )
		check(1 >= 2, "1 >= 2" )
		check(1 -> 2, "1 -> 2" )

		check(1 < > 2, "1 < > 2" )
		check(1 < = 2, "1 < = 2" )
		check(1 > = 2, "1 > = 2" )
		check(1 - > 2, "1 - > 2" )

	END_TEST

END_SUITE
