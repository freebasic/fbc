#include "fbcunit.bi"

SUITE( fbc_tests.pp.quote_utf8 )

	TEST( direct )

		CU_ASSERT_EQUAL( __FB_QUOTE__( Καλημέρα ), "Καλημέρα" )

		scope
			__FB_UNQUOTE__( "dim n as integer = 1" )
			CU_ASSERT_EQUAL( n, 1 )
		end scope

		scope
			__FB_UNQUOTE__( "dim s as string = ""Καλημέρα""" )
			CU_ASSERT_EQUAL( s, "Καλημέρα" )
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
			__FB_QUOTE__( Καλημέρα ), _
			"Καλημέρα" _
		)

		CU_ASSERT_EQUAL( _
			__FB_QUOTE__( "Καλημέρα" ), _
			"""Καλημέρα""" _
		)

		CU_ASSERT_EQUAL( _
			__FB_QUOTE__( __FB_QUOTE__( Καλημέρα ) ), _
			"$""Καλημέρα""" _
		)

		CU_ASSERT_EQUAL( _
			__FB_UNQUOTE__( __FB_QUOTE__( __FB_QUOTE__( Καλημέρα ) ) ), _
			"Καλημέρα" _
		)

		CU_ASSERT_EQUAL( _
			__FB_UNQUOTE__( __FB_UNQUOTE__( __FB_QUOTE__( __FB_QUOTE__( __FB_QUOTE__( Καλημέρα ) ) ) ) ), _
			"Καλημέρα" _
		)

	END_TEST

	TEST( strings )

		#define token "Καλημέρα"
		#define text  __FB_QUOTE__(token)

		#define s( x ) #x

		CU_ASSERT_EQUAL( s( "Καλημέρα" ), """Καλημέρα""" )
		CU_ASSERT_EQUAL( s( token )     , """Καλημέρα""" )
		CU_ASSERT_EQUAL( s( text )      , "$""""""Καλημέρα""""""" )

		CU_ASSERT_EQUAL( s( "Καλημέρα" ), text )
		CU_ASSERT_EQUAL( s( token )     , text )

		CU_ASSERT_EQUAL( __FB_QUOTE__( "Καλημέρα" ), """Καλημέρα""" )
		CU_ASSERT_EQUAL( __FB_QUOTE__( token )    , """Καλημέρα""" )
		CU_ASSERT_EQUAL( __FB_QUOTE__( text )     , "$""""""Καλημέρα"""""""  )

	END_TEST

END_SUITE
