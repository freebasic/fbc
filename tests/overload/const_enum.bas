# include "fbcu.bi"



namespace fbc_tests.overloads.const_enum

enum
	RES_ENUM
	RES_INT
	RES_DBL
end enum

enum enum_t 
   a, b, c 
end enum 

const enum_a as enum_t = a
const enum_b as enum_t = b
const enum_c as enum_t = c
const i as integer = a
const d as double = b

function proc overload( byval x as enum_t ) as integer
	function = RES_ENUM
end function

function proc overload( byval x as integer ) as integer
	function = RES_INT
end function

function proc overload( byval x as double ) as integer
	function = RES_DBL
end function

sub test_params_and_returns cdecl ()
	CU_ASSERT_EQUAL( proc( enum_a ), RES_ENUM )
	CU_ASSERT_EQUAL( proc( i ), RES_INT )
	CU_ASSERT_EQUAL( proc( d ), RES_DBL )
end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-overload:by descriptor")
	fbcu.add_test("test_params_and_returns", @test_params_and_returns)

end sub

end namespace
