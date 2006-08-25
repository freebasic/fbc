# include "fbcu.bi"

#define global .
	
const GLOB_VAL = &hdeadbeef
const LOCA_VAL = &hdeadc0de

dim shared as integer foo = GLOB_VAL

namespace fbc_tests.ns.glob
	dim as integer foo = not GLOB_VAL
	
	type bar
		as integer foo
	end type
end namespace

private sub test_1 cdecl
	using fbc_tests.ns.glob

	CU_ASSERT( foo = GLOB_VAL )
	CU_ASSERT( .foo = GLOB_VAL )
	CU_ASSERT( ..foo = GLOB_VAL )
	CU_ASSERT( global.foo = GLOB_VAL )
end sub	

private sub test_2 cdecl
	dim as integer foo = LOCA_VAL
	
	using fbc_tests.ns.glob

	CU_ASSERT( foo = LOCA_VAL )
	CU_ASSERT( .foo = LOCA_VAL )
	CU_ASSERT( ..foo = LOCA_VAL )
	CU_ASSERT( global.foo = LOCA_VAL )
end sub	

private sub test_3 cdecl
	dim as fbc_tests.ns.glob.bar bar = ( LOCA_VAL )

	with bar
		CU_ASSERT( foo = GLOB_VAL )
		CU_ASSERT( .foo = LOCA_VAL )
		CU_ASSERT( ..foo = GLOB_VAL )
		CU_ASSERT( global.foo = GLOB_VAL )
	end with
end sub	
	
private sub ctor () constructor

	fbcu.add_suite("fbc_tests.namespace.global")
	
	fbcu.add_test("test 1", @test_1)
	fbcu.add_test("test 2", @test_2)
	fbcu.add_test("test 3", @test_3)
	
end sub
