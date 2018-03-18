# include "fbcunit.bi"

SUITE( fbc_tests.functions.str_recursion )

	const TEST_VALUE_1 = "abcDEFghi"
	const TEST_VALUE_2 = "0123456789"


	'':::::
	sub f1( byval s1 as string, byref s2 as string )

		CU_ASSERT( s1 = TEST_VALUE_1 )
		CU_ASSERT( s2 = TEST_VALUE_2 )

	end sub

	'':::::
	sub f2( byref s1 as string, byval s2 as string )

		CU_ASSERT( s1 = TEST_VALUE_1 )
		CU_ASSERT( s2 = TEST_VALUE_2 )
		
		f1( s1, s2 )

	end sub

	'':::::
	sub f3( byval s1 as string, byref s2 as string )

		CU_ASSERT( s1 = TEST_VALUE_1 )
		CU_ASSERT( s2 = TEST_VALUE_2 )

		f2( s1, s2 )

	end sub

	'':::::
	sub f4( byval s1 as zstring ptr, byval s2 as string )

		CU_ASSERT( *s1 = TEST_VALUE_1 )
		CU_ASSERT( s2 = TEST_VALUE_2 )
		
		f3( *s1, s2 )

	end sub

	TEST( default )

		dim s as string
		dim z as zstring * 15+1
		
		s = TEST_VALUE_1
		z = TEST_VALUE_2
		
		f3 s, z
		
		f2 s, z
		
		f4 strptr( s ), z
		
	END_TEST

END_SUITE
