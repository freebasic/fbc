# include "fbcu.bi"

namespace fbc_tests.structs.bitfield_packing

'' Non-field members shouldn't interfere with bitfield packing or struct layout
'' in general, since they're not real fields.
''
'' I.e. bitfields should be merged into the same "storage unit" even if there's
'' a constructor or something else that's not a field declared in between them.

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
	CU_ASSERT( sizeof( UDT1 ) = sizeof( integer ) )
	CU_ASSERT( sizeof( UDT2 ) = sizeof( integer ) )
	CU_ASSERT( sizeof( UDT3 ) = sizeof( integer ) )
	CU_ASSERT( sizeof( UDT4 ) = sizeof( integer ) )
	CU_ASSERT( sizeof( UDT5 ) = sizeof( integer ) )
	CU_ASSERT( sizeof( UDT6 ) = sizeof( integer ) )
end sub

namespace gengccRegressionTest
	type UDT
		f0 : 1 as byte
		f1 : 1 as integer
		f2 : 1 as integer
		f3 : 1 as integer
		f4 : 1 as integer
		f5 : 1 as integer
		f6 : 1 as integer
		f7 : 1 as integer
		f8 : 1 as integer
		f9 : 1 as integer
		i as integer
		f10 : 3 as byte
	end type

	sub test cdecl( )
		dim x as UDT
		x.f1 = 1
		x.f9 = 1
		x.i = 12345
		x.f10 = 5
		CU_ASSERT( x.f0 = 0 )
		CU_ASSERT( x.f1 = 1 )
		CU_ASSERT( x.f2 = 0 )
		CU_ASSERT( x.f3 = 0 )
		CU_ASSERT( x.f4 = 0 )
		CU_ASSERT( x.f5 = 0 )
		CU_ASSERT( x.f6 = 0 )
		CU_ASSERT( x.f7 = 0 )
		CU_ASSERT( x.f8 = 0 )
		CU_ASSERT( x.f9 = 1 )
		CU_ASSERT( x.i = 12345 )
		CU_ASSERT( x.f10 = 5 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/bitfield-packing" )
	fbcu.add_test( "test", @test )
	fbcu.add_test( "gengccRegressionTest", @gengccRegressionTest.test )
end sub

end namespace
