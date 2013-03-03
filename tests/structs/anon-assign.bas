# include "fbcu.bi"

namespace fbc_tests.structs.anon_assign

type t
	a as short
	b as integer
	c(0 to 1) as single
	d as double
end type

sub test_1 cdecl ()
	dim as t udt = (1, 2, {3, 4}, 5 ) 
	
	CU_ASSERT_EQUAL( udt.a, 1 )
	CU_ASSERT_EQUAL( udt.b, 2 )
	CU_ASSERT_EQUAL( udt.c(0), 3 )
	CU_ASSERT_EQUAL( udt.c(1), 4 )
	CU_ASSERT_EQUAL( udt.d, 5 )
end sub

sub test_2 cdecl ()
	static as t udt = (1, 2, {3, 4}, 5 ) 
	
	CU_ASSERT_EQUAL( udt.a, 1 )
	CU_ASSERT_EQUAL( udt.b, 2 )
	CU_ASSERT_EQUAL( udt.c(0), 3 )
	CU_ASSERT_EQUAL( udt.c(1), 4 )
	CU_ASSERT_EQUAL( udt.d, 5 )
end sub

sub test_3 cdecl ()
	dim as t udt
	
	udt = type( -1, -2, {-3, -4}, -5 )

	CU_ASSERT_EQUAL( udt.a, -1 )
	CU_ASSERT_EQUAL( udt.b, -2 )
	CU_ASSERT_EQUAL( udt.c(0), -3 )
	CU_ASSERT_EQUAL( udt.c(1), -4 )
	CU_ASSERT_EQUAL( udt.d, -5 )	
end sub

sub test_4  cdecl ()
	static as t udt
	
	udt = type( -1, -2, {-3, -4}, -5 )

	CU_ASSERT_EQUAL( udt.a, -1 )
	CU_ASSERT_EQUAL( udt.b, -2 )
	CU_ASSERT_EQUAL( udt.c(0), -3 )
	CU_ASSERT_EQUAL( udt.c(1), -4 )
	CU_ASSERT_EQUAL( udt.d, -5 )	
end sub

namespace ctorcallDespiteConstBits
	dim shared as integer ctors

	type UDT
		i as integer
		declare constructor( )
	end type

	constructor UDT( )
		ctors += 1
	end constructor

	sub test cdecl( )
		CU_ASSERT( ctors = 0 )
		dim x as UDT
		x.i = 123

		CU_ASSERT( ctors = 1 )

		'' This should be parsed as ctor call, not as UDT initializer,
		'' despite the CONST
		x = type<const UDT>( )

		CU_ASSERT( x.i = 0 )
		CU_ASSERT( ctors = 2 )
	end sub
end namespace

namespace memberAccess
	type UDT
		i as integer
	end type

	sub test cdecl( )
		CU_ASSERT( (type<UDT>( 123 )).i = 123 )
		CU_ASSERT( type<UDT>( 123 ).i = 123 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/anon-assign" )
	fbcu.add_test("test_1", @test_1)
	fbcu.add_test("test_2", @test_2)
	fbcu.add_test("test_3", @test_3)
	fbcu.add_test("test_4", @test_4)
	fbcu.add_test( "ctorcall + CONST bits", @ctorcallDespiteConstBits.test )
	fbcu.add_test( "member access", @memberAccess.test )
end sub

end namespace
