
'' test for temp objects, the dtors should be called right after the expressions are flushed

#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_temp )

	type foo
		as integer id
		declare constructor( )
		declare destructor()
	end type

	constructor foo( )
		id = &hdeadbeef
	end constructor

	destructor foo
		CU_ASSERT_EQUAL( id, &hdeadbeef )
		id = 0
	end destructor

	sub func_pass( byval f as foo ) 
	end sub

	TEST( pass1 )
		dim as foo f1
		
		goto skip
		
		'' foo has a dtor, so, when passed by value, a temp copy will be created
		func_pass( f1 )
		
	skip:

	END_TEST

	TEST( pass2 )
		dim as foo f1
		
		func_pass( f1 )

	END_TEST

	type zzz
		array(0 to 1) as integer
	end type

	function func_ret( array() as integer ) as foo
		return foo( )
	end function

	TEST( return1 )
		dim as foo f1
		dim as zzz z
		
		goto skip
		
		'' foo has a dtor, so, when returned by value, a temp copy will be created
		f1 = func_ret( z.array( ) )
		
	skip:

	END_TEST

	TEST( return2 )
		dim as foo f1
		dim as zzz z
		
		f1 = func_ret( z.array( ) )

	END_TEST

END_SUITE