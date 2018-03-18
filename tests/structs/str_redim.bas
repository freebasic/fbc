#include "fbcunit.bi"

SUITE( fbc_tests.structs.str_redim )

	dim shared as integer bar_cnt = 0

	const FOO_LBOUND = 0
	const FOO_UBOUND = 1

	type bar
		value as integer
		foo(FOO_LBOUND to FOO_UBOUND) as string
		declare constructor ()
		declare destructor ()
	end type

	constructor bar()
		value = bar_cnt
		bar_cnt += 1
		
		dim as integer i
		for i = FOO_LBOUND to FOO_UBOUND
			foo(i) = str( i )
		next
	end constructor

	destructor bar( )
		bar_cnt -= 1
	end destructor

	#macro test_chk()
		scope
			dim as integer i, j
			for i = lbound( array ) to ubound( array )
				CU_ASSERT_EQUAL( array(i).value, i )
				for j = FOO_LBOUND to FOO_UBOUND
					CU_ASSERT_EQUAL( array(i).foo(j), str(j) )	
				next
			next
		end scope
	#endmacro

	TEST( all )
		redim as bar array(0 to 1)
		test_chk()
		
		redim array(0 to 2)
		test_chk()

		redim array(0 to 1)
		test_chk()

		redim array(0 to 3)
		test_chk()

	END_TEST

END_SUITE
