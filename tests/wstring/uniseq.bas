#include "fbcunit.bi"

'' option escape

SUITE( fbc_tests.wstring_.uniseq )

	const TESTVALUE_1 = !"A\u0022\u0023B\u0024\u0025C\u0026"
	const TESTVALUE_2 = !"\t\u0022\u0023\r\u0024\u0025C\u0026\n"

	declare sub run_test( byval s1 as wstring ptr, byval s2 as wstring ptr )	

	TEST( default )

		dim s as wstring * 32
		dim ps as wstring ptr
		
		s = TESTVALUE_1
		run_test( s, TESTVALUE_1 )

		s = TESTVALUE_2
		run_test( s, TESTVALUE_2 )
		
	END_TEST
		
	sub run_test( byval s1 as wstring ptr, byval s2 as wstring ptr )	
		
		CU_ASSERT( len( *s1 ) = len( *s2 ) )
		
		CU_ASSERT( *s1 = *s2 )
		
	end sub

END_SUITE
