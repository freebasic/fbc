#include "fbcunit.bi"

'' test that address of globals generates valid code
'' fbc 1.05.0 and earlier would generate invalid ASM for
'' CMP instruction: CMP IMM, OFFSET

type T
	__ as integer
end type

dim shared integer_shared as integer
static shared integer_static_shared as integer

dim shared T_shared as T
static shared T_static_shared as T

SUITE( fbc_tests.pointers.addrof )

	TEST( derefAddressOfTest )
		
		dim integer_local as integer
		static integer_static as integer

		dim T_local as T
		static T_static as T

		CU_ASSERT( @integer_shared <> 0 )

		if( @integer_shared = 0 ) then
			CU_FAIL()
		end if

		if( @integer_shared <> 0 ) then
			CU_PASS()
		end if

		CU_ASSERT( @integer_static_shared <> 0 )

		if( @integer_static_shared = 0 ) then
			CU_FAIL()
		end if

		if( @integer_static_shared <> 0 ) then
			CU_PASS()
		end if

		CU_ASSERT( @integer_local <> 0 )

		if( @integer_local = 0 ) then
			CU_FAIL()
		end if

		if( @integer_local <> 0 ) then
			CU_PASS()
		end if

		CU_ASSERT( @integer_static <> 0 )

		if( @integer_static = 0 ) then
			CU_FAIL()
		end if

		if( @integer_static <> 0 ) then
			CU_PASS()
		end if

		CU_ASSERT( @T_shared <> 0 )

		if( @T_shared = 0 ) then
			CU_FAIL()
		end if

		if( @T_shared <> 0 ) then
			CU_PASS()
		end if

		CU_ASSERT( @T_static_shared <> 0 )

		if( @T_static_shared = 0 ) then
			CU_FAIL()
		end if

		if( @T_static_shared <> 0 ) then
			CU_PASS()
		end if

		CU_ASSERT( @T_local <> 0 )

		if( @T_local = 0 ) then
			CU_FAIL()
		end if

		if( @T_local <> 0 ) then
			CU_PASS()
		end if

		CU_ASSERT( @T_static <> 0 )

		if( @T_static = 0 ) then
			CU_FAIL()
		end if

		if( @T_static <> 0 ) then
			CU_PASS()
		end if

	END_TEST

END_SUITE
