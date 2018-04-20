#include "fbcunit.bi"

SUITE( fbc_tests.overload_.strings_ptr )

	enum RESULT
		RESULT_W
		RESULT_WW
		RESULT_WZ
		RESULT_Z
		RESULT_ZW
		RESULT_ZZ
	end enum

	function proc overload( byval bar as zstring ptr, byval baz as zstring ptr ) as RESULT
		function = RESULT_ZZ
	end function

	function proc overload( byval bar as zstring ptr, byval baz as wstring ptr ) as RESULT
		function = RESULT_ZW
	end function

	function proc overload( byval bar as wstring ptr, byval baz as zstring ptr ) as RESULT
		function = RESULT_WZ
	end function
		
	function proc overload( byval bar as wstring ptr, byval baz as wstring ptr ) as RESULT
		function = RESULT_WW
	end function
		
	function proc overload( byval bar as zstring ptr ) as RESULT
		function = RESULT_Z
	end function

	function proc overload( byval bar as wstring ptr ) as RESULT
		function = RESULT_W
	end function
		
	# macro RUN_TESTS(s)
		CU_ASSERT_EQUAL( RESULT_ZZ, proc( s, s ) )
		CU_ASSERT_EQUAL( RESULT_ZW, proc( s, wstr(s) ) )
		CU_ASSERT_EQUAL( RESULT_WZ, proc( wstr(s), s ) )
		CU_ASSERT_EQUAL( RESULT_WW, proc( wstr(s), wstr(s) ) )
		CU_ASSERT_EQUAL( RESULT_W, proc( wstr(s) ) )
		CU_ASSERT_EQUAL( RESULT_Z, proc( s ) )
	# endmacro

	TEST( literals )
		RUN_TESTS("123")
	END_TEST

	TEST( strings )
		dim s as string

		RUN_TESTS(s)
	END_TEST

	TEST( fixed_strings )
		dim fs as string * 10

		RUN_TESTS(fs)
	END_TEST

	TEST( zstrings )
		dim zs as zstring * 10

		RUN_TESTS(zs)
	END_TEST

	TEST( zstring_ptrs )
		dim zsp as zstring ptr

		RUN_TESTS(zsp)
	END_TEST

	TEST( fixed_wstrings )
		dim fws as wstring * 10

		CU_ASSERT_EQUAL( RESULT_WW, proc( fws, fws ) )
		CU_ASSERT_EQUAL( RESULT_WW, proc( fws, wstr(fws) ) )
		CU_ASSERT_EQUAL( RESULT_WW, proc( wstr(fws), fws ) )
		CU_ASSERT_EQUAL( RESULT_WW, proc( wstr(fws), wstr(fws) ) )
		CU_ASSERT_EQUAL( RESULT_W, proc( wstr(fws) ) )
		CU_ASSERT_EQUAL( RESULT_W, proc( fws ) )
	END_TEST

	TEST( wstring_ptrs )
		dim wsp as wstring ptr

		CU_ASSERT_EQUAL( RESULT_WW, proc( wsp, wsp ) )
		CU_ASSERT_EQUAL( RESULT_WW, proc( wsp, wstr(wsp) ) )
		CU_ASSERT_EQUAL( RESULT_WW, proc( wstr(wsp), wsp ) )
		CU_ASSERT_EQUAL( RESULT_WW, proc( wstr(wsp), wstr(wsp) ) )
		CU_ASSERT_EQUAL( RESULT_W, proc( wstr(wsp) ) )
		CU_ASSERT_EQUAL( RESULT_W, proc( wsp ) )
	END_TEST

END_SUITE
