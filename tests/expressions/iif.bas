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

sub test_3 cdecl ()
	dim TEST1 as string = "1234"
	dim TEST2 as string = "5678"

	dim as string res
	dim as integer q

	q = 1
	res = iif (q, TEST1, TEST2)

	CU_ASSERT_EQUAL( res, TEST1 )

	q = 0
	res = iif (q, TEST1, TEST2)

	CU_ASSERT_EQUAL( res, TEST2 )

end sub

sub test_4 cdecl ()
	dim TEST1 as zstring * 5 = "1234"
	dim TEST2 as zstring * 5 = "5678"

	dim as zstring * 5 res
	dim as integer q

	q = 1
	res = iif (q, TEST1, TEST2)

	CU_ASSERT_EQUAL( res, TEST1 )

	q = 0
	res = iif (q, TEST1, TEST2)

	CU_ASSERT_EQUAL( res, TEST2 )

end sub

sub test_5 cdecl ()
	dim TEST1 as wstring * 5 = "1234"
	dim TEST2 as wstring * 5 = "5678"

	dim as wstring * 5 res
	dim as integer q

	q = 1
	res = iif (q, TEST1, TEST2)

	CU_ASSERT_EQUAL( res, TEST1 )

	q = 0
	res = iif (q, TEST1, TEST2)

	CU_ASSERT_EQUAL( res, TEST2 )

end sub

sub test_6 cdecl ()
	dim TEST1 as string = "1234"
	dim TEST2 as string = "5678"
	dim TEST3 as string = "abcd"

	dim as string res
	dim as integer q1, q2

	q1 = 0
	q2 = 0
	res = iif (q1, TEST1, iif (q2, TEST2, TEST3))

	CU_ASSERT_EQUAL( res, TEST3 )

	q1 = 0
	q2 = 1
	res = iif (q1, TEST1, iif (q2, TEST2, TEST3))

	CU_ASSERT_EQUAL( res, TEST2 )

	q1 = 1
	q2 = 0
	res = iif (q1, TEST1, iif (q2, TEST2, TEST3))

	CU_ASSERT_EQUAL( res, TEST1 )

end sub

sub test_7_inner1(byval TEST1 as string, byval TEST2 as string)

	dim as string res
	dim as integer q

	q = 1
	res = iif (q, TEST1, TEST2)

	CU_ASSERT_EQUAL( res, TEST1 )

	q = 0
	res = iif (q, TEST1, TEST2)

	CU_ASSERT_EQUAL( res, TEST2 )

end sub

sub test_7_inner2(byref TEST1 as string, byref TEST2 as string)

	dim as string res
	dim as integer q

	q = 1
	res = iif (q, TEST1, TEST2)

	CU_ASSERT_EQUAL( res, TEST1 )

	q = 0
	res = iif (q, TEST1, TEST2)

	CU_ASSERT_EQUAL( res, TEST2 )

end sub

sub test_7 cdecl ()
	dim TEST1 as string = "1234"
	dim TEST2 as string = "5678"

	test_7_inner1(TEST1, TEST2)
	test_7_inner2(TEST1, TEST2)

	test_7_inner1("1234", "5678")
	test_7_inner2("1234", "5678")

end sub

sub test_8 cdecl ()
	dim TEST1 as string * 5 = "1234"
	dim TEST2 as string * 5 = "5678"

	dim as string * 5 res
	dim as integer q

	q = 1
	res = iif (q, TEST1, TEST2)

	CU_ASSERT_EQUAL( res, TEST1 )

	q = 0
	res = iif (q, TEST1, TEST2)

	CU_ASSERT_EQUAL( res, TEST2 )

end sub

sub test_9 cdecl ()
	dim as integer q

	q = 1
	CU_ASSERT_EQUAL( iif (q, "1234", "5678"), "1234" )

	q = 0
	CU_ASSERT_EQUAL( iif (q, "1234", "5678"), "5678" )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc-tests-expressions-iif")
	fbcu.add_test("test 1", @test_1)
	fbcu.add_test("test 2", @test_2)
	fbcu.add_test("test 3", @test_3)
	fbcu.add_test("test 4", @test_4)
	fbcu.add_test("test 5", @test_5)
	fbcu.add_test("test 6", @test_6)
	fbcu.add_test("test 7", @test_7)
	fbcu.add_test("test 8", @test_8)
	fbcu.add_test("test 9", @test_9)

end sub

end namespace
