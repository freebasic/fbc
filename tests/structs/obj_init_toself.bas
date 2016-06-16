# include "fbcu.bi"

namespace fbc_tests.structs.obj_init_toself

    dim shared as integer cnt = 0

type foo
    const as integer c = 1234
    declare static sub baz( f as integer = c )
    fp as sub( f as integer = c ) = @baz
end type

sub test_1 cdecl
	dim f as foo
	
	f.baz( )
	foo.baz( )
	f.fp( )
	
	CU_ASSERT_EQUAL( cnt, 3 )
end sub
	
sub foo.baz( f as integer )
	CU_ASSERT_EQUAL( f, c )
	cnt += 1
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.structs.obj_init_toself")
	fbcu.add_test( "#1", @test_1)

end sub
	
end namespace	