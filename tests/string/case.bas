#include "fbcunit.bi"

SUITE( fbc_tests.string_.case_ )

	TEST( default )
		'' Default lcase/ucase( zstring ) is codepage-specific,
		'' so it cannot really be tested, but at least we can ensure it
		'' compiles fine and does something...
		dim s as string
		dim z as zstring * 32
		s = "abc"
		z = "abc"
		CU_ASSERT( len( lcase( s ) ) > 0 )
		CU_ASSERT( len( ucase( s ) ) > 0 )
		CU_ASSERT( len( lcase( z ) ) > 0 )
		CU_ASSERT( len( ucase( z ) ) > 0 )
		CU_ASSERT( len( lcase( "abc" ) ) > 0 )
		CU_ASSERT( len( ucase( "abc" ) ) > 0 )

		'' For wstrings it should use Unicode and be reliable though.
		dim w as wstring * 32
		w = !"\u0041\u0061"
		CU_ASSERT( lcase( w ) = !"\u0061\u0061" )
		CU_ASSERT( ucase( w ) = !"\u0041\u0041" )
		CU_ASSERT( lcase( !"\u0041\u0061" ) = !"\u0061\u0061" )
		CU_ASSERT( ucase( !"\u0041\u0061" ) = !"\u0041\u0041" )
	END_TEST

	TEST( AsciiOnly )
		dim s as string

		CU_ASSERT( lcase( "ABC", 1 ) = "abc" )
		CU_ASSERT( lcase( "abc", 1 ) = "abc" )
		CU_ASSERT( ucase( "abc", 1 ) = "ABC" )
		CU_ASSERT( ucase( "ABC", 1 ) = "ABC" )

		s = "ABC" : CU_ASSERT( lcase( s, 1 ) = "abc" )
		s = "abc" : CU_ASSERT( lcase( s, 1 ) = "abc" )
		s = "abc" : CU_ASSERT( ucase( s, 1 ) = "ABC" )
		s = "ABC" : CU_ASSERT( ucase( s, 1 ) = "ABC" )

		const CONSTZ1 = lcase( "XYZ123", 1 )
		const CONSTZ2 = ucase( "xyz123", 1 )
		CU_ASSERT( lcase( CONSTZ1, 1 ) = CONSTZ1 )
		CU_ASSERT( lcase( CONSTZ1, 1 ) = "xyz123" )
		CU_ASSERT( ucase( CONSTZ2, 1 ) = CONSTZ2 )
		CU_ASSERT( ucase( CONSTZ2, 1 ) = "XYZ123" )

		dim z as zstring * 32
		z = "ABC" : CU_ASSERT( lcase( z, 1 ) = "abc" )
		z = "abc" : CU_ASSERT( lcase( z, 1 ) = "abc" )
		z = "abc" : CU_ASSERT( ucase( z, 1 ) = "ABC" )
		z = "ABC" : CU_ASSERT( ucase( z, 1 ) = "ABC" )

		dim pz as zstring ptr = @z
		*pz = "ABC" : CU_ASSERT( lcase( *pz, 1 ) = "abc" )
		*pz = "abc" : CU_ASSERT( lcase( *pz, 1 ) = "abc" )
		*pz = "abc" : CU_ASSERT( ucase( *pz, 1 ) = "ABC" )
		*pz = "ABC" : CU_ASSERT( ucase( *pz, 1 ) = "ABC" )

		#if CONSTZ1 <> "xyz123"
			CU_FAIL( )
		#endif

		#if CONSTZ2 <> "XYZ123"
			CU_FAIL( )
		#endif

		#if lcase( "ABC", 1 ) <> "abc"
			CU_FAIL( )
		#endif

		#if lcase( "abc", 1 ) <> "abc"
			CU_FAIL( )
		#endif

		#if ucase( "abc", 1 ) <> "ABC"
			CU_FAIL( )
		#endif

		#if ucase( "ABC", 1 ) <> "ABC"
			CU_FAIL( )
		#endif

		''
		'' wstring
		''

		CU_ASSERT( lcase( wstr( "ABC" ), 1 ) = wstr( "abc" ) )
		CU_ASSERT( lcase( wstr( "abc" ), 1 ) = wstr( "abc" ) )
		CU_ASSERT( ucase( wstr( "abc" ), 1 ) = wstr( "ABC" ) )
		CU_ASSERT( ucase( wstr( "ABC" ), 1 ) = wstr( "ABC" ) )

		const CONSTW1 = lcase( wstr( "XYZ123" ), 1 )
		const CONSTW2 = ucase( wstr( "xyz123" ), 1 )
		CU_ASSERT( lcase( CONSTW1, 1 ) = CONSTW1 )
		CU_ASSERT( lcase( CONSTW1, 1 ) = wstr( "xyz123" ) )
		CU_ASSERT( ucase( CONSTW2, 1 ) = CONSTW2 )
		CU_ASSERT( ucase( CONSTW2, 1 ) = wstr( "XYZ123" ) )

		dim w as wstring * 32
		w = wstr( "ABC" ) : CU_ASSERT( lcase( w, 1 ) = wstr( "abc" ) )
		w = wstr( "abc" ) : CU_ASSERT( lcase( w, 1 ) = wstr( "abc" ) )
		w = wstr( "abc" ) : CU_ASSERT( ucase( w, 1 ) = wstr( "ABC" ) )
		w = wstr( "ABC" ) : CU_ASSERT( ucase( w, 1 ) = wstr( "ABC" ) )

		dim pw as wstring ptr = @w
		*pw = wstr( "ABC" ) : CU_ASSERT( lcase( *pw, 1 ) = wstr( "abc" ) )
		*pw = wstr( "abc" ) : CU_ASSERT( lcase( *pw, 1 ) = wstr( "abc" ) )
		*pw = wstr( "abc" ) : CU_ASSERT( ucase( *pw, 1 ) = wstr( "ABC" ) )
		*pw = wstr( "ABC" ) : CU_ASSERT( ucase( *pw, 1 ) = wstr( "ABC" ) )

		#if CONSTW1 <> wstr( "xyz123" )
			CU_FAIL( )
		#endif

		#if CONSTW2 <> wstr( "XYZ123" )
			CU_FAIL( )
		#endif

		#if lcase( wstr( "ABC" ), 1 ) <> wstr( "abc" )
			CU_FAIL( )
		#endif

		#if lcase( wstr( "abc" ), 1 ) <> wstr( "abc" )
			CU_FAIL( )
		#endif

		#if ucase( wstr( "abc" ), 1 ) <> wstr( "ABC" )
			CU_FAIL( )
		#endif

		#if ucase( wstr( "ABC" ), 1 ) <> wstr( "ABC" )
			CU_FAIL( )
		#endif

		''
		'' escape sequences
		''
		z = !"foo\nFOO\&h61\&h41"
		CU_ASSERT( lcase( z, 1 ) = !"foo\nfooaa" )
		CU_ASSERT( ucase( z, 1 ) = !"FOO\nFOOAA" )

		w = !"foo\nFOO\u0061\u0041"
		CU_ASSERT( lcase( w, 1 ) = wstr( !"foo\nfooaa" ) )
		CU_ASSERT( ucase( w, 1 ) = wstr( !"FOO\nFOOAA" ) )
	END_TEST

END_SUITE
