#include "fbcunit.bi"

SUITE( fbc_tests.pp.macro_eval_str )

	TEST( direct )
		CU_ASSERT_EQUAL( "", __FB_EVAL__( "" ) )
		CU_ASSERT_EQUAL( "A", __FB_EVAL__( "A" ) )
		CU_ASSERT_EQUAL( "A" + "B", __FB_EVAL__( "A" + "B" ) )
		CU_ASSERT_EQUAL( "A" + !"\0", __FB_EVAL__( "A" + !"\0" ) )
		CU_ASSERT_EQUAL( "A" + !"\0" + "B", __FB_EVAL__( "A" + !"\0" + "B" ) )
		CU_ASSERT_EQUAL( !"\\" + "\" + !"\\", __FB_EVAL__( !"\\" + "\" + !"\\" ) )

	END_TEST
	
	TEST( nulchar )
		dim s as string
		s = chr( 65, 0, 66 )
#if ENABLE_CHECK_BUGS
		'' fbc doesn't handle literal strings with embedded NUL CHAR well
		CU_ASSERT_EQUAL( s, __FB_EVAL__( !"A\000B" ) )
		CU_ASSERT_EQUAL( s, __FB_EVAL__( "A" + !"\0" + "B" ) )
#endif
	END_TEST

END_SUITE
