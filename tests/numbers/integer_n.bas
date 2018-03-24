#include "fbcunit.bi"

SUITE( fbc_tests.numbers.integer_n )

	TEST( all )

		#macro TEST_SIGNED(n)
		scope

			'' SIZEOF / LEN
			CU_ASSERT_EQUAL( sizeof( integer<n> ) * 8, n )
			CU_ASSERT_EQUAL( len( integer<n> ), sizeof( integer<n> ) )

			'' TYPE a AS b / TYPE AS b a
			type as integer<n> int_##n
			type int__##n as integer<n>

			'' TYPEOF
			#assert typeof( integer<n> ) = typeof( int_##n )

			'' CONST a AS b / CONST AS b a; CINT<n>
			const as integer<n> MIN= cint<n>( -1 ) shl ((n)-1)
			const MAX as integer<n>= cint<n>( not MIN )

			'' CAST
			CU_ASSERT_EQUAL( cast( integer<n>, MIN - 1), MAX )


			'' DIM a AS b / DIM AS b a
			dim as int_##n max##n = MAX
			dim min##n as int_##n = max##n + 1

			CU_ASSERT_EQUAL( max##n, MAX )
			CU_ASSERT_EQUAL( min##n, MIN )

		end scope
		#endmacro

		#macro TEST_UNSIGNED(n, T)
		scope

			'' SIZEOF / LEN
			CU_ASSERT_EQUAL( sizeof( T<n> ) * 8, n )
			CU_ASSERT_EQUAL( len( T<n> ), sizeof( T<n> ) )

			'' TYPE a AS b / TYPE AS b a
			type as T<n> uint_##n
			type int__##n as T<n>

			'' TYPEOF
			#assert typeof( T<n> ) = typeof( uint_##n )

			'' CONST a AS b / CONST AS b a; CUINT<n>
			const as T<n> MIN= cuint<n>( 0 )
			const MAX as T<n>= cuint<n>( not MIN )

			'' CAST
			CU_ASSERT_EQUAL( cast( T<n>, MIN - 1), MAX )


			'' DIM a AS b / DIM AS b a
			dim as T<n> max##n = MAX
			dim min##n as T<n> = max##n + 1

			CU_ASSERT_EQUAL( max##n, MAX )
			CU_ASSERT_EQUAL( min##n, MIN )

		end scope
		#endmacro

		TEST_SIGNED(8)
		TEST_SIGNED(16)
		TEST_SIGNED(32)
		TEST_SIGNED(64)

		TEST_UNSIGNED(8,  uinteger)
		TEST_UNSIGNED(16, uinteger)
		TEST_UNSIGNED(32, uinteger)
		TEST_UNSIGNED(64, uinteger)

		TEST_UNSIGNED(8,  unsigned integer)
		TEST_UNSIGNED(16, unsigned integer)
		TEST_UNSIGNED(32, unsigned integer)
		TEST_UNSIGNED(64, unsigned integer)

	END_TEST

END_SUITE
