# include "fbcunit.bi"

SUITE( fbc_tests.const_.offsetof_ )

	type foo
		as integer field1
		as integer field2
	end type

	const field1_ofs = offsetof(foo, field1)
	const field2_ofs = offsetof(foo, field2)

	TEST( offset_1 )
		CU_ASSERT_EQUAL( field1_ofs, len( integer ) * 0 )
		CU_ASSERT_EQUAL( field2_ofs, len( integer ) * 1 )
	END_TEST

END_SUITE
