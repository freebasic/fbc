#include "fbcunit.bi"

SUITE( fbc_tests.string_.comp_null )

	dim shared v as string
	dim shared f as string * 10	
	dim shared z as zstring * 10
	dim shared pz as zstring ptr
	dim shared w as wstring * 10
	dim shared pw as wstring ptr

	SUITE_INIT
		v = ""
		f = ""
		z = ""
		pz = 0
		w = wstr("")
		pw = 0
		'' return success
		return 0
	END_SUITE_INIT

	TEST( stringType )
		CU_ASSERT_EQUAL( v, f )
		CU_ASSERT_EQUAL( v, z )
		CU_ASSERT_EQUAL( v, *pz )
		CU_ASSERT_EQUAL( v, w )
		CU_ASSERT_EQUAL( v, *pw )

		CU_ASSERT_EQUAL( f, v )
		CU_ASSERT_EQUAL( f, z )
		CU_ASSERT_EQUAL( f, *pz )
		CU_ASSERT_EQUAL( f, w )
		CU_ASSERT_EQUAL( f, *pw )
	END_TEST

	TEST( zstringType )
		CU_ASSERT_EQUAL( z, v )
		CU_ASSERT_EQUAL( z, f )
		CU_ASSERT_EQUAL( z, *pz )
		CU_ASSERT_EQUAL( z, w )
		CU_ASSERT_EQUAL( z, *pw )

		CU_ASSERT_EQUAL( *pz, v )
		CU_ASSERT_EQUAL( *pz, f )
		CU_ASSERT_EQUAL( *pz, z )
		CU_ASSERT_EQUAL( *pz, w )
		CU_ASSERT_EQUAL( *pz, *pw )
	END_TEST

	TEST( wstringType )
		CU_ASSERT_EQUAL( w, v )
		CU_ASSERT_EQUAL( w, f )
		CU_ASSERT_EQUAL( w, z )
		CU_ASSERT_EQUAL( w, *pz )
		CU_ASSERT_EQUAL( w, *pw )

		CU_ASSERT_EQUAL( *pw, v )
		CU_ASSERT_EQUAL( *pw, f )
		CU_ASSERT_EQUAL( *pw, z )
		CU_ASSERT_EQUAL( *pw, *pz )
		CU_ASSERT_EQUAL( *pw, w )
	END_TEST

END_SUITE
