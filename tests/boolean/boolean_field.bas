# include "fbcunit.bi"

'' - don't mix false/true intrinsic constants 
''   of the compiler in with the tests
#undef FALSE
#undef TRUE

#define FALSE 0
#define TRUE (-1)

SUITE( fbc_tests.boolean_.boolean_field )

	type T1
		i as integer
		b as boolean
		j as integer
	end type

	type T2
		i as integer
		b as byte
		j as integer
	end type

	union U
		a as T1
		b as T2
	end union

	TEST( offsets )
		dim as T1 a
		dim as T2 b

		CU_ASSERT_EQUAL( offsetof(T1, i), offsetof(T2, i) )
		CU_ASSERT_EQUAL( offsetof(T1, b), offsetof(T2, b) )
		CU_ASSERT_EQUAL( offsetof(T1, j), offsetof(T2, j) )
	END_TEST

	TEST( assignment )
		dim as T1 a

		a.b = 0
		CU_ASSERT_EQUAL( a.b, 0 )

		a.b = 1
		CU_ASSERT_EQUAL( a.b, TRUE )

		a.b = 256
		CU_ASSERT_EQUAL( a.b, TRUE )
	END_TEST

	TEST( boolean_storage )
		dim as U a

		a.a.b = 0
		CU_ASSERT_EQUAL( a.a.b, 0 )
		CU_ASSERT_EQUAL( a.b.b, 0 )

		a.a.b = 1
		CU_ASSERT_EQUAL( a.a.b, TRUE )
		CU_ASSERT_EQUAL( a.b.b, 1 )

		a.a.b = 256
		CU_ASSERT_EQUAL( a.a.b, TRUE )
		CU_ASSERT_EQUAL( a.b.b, 1 )
	END_TEST

	TEST( indirect_storage )
		dim as U a

		'' Storing into the byte, instead of the boolean -- should only
		'' write values that are valid for the boolean type.

		a.b.b = 0
		CU_ASSERT_EQUAL( a.a.b, 0 )
		CU_ASSERT_EQUAL( a.b.b, 0 )

		a.b.b = 1
		CU_ASSERT_EQUAL( a.a.b, TRUE )
		CU_ASSERT_EQUAL( a.b.b, 1 )
	END_TEST

END_SUITE
