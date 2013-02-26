# include "fbcu.bi"

namespace fbc_tests.numbers.integer_n

sub test cdecl ()

	#macro TEST_SIGNED(n)
	scope

		'' SIZEOF / LEN
		CU_ASSERT_EQUAL( sizeof( integer<n> ) * 8, n )
		CU_ASSERT_EQUAL( len( integer<n> ), sizeof( integer<n> ) )

		'' TYPE a AS b / TYPE AS b a
		type as integer<n> int_##n
		type int__##n as integer<n>

		'' TYPEOF
		#if typeof( integer<n> ) <> typeof( int_##n )
		CU_FAIL()
		#endif

		'' CONST a AS b / CONST AS b a
		const as integer<n> MIN = cast( integer<n>, -1) shl ((n)-1)
		const MAX as integer<n> = not MIN

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
		#if typeof( T<n> ) <> typeof( uint_##n )
		CU_FAIL()
		#endif

		'' CONST a AS b / CONST AS b a
		const as T<n> MIN = cast( T<n>, 0)
		const MAX as T<n> = not MIN

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

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.numbers.integer_n")
	fbcu.add_test("test", @test)

end sub

end namespace
