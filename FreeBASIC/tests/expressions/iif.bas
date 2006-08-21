# include once "fbcu.bi"




namespace fbc_tests.expressions.iif_tests

sub test_1 cdecl ()
	const TEST1 = 1234
	const TEST2 = 5678

	dim as integer res
	
	res = (TEST1 xor iif (CU_TRUE, TEST1, TEST2)) or (iif (CU_FALSE, TEST2, TEST1) xor TEST1)
	
	CU_ASSERT_EQUAL( res, 0 )
	
	res = (TEST2 xor iif (CU_FALSE, TEST1, TEST2)) or (iif (CU_TRUE, TEST2, TEST1) xor TEST2)
	
	CU_ASSERT_EQUAL( res, 0 )
	
end sub

sub test_2 cdecl ()
	const TEST1 as double = 1234.0
	const TEST2 as double = 5678.0

	dim as double res

	res = iif (CU_TRUE, TEST1, 0.0 ) * iif (CU_FALSE, 0.0, TEST2)
	
	CU_ASSERT_EQUAL( res, TEST1 * TEST2 )
	
end sub

sub ctor () constructor

	fbcu.add_suite("fbc-tests-expressions-iif")
	fbcu.add_test("test 1", @test_1)
	fbcu.add_test("test 2", @test_2)

end sub

end namespace 
