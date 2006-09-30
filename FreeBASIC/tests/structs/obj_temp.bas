
'' test for temp objects, the dtors should be called right after the expressions are flushed

# include "fbcu.bi"

namespace fbc_tests.structs.obj_temp

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

sub test_pass1 cdecl	
	dim as foo f1
	
	goto skip
	
	'' foo has a dtor, so, when passed by value, a temp copy will be created
	func_pass( f1 )
	
skip:

end sub

sub test_pass2 cdecl	
	dim as foo f1
	
	func_pass( f1 )

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

	fbcu.add_suite("fb-tests-structs:obj-temp")
	fbcu.add_test( "pass 1", @test_pass1)
	fbcu.add_test( "pass 2", @test_pass2)
	fbcu.add_test( "return 1", @test_ret1)
	fbcu.add_test( "return 2", @test_ret2)

end sub
	
end namespace	