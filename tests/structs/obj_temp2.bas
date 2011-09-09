
'' test for temp objects, the dtors should be called right after the expressions are flushed

# include "fbcu.bi"

namespace fbc_tests.structs.obj_temp2

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

sub test_pass1 cdecl	
	dim as foo f1
	
	goto skip
	
	'' foo has a dtor, so, when passed by value, a temp copy will be created
	if( func_pass( f1 ) ) then
	end if
	
skip:

end sub

sub test_pass2 cdecl	
	dim as foo f1
	
	if( func_pass( f1 ) ) then
	end if
	
end sub

type zzz
	array(0 to 1) as integer
end type

function func_ret( array() as integer ) as foo
	return foo( )
end function

sub test_ret1 cdecl	
	dim as foo f1
	dim as zzz z
	
	goto skip
	
	'' foo has a dtor, so, when returned by value, a temp copy will be created
	f1 = func_ret( z.array( ) )
	
skip:

end sub

sub test_ret2 cdecl	
	dim as foo f1
	dim as zzz z
	
	f1 = func_ret( z.array( ) )

end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-structs:obj-temp2")
	fbcu.add_test( "pass 1", @test_pass1)
	fbcu.add_test( "pass 2", @test_pass2)
	fbcu.add_test( "return 1", @test_ret1)
	fbcu.add_test( "return 2", @test_ret2)
	
end sub
	
end namespace	