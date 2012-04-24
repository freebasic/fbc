
# include "fbcu.bi"

namespace fbc_tests.structs.obj_ptr

type foo
	as integer value = any
	declare constructor( byval v as integer = 0 )
	declare destructor( )
end type

constructor foo( byval v as integer )
	static as integer cnt = 0
	value = cnt + v
	cnt += 1
end constructor

destructor foo()
	value = 1234
end destructor

sub test_1 cdecl( )
	dim as foo ptr pf = new foo[10]

	for i as integer = 0 to 9
		CU_ASSERT_EQUAL( pf[i].value, i )
	next

	delete[] pf
end sub

sub test_2 cdecl( )
	dim as foo ptr pf = new foo( -10 )

	CU_ASSERT_EQUAL( pf->value, 0 )

	delete pf
end sub

type Parent
	as integer i
end type

type Child extends Parent
	declare constructor( )
	declare destructor( )
end type

constructor Child( )
	base.i = 123
end constructor

destructor Child( )
end destructor

sub test_3 cdecl( )
	dim as Child ptr pc = new Child[5]

	for i as integer = 0 to 4
		CU_ASSERT( pc[i].i = 123 )
	next

	delete[] pc
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/obj_ptr" )
	fbcu.add_test( "1", @test_1 )
	fbcu.add_test( "2", @test_2 )
	fbcu.add_test( "3", @test_3 )
end sub

end namespace
