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

sub high_codepoints cdecl ()

	'' Test compile-time evaluation of wchr. However there is no way
	'' to test that it produces the correct result if both host and
	'' target have wstring < 4 bytes, as clipping is inevitable.
	#if sizeof(wstring) >= 2
		CU_ASSERT( asc( wchr( &hffff ) ) = &hffff )
		'' In case the compiler evaluates ASC at compile-time, test with run-time ASC
		dim ws1 as wstring * 3 = wchr( &hffff )
		CU_ASSERT( asc( ws1 ) = &hffff )
	#endif
	#if sizeof(wstring) = 4
		'' &h10ffff is the max valid unicode codepoint
		CU_ASSERT( asc( wchr( &h10ffff ) ) = &h10ffff )
		dim ws2 as wstring * 3 = wchr( &h10ffff )
		CU_ASSERT( asc( ws2 ) = &h10ffff )

		'' Check characters out of unicode range
		CU_ASSERT( asc( wchr( &hffffffffU ) ) = &hffffffffU )
		dim ws3 as wstring * 3 = wchr( &hffffffffU )
		CU_ASSERT( asc( ws3 ) = &hffffffffU )
	#endif

	'' Force run-time evaluation of wchr
	dim temp as integer
	#if sizeof(wstring) >= 2
		temp = &hffff
		CU_ASSERT( wchr( temp ) = !"\uffff" )
		CU_ASSERT( asc( wchr( temp ) ) = &hffff )
	#endif
	#if sizeof(wstring) = 4
		temp = &h10ffff
		CU_ASSERT( asc( wchr( temp ) ) = &h10ffff )
		temp = &hffffffff
		CU_ASSERT( asc( wchr( temp ) ) = &hffffffffU )
	#endif

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.wstring.wchr")
	fbcu.add_test("test_1", @test_1)
	fbcu.add_test("High codepoints", @high_codepoints)

end sub

end namespace
