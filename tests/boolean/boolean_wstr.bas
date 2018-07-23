# include "fbcunit.bi"

'' - don't mix false/true intrinsic constants 
''   of the compiler in with the tests
#undef FALSE
#undef TRUE

#define FALSE 0
#define TRUE (-1)

const FALSE_WSTRING = wstr("false")
const TRUE_WSTRING = wstr("true")

SUITE( fbc_tests.boolean_.boolean_wstr )

	'' RTLIB - BOOL2WSTR

	TEST( wstr_true_false_constants )

		'' check that BOOL->WSTR is returning _LC("false") | _LC("true")
		
		dim b as boolean

		b = FALSE
		CU_ASSERT_EQUAL( wstr(b), FALSE_WSTRING)

		b = TRUE
		CU_ASSERT_EQUAL( wstr(b), TRUE_WSTRING)

	END_TEST
	
	TEST( wstr_const_comparison )

		'' check conversion in const comparison

		CU_ASSERT_EQUAL( wstr(cbool(FALSE)), FALSE_WSTRING )
		CU_ASSERT_EQUAL( wstr(cbool(TRUE)), TRUE_WSTRING )

	END_TEST

	TEST( wstr_const_assignment )

		'' check conversion in const assignment

		dim e as string

		e = wstr(cbool(FALSE))
		CU_ASSERT_EQUAL( e, FALSE_WSTRING )

		e = wstr(cbool(TRUE))
		CU_ASSERT_EQUAL( e, TRUE_WSTRING )

	END_TEST
	
	TEST( wstr_conv_initialize )

		'' check conversion on initialize

		dim b1 as boolean = cbool(FALSE)
		dim s1 as wstring * 80 = wstr(cbool(FALSE))	'' const init
		dim s2 as wstring * 80 = wstr(b1)				'' expr init

		CU_ASSERT_EQUAL( s1, wstr(b1) )
		CU_ASSERT_EQUAL( s2, wstr(b1) )

		dim b2 as boolean = cbool(TRUE)
		dim s3 as string = wstr(cbool(TRUE))		'' const init
		dim s4 as string = wstr(b2)				'' expr init

		CU_ASSERT_EQUAL( s3, wstr(b2) )
		CU_ASSERT_EQUAL( s4, wstr(b2) )

	END_TEST
	
	TEST( wstr_conv_expression )

		'' check conversion of bool expressions

		dim b1 as boolean
		dim b2 as boolean
		dim s as wstring * 80

		b1 = TRUE
		b2 = FALSE

		CU_ASSERT_EQUAL( wstr(b1 OR b2), TRUE_WSTRING )
		CU_ASSERT_EQUAL( wstr(b1 AND b2), FALSE_WSTRING )
		CU_ASSERT_EQUAL( wstr(NOT b1), FALSE_WSTRING )
		CU_ASSERT_EQUAL( wstr(NOT b2), TRUE_WSTRING )
		CU_ASSERT_EQUAL( wstr(NOT b2), TRUE_WSTRING )
		CU_ASSERT_EQUAL( wstr(b1 AND NOT b2), TRUE_WSTRING )
		CU_ASSERT_EQUAL( wstr(b1 OR  NOT b2), TRUE_WSTRING )
		CU_ASSERT_EQUAL( wstr(NOT b1 AND b2), FALSE_WSTRING )
		CU_ASSERT_EQUAL( wstr(NOT b1 OR b2), FALSE_WSTRING )
		CU_ASSERT_EQUAL( wstr(NOT b1 AND NOT b2), FALSE_WSTRING )
		CU_ASSERT_EQUAL( wstr(NOT b1 OR NOT b2), TRUE_WSTRING )
		CU_ASSERT_EQUAL( wstr(b1 = b2), FALSE_WSTRING )
		CU_ASSERT_EQUAL( wstr(b1 <> b2), TRUE_WSTRING )

	END_TEST

	TEST( wstr_conv_variable )
		
		'' check conversion of bool variable

		dim b as boolean
		dim s as wstring * 80

		b = FALSE
		s = wstr(b)
		CU_ASSERT_EQUAL( s, FALSE_WSTRING )

		b = TRUE
		s = wstr(b)
		CU_ASSERT_EQUAL( s, TRUE_WSTRING )

	END_TEST
	
	TEST( wstr_conv_concatenate )

		'' check wstring concatenate

		dim b as boolean
		dim s as wstring * 80
		dim t as wstring * 80 = "1" + FALSE_WSTRING + "2" + FALSE_WSTRING + "3" + FALSE_WSTRING + "4"

		b = FALSE
		s = wstr("1") & b
		s += wstr("2")
		s += wstr(b)
		s &= wstr("3")
		s &= b
		s &= wstr("4")

		CU_ASSERT_EQUAL( s, t )

	END_TEST

END_SUITE
