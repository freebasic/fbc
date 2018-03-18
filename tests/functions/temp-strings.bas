#include "fbcunit.bi"

SUITE( fbc_tests.functions.temp_strings )

	''
	'' fbc needs to create temp strings for string arguments in various cases...
	'' but those temp strings should always be kept alive until the end of the
	'' statement, like any other temp vars, to allow them to be referenced by
	'' pointers or references with-in that statement.
	''
	'' For example byref parameters + return byref: The temp string passed in may be
	'' the same that's passed out from that call, and that result must still be a
	'' valid string after returning from the call, so it can be PRINT'ed etc., as
	'' long as that's happening in the same statement.
	''

	const MAGIC_S = "AABBAACC"
	const MAGIC_I = &hAABBAACC

	sub takeByvalString( byval s as string )
		CU_ASSERT( s = MAGIC_S )
	end sub
	sub takeByrefString( byref s as string )
		CU_ASSERT( s = MAGIC_S )
	end sub
	sub takeByrefZstring( byref z as zstring )
		CU_ASSERT( z = MAGIC_S )
	end sub
	sub takeByrefWstring( byref w as wstring )
		CU_ASSERT( w = MAGIC_S )
	end sub
	sub takeZstringPtr( byval pz as zstring ptr )
		CU_ASSERT( *pz = MAGIC_S )
	end sub
	sub takeWstringPtr( byval pw as wstring ptr )
		CU_ASSERT( *pw = MAGIC_S )
	end sub

	function takeByvalStringReturnByvalString( byval s as string ) as string
		CU_ASSERT( s = MAGIC_S )
		function = s
	end function
	function takeByrefStringReturnByvalString( byref s as string ) as string
		CU_ASSERT( s = MAGIC_S )
		function = s
	end function
	function takeByrefZstringReturnByvalString( byref z as zstring ) as string
		CU_ASSERT( z = MAGIC_S )
		function = z
	end function
	function takeByrefWstringReturnByvalString( byref w as wstring ) as string
		CU_ASSERT( w = MAGIC_S )
		function = w
	end function
	function takeZstringPtrReturnByvalString( byval pz as zstring ptr ) as string
		CU_ASSERT( *pz = MAGIC_S )
		function = *pz
	end function
	function takeWstringPtrReturnByvalString( byval pw as wstring ptr ) as string
		CU_ASSERT( *pw = MAGIC_S )
		function = *pw
	end function

	function takeByvalStringReturnByrefString( byval s as string ) byref as string
		CU_ASSERT( s = MAGIC_S )
		function = s
	end function
	function takeByrefStringReturnByrefString( byref s as string ) byref as string
		CU_ASSERT( s = MAGIC_S )
		function = s
	end function

	function takeByvalStringReturnByrefZstring( byval s as string ) byref as zstring
		CU_ASSERT( s = MAGIC_S )
		function = *strptr( s )
	end function
	function takeByrefStringReturnByrefZstring( byref s as string ) byref as zstring
		CU_ASSERT( s = MAGIC_S )
		function = *strptr( s )
	end function
	function takeByrefZstringReturnByrefZstring( byref z as zstring ) byref as zstring
		CU_ASSERT( z = MAGIC_S )
		function = z
	end function
	function takeZstringPtrReturnByrefZstring( byval pz as zstring ptr ) byref as zstring
		CU_ASSERT( *pz = MAGIC_S )
		function = *pz
	end function

	function takeByrefWstringReturnByrefWstring( byref w as wstring ) byref as wstring
		CU_ASSERT( w = MAGIC_S )
		function = w
	end function
	function takeWstringPtrReturnByrefWstring( byval pw as wstring ptr ) byref as wstring
		CU_ASSERT( *pw = MAGIC_S )
		function = *pw
	end function

	function takeByvalStringReturnZstringPtr( byval s as string ) as zstring ptr
		CU_ASSERT( s = MAGIC_S )
		function = strptr( s )
	end function
	function takeByrefStringReturnZstringPtr( byref s as string ) as zstring ptr
		CU_ASSERT( s = MAGIC_S )
		function = strptr( s )
	end function
	function takeByrefZstringReturnZstringPtr( byref z as zstring ) as zstring ptr
		CU_ASSERT( z = MAGIC_S )
		function = @z
	end function
	function takeZstringPtrReturnZstringPtr( byval pz as zstring ptr ) as zstring ptr
		CU_ASSERT( *pz = MAGIC_S )
		function = pz
	end function

	function takeByrefWstringReturnWstringPtr( byref w as wstring ) as wstring ptr
		CU_ASSERT( w = MAGIC_S )
		function = @w
	end function
	function takeWstringPtrReturnWstringPtr( byval pw as wstring ptr ) as wstring ptr
		CU_ASSERT( *pw = MAGIC_S )
		function = pw
	end function

	TEST( default )
		dim s as string => MAGIC_S
		dim f as string * 31 => MAGIC_S
		dim z as zstring * 32 => MAGIC_S
		dim w as wstring * 32 => MAGIC_S
		dim pz as zstring ptr = @z
		dim pw as wstring ptr = @w

		takeByvalString( s )
		takeByvalString( f )
		takeByvalString( z )
		takeByvalString( w )
		takeByvalString( hex( MAGIC_I ) )
		takeByvalString( whex( MAGIC_I ) )

		takeByrefString( s )
		takeByrefString( f )
		takeByrefString( z )
		takeByrefString( w )
		takeByrefString( hex( MAGIC_I ) )
		takeByrefString( whex( MAGIC_I ) )

		takeZstringPtr( s )
		takeZstringPtr( f )
		takeZstringPtr( z )
		takeZstringPtr( w )
		takeZstringPtr( hex( MAGIC_I ) )
		takeZstringPtr( whex( MAGIC_I ) )

		takeWstringPtr( s )
		takeWstringPtr( f )
		takeWstringPtr( z )
		takeWstringPtr( w )
		takeWstringPtr( hex( MAGIC_I ) )
		takeWstringPtr( whex( MAGIC_I ) )

		'' ---

		CU_ASSERT( takeByvalStringReturnByvalString( s ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByvalString( f ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByvalString( z ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByvalString( w ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByvalString( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByvalString( whex( MAGIC_I ) ) = MAGIC_S )

		CU_ASSERT( takeByrefStringReturnByvalString( s ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByvalString( f ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByvalString( z ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByvalString( w ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByvalString( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByvalString( whex( MAGIC_I ) ) = MAGIC_S )

		CU_ASSERT( takeByrefZstringReturnByvalString( s ) = MAGIC_S )
		CU_ASSERT( takeByrefZstringReturnByvalString( f ) = MAGIC_S )
		CU_ASSERT( takeByrefZstringReturnByvalString( z ) = MAGIC_S )
		CU_ASSERT( takeByrefZstringReturnByvalString( w ) = MAGIC_S )
		CU_ASSERT( takeByrefZstringReturnByvalString( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( takeByrefZstringReturnByvalString( whex( MAGIC_I ) ) = MAGIC_S )

		CU_ASSERT( takeByrefWstringReturnByvalString( s ) = MAGIC_S )
		CU_ASSERT( takeByrefWstringReturnByvalString( f ) = MAGIC_S )
		CU_ASSERT( takeByrefWstringReturnByvalString( z ) = MAGIC_S )
		CU_ASSERT( takeByrefWstringReturnByvalString( w ) = MAGIC_S )
		CU_ASSERT( takeByrefWstringReturnByvalString( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( takeByrefWstringReturnByvalString( whex( MAGIC_I ) ) = MAGIC_S )

		CU_ASSERT( takeZstringPtrReturnByvalString( s ) = MAGIC_S )
		CU_ASSERT( takeZstringPtrReturnByvalString( f ) = MAGIC_S )
		CU_ASSERT( takeZstringPtrReturnByvalString( z ) = MAGIC_S )
		CU_ASSERT( takeZstringPtrReturnByvalString( w ) = MAGIC_S )
		CU_ASSERT( takeZstringPtrReturnByvalString( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( takeZstringPtrReturnByvalString( whex( MAGIC_I ) ) = MAGIC_S )

		CU_ASSERT( takeWstringPtrReturnByvalString( s ) = MAGIC_S )
		CU_ASSERT( takeWstringPtrReturnByvalString( f ) = MAGIC_S )
		CU_ASSERT( takeWstringPtrReturnByvalString( z ) = MAGIC_S )
		CU_ASSERT( takeWstringPtrReturnByvalString( w ) = MAGIC_S )
		CU_ASSERT( takeWstringPtrReturnByvalString( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( takeWstringPtrReturnByvalString( whex( MAGIC_I ) ) = MAGIC_S )

		'' ---

		CU_ASSERT( takeByvalStringReturnByrefString( s ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByrefString( f ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByrefString( z ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByrefString( w ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByrefString( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByrefString( whex( MAGIC_I ) ) = MAGIC_S )

		CU_ASSERT( takeByrefStringReturnByrefString( s ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByrefString( f ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByrefString( z ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByrefString( w ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByrefString( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByrefString( whex( MAGIC_I ) ) = MAGIC_S )

		'' ---

		CU_ASSERT( takeByvalStringReturnByrefZstring( s ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByrefZstring( f ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByrefZstring( z ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByrefZstring( w ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByrefZstring( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByrefZstring( whex( MAGIC_I ) ) = MAGIC_S )

		CU_ASSERT( takeByrefStringReturnByrefZstring( s ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByrefZstring( f ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByrefZstring( z ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByrefZstring( w ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByrefZstring( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByrefZstring( whex( MAGIC_I ) ) = MAGIC_S )

		CU_ASSERT( takeByrefZstringReturnByrefZstring( s ) = MAGIC_S )
		CU_ASSERT( takeByrefZstringReturnByrefZstring( f ) = MAGIC_S )
		CU_ASSERT( takeByrefZstringReturnByrefZstring( z ) = MAGIC_S )
		CU_ASSERT( takeByrefZstringReturnByrefZstring( w ) = MAGIC_S )
		CU_ASSERT( takeByrefZstringReturnByrefZstring( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( takeByrefZstringReturnByrefZstring( whex( MAGIC_I ) ) = MAGIC_S )

		CU_ASSERT( takeZstringPtrReturnByrefZstring( s ) = MAGIC_S )
		CU_ASSERT( takeZstringPtrReturnByrefZstring( f ) = MAGIC_S )
		CU_ASSERT( takeZstringPtrReturnByrefZstring( z ) = MAGIC_S )
		CU_ASSERT( takeZstringPtrReturnByrefZstring( w ) = MAGIC_S )
		CU_ASSERT( takeZstringPtrReturnByrefZstring( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( takeZstringPtrReturnByrefZstring( whex( MAGIC_I ) ) = MAGIC_S )

		'' ---

		CU_ASSERT( takeByrefWstringReturnByrefWstring( s ) = MAGIC_S )
		CU_ASSERT( takeByrefWstringReturnByrefWstring( f ) = MAGIC_S )
		CU_ASSERT( takeByrefWstringReturnByrefWstring( z ) = MAGIC_S )
		CU_ASSERT( takeByrefWstringReturnByrefWstring( w ) = MAGIC_S )
		CU_ASSERT( takeByrefWstringReturnByrefWstring( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( takeByrefWstringReturnByrefWstring( whex( MAGIC_I ) ) = MAGIC_S )

		CU_ASSERT( takeWstringPtrReturnByrefWstring( s ) = MAGIC_S )
		CU_ASSERT( takeWstringPtrReturnByrefWstring( f ) = MAGIC_S )
		CU_ASSERT( takeWstringPtrReturnByrefWstring( z ) = MAGIC_S )
		CU_ASSERT( takeWstringPtrReturnByrefWstring( w ) = MAGIC_S )
		CU_ASSERT( takeWstringPtrReturnByrefWstring( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( takeWstringPtrReturnByrefWstring( whex( MAGIC_I ) ) = MAGIC_S )

		'' ---

		CU_ASSERT( *takeByvalStringReturnZstringPtr( s ) = MAGIC_S )
		CU_ASSERT( *takeByvalStringReturnZstringPtr( f ) = MAGIC_S )
		CU_ASSERT( *takeByvalStringReturnZstringPtr( z ) = MAGIC_S )
		CU_ASSERT( *takeByvalStringReturnZstringPtr( w ) = MAGIC_S )
		CU_ASSERT( *takeByvalStringReturnZstringPtr( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( *takeByvalStringReturnZstringPtr( whex( MAGIC_I ) ) = MAGIC_S )

		CU_ASSERT( *takeByrefStringReturnZstringPtr( s ) = MAGIC_S )
		CU_ASSERT( *takeByrefStringReturnZstringPtr( f ) = MAGIC_S )
		CU_ASSERT( *takeByrefStringReturnZstringPtr( z ) = MAGIC_S )
		CU_ASSERT( *takeByrefStringReturnZstringPtr( w ) = MAGIC_S )
		CU_ASSERT( *takeByrefStringReturnZstringPtr( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( *takeByrefStringReturnZstringPtr( whex( MAGIC_I ) ) = MAGIC_S )

		CU_ASSERT( *takeByrefZstringReturnZstringPtr( s ) = MAGIC_S )
		CU_ASSERT( *takeByrefZstringReturnZstringPtr( f ) = MAGIC_S )
		CU_ASSERT( *takeByrefZstringReturnZstringPtr( z ) = MAGIC_S )
		CU_ASSERT( *takeByrefZstringReturnZstringPtr( w ) = MAGIC_S )
		CU_ASSERT( *takeByrefZstringReturnZstringPtr( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( *takeByrefZstringReturnZstringPtr( whex( MAGIC_I ) ) = MAGIC_S )

		CU_ASSERT( *takeZstringPtrReturnZstringPtr( s ) = MAGIC_S )
		CU_ASSERT( *takeZstringPtrReturnZstringPtr( f ) = MAGIC_S )
		CU_ASSERT( *takeZstringPtrReturnZstringPtr( z ) = MAGIC_S )
		CU_ASSERT( *takeZstringPtrReturnZstringPtr( w ) = MAGIC_S )
		CU_ASSERT( *takeZstringPtrReturnZstringPtr( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( *takeZstringPtrReturnZstringPtr( whex( MAGIC_I ) ) = MAGIC_S )

		'' ---

		CU_ASSERT( *takeByrefWstringReturnWstringPtr( s ) = MAGIC_S )
		CU_ASSERT( *takeByrefWstringReturnWstringPtr( f ) = MAGIC_S )
		CU_ASSERT( *takeByrefWstringReturnWstringPtr( z ) = MAGIC_S )
		CU_ASSERT( *takeByrefWstringReturnWstringPtr( w ) = MAGIC_S )
		CU_ASSERT( *takeByrefWstringReturnWstringPtr( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( *takeByrefWstringReturnWstringPtr( whex( MAGIC_I ) ) = MAGIC_S )

		CU_ASSERT( *takeWstringPtrReturnWstringPtr( s ) = MAGIC_S )
		CU_ASSERT( *takeWstringPtrReturnWstringPtr( f ) = MAGIC_S )
		CU_ASSERT( *takeWstringPtrReturnWstringPtr( z ) = MAGIC_S )
		CU_ASSERT( *takeWstringPtrReturnWstringPtr( w ) = MAGIC_S )
		CU_ASSERT( *takeWstringPtrReturnWstringPtr( hex( MAGIC_I ) ) = MAGIC_S )
		CU_ASSERT( *takeWstringPtrReturnWstringPtr( whex( MAGIC_I ) ) = MAGIC_S )

	END_TEST

END_SUITE
