#include "fbcunit.bi"

SUITE( fbc_tests.string_.string_fixed_array )

	TEST( fixed_string )

		scope
			dim As string * 1 s1(0 to 1)

			CU_ASSERT( s1(0)[0] = 32 )
			CU_ASSERT( s1(1)[0] = 32 )

			s1(0)[0] = 65
			s1(1)[0] = 66

			CU_ASSERT( s1(0)[0] = 65 )
			CU_ASSERT( s1(1)[0] = 66 )

			erase s1

			CU_ASSERT( s1(0)[0] = 32 )
			CU_ASSERT( s1(1)[0] = 32 )
		end scope

		scope
			redim as string * 1 s2(0 to 1)

			CU_ASSERT( s2(0)[0] = 32 )
			CU_ASSERT( s2(1)[0] = 32 )

			s2(0)[0] = 65
			s2(1)[0] = 66

			CU_ASSERT( s2(0)[0] = 65 )
			CU_ASSERT( s2(1)[0] = 66 )

			redim preserve s2(0 to 2)

			CU_ASSERT( s2(0)[0] = 65 )
			CU_ASSERT( s2(1)[0] = 66 )
			CU_ASSERT( s2(2)[0] = 32 )
		end scope

		scope
			dim As string * 1 s3()
			redim s3(0 to 1)

			CU_ASSERT( s3(0)[0] = 32 )
			CU_ASSERT( s3(1)[0] = 32 )

			s3(0)[0] = 65
			s3(1)[0] = 66

			CU_ASSERT( s3(0)[0] = 65 )
			CU_ASSERT( s3(1)[0] = 66 )

			redim preserve s3(0 to 2)

			CU_ASSERT( s3(0)[0] = 65 )
			CU_ASSERT( s3(1)[0] = 66 )
			CU_ASSERT( s3(2)[0] = 32 )
		end scope
	END_TEST

	TEST( fixed_string_udt )

		type T
			f as string * 10
		end type

		scope
			dim As T s1(0 to 1)

			CU_ASSERT( s1(0).f[0] = 32 )
			CU_ASSERT( s1(0).f[9] = 32 )
			CU_ASSERT( s1(1).f[0] = 32 )
			CU_ASSERT( s1(1).f[9] = 32 )

			s1(0).f[0] = 65
			s1(0).f[9] = 66
			s1(1).f[0] = 67
			s1(1).f[9] = 68

			CU_ASSERT( s1(0).f[0] = 65 )
			CU_ASSERT( s1(0).f[9] = 66 )
			CU_ASSERT( s1(1).f[0] = 67 )
			CU_ASSERT( s1(1).f[9] = 68 )

			erase s1

			CU_ASSERT( s1(0).f[0] = 32 )
			CU_ASSERT( s1(0).f[9] = 32 )
			CU_ASSERT( s1(1).f[0] = 32 )
			CU_ASSERT( s1(1).f[9] = 32 )
		end scope

		scope
			redim As T s2(0 to 1)

			CU_ASSERT( s2(0).f[0] = 32 )
			CU_ASSERT( s2(0).f[9] = 32 )
			CU_ASSERT( s2(1).f[0] = 32 )
			CU_ASSERT( s2(1).f[9] = 32 )

			s2(0).f[0] = 65
			s2(0).f[9] = 66
			s2(1).f[0] = 67
			s2(1).f[9] = 68

			CU_ASSERT( s2(0).f[0] = 65 )
			CU_ASSERT( s2(0).f[9] = 66 )
			CU_ASSERT( s2(1).f[0] = 67 )
			CU_ASSERT( s2(1).f[9] = 68 )

			redim preserve s2(0 to 2)

			CU_ASSERT( s2(0).f[0] = 65 )
			CU_ASSERT( s2(0).f[9] = 66 )
			CU_ASSERT( s2(1).f[0] = 67 )
			CU_ASSERT( s2(1).f[9] = 68 )
			CU_ASSERT( s2(2).f[0] = 32 )
			CU_ASSERT( s2(2).f[9] = 32 )
		end scope

		scope
			dim As T s3()
			redim s3(0 to 1)

			CU_ASSERT( s3(0).f[0] = 32 )
			CU_ASSERT( s3(0).f[9] = 32 )
			CU_ASSERT( s3(1).f[0] = 32 )
			CU_ASSERT( s3(1).f[9] = 32 )

			s3(0).f[0] = 65
			s3(0).f[9] = 66
			s3(1).f[0] = 67
			s3(1).f[9] = 68

			CU_ASSERT( s3(0).f[0] = 65 )
			CU_ASSERT( s3(0).f[9] = 66 )
			CU_ASSERT( s3(1).f[0] = 67 )
			CU_ASSERT( s3(1).f[9] = 68 )

			redim preserve s3(0 to 2)

			CU_ASSERT( s3(0).f[0] = 65 )
			CU_ASSERT( s3(0).f[9] = 66 )
			CU_ASSERT( s3(1).f[0] = 67 )
			CU_ASSERT( s3(1).f[9] = 68 )
			CU_ASSERT( s3(2).f[0] = 32 )
			CU_ASSERT( s3(2).f[9] = 32 )
		end scope
	END_TEST

	type T2
		f as string * 10
		i as integer
	end type

	TEST( fixed_string_udt_mixed )

		scope
			dim As T2 s1(0 to 1)

			CU_ASSERT( s1(0).f[0] = 32 )
			CU_ASSERT( s1(0).f[9] = 32 )
			CU_ASSERT( s1(0).i    = 0  )
			CU_ASSERT( s1(1).f[0] = 32 )
			CU_ASSERT( s1(1).f[9] = 32 )
			CU_ASSERT( s1(0).i    = 0  )

			s1(0).f[0] = 65
			s1(0).f[9] = 66
			s1(0).i    = 1001
			s1(1).f[0] = 67
			s1(1).f[9] = 68
			s1(1).i    = 1002

			CU_ASSERT( s1(0).f[0] = 65 )
			CU_ASSERT( s1(0).f[9] = 66 )
			CU_ASSERT( s1(0).i    = 1001 )
			CU_ASSERT( s1(1).f[0] = 67 )
			CU_ASSERT( s1(1).f[9] = 68 )
			CU_ASSERT( s1(1).i    = 1002 )

			erase s1

			CU_ASSERT( s1(0).f[0] = 32 )
			CU_ASSERT( s1(0).f[9] = 32 )
			CU_ASSERT( s1(0).i    = 0  )
			CU_ASSERT( s1(1).f[0] = 32 )
			CU_ASSERT( s1(1).f[9] = 32 )
			CU_ASSERT( s1(1).i    = 0  )
		end scope

		scope
			redim As T2 s2(0 to 1)

			CU_ASSERT( s2(0).f[0] = 32 )
			CU_ASSERT( s2(0).f[9] = 32 )
			CU_ASSERT( s2(0).i    = 0  )
			CU_ASSERT( s2(1).f[0] = 32 )
			CU_ASSERT( s2(1).f[9] = 32 )
			CU_ASSERT( s2(1).i    = 0  )

			s2(0).f[0] = 65
			s2(0).f[9] = 66
			s2(0).i    = 1001
			s2(1).f[0] = 67
			s2(1).f[9] = 68
			s2(1).i    = 1002

			CU_ASSERT( s2(0).f[0] = 65 )
			CU_ASSERT( s2(0).f[9] = 66 )
			CU_ASSERT( s2(0).i    = 1001 )
			CU_ASSERT( s2(1).f[0] = 67 )
			CU_ASSERT( s2(1).f[9] = 68 )
			CU_ASSERT( s2(1).i    = 1002  )

			redim preserve s2(0 to 2)

			CU_ASSERT( s2(0).f[0] = 65 )
			CU_ASSERT( s2(0).f[9] = 66 )
			CU_ASSERT( s2(0).i    = 1001 )
			CU_ASSERT( s2(1).f[0] = 67 )
			CU_ASSERT( s2(1).f[9] = 68 )
			CU_ASSERT( s2(1).i    = 1002  )
			CU_ASSERT( s2(2).f[0] = 32 )
			CU_ASSERT( s2(2).f[9] = 32 )
			CU_ASSERT( s2(2).i    = 0  )
		end scope

		scope
			dim As T2 s3()
			redim s3(0 to 1)

			CU_ASSERT( s3(0).f[0] = 32 )
			CU_ASSERT( s3(0).f[9] = 32 )
			CU_ASSERT( s3(0).i    = 0  )
			CU_ASSERT( s3(1).f[0] = 32 )
			CU_ASSERT( s3(1).f[9] = 32 )
			CU_ASSERT( s3(1).i    = 0  )

			s3(0).f[0] = 65
			s3(0).f[9] = 66
			s3(0).i    = 1001
			s3(1).f[0] = 67
			s3(1).f[9] = 68
			s3(1).i    = 1002

			CU_ASSERT( s3(0).f[0] = 65 )
			CU_ASSERT( s3(0).f[9] = 66 )
			CU_ASSERT( s3(0).i    = 1001 )
			CU_ASSERT( s3(1).f[0] = 67 )
			CU_ASSERT( s3(1).f[9] = 68 )
			CU_ASSERT( s3(1).i    = 1002  )

			redim preserve s3(0 to 2)

			CU_ASSERT( s3(0).f[0] = 65 )
			CU_ASSERT( s3(0).f[9] = 66 )
			CU_ASSERT( s3(0).i    = 1001 )
			CU_ASSERT( s3(1).f[0] = 67 )
			CU_ASSERT( s3(1).f[9] = 68 )
			CU_ASSERT( s3(1).i    = 1002  )
			CU_ASSERT( s3(2).f[0] = 32 )
			CU_ASSERT( s3(2).f[9] = 32 )
			CU_ASSERT( s3(2).i    = 0  )
		end scope
	END_TEST

END_SUITE
