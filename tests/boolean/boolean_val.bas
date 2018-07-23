# include "fbcunit.bi"

'' - don't mix false/true intrinsic constants 
''   of the compiler in with the tests
#undef FALSE
#undef TRUE

#define FALSE 0
#define TRUE (-1)

const FALSE_STRING = "false"
const TRUE_STRING = "true"

SUITE( fbc_tests.boolean_.boolean_val )

	'' -----------------------------------
	'' RTLIB - STR2BOOL - valbool(string)
	'' -----------------------------------
	
	TEST( valbool_const_str )
		
		'' constants

		CU_ASSERT_EQUAL( cbool(TRUE) , cbool("true") )
		CU_ASSERT_EQUAL( cbool(FALSE), cbool("false") )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool("TRUE") )
		CU_ASSERT_EQUAL( cbool(FALSE), cbool("FALSE") )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool("True") )
		CU_ASSERT_EQUAL( cbool(FALSE), cbool("False") )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool("TrUe") )
		CU_ASSERT_EQUAL( cbool(FALSE), cbool("FaLsE") )
		CU_ASSERT_EQUAL( cbool(FALSE), cbool("0") )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool("1") )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool("-1") )
		CU_ASSERT_EQUAL( cbool(FALSE), cbool("+0.0") )
		CU_ASSERT_EQUAL( cbool(FALSE), cbool("-0.0") )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool("-1.234e+4") )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool("-1.234d+4") )
		CU_ASSERT_EQUAL( cbool(FALSE), cbool("&h0") )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool("&h1") )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool("&hffffffff") )
		CU_ASSERT_EQUAL( cbool(FALSE), cbool("&b0") )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool("&b1") )

	END_TEST

	TEST( valbool_variable_str )

		'' variables

		dim s as string

		s = "true"       : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = "false"      : CU_ASSERT_EQUAL( cbool(FALSE), cbool(s) )
		s = "TRUE"       : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = "FALSE"      : CU_ASSERT_EQUAL( cbool(FALSE), cbool(s) )
		s = "True"       : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = "False"      : CU_ASSERT_EQUAL( cbool(FALSE), cbool(s) )
		s = "TrUe"       : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = "FaLsE"      : CU_ASSERT_EQUAL( cbool(FALSE), cbool(s) )
		s = "0"          : CU_ASSERT_EQUAL( cbool(FALSE), cbool(s) )
		s = "1"          : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = "-1"         : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = "+0.0"       : CU_ASSERT_EQUAL( cbool(FALSE), cbool(s) )
		s = "-0.0"       : CU_ASSERT_EQUAL( cbool(FALSE), cbool(s) )
		s = "-1.234e+4"  : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = "-1.234d+4"  : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = "&h0"        : CU_ASSERT_EQUAL( cbool(FALSE), cbool(s) )
		s = "&h1"        : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = "&hffffffff" : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = "&b0"        : CU_ASSERT_EQUAL( cbool(FALSE), cbool(s) )
		s = "&b1"        : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )

	END_TEST


	'' -----------------------------------
	'' RTLIB - STR2BOOL - valbool(wstring)
	'' -----------------------------------

	TEST( valbool_const_wstr )

		'' constants
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool(wstr("true")) )
		CU_ASSERT_EQUAL( cbool(FALSE), cbool(wstr("false")) )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool(wstr("TRUE")) )
		CU_ASSERT_EQUAL( cbool(FALSE), cbool(wstr("FALSE")) )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool(wstr("True")) )
		CU_ASSERT_EQUAL( cbool(FALSE), cbool(wstr("False")) )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool(wstr("TrUe")) )
		CU_ASSERT_EQUAL( cbool(FALSE), cbool(wstr("FaLsE")) )
		CU_ASSERT_EQUAL( cbool(FALSE), cbool(wstr("0")) )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool(wstr("1")) )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool(wstr("-1")) )
		CU_ASSERT_EQUAL( cbool(FALSE), cbool(wstr("+0.0")) )
		CU_ASSERT_EQUAL( cbool(FALSE), cbool(wstr("-0.0")) )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool(wstr("-1.234e+4")) )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool(wstr("-1.234d+4")) )
		CU_ASSERT_EQUAL( cbool(FALSE), cbool(wstr("&h0")) )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool(wstr("&h1")) )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool(wstr("&hffffffff")) )
		CU_ASSERT_EQUAL( cbool(FALSE), cbool(wstr("&b0")) )
		CU_ASSERT_EQUAL( cbool(TRUE) , cbool(wstr("&b1")) )

	END_TEST

	TEST( valbool_variable_wstr )

		'' variables

		dim s as wstring * 80

		s = wstr("true")       : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = wstr("false")      : CU_ASSERT_EQUAL( cbool(FALSE), cbool(s) )
		s = wstr("TRUE")       : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = wstr("FALSE")      : CU_ASSERT_EQUAL( cbool(FALSE), cbool(s) )
		s = wstr("True")       : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = wstr("False")      : CU_ASSERT_EQUAL( cbool(FALSE), cbool(s) )
		s = wstr("TrUe")       : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = wstr("FaLsE")      : CU_ASSERT_EQUAL( cbool(FALSE), cbool(s) )
		s = wstr("0")          : CU_ASSERT_EQUAL( cbool(FALSE), cbool(s) )
		s = wstr("1")          : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = wstr("-1")         : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = wstr("+0.0")       : CU_ASSERT_EQUAL( cbool(FALSE), cbool(s) )
		s = wstr("-0.0")       : CU_ASSERT_EQUAL( cbool(FALSE), cbool(s) )
		s = wstr("-1.234e+4")  : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = wstr("-1.234d+4")  : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = wstr("&h0")        : CU_ASSERT_EQUAL( cbool(FALSE), cbool(s) )
		s = wstr("&h1")        : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = wstr("&hffffffff") : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )
		s = wstr("&b0")        : CU_ASSERT_EQUAL( cbool(FALSE), cbool(s) )
		s = wstr("&b1")        : CU_ASSERT_EQUAL( cbool(TRUE) , cbool(s) )

	END_TEST

END_SUITE
