# include "fbcu.bi"




namespace fbc_tests.wstrings.wchr_

const TESTVALUE_1 = wchr( 65, 66, 67 )
const TESTVALUE_2 = wchr( 256, 257, 258 )

declare sub run_test( byval s1 as wstring ptr, byval s2 as wstring ptr )	

sub test_1 cdecl ()

	dim s as wstring * 32
	dim ps as wstring ptr
	
	s = TESTVALUE_1
	run_test( s, TESTVALUE_1 )

	s = TESTVALUE_2
	run_test( s, TESTVALUE_2 )
	
end sub

sub run_test( byval s1 as wstring ptr, byval s2 as wstring ptr )	
	
	CU_ASSERT( len( *s1 ) = len( *s2 ) )
	
	CU_ASSERT( *s1 = *s2 )
	
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.wstring.wchr")
	fbcu.add_test("test_1", @test_1)

end sub

end namespace
