# include "fbcu.bi"

namespace fbc_tests.structs.derived_ptr_assign

'' -----------------------------------------------------------------------------

type AAObject
	dim value as integer
end type

type AABase extends AAObject
	dim value2 as integer
end type

type AADerived extends AABase
	dim value3 as integer
	declare constructor( value as integer )
end type

constructor AADerived( value as integer )
	base.value = value
end constructor

sub testNoCtorBase cdecl( )
	dim pb as AABase ptr
	dim pd as AADerived ptr = new AADerived( 1234 )

	pb = pd '' ok
	CU_ASSERT( pb->value = 1234 )

	dim b as AABase
	dim d as AADerived = ( 5678 )

	b = d '' ok
	CU_ASSERT( b.value = 5678 )
end sub

'' -----------------------------------------------------------------------------

type BBObject
	dim value as integer
	dim somestr as string
end type

type BBBase extends BBObject
	dim value2 as integer
end type

type BBDerived extends BBBase
	dim value3 as integer
	declare constructor( value as integer )
end type

constructor BBDerived( value as integer )
	base.value = value
end constructor

sub testWithCtorBase cdecl( )
	dim pb as BBBase ptr
	dim pd as BBDerived ptr = new BBDerived( 1234 )

	pb = pd '' ok
	CU_ASSERT( pb->value = 1234 )

	dim b as BBBase
	dim d as BBDerived = ( 5678 )

	b = d '' ok
	CU_ASSERT( b.value = 5678 )
end sub

'' -----------------------------------------------------------------------------

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/derived_ptr_assign" )
	fbcu.add_test( "derived pointer assignments", @testNoCtorBase )
	fbcu.add_test( "derived pointer assignments", @testWithCtorBase )
end sub

end namespace
