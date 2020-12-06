#include "fbcunit.bi"

SUITE( fbc_tests.pointers.funptr_array1 )

	enum TEST_RES
		TEST_1	= 1
	end enum

	type foo 
		bar(0 to 1) as function () as TEST_RES
	end type 

	function bar() as TEST_RES
		function = TEST_1
	end function

		dim shared fp as foo ptr

	TEST( all )
		CU_ASSERT_EQUAL( fp->bar(1)(), TEST_1 )
	END_TEST

	SUITE_INIT
		fp = callocate(sizeof(foo))
		if (0 = fp) then
			return -1
		end if
		
		fp->bar(1) = @bar
		'' return success
		return 0
	END_SUITE_INIT

	SUITE_CLEANUP
		deallocate(fp)
		'' return success
		return 0
	END_SUITE_CLEANUP

END_SUITE
