#include "fbcunit.bi"

SUITE( fbc_tests.pp.macro_eval )

	TEST( direct )
		CU_ASSERT_EQUAL( 0, __FB_EVAL__( 0 ) )
		CU_ASSERT_EQUAL( 8, __FB_EVAL__( 3 + 5 ) )
		CU_ASSERT_EQUAL( "hithere", __FB_EVAL__( "hi" + "there" ) )
	END_TEST

	TEST( pp_ )
	    #macro assign( sym, expr )
		#define tmp __FB_EVAL__( expr )
		__FB_UNQUOTE__( __FB_EVAL__( "#undef " + sym ) )
		__FB_UNQUOTE__( __FB_EVAL__( "#define " + sym + " " + __FB_QUOTE__( tmp ) ) )
		#undef tmp
		#endmacro

		assign( "x", 1 )
		CU_ASSERT_EQUAL( x, 1 )
		
		assign( "x", x+1 )
		CU_ASSERT_EQUAL( x, 2 )
		
		assign( "x", x*x )  
		CU_ASSERT_EQUAL( x, 4 ) 
		
		assign( "x", "hello" )  
		CU_ASSERT_EQUAL( x, "hello" )
		
		assign( "x", x+x )  
		CU_ASSERT_EQUAL( x, "hellohello" )
	END_TEST

END_SUITE
