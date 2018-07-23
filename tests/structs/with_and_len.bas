#include "fbcunit.bi"

SUITE( fbc_tests.structs.with_and_len )

	type foo
		bar as string
	end type

	TEST( with_and_len_ )
		dim baz as foo
		with baz
			CU_assert( len( .bar ) = 0 )
			CU_assert( .bar = "" )
		end with
	END_TEST

	TEST( len_no_with )
		dim baz as foo
		CU_assert( len( string ) = sizeof( string ) )
		CU_assert( len( baz.bar ) = 0 )
	END_TEST

END_SUITE
