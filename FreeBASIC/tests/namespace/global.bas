

#define global .
	
const GLOB_VAL = &hdeadbeef
const LOCA_VAL = &hdeadc0de

dim shared as integer foo = GLOB_VAL

namespace ns
	dim as integer foo = not GLOB_VAL
	
	type bar
		as integer foo
	end type
end namespace

sub test_1	
	using ns

	CU_ASSERT( foo = GLOB_VAL )
	CU_ASSERT( .foo = GLOB_VAL )
	CU_ASSERT( ..foo = GLOB_VAL )
	CU_ASSERT( global.foo = GLOB_VAL )
end sub	

sub test_2
	dim as integer foo = LOCA_VAL
	
	using ns

	CU_ASSERT( foo = LOCA_VAL )
	CU_ASSERT( .foo = LOCA_VAL )
	CU_ASSERT( ..foo = LOCA_VAL )
	CU_ASSERT( global.foo = LOCA_VAL )
end sub	

sub test_3
	dim as ns.bar bar = ( LOCA_VAL )

	with bar
		CU_ASSERT( foo = GLOB_VAL )
		CU_ASSERT( .foo = LOCA_VAL )
		CU_ASSERT( ..foo = GLOB_VAL )
		CU_ASSERT( global.foo = GLOB_VAL )
	end with
end sub	
	
	test_1
	test_2
	test_3