# include "fbcu.bi"

namespace fbc_tests.structs.field_init_any

dim shared as integer ctor_count

type Nested
	as integer i
	declare constructor( )
end type

constructor Nested( )
	ctor_count += 1
end constructor

type Parent
	as Nested nested = any
	declare constructor( )
end type

constructor Parent( )
	CU_ASSERT( ctor_count = 0 )
	nested.constructor( )
	CU_ASSERT( ctor_count = 1 )
end constructor

sub test cdecl( )
	CU_ASSERT( ctor_count = 0 )
	dim as Parent x
	CU_ASSERT( ctor_count = 1 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/field-init-any")
	fbcu.add_test( "'= ANY' UDT field initializer", @test )
end sub

end namespace
