#include "fbcunit.bi"

SUITE( fbc_tests.string_.instrrev_0 )

	'' whole string test
	TEST( wholeStringTest )

		CU_ASSERT_EQUAL( 1 , instrrev(chr(0)+"asd", chr(0)) )
		CU_ASSERT_EQUAL( 4 , instrrev(chr(0)+"asd", "d") )
		CU_ASSERT_EQUAL( 2 , instrrev(chr(0)+"asd", "a") )
		CU_ASSERT_EQUAL( 3 , instrrev(chr(0)+"asd", "sd") )
		CU_ASSERT_EQUAL( 0 , instrrev(chr(0)+"asd", "") )
		CU_ASSERT_EQUAL( 0 , instrrev(chr(0)+"asd", "asdfg") )
		CU_ASSERT_EQUAL( 0 , instrrev(chr(0)+"asd", "qwe") )
		CU_ASSERT_EQUAL( 0 , instrrev("", "asdf") )
		CU_ASSERT_EQUAL( 0 , instrrev("", "") )

	END_TEST

	'' partial string test
	TEST( partialStringTest )

		CU_ASSERT_EQUAL( 1 , instrrev( chr(0)+"asd", chr(0), 3) )
		CU_ASSERT_EQUAL( 0 , instrrev( chr(0)+"asd", "d", 3) )
		CU_ASSERT_EQUAL( 2 , instrrev( chr(0)+"asd", "a", 3) )
		CU_ASSERT_EQUAL( 3 , instrrev( chr(0)+"asd", "sd", 3) )
		CU_ASSERT_EQUAL( 0 , instrrev( chr(0)+"asd", "", 3) )
		CU_ASSERT_EQUAL( 0 , instrrev( chr(0)+"asd", "asdfg", 3) )
		CU_ASSERT_EQUAL( 0 , instrrev( chr(0)+"asd", "qwe", 3) )
		CU_ASSERT_EQUAL( 0 , instrrev( "", "asdf", 3) )
		CU_ASSERT_EQUAL( 0 , instrrev( "", "", 3) )

	END_TEST

	#define DoTest( s1, s2, start, exp_result ) _
		CU_ASSERT_EQUAL( exp_result, InstrRev(s1,s2,start) )

	'' check every input value test
	TEST( checkEveryInputValueTest )

		dim a as string 
		dim b as string 

		a = "thes is the the string"
		b = "the"

		DoTest( a, b, 23, 0 )
		DoTest( a, b, 22, 13 )
		DoTest( a, b, 21, 13 )
		DoTest( a, b, 20, 13 )
		DoTest( a, b, 19, 13 )
		DoTest( a, b, 18, 13 )
		DoTest( a, b, 17, 13 )
		DoTest( a, b, 16, 13 )
		DoTest( a, b, 15, 13 )
		DoTest( a, b, 14, 13 )
		DoTest( a, b, 13, 13 )
		DoTest( a, b, 12, 9 )
		DoTest( a, b, 11, 9 )
		DoTest( a, b, 10, 9 )
		DoTest( a, b, 9, 9 )
		DoTest( a, b, 8, 1 )
		DoTest( a, b, 7, 1 )
		DoTest( a, b, 6, 1 )
		DoTest( a, b, 5, 1 )
		DoTest( a, b, 4, 1 )
		DoTest( a, b, 3, 1 )
		DoTest( a, b, 2, 1 )
		DoTest( a, b, 1, 1 )
		DoTest( a, b, 0, 0 )
		DoTest( a, b, -1, 13 )

		a = "xxx the"
		b = "the"

		DoTest( a, b, 8, 0 )
		DoTest( a, b, 7, 5 )
		DoTest( a, b, 6, 5 )
		DoTest( a, b, 5, 5 )
		DoTest( a, b, 4, 0 )
		DoTest( a, b, 3, 0 )
		DoTest( a, b, 2, 0 )
		DoTest( a, b, 1, 0 )
		DoTest( a, b, 0, 0 )
		DoTest( a, b, -1, 5 )

		a = " test   test "
		b = "test"

		DoTest( a, b, 14, 0 )
		DoTest( a, b, 13, 9 )
		DoTest( a, b, 12, 9 )
		DoTest( a, b, 11, 9 )
		DoTest( a, b, 10, 9 )
		DoTest( a, b,  9, 9 )
		DoTest( a, b,  8, 2 )
		DoTest( a, b,  7, 2 )
		DoTest( a, b,  6, 2 )
		DoTest( a, b,  5, 2 )
		DoTest( a, b,  4, 2 )
		DoTest( a, b,  3, 2 )
		DoTest( a, b,  2, 2 )
		DoTest( a, b,  1, 0 )
		DoTest( a, b,  0, 0 )
		DoTest( a, b, -1, 9 )

		a = "xxx"
		b = "xxx"

		DoTest( "", "", 0, 0 )
		DoTest( a , "", 0, 0 )
		DoTest( "",  b, 0, 0 )

	END_TEST

END_SUITE
