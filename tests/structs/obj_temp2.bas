
'' test for temp objects, the dtors should be called right after the expressions are flushed

#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_temp2 )

	static shared as integer foo_cnt = 0

	type foo
		as integer id = any
		declare constructor( )
		declare constructor( byref rhs as foo )
		declare destructor()
		declare operator let( byref rhs as foo )
	end type

	constructor foo( )
		id = foo_cnt
		foo_cnt += 1
	end constructor

	constructor foo( byref rhs as foo )
		id = foo_cnt
		foo_cnt += 1
	end constructor

	operator foo.let( byref rhs as foo )
		'' do nothing
	end operator

	destructor foo
		foo_cnt -= 1
		CU_ASSERT_EQUAL( id, foo_cnt )
		id = 1234
	end destructor

	function func_pass( byval f as foo ) as integer
		return 1
	end function

	TEST( pass1 )
		dim as foo f1
		
		goto skip
		
		'' foo has a dtor, so, when passed by value, a temp copy will be created
		if( func_pass( f1 ) ) then
		end if
		
	skip:

	END_TEST

	TEST( pass2 )
		dim as foo f1
		
		if( func_pass( f1 ) ) then
		end if
		
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
