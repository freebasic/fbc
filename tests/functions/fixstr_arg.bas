# include "fbcunit.bi"

SUITE( fbc_tests.functions.fixstr_arg )

	const TEST_LC = "hello!"
	const TEST_UC = "HELLO!"

	type foo
		f1 as integer
 		s as string * 20
	end type

	sub ucaseme_ref(byref s as string)
		s = ucase( s )
	end sub

	sub ucaseme_val(byval s as string)
		s = ucase( s )
	end sub

	TEST( ref1 )
		dim as string * 20 s

		s = TEST_LC
		ucaseme_ref( s )
		CU_ASSERT( s = TEST_UC )

	END_TEST

	TEST( val1 )
		dim as string * 20 s

		s = TEST_LC
		ucaseme_val( s )
		CU_ASSERT( s = TEST_LC )

	END_TEST

	TEST( ref2 )
		dim as foo f(0)

		f(0).s = TEST_LC
		ucaseme_ref( f(0).s )
		CU_ASSERT( f(0).s = TEST_UC )

	END_TEST

	TEST( val )
		dim as foo f(0)

		f(0).s = TEST_LC
		ucaseme_val( f(0).s )
		CU_ASSERT( f(0).s = TEST_LC )
		
	END_TEST

END_SUITE
