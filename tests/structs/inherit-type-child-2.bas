#include once "fbcunit.bi"

'' define namespace names to allow short names
'' in this source but avoid namespace collisions
'' in other sources

#define P  iherit_type_child_2_P
#define C  iherit_type_child_2_C
#define C2 iherit_type_child_2_C2

#macro checkCall( func, result )
	func
	CU_ASSERT_EQUAL( proc_result, result )
#endmacro

dim shared proc_result as string
dim shared var_result as integer

type P extends object
	A as integer = 1
	declare sub proc()
end type

sub P.proc()
	proc_result = "P.PROC"
	var_result = A
end sub

type C extends P
	A as integer = 2
	declare sub proc()
end type

sub C.proc()
	proc_result = "C.PROC"
	var_result = A
end sub

type C2 extends C
	declare sub proc()
end type

sub C2.proc()
	proc_result = "C2.PROC"
	var_result = A
end sub

private sub module_proc()

	dim z as C2
	''                    '' fbc-1.08  fbc-1.09
	cast(P, c).proc()     ''   n/a       1

	CU_ASSERT_EQUAL( proc_result, "P.PROC" )
	CU_ASSERT_EQUAL( var_result,  1 )

	cast(C, c).proc()     ''   n/a       2

	CU_ASSERT_EQUAL( proc_result, "C.PROC" )
	CU_ASSERT_EQUAL( var_result,  2 )

	z.proc()              ''   n/a       2

	CU_ASSERT_EQUAL( proc_result, "C2.PROC" )
	CU_ASSERT_EQUAL( var_result,  2 )


end sub

SUITE( fbc_tests.structs.inherit_type_child_2 )
	TEST( default )
		module_proc()
	END_TEST
END_SUITE
