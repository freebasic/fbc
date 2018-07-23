# include "fbcunit.bi"

SUITE( fbc_tests.compound.select_ )

	const FALSE = 0
	const TRUE = not FALSE

	''::::
	TEST( case_single_value )

	const TEST_VAL = 100
		
		dim as integer v = TEST_VAL
		dim as integer ok
		
		select case v
		case TEST_VAL - 5
			ok = FALSE
		case TEST_VAL - 4
			ok = FALSE
		case TEST_VAL - 3
			ok = FALSE
		case TEST_VAL - 2
			ok = FALSE
		case TEST_VAL - 1
			ok = FALSE
		case TEST_VAL + 1
			ok = FALSE
		case TEST_VAL + 2
			ok = FALSE
		case TEST_VAL + 3
			ok = FALSE
		case TEST_VAL + 4
			ok = FALSE
		case TEST_VAL + 5
			ok = FALSE
		case TEST_VAL
			ok = TRUE
		case else
			ok = FALSE
		end select
		
		CU_ASSERT_EQUAL( ok, TRUE )

	END_TEST

	''::::
	TEST( case_multiple_value )

	const TEST_VAL = -100
		
		dim as integer v = TEST_VAL
		dim as integer ok
		
		select case v
		case TEST_VAL - 5, TEST_VAL - 6, TEST_VAL - 7, TEST_VAL - 8
			ok = FALSE
		case TEST_VAL - 4, TEST_VAL - 5, TEST_VAL - 6
			ok = FALSE
		case TEST_VAL - 3, TEST_VAL - 4
			ok = FALSE
		case TEST_VAL - 2
			ok = FALSE
		case TEST_VAL - 1
			ok = FALSE
		case TEST_VAL + 1
			ok = FALSE
		case TEST_VAL + 2
			ok = FALSE
		case TEST_VAL + 3, TEST_VAL + 4
			ok = FALSE
		case TEST_VAL + 4, TEST_VAL + 5, TEST_VAL + 6
			ok = FALSE
		case TEST_VAL + 5, TEST_VAL + 6, TEST_VAL + 7, TEST_VAL + 8
			ok = FALSE
		case TEST_VAL
			ok = TRUE
		case else
			ok = FALSE
		end select
		
		CU_ASSERT_EQUAL( ok, TRUE )

	END_TEST

	''::::
	TEST( case_single_range )

	const TEST_VAL = 100
		
		dim as integer v = TEST_VAL
		dim as integer ok
		
		select case v
		case TEST_VAL - 8 to TEST_VAL - 5
			ok = FALSE
		case TEST_VAL - 6 to TEST_VAL - 4
			ok = FALSE
		case TEST_VAL - 4 to TEST_VAL - 3
			ok = FALSE
		case TEST_VAL - 2 to TEST_VAL - 2
			ok = FALSE
		case TEST_VAL - 1 
			ok = FALSE
		case TEST_VAL + 1
			ok = FALSE
		case TEST_VAL + 2 to TEST_VAL + 2
			ok = FALSE
		case TEST_VAL + 3 to TEST_VAL + 4
			ok = FALSE
		case TEST_VAL + 4 to TEST_VAL + 6
			ok = FALSE
		case TEST_VAL + 5 to TEST_VAL + 8
			ok = FALSE
		case TEST_VAL - 1 to TEST_VAL + 1
			ok = TRUE
		case else
			ok = FALSE
		end select
		
		CU_ASSERT_EQUAL( ok, TRUE )

	END_TEST

	''::::
	TEST( case_multiple_range )

	const TEST_VAL = -100
		
		dim as integer v = TEST_VAL
		dim as integer ok
		
		select case v
		case TEST_VAL - 8 to TEST_VAL - 5, TEST_VAL - 12 to TEST_VAL - 9
			ok = FALSE
		case TEST_VAL - 6 to TEST_VAL - 4, TEST_VAL - 7 to TEST_VAL - 5
			ok = FALSE
		case TEST_VAL - 4 to TEST_VAL - 3, TEST_VAL - 5 to TEST_VAL - 4
			ok = FALSE
		case TEST_VAL - 2 to TEST_VAL - 2
			ok = FALSE
		case TEST_VAL - 1 
			ok = FALSE
		case TEST_VAL + 1
			ok = FALSE
		case TEST_VAL + 2 to TEST_VAL + 2
			ok = FALSE
		case TEST_VAL + 3 to TEST_VAL + 4, TEST_VAL + 4 to TEST_VAL + 5
			ok = FALSE
		case TEST_VAL + 4 to TEST_VAL + 6, TEST_VAL + 4 to TEST_VAL + 7
			ok = FALSE
		case TEST_VAL + 5 to TEST_VAL + 8, TEST_VAL + 9 to TEST_VAL + 12
			ok = FALSE
		case TEST_VAL - 1 to TEST_VAL + 1
			ok = TRUE
		case else
			ok = FALSE
		end select
		
		CU_ASSERT_EQUAL( ok, TRUE )

	END_TEST

	''::::
	TEST( case_is_single_value )

	const TEST_VAL = 100
		
		dim as integer v = TEST_VAL
		dim as integer ok
		
		select case v
		case is < TEST_VAL - 5
			ok = FALSE
		case is <= TEST_VAL - 4
			ok = FALSE
		case is < TEST_VAL - 3
			ok = FALSE
		case is < TEST_VAL - 2
			ok = FALSE
		case is <= TEST_VAL - 1
			ok = FALSE
		case is > TEST_VAL + 1
			ok = FALSE
		case is >= TEST_VAL + 2
			ok = FALSE
		case is > TEST_VAL + 3
			ok = FALSE
		case is >= TEST_VAL + 4
			ok = FALSE
		case is > TEST_VAL + 5
			ok = FALSE
		case is >= TEST_VAL
			ok = TRUE
		case else
			ok = FALSE
		end select
		
		CU_ASSERT_EQUAL( ok, TRUE )

	END_TEST

	''::::
	TEST( case_is_multiple_value )

	const TEST_VAL = -100
		
		dim as integer v = TEST_VAL
		dim as integer ok
		
		select case v
		case is < TEST_VAL - 5, is < TEST_VAL - 6, is < TEST_VAL - 7, is < TEST_VAL - 8
			ok = FALSE
		case is <= TEST_VAL - 4, is <= TEST_VAL - 5, is <= TEST_VAL - 6
			ok = FALSE
		case is < TEST_VAL - 3, is < TEST_VAL - 4
			ok = FALSE
		case is < TEST_VAL - 2
			ok = FALSE
		case is <= TEST_VAL - 1
			ok = FALSE
		case is > TEST_VAL + 1
			ok = FALSE
		case is >= TEST_VAL + 2
			ok = FALSE
		case is > TEST_VAL + 3, is > TEST_VAL + 4
			ok = FALSE
		case is >= TEST_VAL + 4, is >= TEST_VAL + 5, is >= TEST_VAL + 6
			ok = FALSE
		case is > TEST_VAL + 5, is > TEST_VAL + 6, is > TEST_VAL + 7, is > TEST_VAL + 8
			ok = FALSE
		case is <= TEST_VAL
			ok = TRUE
		case else
			ok = FALSE
		end select
		
		CU_ASSERT_EQUAL( ok, TRUE )

	END_TEST

	TEST( case_string )
		dim as string s = "a"

		select case( s + "b" )
		case "ab"

		case "b"
			CU_FAIL( )
		case else
			CU_FAIL( )
		end select
	END_TEST

	#macro check( expr, expectedvalue )
		select case expr
		case expectedvalue
		case else
			CU_FAIL( )
		end select
	#endmacro

	type SmallUdt
		as integer a
	end type

	type SmallUdt2 field = 1
		as short a
		as short b
	end type

	type BigUdt
		as integer a, b, c, d, e, f
	end type

	type BitfieldsUdt
		a : 1 as integer
		b : 1 as integer
	end type

	private function returnInteger123( ) as integer
		function = 123
	end function

	private function returnUIntegerMax( ) as uinteger
		function = &hFFFFFFFFu
	end function

	private function returnLongint123( ) as longint
		function = 123ll
	end function

	private function returnULongintMax( ) as ulongint
		function = &hFFFFFFFFFFFFFFFFull
	end function

	function returnSmallUdt( ) as SmallUdt
		function = type( 123 )
	end function

	function returnSmallUdt2( ) as SmallUdt2
		function = type( 123, 456 )
	end function

	function returnBigUdt( ) as BigUdt
		function = type( 123, 456, 0, 0, 0, 0 )
	end function

	dim shared as integer globali = 123
	dim shared as integer globalarray(0 to 1) = { 123, 456 }

	TEST( expressions )
		scope
			static as integer statici = 123
			static as integer staticarray(0 to 1) = { 123, 456 }
			dim as integer i = 123
			dim as integer array(0 to 1) = { 123, 456 }
			dim as integer ptr p = @array(0)
			dim as integer ix = 0

			check( i, 123 )
			check( statici, 123 )
			check( globali, 123 )
			check( i + 1, 124 )
			check( i = 123, -1 )
			check( -i, -123 )
			check( *p, 123 )
			check( p[1], 456 )
			check( p[ix], 123 )

			check( array(0), 123 )
			check( array(1), 456 )
			check( array(ix), 123 )
			check( staticarray(0), 123 )
			check( staticarray(1), 456 )
			check( staticarray(ix), 123 )
			check( globalarray(0), 123 )
			check( globalarray(1), 456 )
			check( globalarray(ix), 123 )
		end scope

		scope
			dim as BigUdt udt = ( 123, 456, 0, 0, 0, 0 )
			check( udt.a, 123 )
			check( udt.b, 456 )

			dim as BitfieldsUdt bitfields = ( 1, 0 )
			check( bitfields.a, 1 )
			check( bitfields.b, 0 )
		end scope

		scope
			check( returnInteger123( ), 123 )
			check( returnUIntegerMax( ), &hFFFFFFFFu )
			check( returnLongint123( ), 123ll )
			check( returnULongintMax( ), &hFFFFFFFFFFFFFFFFull )
			check( returnSmallUdt( ).a, 123 )
			check( returnSmallUdt2( ).a, 123 )
			check( returnSmallUdt2( ).b, 456 )
			check( returnBigUdt( ).a, 123 )
			check( returnBigUdt( ).b, 456 )
		end scope

		scope
			dim as string s = "123"
			dim as string * 3 f = "123"
			dim as zstring * 4 z = "123"
			dim as wstring * 4 w = wstr( "123" )
			dim as string ptr ps = @s
			dim as zstring ptr pz = @z
			dim as wstring ptr pw = @w

			check( s, "123" )
			check( f, "123" )
			check( z, "123" )
			check( w, wstr( "123" ) )
			check( *ps, "123" )
			check( *pz, "123" )
			check( *pw, wstr( "123" ) )

			check( lcase( s ), "123" )
			check( lcase( f ), "123" )
			check( lcase( z ), "123" )
			check( lcase( w ), wstr( "123" ) )
			check( lcase( *ps ), "123" )
			check( lcase( *pz ), "123" )
			check( lcase( *pw ), wstr( "123" ) )

			check( s + "123", "123123" )
			check( f + "123", "123123" )
			check( z + "123", "123123" )
			check( w + wstr( "123" ), wstr( "123123" ) )
			check( *ps + "123", "123123" )
			check( *pz + "123", "123123" )
			check( *pw + wstr( "123" ), wstr( "123123" ) )
		end scope
	END_TEST

	dim shared as integer intcalls, strcalls, strptrcalls, zstrcalls, wstrcalls
	dim shared globalstr as string

	private function sidefxInt( ) as integer
		intcalls += 1
		function = 123
	end function

	private function sidefxStr( ) as string
		strcalls += 1
		function = globalstr
	end function

	private function sidefxStrPtr( ) as string ptr
		strptrcalls += 1
		function = @globalstr
	end function

	private function sidefxZstr( ) as zstring ptr
		static z as zstring * 10 = "123"
		zstrcalls += 1
		function = @z
	end function

	private function sidefxWstr( ) as wstring ptr
		static w as wstring * 10 = wstr( "123" )
		wstrcalls += 1
		function = @w
	end function

	TEST( sideEffects )
		CU_ASSERT( intcalls = 0 )
		check( sidefxInt( ), 123 )
		CU_ASSERT( intcalls = 1 )
		intcalls = 0

		CU_ASSERT( intcalls = 0 )
		check( 123, sidefxInt( ) )
		CU_ASSERT( intcalls = 1 )
		intcalls = 0

		#macro checkStr( expr, expectedexpr )
			CU_ASSERT( strcalls = 0 )
			check( expr, expectedexpr )
			CU_ASSERT( strcalls = 1 )
			strcalls = 0
		#endmacro

		#macro checkStrPtr( expr, expectedexpr )
			CU_ASSERT( strptrcalls = 0 )
			check( expr, expectedexpr )
			CU_ASSERT( strptrcalls = 1 )
			strptrcalls = 0
		#endmacro

		#macro checkZstr( expr, expectedexpr )
			CU_ASSERT( zstrcalls = 0 )
			check( expr, expectedexpr )
			CU_ASSERT( zstrcalls = 1 )
			zstrcalls = 0
		#endmacro

		#macro checkWstr( expr, expectedexpr )
			CU_ASSERT( wstrcalls = 0 )
			check( expr, expectedexpr )
			CU_ASSERT( wstrcalls = 1 )
			wstrcalls = 0
		#endmacro

		#macro checkStrings( checkMacro, f, var, lit )
			checkMacro( f      , lit       )
			checkMacro( f + var, lit + lit )
			checkMacro( f + lit, lit + lit )
			checkMacro( f      , var       )
			checkMacro( f + var, var + lit )
			checkMacro( f + lit, var + lit )
			checkMacro( f + var, var + var )
			checkMacro( f + lit, var + var )

			checkMacro( lit      , f       )
			checkMacro( lit + lit, f + var )
			checkMacro( lit + lit, f + lit )
			checkMacro( var      , f       )
			checkMacro( var + lit, f + var )
			checkMacro( var + lit, f + lit )
			checkMacro( var + var, f + var )
			checkMacro( var + var, f + lit )
		#endmacro

		globalstr = "123"
		dim s as string = "123"
		dim i as integer = 123
		dim z as zstring * 4 = "123"
		dim w as wstring * 4 = wstr( "123" )

		checkStrings( checkStr   , sidefxStr( )    , s, "123" )
		checkStrings( checkStrPtr, *sidefxStrPtr( ), s, "123" )
		checkStrings( check      , str( i )        , s, "123" )
		checkStrings( checkZstr  , *sidefxZstr( )  , z, "123" )
		checkStrings( checkWstr  , *sidefxWstr( )  , w, wstr( "123" ) )
		checkStrings( check      , wstr( i )       , w, wstr( "123" ) )
	END_TEST

END_SUITE
