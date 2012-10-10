# include "fbcu.bi"

namespace fbc_tests.structs.bitfield_packing

type UDT1
	a : 1		as integer
	b : 1		as integer
end type 

type UDT2
	a : 1		as integer
	declare constructor( )
	b : 1		as integer
end type 

type UDT3
	declare constructor( )
	a : 1		as integer
	b : 1		as integer
end type 

type UDT4
	a : 1		as integer
	b : 1		as integer
	declare constructor( )
end type 

type UDT5
	a : 1		as integer
	const FOO = 123
	b : 1		as integer
end type 

type UDT6
	a : 1		as integer
	enum FOO
		BAR = 123
	end enum
	b : 1		as integer
end type 

private sub test cdecl( )
	CU_ASSERT( sizeof( UDT1 ) = 4 )
	CU_ASSERT( sizeof( UDT2 ) = 4 )
	CU_ASSERT( sizeof( UDT3 ) = 4 )
	CU_ASSERT( sizeof( UDT4 ) = 4 )
	CU_ASSERT( sizeof( UDT5 ) = 4 )
	CU_ASSERT( sizeof( UDT6 ) = 4 )
end sub

private sub ctor( ) constructor
	'' Non-field members shouldn't interfere with bitfield packing or
	'' struct layout in general, since they're not real fields.
	fbcu.add_suite( "tests/structs/bitfield-packing" )
	fbcu.add_test( "test", @test )
end sub

end namespace
