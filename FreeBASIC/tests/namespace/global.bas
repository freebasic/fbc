

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

	assert( foo = GLOB_VAL )
	assert( .foo = GLOB_VAL )
	assert( ..foo = GLOB_VAL )
	assert( global.foo = GLOB_VAL )
end sub	

sub test_2
	dim as integer foo = LOCA_VAL
	
	using ns

	assert( foo = LOCA_VAL )
	assert( .foo = LOCA_VAL )
	assert( ..foo = LOCA_VAL )
	assert( global.foo = LOCA_VAL )
end sub	

sub test_3
	dim as ns.bar bar = ( LOCA_VAL )

	with bar
		assert( foo = GLOB_VAL )
		assert( .foo = LOCA_VAL )
		assert( ..foo = GLOB_VAL )
		assert( global.foo = GLOB_VAL )
	end with
end sub	
	
	test_1
	test_2
	test_3