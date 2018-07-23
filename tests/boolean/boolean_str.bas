# include "fbcunit.bi"

'' - don't mix false/true intrinsic constants 
''   of the compiler in with the tests
#undef FALSE
#undef TRUE

#define FALSE 0
#define TRUE (-1)

const FALSE_STRING = "false"
const TRUE_STRING = "true"

SUITE( fbc_tests.boolean_.boolean_str )

	'' RTLIB - BOOL2STR

	TEST( str_true_false_constants )

		'' check that BOOL->STR is returning "false" | "true"
		
		dim b as boolean

		b = FALSE
		CU_ASSERT_EQUAL( str(b), FALSE_STRING)

		b = TRUE
		CU_ASSERT_EQUAL( str(b), TRUE_STRING)

	END_TEST
	
	TEST( str_const_comparison )

		'' check conversion in const comparison

		CU_ASSERT_EQUAL( str(cbool(FALSE)), FALSE_STRING )
		CU_ASSERT_EQUAL( str(cbool(TRUE)), TRUE_STRING )

	END_TEST

	TEST( str_const_assignment )

		'' check conversion in const assignment

		dim e as string

		e = str(cbool(FALSE))
		CU_ASSERT_EQUAL( e, FALSE_STRING )

		e = str(cbool(TRUE))
		CU_ASSERT_EQUAL( e, TRUE_STRING )

	END_TEST
	
	TEST( str_conv_initialize )

		'' check conversion on initialize

		dim b1 as boolean = cbool(FALSE)
		dim s1 as string = str(cbool(FALSE))	'' const init
		dim s2 as string = str(b1)				'' expr init

		CU_ASSERT_EQUAL( s1, str(b1) )
		CU_ASSERT_EQUAL( s2, str(b1) )

		dim b2 as boolean = cbool(TRUE)
		dim s3 as string = str(cbool(TRUE))	'' const init
		dim s4 as string = str(b2)				'' expr init

		CU_ASSERT_EQUAL( s3, str(b2) )
		CU_ASSERT_EQUAL( s4, str(b2) )

	END_TEST

	
	TEST( str_conv_expression )

		'' check conversion of bool expressions

		dim b1 as boolean
		dim b2 as boolean
		dim s as string

		b1 = TRUE
		b2 = FALSE

		CU_ASSERT_EQUAL( str(b1 OR b2), TRUE_STRING )
		CU_ASSERT_EQUAL( str(b1 AND b2), FALSE_STRING )
		CU_ASSERT_EQUAL( str(NOT b1), FALSE_STRING )
		CU_ASSERT_EQUAL( str(NOT b2), TRUE_STRING )
		CU_ASSERT_EQUAL( str(NOT b2), TRUE_STRING )
		CU_ASSERT_EQUAL( str(b1 AND NOT b2), TRUE_STRING )
		CU_ASSERT_EQUAL( str(b1 OR  NOT b2), TRUE_STRING )
		CU_ASSERT_EQUAL( str(NOT b1 AND b2), FALSE_STRING )
		CU_ASSERT_EQUAL( str(NOT b1 OR b2), FALSE_STRING )
		CU_ASSERT_EQUAL( str(NOT b1 AND NOT b2), FALSE_STRING )
		CU_ASSERT_EQUAL( str(NOT b1 OR NOT b2), TRUE_STRING )
		CU_ASSERT_EQUAL( str(b1 = b2), FALSE_STRING )
		CU_ASSERT_EQUAL( str(b1 <> b2), TRUE_STRING )

	END_TEST

	TEST( str_conv_variable )
		
		'' check conversion of bool variable

		dim b as boolean
		dim s as string

		b = FALSE
		s = str(b)
		CU_ASSERT_EQUAL( s, FALSE_STRING )

		b = TRUE
		s = str(b)
		CU_ASSERT_EQUAL( s, TRUE_STRING )

	END_TEST
	
	TEST( str_conv_concatenate )

		'' check string concatenate

		dim b as boolean
		dim s as string
		dim t as string = "1" + FALSE_STRING + "2" + FALSE_STRING + "3" + FALSE_STRING + "4"

		b = FALSE
		s = "1" & b
		s += "2"
		s += str(b)
		s &= "3"
		s &= b
		s &= "4"

		CU_ASSERT_EQUAL( s, t )

	END_TEST

END_SUITE
