# include once "fbcu.bi"

namespace fbc_tests.expressions.iif_tests

dim shared as integer condtrue = -1, condfalse = 0

sub testIntBop cdecl( )
	const TEST1 = 1234
	const TEST2 = 5678
	dim as integer res

	res = (TEST1 xor iif( condtrue, TEST1, TEST2 )) or (iif( condfalse, TEST2, TEST1 ) xor TEST1)
	CU_ASSERT_EQUAL( res, 0 )

	res = (TEST2 xor iif( condfalse, TEST1, TEST2 )) or (iif( condtrue, TEST2, TEST1 ) xor TEST2)
	CU_ASSERT_EQUAL( res, 0 )


	const TEST_VAL as integer = 1234

	dim value as integer = TEST_VAL
	dim test as integer = 0

	value += iif (test > 5, 10, -10) + iif (test < 5, 10, -10)
	CU_ASSERT_EQUAL( value, TEST_VAL )

	value += iif (test > -5, 10, -10) + iif (test < -5, 10, -10)
	CU_ASSERT_EQUAL( value, TEST_VAL )
end sub

sub testFloatBop cdecl( )
	const TEST1 as double = 1234.0
	const TEST2 as double = 5678.0

	dim as double res

	res = iif( condtrue, TEST1, 0.0 ) * iif( condfalse, 0.0, TEST2 )
	CU_ASSERT_EQUAL( res, TEST1 * TEST2 )
end sub

#macro checkStr( a, b, c, EMPTY, hex )
	c = iif( -1, a, b )
	CU_ASSERT( c = a )

	c = iif( -1, a + b, EMPTY )
	CU_ASSERT( c = a + b )

	c = iif( -1, EMPTY, a + b )
	CU_ASSERT( c = EMPTY )

	c = iif( -1, hex( 123 ), hex( 456 ) )
	CU_ASSERT( c = hex( 123 ) )


	c = iif( 0, a, b )
	CU_ASSERT( c = b )

	c = iif( 0, a + b, EMPTY )
	CU_ASSERT( c = EMPTY )

	c = iif( 0, EMPTY, a + b )
	CU_ASSERT( c = a + b )

	c = iif( 0, hex( 123 ), hex( 456 ) )
	CU_ASSERT( c = hex( 456 ) )


	c = iif( condtrue, a, b )
	CU_ASSERT( c = a )

	c = iif( condtrue, a + b, EMPTY )
	CU_ASSERT( c = a + b )

	c = iif( condtrue, EMPTY, a + b )
	CU_ASSERT( c = EMPTY )

	c = iif( condtrue, hex( 123 ), hex( 456 ) )
	CU_ASSERT( c = hex( 123 ) )


	c = iif( condfalse, a, b )
	CU_ASSERT( c = b )

	c = iif( condfalse, a + b, EMPTY )
	CU_ASSERT( c = EMPTY )

	c = iif( condfalse, EMPTY, a + b )
	CU_ASSERT( c = a + b )

	c = iif( condfalse, hex( 123 ), hex( 456 ) )
	CU_ASSERT( c = hex( 456 ) )
#endmacro

#macro hStringChecks( a, b, c )
	a = "1234"      : b = "5678"     : checkStr(          a,          b, c, "", hex )
	a = ""          : b = "5678"     : checkStr(     "1234",          b, c, "", hex )
	a = "1234"      : b = ""         : checkStr(          a,     "5678", c, "", hex )

	a = "aaaaaaaa"  : b = "b"        : checkStr(          a,          b, c, "", hex )
	a = ""          : b = "b"        : checkStr( "aaaaaaaa",          b, c, "", hex )
	a = "aaaaaaaa"  : b = ""         : checkStr(          a,        "b", c, "", hex )

	a = "a"         : b = "bbbbbbbb" : checkStr(          a,          b, c, "", hex )
	a = ""          : b = "bbbbbbbb" : checkStr(        "a",          b, c, "", hex )
	a = "a"         : b = ""         : checkStr(          a, "bbbbbbbb", c, "", hex )

	a = ""          : b = ""         : checkStr(          a,          b, c, "", hex )
	a = ""          : b = ""         : checkStr(         "",          b, c, "", hex )
	a = ""          : b = ""         : checkStr(          a,         "", c, "", hex )
#endmacro

#macro hWstringChecks( a, b, c )
	a = wstr( "1234"     ) : b = wstr( "5678"     ) : checkStr(                  a,                  b, c, wstr( "" ), whex )
	a = wstr( ""         ) : b = wstr( "5678"     ) : checkStr(     wstr( "1234" ),                  b, c, wstr( "" ), whex )
	a = wstr( "1234"     ) : b = wstr( ""         ) : checkStr(                  a,     wstr( "5678" ), c, wstr( "" ), whex )
	a = wstr( "aaaaaaaa" ) : b = wstr( "b"        ) : checkStr(                  a,                  b, c, wstr( "" ), whex )
	a = wstr( ""         ) : b = wstr( "b"        ) : checkStr( wstr( "aaaaaaaa" ),                  b, c, wstr( "" ), whex )
	a = wstr( "aaaaaaaa" ) : b = wstr( ""         ) : checkStr(                  a,        wstr( "b" ), c, wstr( "" ), whex )
	a = wstr( "a"        ) : b = wstr( "bbbbbbbb" ) : checkStr(                  a,                  b, c, wstr( "" ), whex )
	a = wstr( ""         ) : b = wstr( "bbbbbbbb" ) : checkStr(        wstr( "a" ),                  b, c, wstr( "" ), whex )
	a = wstr( "a"        ) : b = wstr( ""         ) : checkStr(                  a, wstr( "bbbbbbbb" ), c, wstr( "" ), whex )
	a = wstr( ""         ) : b = wstr( ""         ) : checkStr(                  a,                  b, c, wstr( "" ), whex )
	a = wstr( ""         ) : b = wstr( ""         ) : checkStr(         wstr( "" ),                  b, c, wstr( "" ), whex )
	a = wstr( ""         ) : b = wstr( ""         ) : checkStr(                  a,         wstr( "" ), c, wstr( "" ), whex )
#endmacro

private sub hCheckByrefStrings( byref a as string, byref b as string, byref c as string )
	hStringChecks( a, b, c )
end sub

private sub hCheckByrefWstrings( byref a as wstring, byref b as wstring, byref c as wstring )
	hWstringChecks( a, b, c )
end sub

sub testStrings cdecl( )
	scope
		dim as string a, b, c
		hStringChecks( a, b, c )
	end scope

	scope
		dim as string * 33 a, b, c
		hStringChecks( a, b, c )
	end scope

	scope
		dim as zstring * 32+1 a, b, c
		hStringChecks( a, b, c )
	end scope

	scope
		dim as wstring * 32+1 a, b, c
		hWstringChecks( a, b, c )
	end scope

	scope
		dim as string aa, bb, cc
		dim as string ptr pa, pb, pc
		pa = @aa
		pb = @bb
		pc = @cc

		hStringChecks( *pa, *pb, *pc )
	end scope

	scope
		dim as zstring * 32+1 aa, bb, cc
		dim as zstring ptr pa, pb, pc
		pa = @aa
		pb = @bb
		pc = @cc

		hStringChecks( *pa, *pb, *pc )
	end scope

	scope
		dim as wstring * 32+1 aa, bb, cc
		dim as wstring ptr pa, pb, pc
		pa = @aa
		pb = @bb
		pc = @cc

		hWstringChecks( *pa, *pb, *pc )
	end scope

	scope
		dim as string a, b, c
		hCheckByrefStrings( a, b, c )
	end scope

	scope
		dim as wstring * 32+1 a, b, c
		hCheckByrefWstrings( a, b, c )
	end scope
end sub

sub testNested cdecl( )
	#macro checkNested( T, NA, NB, NC )
		scope
			dim as T a, b, c, d

			a = NA
			b = NB
			c = NC

			d = iif(         0, a, b ) : CU_ASSERT( d = b )
			d = iif(        -1, a, b ) : CU_ASSERT( d = a )
			d = iif( condfalse, a, b ) : CU_ASSERT( d = b )
			d = iif(  condtrue, a, b ) : CU_ASSERT( d = a )

			d = iif(  0, iif(  0, a, b ), c ) : CU_ASSERT( d = c )
			d = iif(  0, iif( -1, a, b ), c ) : CU_ASSERT( d = c )
			d = iif( -1, iif(  0, a, b ), c ) : CU_ASSERT( d = b )
			d = iif( -1, iif( -1, a, b ), c ) : CU_ASSERT( d = a )

			d = iif(  0, a, iif(  0, b, c ) ) : CU_ASSERT( d = c )
			d = iif(  0, a, iif( -1, b, c ) ) : CU_ASSERT( d = b )
			d = iif( -1, a, iif(  0, b, c ) ) : CU_ASSERT( d = a )
			d = iif( -1, a, iif( -1, b, c ) ) : CU_ASSERT( d = a )

			d = iif( condfalse, iif( condfalse, a, b ), c ) : CU_ASSERT( d = c )
			d = iif( condfalse, iif(  condtrue, a, b ), c ) : CU_ASSERT( d = c )
			d = iif(  condtrue, iif( condfalse, a, b ), c ) : CU_ASSERT( d = b )
			d = iif(  condtrue, iif(  condtrue, a, b ), c ) : CU_ASSERT( d = a )

			d = iif( condfalse, a, iif( condfalse, b, c ) ) : CU_ASSERT( d = c )
			d = iif( condfalse, a, iif(  condtrue, b, c ) ) : CU_ASSERT( d = b )
			d = iif(  condtrue, a, iif( condfalse, b, c ) ) : CU_ASSERT( d = a )
			d = iif(  condtrue, a, iif(  condtrue, b, c ) ) : CU_ASSERT( d = a )
		end scope
	#endmacro

	checkNested(  byte, 1, 2, 3 )
	checkNested( ubyte, 1, 2, 3 )
	checkNested(  short, 1111, 2222, 3333 )
	checkNested( ushort, 1111, 2222, 3333 )
	checkNested(  integer, 111111, 222222, 333333 )
	checkNested( uinteger, 111111u, 222222u, 333333u )
	checkNested(  longint, 111111111111ll, 222222222222ll, 333333333333ll )
	checkNested( ulongint, 111111111111ull, 222222222222ull, 333333333333ull )
	checkNested( string,    "",    "",    "" )
	checkNested( string,   "a",   "b",   "c" )
	checkNested( string, "aaa",   "b",   "c" )
	checkNested( string,   "a", "bbb",   "c" )
	checkNested( string,   "a",   "b", "ccc" )
	checkNested( string,    "",   "b",   "c" )
	checkNested( string,   "a",    "",   "c" )
	checkNested( string,   "a",   "b",    "" )

	dim as integer xa, xb, xc
	checkNested( integer ptr, @xa, @xb, @xc )
end sub

dim shared as integer fint1calls, fint2calls
dim shared as integer fstr1calls, fstr2calls
dim shared as integer fzstr1calls, fzstr2calls
dim shared as integer fwstr1calls, fwstr2calls

function fint1( ) as integer
	fint1calls += 1
	function = 1
end function

function fint2( ) as integer
	fint2calls += 1
	function = 2
end function

function fstr1( ) as string
	fstr1calls += 1
	function = "1"
end function

function fstr2( ) as string
	fstr2calls += 1
	function = "2"
end function

function fzstr1( ) as zstring ptr
	static as zstring * 32+1 z = "1"
	fzstr1calls += 1
	function = @z
end function

function fzstr2( ) as zstring ptr
	static as zstring * 32+1 z = "2"
	fzstr2calls += 1
	function = @z
end function

function fwstr1( ) as wstring ptr
	static as wstring * 32+1 w = wstr( "1" )
	fwstr1calls += 1
	function = @w
end function

function fwstr2( ) as wstring ptr
	static as wstring * 32+1 w = wstr( "2" )
	fwstr2calls += 1
	function = @w
end function

sub testSideFx cdecl( )
	#macro check( T, f1, f2, f1calls, f2calls, N1, N2 )
		scope
			dim as T a

			CU_ASSERT( f1calls = 0 )
			CU_ASSERT( f2calls = 0 )

			a = iif(         0, f1( ), f2( ) )
			CU_ASSERT( a = N2 )
			CU_ASSERT( f1calls = 0 )
			CU_ASSERT( f2calls = 1 )

			a = iif(        -1, f1( ), f2( ) )
			CU_ASSERT( a = N1 )
			CU_ASSERT( f1calls = 1 )
			CU_ASSERT( f2calls = 1 )

			a = iif( condfalse, f1( ), f2( ) )
			CU_ASSERT( a = N2 )
			CU_ASSERT( f1calls = 1 )
			CU_ASSERT( f2calls = 2 )

			a = iif(  condtrue, f1( ), f2( ) )
			CU_ASSERT( a = N1 )
			CU_ASSERT( f1calls = 2 )
			CU_ASSERT( f2calls = 2 )
		end scope
	#endmacro

	check(        integer,   fint1,   fint2,  fint1calls,  fint2calls,   1,   2 )
	check(         string,   fstr1,   fstr2,  fstr1calls,  fstr2calls, "1", "2" )
	check( zstring * 32+1, *fzstr1, *fzstr2, fzstr1calls, fzstr2calls, "1", "2" )
	check( wstring * 32+1, *fwstr1, *fwstr2, fwstr1calls, fwstr2calls, wstr( "1" ), wstr( "2" ) )
end sub

sub testConstness cdecl( )
	#macro check( ConstT, T, NA, NB )
		scope
			dim as ConstT a = NA, b = NB
			dim as T c

			c = iif(         0, a, b ) : CU_ASSERT( c = b )
			c = iif(        -1, a, b ) : CU_ASSERT( c = a )
			c = iif( condfalse, a, b ) : CU_ASSERT( c = b )
			c = iif(  condtrue, a, b ) : CU_ASSERT( c = a )
		end scope
	#endmacro

	check( const     byte,     byte, 1, 2 )
	check( const    ubyte,    ubyte, 1, 2 )
	check( const    short,    short, 1, 2 )
	check( const   ushort,   ushort, 1, 2 )
	check( const  integer,  integer, 1, 2 )
	check( const uinteger, uinteger, 1, 2 )
	check( const  longint,  longint, 1, 2 )
	check( const ulongint, ulongint, 1, 2 )
	check( const   string,   string, "1", "2" )

	scope
		dim as integer xa, xb
		check(     any const ptr,     any ptr, @xa, @xb )
		check( integer const ptr, integer ptr, @xa, @xb )
	end scope

	scope
		dim as zstring * 32+1 z1, z2
		check( zstring const ptr, zstring ptr, @z1, @z2 )
	end scope
end sub

sub testDifferentTypes cdecl( )
	#macro check( TA, NA, TB, RA )
		scope
			dim as TA a = NA
			dim as TB b = 0
			CU_ASSERT( iif(  condtrue, a, b ) = RA )
			CU_ASSERT( iif( condfalse, a, b ) = 0 )
			CU_ASSERT( iif(  condtrue, b, a ) = 0 )
			CU_ASSERT( iif( condfalse, b, a ) = RA )
		end scope
	#endmacro

	check( byte, -1,     byte,   -1 )
	check( byte, -1,    ubyte, &hFF )
	check( byte, -1,    short,   -1 )
	check( byte, -1,   ushort, &hFFFF )
	check( byte, -1,  integer,   -1 )
	check( byte, -1, uinteger, &hFFFFFFFFu )
	check( byte, -1,  longint,   -1 )
	check( byte, -1, ulongint, &hFFFFFFFFFFFFFFFFull )

	check( ubyte, &hFF,     byte, &hFF )
	check( ubyte, &hFF,    ubyte, &hFF )
	check( ubyte, &hFF,    short, &hFF )
	check( ubyte, &hFF,   ushort, &hFF )
	check( ubyte, &hFF,  integer, &hFF )
	check( ubyte, &hFF, uinteger, &hFF )
	check( ubyte, &hFF,  longint, &hFF )
	check( ubyte, &hFF, ulongint, &hFF )

	check( short, -1,     byte,     -1 )
	check( short, -1,    ubyte,     -1 )
	check( short, -1,    short,     -1 )
	check( short, -1,   ushort, &hFFFF )
	check( short, -1,  integer,     -1 )
	check( short, -1, uinteger, &hFFFFFFFFu )
	check( short, -1,  longint,     -1 )
	check( short, -1, ulongint, &hFFFFFFFFFFFFFFFFull )

	check( ushort, &hFFFF,     byte, &hFFFF )
	check( ushort, &hFFFF,    ubyte, &hFFFF )
	check( ushort, &hFFFF,    short, &hFFFF )
	check( ushort, &hFFFF,   ushort, &hFFFF )
	check( ushort, &hFFFF,  integer, &hFFFF )
	check( ushort, &hFFFF, uinteger, &hFFFF )
	check( ushort, &hFFFF,  longint, &hFFFF )
	check( ushort, &hFFFF, ulongint, &hFFFF )

	check( integer, -1,     byte,     -1 )
	check( integer, -1,    ubyte,     -1 )
	check( integer, -1,    short,     -1 )
	check( integer, -1,   ushort,     -1 )
	check( integer, -1,  integer,     -1 )
	check( integer, -1, uinteger, &hFFFFFFFFu )
	check( integer, -1,  longint,     -1 )
	check( integer, -1, ulongint, &hFFFFFFFFFFFFFFFFull )

	check( uinteger, &hFFFFFFFFu,     byte, &hFFFFFFFFu )
	check( uinteger, &hFFFFFFFFu,    ubyte, &hFFFFFFFFu )
	check( uinteger, &hFFFFFFFFu,    short, &hFFFFFFFFu )
	check( uinteger, &hFFFFFFFFu,   ushort, &hFFFFFFFFu )
	check( uinteger, &hFFFFFFFFu,  integer, &hFFFFFFFFu )
	check( uinteger, &hFFFFFFFFu, uinteger, &hFFFFFFFFu )
	check( uinteger, &hFFFFFFFFu,  longint, &hFFFFFFFFu )
	check( uinteger, &hFFFFFFFFu, ulongint, &hFFFFFFFFu )

	check( longint, -1,     byte,     -1 )
	check( longint, -1,    ubyte,     -1 )
	check( longint, -1,    short,     -1 )
	check( longint, -1,   ushort,     -1 )
	check( longint, -1,  integer,     -1 )
	check( longint, -1, uinteger,     -1 )
	check( longint, -1,  longint,     -1 )
	check( longint, -1, ulongint, &hFFFFFFFFFFFFFFFFull )

	check( ulongint, &hFFFFFFFFFFFFFFFFull,     byte, &hFFFFFFFFFFFFFFFFull )
	check( ulongint, &hFFFFFFFFFFFFFFFFull,    ubyte, &hFFFFFFFFFFFFFFFFull )
	check( ulongint, &hFFFFFFFFFFFFFFFFull,    short, &hFFFFFFFFFFFFFFFFull )
	check( ulongint, &hFFFFFFFFFFFFFFFFull,   ushort, &hFFFFFFFFFFFFFFFFull )
	check( ulongint, &hFFFFFFFFFFFFFFFFull,  integer, &hFFFFFFFFFFFFFFFFull )
	check( ulongint, &hFFFFFFFFFFFFFFFFull, uinteger, &hFFFFFFFFFFFFFFFFull )
	check( ulongint, &hFFFFFFFFFFFFFFFFull,  longint, &hFFFFFFFFFFFFFFFFull )
	check( ulongint, &hFFFFFFFFFFFFFFFFull, ulongint, &hFFFFFFFFFFFFFFFFull )

	CU_ASSERT( iif(  condtrue, csng( 1.0 ),       2.0   ) = 1.0 )
	CU_ASSERT( iif(  condtrue,       1.0  , csng( 2.0 ) ) = 1.0 )
	CU_ASSERT( iif( condfalse, csng( 1.0 ),       2.0   ) = 2.0 )
	CU_ASSERT( iif( condfalse,       1.0  , csng( 2.0 ) ) = 2.0 )

	CU_ASSERT( iif(  condtrue, cptr( integer ptr, 0 ), 1 ) = cptr( integer ptr, 0 ) )
	CU_ASSERT( iif( condfalse, cptr( integer ptr, 0 ), 1 ) = cptr( integer ptr, 1 ) )
	CU_ASSERT( iif(  condtrue, 0, cptr( integer ptr, 1 ) ) = cptr( integer ptr, 0 ) )
	CU_ASSERT( iif( condfalse, 0, cptr( integer ptr, 1 ) ) = cptr( integer ptr, 1 ) )
end sub

sub ctor( ) constructor
	fbcu.add_suite( "tests/expressions/iif" )
	fbcu.add_test( "int BOP", @testIntBop )
	fbcu.add_test( "float BOP", @testFloatBop )
	fbcu.add_test( "string IIF", @testStrings )
	fbcu.add_test( "nested IIFs", @testNested )
	fbcu.add_test( "side effects", @testSideFx )
	fbcu.add_test( "CONSTness", @testConstness )
	fbcu.add_test( "different types", @testDifferentTypes )
end sub

end namespace
