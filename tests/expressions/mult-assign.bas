# include once "fbcu.bi"

namespace fbc_tests.expressions.multasgn

type triplet
	dim as short a = any, b = any
	dim as string c
	declare constructor( a as short, b as short, c as zstring ptr )
	declare destructor( )
end type

constructor triplet ( a as short, b as short, c as zstring ptr )
	this.a = a
	this.b = b
	this.c = *c
end constructor

	dim shared as integer dtorcnt = 0

destructor triplet( )
	dtorcnt += 1
end destructor

function func1( ) as triplet
	return triplet( 1, 2, "3" )
end function

function func2( ) as triplet
	return triplet( -1, -2, "-3" )
end function

function func3( ) as triplet
	return triplet( 10, 11, "12" )
end function

function func4( ) as triplet
	return triplet( -10, -11, "-12" )
end function
	
sub test_1 cdecl ()
	dim as integer foo, bar
	dim as string baz
	
	let( foo, bar, baz ) = func1( )
	CU_ASSERT( foo = 1 )
	CU_ASSERT( bar = 2 )
	CU_ASSERT( baz = "3" )
	
	let( foo, , baz ) = func2( )
	CU_ASSERT( foo = -1 )
	CU_ASSERT( bar = 2 )
	CU_ASSERT( baz = "-3" )
	
	let( foo ) = func3( )
	CU_ASSERT( foo = 10 )
	CU_ASSERT( bar = 2 )
	CU_ASSERT( baz = "-3" )
	
	let( , , baz ) = func4( )
	CU_ASSERT( foo = 10 )
	CU_ASSERT( bar = 2 )
	CU_ASSERT( baz = "-12" )

	CU_ASSERT( dtorcnt = 4 )
end sub

sub test_2 cdecl ()
	type baz
		as double a, b
	end type	
	
	dim as baz z(0)
	dim as integer i = 0
	
	let( z(i).a, z(i).b ) = type<baz>( -1, -2 )
	
	CU_ASSERT_EQUAL( z(i).a, -1 )
	CU_ASSERT_EQUAL( z(i).b, -2 )
end sub

sub test_3 cdecl ()
	type baz
		as short a, b
	end type	
	
	dim as baz z(0) = { ( -1234, -5678 ) }
	dim as integer foo, bar, i = 0
	
	let( foo, bar ) = z(i)
	
	CU_ASSERT_EQUAL( foo, -1234 )
	CU_ASSERT_EQUAL( bar, -5678 )

	''
	z(0).a = 1234
	z(0).b = 5678
	
	dim as baz ptr p = @z(0)
	let( foo, bar ) = *p
	
	CU_ASSERT_EQUAL( foo, 1234 )
	CU_ASSERT_EQUAL( bar, 5678 )
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.expressions.mult-assign")
	fbcu.add_test("#1", @test_1)
	fbcu.add_test("#2", @test_2)
	fbcu.add_test("#3", @test_3)

end sub

end namespace 
	