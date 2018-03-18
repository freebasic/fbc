#include "fbcunit.bi"

SUITE( fbc_tests.functions.byval_string )

	sub f1( byval expectedlen as integer, byval s as string )
		CU_ASSERT( len( s ) = expectedlen )
	end sub

	function f2( byval s1 as string, byref s2 as string ) as integer
		CU_ASSERT( s1 = s2 )
		function = len( s1 )
	end function

	function returnAsIs( byval s as string ) as string
		function = s
	end function

	function returnString( ) as string
		function = "abc"
	end function

	sub passOn( byval s1 as string, byref s2 as string )
		CU_ASSERT( f2( s1, s2 ) = len( s2 ) )
	end sub

	sub modifiesByvalStringParam( byval s as string )
		s = "abc"
	end sub

	sub strptrOfByvalString( byval s as string, byref expected as string )
		var p = strptr( s )
		CU_ASSERT( *p = expected )
	end sub

	TEST( default )
		dim s as string => "1"
		dim f as string * 31 => "12"
		dim z as zstring * 32 => "123"
		dim w as wstring * 32 => wstr( "1234" )
		dim pz as zstring ptr = @z
		dim pw as wstring ptr = @w

		f1( 1, s )
		f1( 2, f )
		f1( 3, z )
		f1( 4, w )
		f1( 3, *pz )
		f1( 4, *pw )
		f1( 1, "1" )
		f1( 2, "12" )
		f1( 1, wstr( "1" ) )
		f1( 2, wstr( "12" ) )

		CU_ASSERT( f2( s, s ) = 1 )
		CU_ASSERT( f2( f, f ) = 2 )
		CU_ASSERT( f2( z, z ) = 3 )
		CU_ASSERT( f2( w, w ) = 4 )
		CU_ASSERT( f2( *pz, *pz ) = 3 )
		CU_ASSERT( f2( *pw, *pw ) = 4 )
		CU_ASSERT( f2( "1", "1" ) = 1 )
		CU_ASSERT( f2( wstr( "1" ), "1" ) = 1 )
		CU_ASSERT( f2( returnString( ), "abc" ) = 3 )
		CU_ASSERT( f2( hex( &hAABBCCDD ), "AABBCCDD" ) = 8 )
		CU_ASSERT( f2( whex( &hAABBCCDD ), "AABBCCDD" ) = 8 )

		CU_ASSERT( returnAsIs( s ) = "1" )
		CU_ASSERT( returnAsIs( s ) = s )
		CU_ASSERT( returnAsIs( f ) = "12" )
		CU_ASSERT( returnAsIs( f ) = f )
		CU_ASSERT( returnAsIs( z ) = "123" )
		CU_ASSERT( returnAsIs( z ) = z )
		CU_ASSERT( returnAsIs( w ) = "1234" )
		CU_ASSERT( returnAsIs( w ) = w )
		CU_ASSERT( returnAsIs( *pz ) = "123" )
		CU_ASSERT( returnAsIs( *pz ) = z )
		CU_ASSERT( returnAsIs( *pw ) = "1234" )
		CU_ASSERT( returnAsIs( *pw ) = w )

		CU_ASSERT( returnAsIs( returnAsIs( s ) ) = "1" )
		CU_ASSERT( returnAsIs( returnAsIs( s ) ) = s )
		CU_ASSERT( returnAsIs( returnAsIs( f ) ) = "12" )
		CU_ASSERT( returnAsIs( returnAsIs( f ) ) = f )
		CU_ASSERT( returnAsIs( returnAsIs( z ) ) = "123" )
		CU_ASSERT( returnAsIs( returnAsIs( z ) ) = z )
		CU_ASSERT( returnAsIs( returnAsIs( w ) ) = "1234" )
		CU_ASSERT( returnAsIs( returnAsIs( w ) ) = w )
		CU_ASSERT( returnAsIs( returnAsIs( *pz ) ) = "123" )
		CU_ASSERT( returnAsIs( returnAsIs( *pz ) ) = z )
		CU_ASSERT( returnAsIs( returnAsIs( *pw ) ) = "1234" )
		CU_ASSERT( returnAsIs( returnAsIs( *pw ) ) = w )

		passOn( s, s )

		CU_ASSERT( s = "1"    ) : modifiesByvalStringParam( s   ) : CU_ASSERT( s = "1"    )
		CU_ASSERT( f = "12"   ) : modifiesByvalStringParam( f   ) : CU_ASSERT( f = "12"   )
		CU_ASSERT( z = "123"  ) : modifiesByvalStringParam( z   ) : CU_ASSERT( z = "123"  )
		CU_ASSERT( w = "1234" ) : modifiesByvalStringParam( w   ) : CU_ASSERT( w = "1234" )
		CU_ASSERT( z = "123"  ) : modifiesByvalStringParam( *pz ) : CU_ASSERT( z = "123"  )
		CU_ASSERT( w = "1234" ) : modifiesByvalStringParam( *pw ) : CU_ASSERT( w = "1234" )

		strptrOfByvalString( s, "1" )
		strptrOfByvalString( f, "12" )
		strptrOfByvalString( z, "123" )
		strptrOfByvalString( w, "1234" )
		strptrOfByvalString( *pz, "123" )
		strptrOfByvalString( *pw, "1234" )

	END_TEST

END_SUITE
