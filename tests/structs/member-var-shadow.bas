#include "fbcunit.bi"

type Parent
	as integer x = 1
end type

type Child extends Parent
	as integer y = 2
	declare sub test_proc()
end type

sub Child.test_proc()
	dim as integer x = 3
	dim as integer y = 4

	CU_ASSERT( x = 3 )
	CU_ASSERT( y = 4)

	CU_ASSERT( this.x = 1 )
	CU_ASSERT( base.x = 1 )
	CU_ASSERT( this.y = 2 )
	
end sub

SUITE( fbc_tests.structs.member_var_shadow )
	TEST( local_var )
		dim x as Child
		x.test_proc()
	END_TEST
END_SUITE


 
