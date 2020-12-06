#include "fbcunit.bi"

SUITE( fbc_tests.pointers.array_ptr_fn )

	const TEST_VAL = &hdeadbeef

	type fn as function(byval as integer, byval as integer, byval as integer) as integer ptr
		
	function func(byval a as integer, byval b as integer, byval c as integer) as integer ptr

		static test_int as integer = TEST_VAL
		function = @test_int

	end function
		
	dim shared fnarray(10) as fn ptr

	dim shared i as integer = 5
	dim shared j as integer = 3
	
	TEST( ptrToFuncArray )
		CU_ASSERT_EQUAL( *fnarray(i)[j]( 1, 2, 3 ), TEST_VAL )

	END_TEST

	SUITE_INIT
		fnarray(i) = allocate((j + 1) * sizeof(fn ptr))
		if (0 = fnarray(i)) then
			'' return failure
			return -1
		end if
		
		fnarray(i)[j] = @func
		'' return success
		return 0
	END_SUITE_INIT

	SUITE_CLEANUP
		if( fnarray(i) ) then
			deallocate(fnarray(i))
		end if
		'' return success
		return 0
	END_SUITE_CLEANUP

END_SUITE
