#include "fbcunit.bi"

SUITE( fbc_tests.pp.macro_eval_str )

	TEST( direct )
		CU_ASSERT_EQUAL( "", __FB_EVAL__( "" ) )
		CU_ASSERT_EQUAL( "A", __FB_EVAL__( "A" ) )
		CU_ASSERT_EQUAL( "A" + "B", __FB_EVAL__( "A" + "B" ) )
		CU_ASSERT_EQUAL( "A" + !"\0", __FB_EVAL__( "A" + !"\0" ) )
		CU_ASSERT_EQUAL( "A" + !"\0" + "B", __FB_EVAL__( "A" + !"\0" + "B" ) )
		CU_ASSERT_EQUAL( !"\\" + "\" + !"\\", __FB_EVAL__( !"\\" + "\" + !"\\" ) )

		CU_ASSERT_EQUAL( wstr(""), __FB_EVAL__( wstr("") ) )
		CU_ASSERT_EQUAL( wstr("A"), __FB_EVAL__( wstr("A") ) )
		CU_ASSERT_EQUAL( wstr("A") + wstr("B"), __FB_EVAL__( wstr("A") + wstr("B") ) )
		CU_ASSERT_EQUAL( wstr("A") + wstr(!"\0"), __FB_EVAL__( wstr("A") + wstr(!"\0") ) )
		CU_ASSERT_EQUAL( wstr("A") + wstr(!"\0") + wstr("B"), __FB_EVAL__( wstr("A") + wstr(!"\0") + wstr("B") ) )
		CU_ASSERT_EQUAL( wstr(!"\\") + wstr("\") + wstr(!"\\"), __FB_EVAL__( wstr(!"\\") + wstr("\") + wstr(!"\\") ) )

	END_TEST
	
	TEST( nulchar )
		const c as string = !"A\000B" 
		'' ensure that c has the embedded NUL
		CU_ASSERT_EQUAL( asc( c, 0 ), 0 )
		CU_ASSERT_EQUAL( asc( c, 1 ), 65 )
		CU_ASSERT_EQUAL( asc( c, 2 ), 0 )
		CU_ASSERT_EQUAL( asc( c, 3 ), 66 )
		CU_ASSERT_EQUAL( asc( c, 4 ), 0 )

		CU_ASSERT_EQUAL( c, __FB_EVAL__( !"A\000B" ) )
		CU_ASSERT_EQUAL( c, __FB_EVAL__( "A" + !"\0" + "B" ) )

#if ENABLE_CHECK_BUGS
		'' !!!FIXME!!! - const strings compared at compile time
		'' are handled like zstring ptr and the NUL CHAR ends the string
		'' fails because second string is truncated
		CU_ASSERT_NOT_EQUAL( !"A", !"A\000B" )
#endif

		dim s as string
		s = chr( 65, 0, 66 )

		'' ensure that s has the embedded NUL
		CU_ASSERT_EQUAL( asc( s, 0 ), 0 )
		CU_ASSERT_EQUAL( asc( s, 1 ), 65 )
		CU_ASSERT_EQUAL( asc( s, 2 ), 0 )
		CU_ASSERT_EQUAL( asc( s, 3 ), 66 )
		CU_ASSERT_EQUAL( asc( s, 4 ), 0 )

#if ENABLE_CHECK_BUGS
		'' !!!FIXME!!! - const string passed to rtlib as zstring ptr
		'' and the embedded NUL CHAR ends the string
		'' fails because CONST strings do not have a desriptot
		CU_ASSERT_EQUAL( s, __FB_EVAL__( !"A\000B" ) )
		CU_ASSERT_EQUAL( s, __FB_EVAL__( "A" + !"\0" + "B" ) )
#endif

#if ENABLE_CHECK_BUGS
		'' ensure that s and c compare the same
		'' !!!FIXME!!! - const string passed to rtlib as zstring ptr
		'' and the embedded NUL CHAR ends the string
		'' fails because CONST strings do not have a desriptot
		CU_ASSERT_EQUAL( c, s )		
#endif
	
	END_TEST

END_SUITE
