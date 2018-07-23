#include "fbcunit.bi"

SUITE( fbc_tests.overload_.strings )

	enum RESULT
	   RESULT_ZSTRING
	   RESULT_WSTRING
	end enum

	function proc overload ( byval s as zstring ptr ) as RESULT
		function = RESULT_ZSTRING
	end function

	function proc overload ( byval s as wstring ptr ) as RESULT
		function = RESULT_WSTRING
	end function

	TEST( variables )

		dim as string s
		dim as string * 4 f
		dim as zstring * 4 z
		dim as wstring * 4 w
		dim as string ptr ps = @s
		dim as zstring ptr pz = @z
		dim as wstring ptr pw = @w
		
		CU_ASSERT_EQUAL( proc( s ), RESULT_ZSTRING )
		CU_ASSERT_EQUAL( proc( f ), RESULT_ZSTRING )
		CU_ASSERT_EQUAL( proc( z ), RESULT_ZSTRING )
		CU_ASSERT_EQUAL( proc( w ), RESULT_WSTRING )
		
		CU_ASSERT_EQUAL( proc( *ps ), RESULT_ZSTRING )
		CU_ASSERT_EQUAL( proc( pz ), RESULT_ZSTRING )
		CU_ASSERT_EQUAL( proc( pw ), RESULT_WSTRING )
		CU_ASSERT_EQUAL( proc( *pz ), RESULT_ZSTRING )
		CU_ASSERT_EQUAL( proc( *pw ), RESULT_WSTRING )
		
	END_TEST

	TEST( literals )

		CU_ASSERT_EQUAL( proc( "abc" ), RESULT_ZSTRING )
		CU_ASSERT_EQUAL( proc( wstr( "abc" ) ), RESULT_WSTRING )

	END_TEST

END_SUITE
