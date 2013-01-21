# include "fbcu.bi"

namespace fbc_tests.compound.select_

const FALSE = 0
const TRUE = not FALSE

''::::
sub test_single_1 cdecl ( )

const TEST = 100
	
	dim as integer v = TEST
	dim as integer ok
	
	select case v
	case TEST - 5
		ok = FALSE
	case TEST - 4
		ok = FALSE
	case TEST - 3
		ok = FALSE
	case TEST - 2
		ok = FALSE
	case TEST - 1
		ok = FALSE
	case TEST + 1
		ok = FALSE
	case TEST + 2
		ok = FALSE
	case TEST + 3
		ok = FALSE
	case TEST + 4
		ok = FALSE
	case TEST + 5
		ok = FALSE
	case TEST
		ok = TRUE
	case else
		ok = FALSE
	end select
	
	CU_ASSERT_EQUAL( ok, TRUE )

end sub

''::::
sub test_single_2 cdecl ( )

const TEST = -100
	
	dim as integer v = TEST
	dim as integer ok
	
	select case v
	case TEST - 5, TEST - 6, TEST - 7, TEST - 8
		ok = FALSE
	case TEST - 4, TEST - 5, TEST - 6
		ok = FALSE
	case TEST - 3, TEST - 4
		ok = FALSE
	case TEST - 2
		ok = FALSE
	case TEST - 1
		ok = FALSE
	case TEST + 1
		ok = FALSE
	case TEST + 2
		ok = FALSE
	case TEST + 3, TEST + 4
		ok = FALSE
	case TEST + 4, TEST + 5, TEST + 6
		ok = FALSE
	case TEST + 5, TEST + 6, TEST + 7, TEST + 8
		ok = FALSE
	case TEST
		ok = TRUE
	case else
		ok = FALSE
	end select
	
	CU_ASSERT_EQUAL( ok, TRUE )

end sub

''::::
sub test_range_1 cdecl ( )

const TEST = 100
	
	dim as integer v = TEST
	dim as integer ok
	
	select case v
	case TEST - 8 to TEST - 5
		ok = FALSE
	case TEST - 6 to TEST - 4
		ok = FALSE
	case TEST - 4 to TEST - 3
		ok = FALSE
	case TEST - 2 to TEST - 2
		ok = FALSE
	case TEST - 1 
		ok = FALSE
	case TEST + 1
		ok = FALSE
	case TEST + 2 to TEST + 2
		ok = FALSE
	case TEST + 3 to TEST + 4
		ok = FALSE
	case TEST + 4 to TEST + 6
		ok = FALSE
	case TEST + 5 to TEST + 8
		ok = FALSE
	case TEST - 1 to TEST + 1
		ok = TRUE
	case else
		ok = FALSE
	end select
	
	CU_ASSERT_EQUAL( ok, TRUE )

end sub

''::::
sub test_range_2 cdecl ( )

const TEST = -100
	
	dim as integer v = TEST
	dim as integer ok
	
	select case v
	case TEST - 8 to TEST - 5, TEST - 12 to TEST - 9
		ok = FALSE
	case TEST - 6 to TEST - 4, TEST - 7 to TEST - 5
		ok = FALSE
	case TEST - 4 to TEST - 3, TEST - 5 to TEST - 4
		ok = FALSE
	case TEST - 2 to TEST - 2
		ok = FALSE
	case TEST - 1 
		ok = FALSE
	case TEST + 1
		ok = FALSE
	case TEST + 2 to TEST + 2
		ok = FALSE
	case TEST + 3 to TEST + 4, TEST + 4 to TEST + 5
		ok = FALSE
	case TEST + 4 to TEST + 6, TEST + 4 to TEST + 7
		ok = FALSE
	case TEST + 5 to TEST + 8, TEST + 9 to TEST + 12
		ok = FALSE
	case TEST - 1 to TEST + 1
		ok = TRUE
	case else
		ok = FALSE
	end select
	
	CU_ASSERT_EQUAL( ok, TRUE )

end sub

''::::
sub test_is_1 cdecl ( )

const TEST = 100
	
	dim as integer v = TEST
	dim as integer ok
	
	select case v
	case is < TEST - 5
		ok = FALSE
	case is <= TEST - 4
		ok = FALSE
	case is < TEST - 3
		ok = FALSE
	case is < TEST - 2
		ok = FALSE
	case is <= TEST - 1
		ok = FALSE
	case is > TEST + 1
		ok = FALSE
	case is >= TEST + 2
		ok = FALSE
	case is > TEST + 3
		ok = FALSE
	case is >= TEST + 4
		ok = FALSE
	case is > TEST + 5
		ok = FALSE
	case is >= TEST
		ok = TRUE
	case else
		ok = FALSE
	end select
	
	CU_ASSERT_EQUAL( ok, TRUE )

end sub

''::::
sub test_is_2 cdecl ( )

const TEST = -100
	
	dim as integer v = TEST
	dim as integer ok
	
	select case v
	case is < TEST - 5, is < TEST - 6, is < TEST - 7, is < TEST - 8
		ok = FALSE
	case is <= TEST - 4, is <= TEST - 5, is <= TEST - 6
		ok = FALSE
	case is < TEST - 3, is < TEST - 4
		ok = FALSE
	case is < TEST - 2
		ok = FALSE
	case is <= TEST - 1
		ok = FALSE
	case is > TEST + 1
		ok = FALSE
	case is >= TEST + 2
		ok = FALSE
	case is > TEST + 3, is > TEST + 4
		ok = FALSE
	case is >= TEST + 4, is >= TEST + 5, is >= TEST + 6
		ok = FALSE
	case is > TEST + 5, is > TEST + 6, is > TEST + 7, is > TEST + 8
		ok = FALSE
	case is <= TEST
		ok = TRUE
	case else
		ok = FALSE
	end select
	
	CU_ASSERT_EQUAL( ok, TRUE )

end sub

private sub testStringConcat cdecl( )
	dim as string s = "a"

	select case( s + "b" )
	case "ab"

	case "b"
		CU_FAIL( )
	case else
		CU_FAIL( )
	end select
end sub

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

private sub testExpressions cdecl( )
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
end sub

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

private sub testSidefx cdecl( )
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
end sub

sub ctor( ) constructor
	fbcu.add_suite("fbc_tests-compound:select")
	fbcu.add_test("test single1", @test_single_1)
	fbcu.add_test("test single2", @test_single_2)
	fbcu.add_test("test range1", @test_range_1)
	fbcu.add_test("test range2", @test_range_2)
	fbcu.add_test("test is1", @test_is_1)
	fbcu.add_test("test is2", @test_is_2)
	fbcu.add_test("SELECT CASE s + s", @testStringConcat)
	fbcu.add_test("All kinds of expressions", @testExpressions)
	fbcu.add_test("side effects", @testSidefx)
end sub

end namespace
