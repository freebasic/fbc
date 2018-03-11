# include once "fbcunit.bi"

SUITE( fbc_tests.expressions.div_by_zero )

	TEST( testproc )
		dim as double a = 1, b = 0, c

		c = 1.0 / 0.0  '' no compile error, but returns INF
		CU_ASSERT_TRUE( fbcu.dblIsInf(c) )

		c = a / 0.0    '' no compile error, but returns INF
		CU_ASSERT_TRUE( fbcu.dblIsInf(c) )

		c = 1.0 / b    '' no runtime error, but returns INF
		CU_ASSERT_TRUE( fbcu.dblIsInf(c) )

		c = a / b      '' no runtime error, but returns INF
		CU_ASSERT_TRUE( fbcu.dblIsInf(c) )

	END_TEST

END_SUITE
