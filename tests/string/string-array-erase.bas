#include "fbcunit.bi"

SUITE( fbc_tests.string_.string_array_erase )

	TEST_GROUP( fixedsize )

		TEST( default )
			scope
				'' Local fixed-size array
				dim as string x0(0 to 1)
				CU_ASSERT( x0(0) = "" )
				CU_ASSERT( x0(1) = "" )
				x0(0) = "a"
				x0(1) = "b"
				erase x0 '' clear
				CU_ASSERT( x0(0) = "" )
				CU_ASSERT( x0(1) = "" )
				CU_ASSERT( ubound(x0) = 1 )
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( dynamic_ )

		TEST( default )
			scope
				'' Local dynamic array, POD
				redim as string x0(0 to 1)
				CU_ASSERT( x0(0) = "" )
				CU_ASSERT( x0(1) = "" )
				erase x0 '' deallocate
				CU_ASSERT( ubound(x0) = -1 )
			end scope

		END_TEST
	END_TEST_GROUP

END_SUITE
