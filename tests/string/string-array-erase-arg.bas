#include "fbcunit.bi"

SUITE( fbc_tests.string_.string_array_erase_arg )

	TEST_GROUP( fixedsize )

		sub erase_string( arg() as string )
			erase arg 
		end sub 

		TEST( default )
			scope
				'' Local fixed-size array
				dim as string x0(0 to 1)
				CU_ASSERT( x0(0) = "" )
				CU_ASSERT( x0(1) = "" )
				x0(0) = "a"
				x0(1) = "b"
				erase_string x0() '' clear
				CU_ASSERT( x0(0) = "" )
				CU_ASSERT( x0(1) = "" )
				CU_ASSERT( ubound(x0) = 1 )
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( dynamic_ )

		sub erase_string( arg() as string )
			erase arg 
		end sub 

		TEST( default )
			scope
				'' Local dynamic array, POD
				redim as string x0(0 to 1)
				CU_ASSERT( x0(0) = "" )
				CU_ASSERT( x0(1) = "" )
				erase_string x0() '' deallocate
				CU_ASSERT( ubound(x0) = -1 )
			end scope

		END_TEST
	END_TEST_GROUP

END_SUITE
