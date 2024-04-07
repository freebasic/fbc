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
	const MAGIC_F = "AABBAACC                       "
	const MAGIC_I = &hAABBAACC

	sub takeByvalString( byval s as string, isfixed as integer )
		if( isfixed ) then
			CU_ASSERT( s = MAGIC_F )
		else
			CU_ASSERT( s = MAGIC_S )
		end if
	end sub
	sub takeByrefString( byref s as string, isfixed as integer )
		if( isfixed ) then
			CU_ASSERT( s = MAGIC_F )
		else
			CU_ASSERT( s = MAGIC_S )
		end if
	end sub
	sub takeByrefZstring( byref z as zstring, isfixed as integer )
		if( isfixed ) then
			CU_ASSERT( z = MAGIC_F )
		else
			CU_ASSERT( z = MAGIC_S )
		end if
	end sub
	sub takeByrefWstring( byref w as wstring, isfixed as integer )
		if( isfixed ) then
			CU_ASSERT( w = MAGIC_F )
		else
			CU_ASSERT( w = MAGIC_S )
		end if
	end sub
	sub takeZstringPtr( byval pz as zstring ptr, isfixed as integer )
		if( isfixed ) then
			CU_ASSERT( *pz = MAGIC_F )
		else
			CU_ASSERT( *pz = MAGIC_S )
		end if
	end sub
	sub takeWstringPtr( byval pw as wstring ptr, isfixed as integer )
		if( isfixed ) then
			CU_ASSERT( *pw = MAGIC_F )
		else
			CU_ASSERT( *pw = MAGIC_S )
		end if
	end sub

	function takeByvalStringReturnByvalString( byval s as string, isfixed as integer ) as string
		if( isfixed ) then
			CU_ASSERT( s = MAGIC_F )
		else
			CU_ASSERT( s = MAGIC_S )
		end if
		function = s
	end function
	function takeByrefStringReturnByvalString( byref s as string, isfixed as integer ) as string
		if( isfixed ) then
			CU_ASSERT( s = MAGIC_F )
		else
			CU_ASSERT( s = MAGIC_S )
		end if
		function = s
	end function
	function takeByrefZstringReturnByvalString( byref z as zstring, isfixed as integer ) as string
		if( isfixed ) then
			CU_ASSERT( z = MAGIC_F )
		else
			CU_ASSERT( z = MAGIC_S )
		end if
		function = z
	end function
	function takeByrefWstringReturnByvalString( byref w as wstring, isfixed as integer ) as string
		if( isfixed ) then
			CU_ASSERT( w = MAGIC_F )
		else
			CU_ASSERT( w = MAGIC_S )
		end if
		function = w
	end function
	function takeZstringPtrReturnByvalString( byval pz as zstring ptr, isfixed as integer ) as string
		if( isfixed ) then
			CU_ASSERT( *pz = MAGIC_F )
		else
			CU_ASSERT( *pz = MAGIC_S )
		end if
		function = *pz
	end function
	function takeWstringPtrReturnByvalString( byval pw as wstring ptr, isfixed as integer ) as string
		if( isfixed ) then
			CU_ASSERT( *pw = MAGIC_F )
		else
			CU_ASSERT( *pw = MAGIC_S )
		end if
		function = *pw
	end function

	function takeByvalStringReturnByrefString( byval s as string, isfixed as integer ) byref as string
		if( isfixed ) then
			CU_ASSERT( s = MAGIC_F )
		else
			CU_ASSERT( s = MAGIC_S )
		end if
		function = s
	end function
	function takeByrefStringReturnByrefString( byref s as string, isfixed as integer ) byref as string
		if( isfixed ) then
			CU_ASSERT( s = MAGIC_F )
		else
			CU_ASSERT( s = MAGIC_S )
		end if
		function = s
	end function

	function takeByvalStringReturnByrefZstring( byval s as string, isfixed as integer ) byref as zstring
		if( isfixed ) then
			CU_ASSERT( s = MAGIC_F )
		else
			CU_ASSERT( s = MAGIC_S )
		end if
		function = *strptr( s )
	end function
	function takeByrefStringReturnByrefZstring( byref s as string, isfixed as integer ) byref as zstring
		if( isfixed ) then
			CU_ASSERT( s = MAGIC_F )
		else
			CU_ASSERT( s = MAGIC_S )
		end if
		function = *strptr( s )
	end function
	function takeByrefZstringReturnByrefZstring( byref z as zstring, isfixed as integer ) byref as zstring
		if( isfixed ) then
			CU_ASSERT( z = MAGIC_F )
		else
			CU_ASSERT( z = MAGIC_S )
		end if
		function = z
	end function
	function takeZstringPtrReturnByrefZstring( byval pz as zstring ptr, isfixed as integer ) byref as zstring
		if( isfixed ) then
			CU_ASSERT( *pz = MAGIC_F )
		else
			CU_ASSERT( *pz = MAGIC_S )
		end if
		function = *pz
	end function

	function takeByrefWstringReturnByrefWstring( byref w as wstring, isfixed as integer ) byref as wstring
		if( isfixed ) then
			CU_ASSERT( w = MAGIC_F )
		else
			CU_ASSERT( w = MAGIC_S )
		end if
		function = w
	end function
	function takeWstringPtrReturnByrefWstring( byval pw as wstring ptr, isfixed as integer ) byref as wstring
		if( isfixed ) then
			CU_ASSERT( *pw = MAGIC_F )
		else
			CU_ASSERT( *pw = MAGIC_S )
		end if
		function = *pw
	end function

	function takeByvalStringReturnZstringPtr( byval s as string, isfixed as integer ) as zstring ptr
		if( isfixed ) then
			CU_ASSERT( s = MAGIC_F )
		else
			CU_ASSERT( s = MAGIC_S )
		end if
		function = strptr( s )
	end function
	function takeByrefStringReturnZstringPtr( byref s as string, isfixed as integer ) as zstring ptr
		if( isfixed ) then
			CU_ASSERT( s = MAGIC_F )
		else
			CU_ASSERT( s = MAGIC_S )
		end if
		function = strptr( s )
	end function
	function takeByrefZstringReturnZstringPtr( byref z as zstring, isfixed as integer ) as zstring ptr
		if( isfixed ) then
			CU_ASSERT( z = MAGIC_F )
		else
			CU_ASSERT( z = MAGIC_S )
		end if
		function = @z
	end function
	function takeZstringPtrReturnZstringPtr( byval pz as zstring ptr, isfixed as integer ) as zstring ptr
		if( isfixed ) then
			CU_ASSERT( *pz = MAGIC_F )
		else
			CU_ASSERT( *pz = MAGIC_S )
		end if
		function = pz
	end function

	function takeByrefWstringReturnWstringPtr( byref w as wstring, isfixed as integer ) as wstring ptr
		if( isfixed ) then
			CU_ASSERT( w = MAGIC_F )
		else
			CU_ASSERT( w = MAGIC_S )
		end if
		function = @w
	end function
	function takeWstringPtrReturnWstringPtr( byval pw as wstring ptr, isfixed as integer ) as wstring ptr
		if( isfixed ) then
			CU_ASSERT( *pw = MAGIC_F )
		else
			CU_ASSERT( *pw = MAGIC_S )
		end if
		function = pw
	end function

	TEST( default )
		dim s as string => MAGIC_S
		dim f as string * 31 => MAGIC_S
		dim z as zstring * 32 => MAGIC_S
		dim w as wstring * 32 => MAGIC_S
		dim pz as zstring ptr = @z
		dim pw as wstring ptr = @w

		takeByvalString( s, 0 )
		takeByvalString( f, 1 )
		takeByvalString( z, 0 )
		takeByvalString( w, 0 )
		takeByvalString( hex( MAGIC_I ), 0 )
		takeByvalString( whex( MAGIC_I ), 0 )

		takeByrefString( s, 0 )
		takeByrefString( f, 1 )
		takeByrefString( z, 0 )
		takeByrefString( w, 0 )
		takeByrefString( hex( MAGIC_I ), 0 )
		takeByrefString( whex( MAGIC_I ), 0 )

		takeZstringPtr( s, 0 )
		takeZstringPtr( f, 1 )
		takeZstringPtr( z, 0 )
		takeZstringPtr( w, 0 )
		takeZstringPtr( hex( MAGIC_I ), 0 )
		takeZstringPtr( whex( MAGIC_I ), 0 )

		takeWstringPtr( s, 0 )
		takeWstringPtr( f, 1 )
		takeWstringPtr( z, 0 )
		takeWstringPtr( w, 0 )
		takeWstringPtr( hex( MAGIC_I ), 0 )
		takeWstringPtr( whex( MAGIC_I ), 0 )

		'' ---

		CU_ASSERT( takeByvalStringReturnByvalString( s, 0 ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByvalString( f, 1 ) = MAGIC_F )
		CU_ASSERT( takeByvalStringReturnByvalString( z, 0 ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByvalString( w, 0 ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByvalString( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByvalString( whex( MAGIC_I ), 0 ) = MAGIC_S )

		CU_ASSERT( takeByrefStringReturnByvalString( s, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByvalString( f, 1 ) = MAGIC_F )
		CU_ASSERT( takeByrefStringReturnByvalString( z, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByvalString( w, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByvalString( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByvalString( whex( MAGIC_I ), 0 ) = MAGIC_S )

		CU_ASSERT( takeByrefZstringReturnByvalString( s, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefZstringReturnByvalString( f, 1 ) = MAGIC_F )
		CU_ASSERT( takeByrefZstringReturnByvalString( z, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefZstringReturnByvalString( w, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefZstringReturnByvalString( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefZstringReturnByvalString( whex( MAGIC_I ), 0 ) = MAGIC_S )

		CU_ASSERT( takeByrefWstringReturnByvalString( s, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefWstringReturnByvalString( f, 1 ) = MAGIC_F )
		CU_ASSERT( takeByrefWstringReturnByvalString( z, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefWstringReturnByvalString( w, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefWstringReturnByvalString( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefWstringReturnByvalString( whex( MAGIC_I ), 0 ) = MAGIC_S )

		CU_ASSERT( takeZstringPtrReturnByvalString( s, 0 ) = MAGIC_S )
		CU_ASSERT( takeZstringPtrReturnByvalString( f, 1 ) = MAGIC_F )
		CU_ASSERT( takeZstringPtrReturnByvalString( z, 0 ) = MAGIC_S )
		CU_ASSERT( takeZstringPtrReturnByvalString( w, 0 ) = MAGIC_S )
		CU_ASSERT( takeZstringPtrReturnByvalString( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( takeZstringPtrReturnByvalString( whex( MAGIC_I ), 0 ) = MAGIC_S )

		CU_ASSERT( takeWstringPtrReturnByvalString( s, 0 ) = MAGIC_S )
		CU_ASSERT( takeWstringPtrReturnByvalString( f, 1 ) = MAGIC_F )
		CU_ASSERT( takeWstringPtrReturnByvalString( z, 0 ) = MAGIC_S )
		CU_ASSERT( takeWstringPtrReturnByvalString( w, 0 ) = MAGIC_S )
		CU_ASSERT( takeWstringPtrReturnByvalString( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( takeWstringPtrReturnByvalString( whex( MAGIC_I ), 0 ) = MAGIC_S )

		'' ---

		CU_ASSERT( takeByvalStringReturnByrefString( s, 0 ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByrefString( f, 1 ) = MAGIC_F )
		CU_ASSERT( takeByvalStringReturnByrefString( z, 0 ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByrefString( w, 0 ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByrefString( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByrefString( whex( MAGIC_I ), 0 ) = MAGIC_S )

		CU_ASSERT( takeByrefStringReturnByrefString( s, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByrefString( f, 1 ) = MAGIC_F )
		CU_ASSERT( takeByrefStringReturnByrefString( z, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByrefString( w, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByrefString( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByrefString( whex( MAGIC_I ), 0 ) = MAGIC_S )

		'' ---

		CU_ASSERT( takeByvalStringReturnByrefZstring( s, 0 ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByrefZstring( f, 1 ) = MAGIC_F )
		CU_ASSERT( takeByvalStringReturnByrefZstring( z, 0 ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByrefZstring( w, 0 ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByrefZstring( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( takeByvalStringReturnByrefZstring( whex( MAGIC_I ), 0 ) = MAGIC_S )

		CU_ASSERT( takeByrefStringReturnByrefZstring( s, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByrefZstring( f, 1 ) = MAGIC_F )
		CU_ASSERT( takeByrefStringReturnByrefZstring( z, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByrefZstring( w, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByrefZstring( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefStringReturnByrefZstring( whex( MAGIC_I ), 0 ) = MAGIC_S )

		CU_ASSERT( takeByrefZstringReturnByrefZstring( s, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefZstringReturnByrefZstring( f, 1 ) = MAGIC_F )
		CU_ASSERT( takeByrefZstringReturnByrefZstring( z, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefZstringReturnByrefZstring( w, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefZstringReturnByrefZstring( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefZstringReturnByrefZstring( whex( MAGIC_I ), 0 ) = MAGIC_S )

		CU_ASSERT( takeZstringPtrReturnByrefZstring( s, 0 ) = MAGIC_S )
		CU_ASSERT( takeZstringPtrReturnByrefZstring( f, 1 ) = MAGIC_F )
		CU_ASSERT( takeZstringPtrReturnByrefZstring( z, 0 ) = MAGIC_S )
		CU_ASSERT( takeZstringPtrReturnByrefZstring( w, 0 ) = MAGIC_S )
		CU_ASSERT( takeZstringPtrReturnByrefZstring( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( takeZstringPtrReturnByrefZstring( whex( MAGIC_I ), 0 ) = MAGIC_S )

		'' ---

		CU_ASSERT( takeByrefWstringReturnByrefWstring( s, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefWstringReturnByrefWstring( f, 1 ) = MAGIC_F )
		CU_ASSERT( takeByrefWstringReturnByrefWstring( z, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefWstringReturnByrefWstring( w, 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefWstringReturnByrefWstring( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( takeByrefWstringReturnByrefWstring( whex( MAGIC_I ), 0 ) = MAGIC_S )

		CU_ASSERT( takeWstringPtrReturnByrefWstring( s, 0 ) = MAGIC_S )
		CU_ASSERT( takeWstringPtrReturnByrefWstring( f, 1 ) = MAGIC_F )
		CU_ASSERT( takeWstringPtrReturnByrefWstring( z, 0 ) = MAGIC_S )
		CU_ASSERT( takeWstringPtrReturnByrefWstring( w, 0 ) = MAGIC_S )
		CU_ASSERT( takeWstringPtrReturnByrefWstring( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( takeWstringPtrReturnByrefWstring( whex( MAGIC_I ), 0 ) = MAGIC_S )

		'' ---

		CU_ASSERT( *takeByvalStringReturnZstringPtr( s, 0 ) = MAGIC_S )
		CU_ASSERT( *takeByvalStringReturnZstringPtr( f, 1 ) = MAGIC_F )
		CU_ASSERT( *takeByvalStringReturnZstringPtr( z, 0 ) = MAGIC_S )
		CU_ASSERT( *takeByvalStringReturnZstringPtr( w, 0 ) = MAGIC_S )
		CU_ASSERT( *takeByvalStringReturnZstringPtr( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( *takeByvalStringReturnZstringPtr( whex( MAGIC_I ), 0 ) = MAGIC_S )

		CU_ASSERT( *takeByrefStringReturnZstringPtr( s, 0 ) = MAGIC_S )
		CU_ASSERT( *takeByrefStringReturnZstringPtr( f, 1 ) = MAGIC_F )
		CU_ASSERT( *takeByrefStringReturnZstringPtr( z, 0 ) = MAGIC_S )
		CU_ASSERT( *takeByrefStringReturnZstringPtr( w, 0 ) = MAGIC_S )
		CU_ASSERT( *takeByrefStringReturnZstringPtr( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( *takeByrefStringReturnZstringPtr( whex( MAGIC_I ), 0 ) = MAGIC_S )

		CU_ASSERT( *takeByrefZstringReturnZstringPtr( s, 0 ) = MAGIC_S )
		CU_ASSERT( *takeByrefZstringReturnZstringPtr( f, 1 ) = MAGIC_F )
		CU_ASSERT( *takeByrefZstringReturnZstringPtr( z, 0 ) = MAGIC_S )
		CU_ASSERT( *takeByrefZstringReturnZstringPtr( w, 0 ) = MAGIC_S )
		CU_ASSERT( *takeByrefZstringReturnZstringPtr( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( *takeByrefZstringReturnZstringPtr( whex( MAGIC_I ), 0 ) = MAGIC_S )

		CU_ASSERT( *takeZstringPtrReturnZstringPtr( s, 0 ) = MAGIC_S )
		CU_ASSERT( *takeZstringPtrReturnZstringPtr( f, 1 ) = MAGIC_F )
		CU_ASSERT( *takeZstringPtrReturnZstringPtr( z, 0 ) = MAGIC_S )
		CU_ASSERT( *takeZstringPtrReturnZstringPtr( w, 0 ) = MAGIC_S )
		CU_ASSERT( *takeZstringPtrReturnZstringPtr( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( *takeZstringPtrReturnZstringPtr( whex( MAGIC_I ), 0 ) = MAGIC_S )

		'' ---

		CU_ASSERT( *takeByrefWstringReturnWstringPtr( s, 0 ) = MAGIC_S )
		CU_ASSERT( *takeByrefWstringReturnWstringPtr( f, 1 ) = MAGIC_F )
		CU_ASSERT( *takeByrefWstringReturnWstringPtr( z, 0 ) = MAGIC_S )
		CU_ASSERT( *takeByrefWstringReturnWstringPtr( w, 0 ) = MAGIC_S )
		CU_ASSERT( *takeByrefWstringReturnWstringPtr( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( *takeByrefWstringReturnWstringPtr( whex( MAGIC_I ), 0 ) = MAGIC_S )

		CU_ASSERT( *takeWstringPtrReturnWstringPtr( s, 0 ) = MAGIC_S )
		CU_ASSERT( *takeWstringPtrReturnWstringPtr( f, 1 ) = MAGIC_F )
		CU_ASSERT( *takeWstringPtrReturnWstringPtr( z, 0 ) = MAGIC_S )
		CU_ASSERT( *takeWstringPtrReturnWstringPtr( w, 0 ) = MAGIC_S )
		CU_ASSERT( *takeWstringPtrReturnWstringPtr( hex( MAGIC_I ), 0 ) = MAGIC_S )
		CU_ASSERT( *takeWstringPtrReturnWstringPtr( whex( MAGIC_I ), 0 ) = MAGIC_S )

	END_TEST

END_SUITE
