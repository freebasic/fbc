# include "fbcu.bi"

namespace fbc_tests.functions.param_string_copyback

namespace simple
	sub nocopyback( byval s as string )
		s = ucase( s )
	end sub

	sub copyback( byref s as string )
		s = ucase( s )
	end sub

	sub test cdecl( )
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
		z = "zer" : copyback( z   ) : CU_ASSERT( z = "ZER" )
		z = "zer" : copyback( *pz ) : CU_ASSERT( z = "ZER" )
		w = "foo" : copyback( w   ) : CU_ASSERT( w = "FOO" )
		w = "foo" : copyback( *pw ) : CU_ASSERT( w = "FOO" )

		'' Special cases with string literals (passed via implicitly
		'' created temp STRING): can't ever copy back, because string
		'' literals are read-only.
		nocopyback( "abc" )
		nocopyback( wstr( "abc" ) )
		copyback( "abc" )
		copyback( wstr( "abc" ) )
	end sub
end namespace

namespace differentLength
	sub appendChars( byref s as string, byval n as integer )
		CU_ASSERT( s = "a" )
		s += string( n, "!" )
	end sub

	sub test cdecl( )
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

		z = "a" : appendChars( z, 1 ) : CU_ASSERT( z = "a!" )
		z = "a" : appendChars( z, 3 ) : CU_ASSERT( z = "a!!!" )
		z = "a" : appendChars( z, 5 ) : CU_ASSERT( z = "a!!!!" )  '' truncated

		w = "a" : appendChars( w, 1 ) : CU_ASSERT( w = "a!" )
		w = "a" : appendChars( w, 3 ) : CU_ASSERT( w = "a!!!" )
		w = "a" : appendChars( w, 5 ) : CU_ASSERT( w = "a!!!!" )  '' truncated

		z = "a" : appendChars( *pz, 1 ) : CU_ASSERT( z = "a!" )
		z = "a" : appendChars( *pz, 3 ) : CU_ASSERT( z = "a!!!" )
		z = "a" : appendChars( *pz, 4 ) : CU_ASSERT( z = "a!!!!" )  '' 5 wouldn't be safe (no length check)

		w = "a" : appendChars( *pw, 1 ) : CU_ASSERT( w = "a!" )
		w = "a" : appendChars( *pw, 3 ) : CU_ASSERT( w = "a!!!" )
		w = "a" : appendChars( *pw, 4 ) : CU_ASSERT( w = "a!!!!" )  '' 5 wouldn't be safe (no length check)
	end sub
end namespace

namespace functionResults
	sub copyback( byref s as string )
		s = ucase( s )
	end sub

	function returnString( ) as string
		function = "abc"
	end function

	sub test cdecl( )
		'' No copyback necessary in these cases
		copyback( returnString( ) )
		copyback( hex( &hAABBCCDD ) )
		copyback( whex( &hAABBCCDD ) )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/functions/param-string-copyback" )
	fbcu.add_test( "simple", @simple.test )
	fbcu.add_test( "different length", @differentLength.test )
	fbcu.add_test( "function results", @functionResults.test )
end sub

end namespace
