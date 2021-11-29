#include "fbcunit.bi"

#define global .
	
const GLOB_VAL = &hdeadbeef
const LOCA_VAL = &hdeadc0de

dim shared as integer foo = GLOB_VAL

namespace module.ns.glob
	dim as integer foo = not GLOB_VAL
	
	type bar
		as integer foo
	end type
end namespace

private sub test1_proc
	using module.ns.glob

	CU_ASSERT( foo = GLOB_VAL )
	CU_ASSERT( .foo = GLOB_VAL )
	CU_ASSERT( ..foo = GLOB_VAL )
	CU_ASSERT( global.foo = GLOB_VAL )
end sub	

private sub test2_proc
	dim as integer foo = LOCA_VAL
	
	using module.ns.glob

	CU_ASSERT( foo = LOCA_VAL )
	CU_ASSERT( .foo = GLOB_VAL )
	CU_ASSERT( ..foo = GLOB_VAL )
	CU_ASSERT( global.foo = GLOB_VAL )
end sub	

private sub test2a_proc
	using module.ns.glob

	dim as integer foo = LOCA_VAL

	CU_ASSERT( foo = LOCA_VAL )
	CU_ASSERT( .foo = GLOB_VAL )
	CU_ASSERT( ..foo = GLOB_VAL )
	CU_ASSERT( global.foo = GLOB_VAL )
end sub	

private sub test3_proc
	dim as module.ns.glob.bar bar = ( LOCA_VAL )

	with bar
		CU_ASSERT( foo = GLOB_VAL )
		CU_ASSERT( .foo = LOCA_VAL )
		CU_ASSERT( ..foo = GLOB_VAL )
		CU_ASSERT( global.foo = GLOB_VAL )
	end with
end sub	
	
SUITE( fbc_tests.namespace_.global_ )
	TEST( test1 )
		test1_proc
	END_TEST
	TEST( test2 )
		test2_proc
	END_TEST
	TEST( test3 )
		test3_proc
	END_TEST
END_SUITE
