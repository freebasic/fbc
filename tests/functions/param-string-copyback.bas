# include "fbcunit.bi"

SUITE( fbc_tests.functions.param_string_copyback )

	namespace ns1
		sub nocopyback( byval s as string )
			s = ucase( s )
		end sub

		sub copyback( byref s as string )
			s = ucase( s )
		end sub

		TEST( simple )
			dim s as string
			dim f as string * 3
			dim z as zstring * 3+1
			dim w as wstring * 3+1
			dim pz as zstring ptr = @z
			dim pw as wstring ptr = @w

			s = "var" : nocopyback( s   ) : CU_ASSERT( s = "var" )
			f = "fix" : nocopyback( f   ) : CU_ASSERT( f = "fix" )
			z = "zer" : nocopyback( z   ) : CU_ASSERT( z = "zer" )
			z = "zer" : nocopyback( *pz ) : CU_ASSERT( z = "zer" )
			w = "foo" : nocopyback( w   ) : CU_ASSERT( w = "foo" )
			w = "foo" : nocopyback( *pw ) : CU_ASSERT( w = "foo" )

			s = "var" : copyback( s   ) : CU_ASSERT( s = "VAR" )
			f = "fix" : copyback( f   ) : CU_ASSERT( f = "FIX" )
			z = "zer" : copyback( z   ) : CU_ASSERT( z = "zer" )  '' no copy back should be done for z/wstrings
			z = "zer" : copyback( *pz ) : CU_ASSERT( z = "zer" )
			w = "foo" : copyback( w   ) : CU_ASSERT( w = "foo" )
			w = "foo" : copyback( *pw ) : CU_ASSERT( w = "foo" )

			'' Special cases with string literals (passed via implicitly
			'' created temp STRING): can't ever copy back, because string
			'' literals are read-only.
			nocopyback( "abc" )
			nocopyback( wstr( "abc" ) )
			copyback( "abc" )
			copyback( wstr( "abc" ) )
		END_TEST
	end namespace

	namespace ns2
		sub appendChars( byref s as string, byval n as integer )
			CU_ASSERT( s = "a" )
			s += string( n, "!" )
		end sub

		TEST( differentLength )
			dim s as string
			dim f as string * 5
			dim z as zstring * 5+1
			dim w as wstring * 5+1
			dim pz as zstring ptr = @z
			dim pw as wstring ptr = @w

			s = "a" : appendChars( s, 1 ) : CU_ASSERT( s = "a!" )
			s = "a" : appendChars( s, 3 ) : CU_ASSERT( s = "a!!!" )
			s = "a" : appendChars( s, 5 ) : CU_ASSERT( s = "a!!!!!" )

			f = "a" : appendChars( f, 1 ) : CU_ASSERT( f = "a!" )
			f = "a" : appendChars( f, 3 ) : CU_ASSERT( f = "a!!!" )
			f = "a" : appendChars( f, 5 ) : CU_ASSERT( f = "a!!!!" )  '' truncated

			z = "a" : appendChars( z, 1 ) : CU_ASSERT( z = "a" )
			z = "a" : appendChars( z, 3 ) : CU_ASSERT( z = "a" )
			z = "a" : appendChars( z, 5 ) : CU_ASSERT( z = "a" )

			w = "a" : appendChars( w, 1 ) : CU_ASSERT( w = "a" )
			w = "a" : appendChars( w, 3 ) : CU_ASSERT( w = "a" )
			w = "a" : appendChars( w, 5 ) : CU_ASSERT( w = "a" )

			z = "a" : appendChars( *pz, 1 ) : CU_ASSERT( z = "a" )
			z = "a" : appendChars( *pz, 3 ) : CU_ASSERT( z = "a" )
			z = "a" : appendChars( *pz, 4 ) : CU_ASSERT( z = "a" )

			w = "a" : appendChars( *pw, 1 ) : CU_ASSERT( w = "a" )
			w = "a" : appendChars( *pw, 3 ) : CU_ASSERT( w = "a" )
			w = "a" : appendChars( *pw, 4 ) : CU_ASSERT( w = "a" )
		END_TEST
	end namespace

	namespace ns3
		sub copyback( byref s as string )
			s = ucase( s )
		end sub

		function returnString( ) as string
			function = "abc"
		end function

		TEST( functionResults )
			'' No copyback necessary in these cases
			copyback( returnString( ) )
			copyback( hex( &hAABBCCDD ) )
			copyback( whex( &hAABBCCDD ) )
		END_TEST
	end namespace

	namespace ns4
		sub copyback( byref s as string )
			s = ucase( s )
		end sub

		'' DEREF z/wstring pointing to literal
		TEST( derefZWstringLiteral )
			dim pz as zstring ptr = @"aaa"
			dim pw as wstring ptr = @wstr( "bbb" )

			'' should not copy back into string literals
			CU_ASSERT( *pz = "aaa" ) : copyback( *pz ) : CU_ASSERT( *pz = "aaa" )
			CU_ASSERT( *pw = wstr( "bbb" ) ) : copyback( *pw ) : CU_ASSERT( *pw = wstr( "bbb" ) )
		END_TEST
	end namespace

END_SUITE
