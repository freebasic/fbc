#include "fbcunit.bi"

namespace foo
	dim as integer bar()
	
	sub dotest
		dim as integer i
		
		CU_ASSERT( (ubound(bar) - lbound(bar)) <> 0 )
		
		for i = lbound(bar) to ubound(bar)
			CU_ASSERT_EQUAL( bar(i), i )
		next
	end sub
end namespace

SUITE( fbc_tests.namespace_.redim_1 )

	TEST( redim1 )
		redim as integer foo.bar(0 to 2)
		
		dim as integer i
		for i = lbound(foo.bar) to ubound(foo.bar)
			foo.bar(i) = i
		next
		
		foo.dotest
	END_TEST

	TEST( redim2 )
		redim foo.bar(3 to 5)
		
		dim as integer i
		for i = lbound(foo.bar) to ubound(foo.bar)
			foo.bar(i) = i
		next
		
		foo.dotest
	END_TEST

END_SUITE
