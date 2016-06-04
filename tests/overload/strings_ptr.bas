# include "fbcu.bi"

namespace fbc_tests.overloads.strings_ptr

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

sub test_literals cdecl ()
	RUN_TESTS("123")
end sub	

sub test_string cdecl ()
	dim s as string

	RUN_TESTS(s)
end sub

sub test_fixed_string cdecl ()
	dim fs as string * 10

	RUN_TESTS(fs)
end sub	

sub test_zstring cdecl ()
	dim zs as zstring * 10

	RUN_TESTS(zs)
end sub	

sub test_zstring_ptr cdecl ()
	dim zsp as zstring ptr

	RUN_TESTS(zsp)
end sub	

sub test_fixed_wstring cdecl ()
	dim fws as wstring * 10

	CU_ASSERT_EQUAL( RESULT_WW, proc( fws, fws ) )
	CU_ASSERT_EQUAL( RESULT_WW, proc( fws, wstr(fws) ) )
	CU_ASSERT_EQUAL( RESULT_WW, proc( wstr(fws), fws ) )
	CU_ASSERT_EQUAL( RESULT_WW, proc( wstr(fws), wstr(fws) ) )
	CU_ASSERT_EQUAL( RESULT_W, proc( wstr(fws) ) )
	CU_ASSERT_EQUAL( RESULT_W, proc( fws ) )
end sub	

sub test_wstring_ptr cdecl ()
	dim wsp as wstring ptr

	CU_ASSERT_EQUAL( RESULT_WW, proc( wsp, wsp ) )
	CU_ASSERT_EQUAL( RESULT_WW, proc( wsp, wstr(wsp) ) )
	CU_ASSERT_EQUAL( RESULT_WW, proc( wstr(wsp), wsp ) )
	CU_ASSERT_EQUAL( RESULT_WW, proc( wstr(wsp), wstr(wsp) ) )
	CU_ASSERT_EQUAL( RESULT_W, proc( wstr(wsp) ) )
	CU_ASSERT_EQUAL( RESULT_W, proc( wsp ) )
end sub	

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.overload.strings_ptr")
	fbcu.add_test("test_literals", @test_literals)
	fbcu.add_test("test_string", @test_string)
	fbcu.add_test("test_fixed_string", @test_fixed_string)
	fbcu.add_test("test_zstring", @test_zstring)
	fbcu.add_test("test_zstring_ptr", @test_zstring_ptr)
	fbcu.add_test("test_fixed_wstring", @test_fixed_wstring)
	fbcu.add_test("test_wstring ptr", @test_wstring_ptr)

end sub

end namespace
