
# include "fbcu.bi"

namespace fbc_tests.structs.obj_cast_ovl

	type A
	    member as integer
	end type
	
	type B
		declare operator cast as A
	    member as integer
	end type
	
	operator B.cast as A
		return type(0)
	end operator
	
	function f overload as integer
		return 0
	end function 
	
	function f overload (x as A) as integer
		return -1
	end function
	
sub test1 cdecl	
		dim x as B
		CU_ASSERT( f( x ) )
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.structs.obj_cast_ovl")
	fbcu.add_test( "test 1", @test1)

end sub
	
end namespace	