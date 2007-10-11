# include once "fbcu.bi"




namespace fbc_tests.expressions.iif2_tests

const TEST_VAL as integer = 1234

sub test_1 cdecl ()
	dim value as integer = TEST_VAL
	dim test as integer = 0
	
	value += iif (test > 5, 10, -10) + iif (test < 5, 10, -10)
	CU_ASSERT_EQUAL( value, TEST_VAL )

	value += iif (test > -5, 10, -10) + iif (test < -5, 10, -10)
	CU_ASSERT_EQUAL( value, TEST_VAL )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc-tests-expressions-iif")
	fbcu.add_test("test 1", @test_1)

end sub

end namespace
