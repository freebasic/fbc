# include "fbcu.bi"

namespace fbc_tests.dim_.auto_var2

type foo
	bar as integer
	declare constructor()	
	declare constructor( v as integer )
end type

constructor foo()	
	bar = 1234
end constructor

constructor foo( v as integer )
	bar = v
end constructor

sub test_obj cdecl

	var f1 = foo
	CU_ASSERT_EQUAL( f1.bar, 1234 )

	var f2 = foo( 5678 )
	CU_ASSERT_EQUAL( f2.bar, 5678 )
	
end sub

type bar
	pad as byte
	foo as integer
end type

sub test_anon cdecl

	var f1 = type<bar>( 0, 1234 )
	CU_ASSERT_EQUAL( f1.foo, 1234 )

	var f2 = type<bar>( 0, 5678 )
	CU_ASSERT_EQUAL( f2.foo, 5678 )
	
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.dim.auto_var2")
	fbcu.add_test("obj", @test_obj)
	fbcu.add_test("anon", @test_anon)

end sub

end namespace
	