#include "fbcunit.bi"

SUITE( fbc_tests.pp.quote )

	function hQuote( byref s as string ) as string
		dim res as string = "$"""
		for i as integer = 0 to len(s)-1
			if( s[i] = asc("""") ) then
				res += """"""
			else
				res += chr( s[i] )
			end if
		next
		res += """"
		function = res
	end function

	TEST( direct )

		CU_ASSERT_EQUAL( __FB_QUOTE__( freebasic ), "freebasic" )

		scope
			__FB_UNQUOTE__( "dim n as integer = 1" )
			CU_ASSERT_EQUAL( n, 1 )
		end scope

		scope
			__FB_UNQUOTE__( "dim s as string = ""freebasic""" )
			CU_ASSERT_EQUAL( s, "freebasic" )
		end scope

	END_TEST

	TEST( empty )

		CU_ASSERT_EQUAL( _
			__FB_QUOTE__(), _
			"" _
		)

		CU_ASSERT_EQUAL( _
			__FB_QUOTE__( ), _
			"" _
		)

		CU_ASSERT_EQUAL( _
			__FB_QUOTE__ _
			( _
			), _
			"" _
		)

	END_TEST

	TEST( multiple )

		CU_ASSERT_EQUAL( _
			__FB_QUOTE__( freebasic ), _
			"freebasic" _
		)

		CU_ASSERT_EQUAL( _
			__FB_QUOTE__( "freebasic" ), _
			"""freebasic""" _
		)

		CU_ASSERT_EQUAL( _
			__FB_QUOTE__( __FB_QUOTE__( freebasic ) ), _
			hQuote( "freebasic" ) _
		)

		CU_ASSERT_EQUAL( _
			__FB_UNQUOTE__( __FB_QUOTE__( __FB_QUOTE__( freebasic ) ) ), _
			"freebasic" _
		)

		CU_ASSERT_EQUAL( _
			__FB_UNQUOTE__( __FB_UNQUOTE__( __FB_QUOTE__( __FB_QUOTE__( __FB_QUOTE__( freebasic ) ) ) ) ), _
			"freebasic" _
		)

	END_TEST

	TEST( defs )

		#define token freebasic
		#define text  __FB_QUOTE__(token)

		#define s( x ) #x
		#define q( x ) hQuote( #x )

		CU_ASSERT_EQUAL( s( freebasic ), "freebasic" )
		CU_ASSERT_EQUAL( s( token )    , "freebasic" )

		CU_ASSERT_EQUAL( q( freebasic ), "$""freebasic""" )
		CU_ASSERT_EQUAL( q( token )    , "$""freebasic""" )

		CU_ASSERT_EQUAL( s( text )     , "$""freebasic""" )
		CU_ASSERT_EQUAL( q( text )     , "$""$""""freebasic""""""" )

		CU_ASSERT_EQUAL( s( freebasic ), text )
		CU_ASSERT_EQUAL( s( token ),     text )

		CU_ASSERT_EQUAL( __FB_QUOTE__( "freebasic" ), """freebasic""" )

		CU_ASSERT_EQUAL( __FB_QUOTE__( freebasic ), "freebasic" )
		CU_ASSERT_EQUAL( __FB_QUOTE__( freebasic ), s( freebasic ) )

		CU_ASSERT_EQUAL( __FB_QUOTE__( token )    , "freebasic" )
		CU_ASSERT_EQUAL( __FB_QUOTE__( text )     , hQuote( "freebasic" ) )

	END_TEST

END_SUITE
