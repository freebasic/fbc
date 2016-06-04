# include "fbcu.bi"



namespace fbc_tests.overloads.strings

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

sub test_vars cdecl ()

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
	
end sub

sub test_literals cdecl ()

	CU_ASSERT_EQUAL( proc( "abc" ), RESULT_ZSTRING )
	CU_ASSERT_EQUAL( proc( wstr( "abc" ) ), RESULT_WSTRING )

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.overload.strings")
	fbcu.add_test("test_vars", @test_vars)
	fbcu.add_test("test_literals", @test_literals)

end sub

end namespace
