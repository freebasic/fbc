#include "fbcunit.bi"

type T
	__ as integer
end type

dim shared integer_shared as integer
static shared integer_static_shared as integer

dim shared T_shared as T
static shared T_static_shared as T

SUITE( fbc_tests.expressions.address_comparison )

	'' test that address of globals generates valid code
	'' fbc 1.05.0 and earlier would generate invalid ASM for
	'' CMP instruction: CMP IMM, OFFSET

	TEST( compare_shared_literal )
		
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


	TEST( compare_static_local )
		dim as integer i1, i2
		static as integer si1, si2

		'' Testing code generation for comparing involving OFS vregs

		CU_ASSERT( @i1 =  @i1  )
		CU_ASSERT( @i1 <> @i2  )
		CU_ASSERT( @i1 <> @si1 )
		CU_ASSERT( @i1 <> @si2 )

		CU_ASSERT( @i2 <> @i1  )
		CU_ASSERT( @i2 =  @i2  )
		CU_ASSERT( @i2 <> @si1 )
		CU_ASSERT( @i2 <> @si2 )

		CU_ASSERT( @si1 <> @i1  )
		CU_ASSERT( @si1 <> @i2  )
		CU_ASSERT( @si1 =  @si1 )
		CU_ASSERT( @si1 <> @si2 )

		CU_ASSERT( @si2 <> @i1  )
		CU_ASSERT( @si2 <> @i2  )
		CU_ASSERT( @si2 <> @si1 )
		CU_ASSERT( @si2 =  @si2 )

		if @i1 = @i1  then : end if
		if @i1 = @i2  then : end if
		if @i1 = @si1 then : end if
		if @i1 = @si2 then : end if

		if @i2 = @i1  then : end if
		if @i2 = @i2  then : end if
		if @i2 = @si1 then : end if
		if @i2 = @si2 then : end if

		if @si1 = @i1  then : end if
		if @si1 = @i2  then : end if
		if @si1 = @si1 then : end if
		if @si1 = @si2 then : end if

		if @si2 = @i1  then : end if
		if @si2 = @i2  then : end if
		if @si2 = @si1 then : end if
		if @si2 = @si2 then : end if
	END_TEST

END_SUITE
