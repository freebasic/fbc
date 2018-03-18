#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_init_toself )

    dim shared as integer cnt = 0

	type foo
		const as integer c = 1234
		declare static sub baz( f as integer = c )
		fp as sub( f as integer = c ) = @baz
	end type

	TEST( all )
		dim f as foo
		
		f.baz( )
		foo.baz( )
		f.fp( )
		
		CU_ASSERT_EQUAL( cnt, 3 )
	END_TEST
		
	sub foo.baz( f as integer )
		CU_ASSERT_EQUAL( f, c )
		cnt += 1
	end sub
	
END_SUITE
