#include "fbcunit.bi"

'' inherited methods called without 'this' should be preferred over the globally defined procedure

dim shared f_count as integer = 0
dim shared af_count as integer = 0

private sub f()
	f_count += 1
end sub

type A
	i as integer
	declare sub f()
end type

sub A.f()
	af_count += 1
end sub

type B extends A
	declare sub test_proc()
end type

sub B.test_proc()
	CU_ASSERT( f_count = 0 )
	CU_ASSERT( af_count = 0 )

	f()

	CU_ASSERT( f_count = 0 )
	CU_ASSERT( af_count = 1 )

	.f()

	CU_ASSERT( f_count = 1 )
	CU_ASSERT( af_count = 1 )

	..f()

	CU_ASSERT( f_count = 2 )
	CU_ASSERT( af_count = 1 )

	this.f()

	CU_ASSERT( f_count = 2 )
	CU_ASSERT( af_count = 2 )

	base.f()

	CU_ASSERT( f_count = 2 )
	CU_ASSERT( af_count = 3 )

end sub


SUITE( fbc_tests.structs.member_proc_shadow )
	TEST( default )
		dim x as B
		x.test_proc()
	END_TEST

END_SUITE
 
