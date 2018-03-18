# include once "fbcunit.bi"

SUITE( fbc_tests.expressions.iif_ )

	dim shared as integer condtrue = -1, condfalse = 0

	'' int BOP
	TEST( iifIntBop )
		const TEST1 = 1234
		const TEST2 = 5678
		dim as integer res

		res = (TEST1 xor iif( condtrue, TEST1, TEST2 )) or (iif( condfalse, TEST2, TEST1 ) xor TEST1)
		CU_ASSERT_EQUAL( res, 0 )

		res = (TEST2 xor iif( condfalse, TEST1, TEST2 )) or (iif( condtrue, TEST2, TEST1 ) xor TEST2)
		CU_ASSERT_EQUAL( res, 0 )


		const TEST_VAL as integer = 1234

		dim value as integer = TEST_VAL
		dim test_int as integer = 0

		value += iif (test_int > 5, 10, -10) + iif (test_int < 5, 10, -10)
		CU_ASSERT_EQUAL( value, TEST_VAL )

		value += iif (test_int > -5, 10, -10) + iif (test_int < -5, 10, -10)
		CU_ASSERT_EQUAL( value, TEST_VAL )
	END_TEST

	'' float BOP
	TEST( iifFloatBop )
		const TEST1 as double = 1234.0
		const TEST2 as double = 5678.0

		dim as double res

		res = iif( condtrue, TEST1, 0.0 ) * iif( condfalse, 0.0, TEST2 )
		CU_ASSERT_EQUAL( res, TEST1 * TEST2 )
	END_TEST

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

	sub hCheckByrefStrings( byref a as string, byref b as string, byref c as string )
		hStringChecks( a, b, c )
	end sub

	sub hCheckByrefWstrings( byref a as wstring, byref b as wstring, byref c as wstring )
		hWstringChecks( a, b, c )
	end sub

	'' string IIF
	TEST( iifString )
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
	END_TEST

	sub hCheckByvalString( byval s as string, byval expected as zstring ptr )
		CU_ASSERT( s = *expected )
	end sub

	sub hCheckByrefString( byref s as string, byval expected as zstring ptr )
		CU_ASSERT( s = *expected )
	end sub

	sub hCheckByrefZstring( byref z as zstring, byval expected as zstring ptr )
		CU_ASSERT( z = *expected )
	end sub

	sub hCheckByvalZstringPtr( byval pz as zstring ptr, byval expected as zstring ptr )
		CU_ASSERT( *pz = *expected )
	end sub

	sub hCheckByrefWstring( byref w as wstring, byval expected as wstring ptr )
		CU_ASSERT( w = *expected )
	end sub

	sub hCheckByvalWstringPtr( byval pw as wstring ptr, byval expected as wstring ptr )
		CU_ASSERT( *pw = *expected )
	end sub

	'' string IIF as ARG
	TEST( iifStringAsArg )
		hCheckByvalString    ( iif( condtrue , "a", "bb" ), "a"  )
		hCheckByvalString    ( iif( condfalse, "a", "bb" ), "bb" )
		hCheckByrefString    ( iif( condtrue , "a", "bb" ), "a"  )
		hCheckByrefString    ( iif( condfalse, "a", "bb" ), "bb" )
		hCheckByrefZstring   ( iif( condtrue , "a", "bb" ), "a"  )
		hCheckByrefZstring   ( iif( condfalse, "a", "bb" ), "bb" )
		hCheckByvalZstringPtr( iif( condtrue , "a", "bb" ), "a"  )
		hCheckByvalZstringPtr( iif( condfalse, "a", "bb" ), "bb" )
		hCheckByrefWstring   ( iif( condtrue , wstr( "a" ), wstr( "bb" ) ), wstr( "a"  ) )
		hCheckByrefWstring   ( iif( condfalse, wstr( "a" ), wstr( "bb" ) ), wstr( "bb" ) )
		hCheckByvalWstringPtr( iif( condtrue , wstr( "a" ), wstr( "bb" ) ), wstr( "a"  ) )
		hCheckByvalWstringPtr( iif( condfalse, wstr( "a" ), wstr( "bb" ) ), wstr( "bb" ) )

		'' Testing some other RTL procs too (besides string assign/concat):

		CU_ASSERT( valint( iif( condtrue , "123", "456" ) ) = 123 )
		CU_ASSERT( valint( iif( condfalse, "123", "456" ) ) = 456 )

		CU_ASSERT( valint( iif( condtrue , wstr( "123" ), wstr( "456" ) ) ) = 123 )
		CU_ASSERT( valint( iif( condfalse, wstr( "123" ), wstr( "456" ) ) ) = 456 )

		CU_ASSERT( len( iif( condtrue , "aaaa", "b" ) ) = 4 )
		CU_ASSERT( len( iif( condfalse, "aaaa", "b" ) ) = 1 )

		CU_ASSERT( len( iif( condtrue , wstr( "aaaa" ), wstr( "b" ) ) ) = 4 )
		CU_ASSERT( len( iif( condfalse, wstr( "aaaa" ), wstr( "b" ) ) ) = 1 )
	END_TEST

	'' nested IIFs
	TEST( iifNested )
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
	END_TEST

	type UDT
		as integer i, j
	end type

	sub hCheckByrefUdt _
		( _
			byref x as UDT, _
			byval expecti as integer, _
			byval expectj as integer _
		)

		CU_ASSERT( x.i = expecti )
		CU_ASSERT( x.j = expectj )

	end sub

	sub hCheckByvalUdt _
		( _
			byval x as UDT, _
			byval expecti as integer, _
			byval expectj as integer _
		)

		CU_ASSERT( x.i = expecti )
		CU_ASSERT( x.j = expectj )

	end sub

	'' UDT IIF
	TEST( iifUdt )
		dim as UDT a = ( 12, 34 ), b = ( 56, 78 ), c = ( 11, 22 ), d

		CU_ASSERT( (iif( condtrue , a, b )).i = 12 )
		CU_ASSERT( (iif( condtrue , a, b )).j = 34 )
		CU_ASSERT( (iif( condfalse, a, b )).i = 56 )
		CU_ASSERT( (iif( condfalse, a, b )).j = 78 )

		CU_ASSERT( (iif( condtrue , iif( condtrue , a, b ), c )).i = 12 )
		CU_ASSERT( (iif( condtrue , iif( condtrue , a, b ), c )).j = 34 )
		CU_ASSERT( (iif( condtrue , iif( condfalse, a, b ), c )).i = 56 )
		CU_ASSERT( (iif( condtrue , iif( condfalse, a, b ), c )).j = 78 )
		CU_ASSERT( (iif( condfalse, iif( condtrue , a, b ), c )).i = 11 )
		CU_ASSERT( (iif( condfalse, iif( condtrue , a, b ), c )).j = 22 )
		CU_ASSERT( (iif( condfalse, iif( condfalse, a, b ), c )).i = 11 )
		CU_ASSERT( (iif( condfalse, iif( condfalse, a, b ), c )).j = 22 )

		CU_ASSERT( (iif( condtrue , a, iif( condtrue , b, c ) )).i = 12 )
		CU_ASSERT( (iif( condtrue , a, iif( condtrue , b, c ) )).j = 34 )
		CU_ASSERT( (iif( condtrue , a, iif( condfalse, b, c ) )).i = 12 )
		CU_ASSERT( (iif( condtrue , a, iif( condfalse, b, c ) )).j = 34 )
		CU_ASSERT( (iif( condfalse, a, iif( condtrue , b, c ) )).i = 56 )
		CU_ASSERT( (iif( condfalse, a, iif( condtrue , b, c ) )).j = 78 )
		CU_ASSERT( (iif( condfalse, a, iif( condfalse, b, c ) )).i = 11 )
		CU_ASSERT( (iif( condfalse, a, iif( condfalse, b, c ) )).j = 22 )

		d = iif( condtrue, a, b )
		CU_ASSERT( d.i = 12 )
		CU_ASSERT( d.j = 34 )

		d = iif( condfalse, a, b )
		CU_ASSERT( d.i = 56 )
		CU_ASSERT( d.j = 78 )


		d = iif( condtrue , iif( condtrue , a, b ), c )
		CU_ASSERT( d.i = 12 )
		CU_ASSERT( d.j = 34 )

		d = iif( condtrue , iif( condfalse, a, b ), c )
		CU_ASSERT( d.i = 56 )
		CU_ASSERT( d.j = 78 )

		d = iif( condfalse, iif( condtrue , a, b ), c )
		CU_ASSERT( d.i = 11 )
		CU_ASSERT( d.j = 22 )

		d = iif( condfalse, iif( condfalse, a, b ), c )
		CU_ASSERT( d.i = 11 )
		CU_ASSERT( d.j = 22 )


		d = iif( condtrue , a, iif( condtrue , b, c ) )
		CU_ASSERT( d.i = 12 )
		CU_ASSERT( d.j = 34 )

		d = iif( condtrue , a, iif( condfalse, b, c ) )
		CU_ASSERT( d.i = 12 )
		CU_ASSERT( d.j = 34 )

		d = iif( condfalse, a, iif( condtrue , b, c ) )
		CU_ASSERT( d.i = 56 )
		CU_ASSERT( d.j = 78 )

		d = iif( condfalse, a, iif( condfalse, b, c ) )
		CU_ASSERT( d.i = 11 )
		CU_ASSERT( d.j = 22 )

		hCheckByrefUdt( iif( condtrue , a, b ), 12, 34 )
		hCheckByrefUdt( iif( condfalse, a, b ), 56, 78 )
		hCheckByvalUdt( iif( condtrue , a, b ), 12, 34 )
		hCheckByvalUdt( iif( condfalse, a, b ), 56, 78 )

		CU_ASSERT( (iif( condtrue , type<UDT>( 11, 22 ), a )).i = 11 )
		CU_ASSERT( (iif( condtrue , type<UDT>( 11, 22 ), a )).j = 22 )
		CU_ASSERT( (iif( condfalse, type<UDT>( 11, 22 ), a )).i = 12 )
		CU_ASSERT( (iif( condfalse, type<UDT>( 11, 22 ), a )).j = 34 )

		CU_ASSERT( (iif( condtrue , a, type<UDT>( 11, 22 ) )).i = 12 )
		CU_ASSERT( (iif( condtrue , a, type<UDT>( 11, 22 ) )).j = 34 )
		CU_ASSERT( (iif( condfalse, a, type<UDT>( 11, 22 ) )).i = 11 )
		CU_ASSERT( (iif( condfalse, a, type<UDT>( 11, 22 ) )).j = 22 )

		CU_ASSERT( (iif( condtrue , type<UDT>( 11, 22 ), type<UDT>( 33, 44 ) )).i = 11 )
		CU_ASSERT( (iif( condtrue , type<UDT>( 11, 22 ), type<UDT>( 33, 44 ) )).j = 22 )
		CU_ASSERT( (iif( condfalse, type<UDT>( 11, 22 ), type<UDT>( 33, 44 ) )).i = 33 )
		CU_ASSERT( (iif( condfalse, type<UDT>( 11, 22 ), type<UDT>( 33, 44 ) )).j = 44 )
	END_TEST

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

	'' side effects
	TEST( iifSideEffects )
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

		scope
			dim as string a = "a", b = "b"
			CU_ASSERT( iif( condtrue , a + b, b + a ) = "ab" )
			CU_ASSERT( iif( condfalse, a + b, b + a ) = "ba" )
		end scope
	END_TEST

	'' CONSTness
	TEST( iifConstness )
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
	END_TEST

	'' different types
	TEST( iifDifferentTypes )
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
		check( byte, -1,     long,   -1 )
		check( byte, -1,    ulong, &hFFFFFFFFu )
		check( byte, -1,  integer,   -1 )
	#if sizeof( uinteger ) = 4
		check( byte, -1, uinteger, &hFFFFFFFFu )
	#else
		check( byte, -1, uinteger, &hFFFFFFFFFFFFFFFFu )
	#endif
		check( byte, -1,  longint,   -1 )
		check( byte, -1, ulongint, &hFFFFFFFFFFFFFFFFull )

		check( ubyte, &hFF,     byte, &hFF )
		check( ubyte, &hFF,    ubyte, &hFF )
		check( ubyte, &hFF,    short, &hFF )
		check( ubyte, &hFF,   ushort, &hFF )
		check( ubyte, &hFF,     long, &hFF )
		check( ubyte, &hFF,    ulong, &hFF )
		check( ubyte, &hFF,  integer, &hFF )
		check( ubyte, &hFF, uinteger, &hFF )
		check( ubyte, &hFF,  longint, &hFF )
		check( ubyte, &hFF, ulongint, &hFF )

		check( short, -1,     byte,     -1 )
		check( short, -1,    ubyte,     -1 )
		check( short, -1,    short,     -1 )
		check( short, -1,   ushort, &hFFFF )
		check( short, -1,     long,     -1 )
		check( short, -1,    ulong, &hFFFFFFFFu )
		check( short, -1,  integer,     -1 )
	#if sizeof( uinteger ) = 4
		check( short, -1, uinteger, &hFFFFFFFFu )
	#else
		check( short, -1, uinteger, &hFFFFFFFFFFFFFFFFu )
	#endif
		check( short, -1,  longint,     -1 )
		check( short, -1, ulongint, &hFFFFFFFFFFFFFFFFull )

		check( ushort, &hFFFF,     byte, &hFFFF )
		check( ushort, &hFFFF,    ubyte, &hFFFF )
		check( ushort, &hFFFF,    short, &hFFFF )
		check( ushort, &hFFFF,   ushort, &hFFFF )
		check( ushort, &hFFFF,     long, &hFFFF )
		check( ushort, &hFFFF,    ulong, &hFFFF )
		check( ushort, &hFFFF,  integer, &hFFFF )
		check( ushort, &hFFFF, uinteger, &hFFFF )
		check( ushort, &hFFFF,  longint, &hFFFF )
		check( ushort, &hFFFF, ulongint, &hFFFF )

		check( integer, -1,     byte,     -1 )
		check( integer, -1,    ubyte,     -1 )
		check( integer, -1,    short,     -1 )
		check( integer, -1,   ushort,     -1 )
		check( integer, -1,     long,     -1 )
	#if sizeof( integer ) = 4
		check( integer, -1,    ulong, &hFFFFFFFFu )
	#else
		check( integer, -1,    ulong, &hFFFFFFFFFFFFFFFFu )
	#endif
		check( integer, -1,  integer,     -1 )
	#if sizeof( integer ) = 4
		check( integer, -1, uinteger, &hFFFFFFFFu )
	#else
		check( integer, -1, uinteger, &hFFFFFFFFFFFFFFFFu )
	#endif
		check( integer, -1,  longint,     -1 )
		check( integer, -1, ulongint, &hFFFFFFFFFFFFFFFFull )

		check( uinteger, &hFFFFFFFFu,     byte, &hFFFFFFFFu )
		check( uinteger, &hFFFFFFFFu,    ubyte, &hFFFFFFFFu )
		check( uinteger, &hFFFFFFFFu,    short, &hFFFFFFFFu )
		check( uinteger, &hFFFFFFFFu,   ushort, &hFFFFFFFFu )
		check( uinteger, &hFFFFFFFFu,     long, &hFFFFFFFFu )
		check( uinteger, &hFFFFFFFFu,    ulong, &hFFFFFFFFu )
		check( uinteger, &hFFFFFFFFu,  integer, &hFFFFFFFFu )
		check( uinteger, &hFFFFFFFFu, uinteger, &hFFFFFFFFu )
		check( uinteger, &hFFFFFFFFu,  longint, &hFFFFFFFFu )
		check( uinteger, &hFFFFFFFFu, ulongint, &hFFFFFFFFu )
	#if sizeof( uinteger ) = 8
		check( uinteger, &hFFFFFFFFFFFFFFFFu,     byte, &hFFFFFFFFFFFFFFFFu )
		check( uinteger, &hFFFFFFFFFFFFFFFFu,    ubyte, &hFFFFFFFFFFFFFFFFu )
		check( uinteger, &hFFFFFFFFFFFFFFFFu,    short, &hFFFFFFFFFFFFFFFFu )
		check( uinteger, &hFFFFFFFFFFFFFFFFu,   ushort, &hFFFFFFFFFFFFFFFFu )
		check( uinteger, &hFFFFFFFFFFFFFFFFu,     long, &hFFFFFFFFFFFFFFFFu )
		check( uinteger, &hFFFFFFFFFFFFFFFFu,    ulong, &hFFFFFFFFFFFFFFFFu )
		check( uinteger, &hFFFFFFFFFFFFFFFFu,  integer, &hFFFFFFFFFFFFFFFFu )
		check( uinteger, &hFFFFFFFFFFFFFFFFu, uinteger, &hFFFFFFFFFFFFFFFFu )
		check( uinteger, &hFFFFFFFFFFFFFFFFu,  longint, &hFFFFFFFFFFFFFFFFu )
		check( uinteger, &hFFFFFFFFFFFFFFFFu, ulongint, &hFFFFFFFFFFFFFFFFu )
	#endif

		check( longint, -1,     byte,     -1 )
		check( longint, -1,    ubyte,     -1 )
		check( longint, -1,    short,     -1 )
		check( longint, -1,   ushort,     -1 )
		check( longint, -1,     long,     -1 )
		check( longint, -1,    ulong,     -1 )
		check( longint, -1,  integer,     -1 )
		check( longint, -1, uinteger,     -1 )
		check( longint, -1,  longint,     -1 )
		check( longint, -1, ulongint, &hFFFFFFFFFFFFFFFFull )

		check( ulongint, &hFFFFFFFFFFFFFFFFull,     byte, &hFFFFFFFFFFFFFFFFull )
		check( ulongint, &hFFFFFFFFFFFFFFFFull,    ubyte, &hFFFFFFFFFFFFFFFFull )
		check( ulongint, &hFFFFFFFFFFFFFFFFull,    short, &hFFFFFFFFFFFFFFFFull )
		check( ulongint, &hFFFFFFFFFFFFFFFFull,   ushort, &hFFFFFFFFFFFFFFFFull )
		check( ulongint, &hFFFFFFFFFFFFFFFFull,     long, &hFFFFFFFFFFFFFFFFull )
		check( ulongint, &hFFFFFFFFFFFFFFFFull,    ulong, &hFFFFFFFFFFFFFFFFull )
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
	END_TEST

	TEST_GROUP( iifTempVarDefCtor )
		dim shared as integer ctors

		type CtorUdt
			i as integer
			declare constructor( )
		end type

		constructor CtorUdt( )
			ctors += 1
		end constructor

		'' iif() ctors
		TEST( default )
			CU_ASSERT( ctors = 0 )
			dim as CtorUdt a, b
			CU_ASSERT( ctors = 2 )

			a.i = 11
			b.i = 22
			a = iif( condtrue, a, b )
			CU_ASSERT( ctors = 3 )
			CU_ASSERT( a.i = 11 )

			a.i = 11
			b.i = 22
			a = iif( condfalse, a, b )
			CU_ASSERT( ctors = 4 )
			CU_ASSERT( a.i = 22 )

			a.i = 11
			a = iif( condtrue, CtorUdt( ), a )
			CU_ASSERT( ctors = 5 )
			CU_ASSERT( a.i = 0 )

			a.i = 11
			a = iif( condfalse, CtorUdt( ), a )
			CU_ASSERT( ctors = 6 )
			CU_ASSERT( a.i = 11 )

			a.i = 11
			a = iif( condtrue, a, CtorUdt( ) )
			CU_ASSERT( ctors = 7 )
			CU_ASSERT( a.i = 11 )

			a.i = 11
			a = iif( condfalse, a, CtorUdt( ) )
			CU_ASSERT( ctors = 8 )
			CU_ASSERT( a.i = 0 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( iifTempVarDefCtorAndCopyCtor )
		dim shared as integer defctors, copyctors

		type CtorUdt
			i as integer
			declare constructor( )
			declare constructor( as CtorUdt )
		end type

		constructor CtorUdt( )
			defctors += 1
		end constructor

		constructor CtorUdt( rhs as CtorUdt )
			copyctors += 1
			this.i = rhs.i
		end constructor

		'' iif() ctors
		TEST( default )
			CU_ASSERT(  defctors = 0 )
			CU_ASSERT( copyctors = 0 )

			dim as CtorUdt a, b
			CU_ASSERT(  defctors = 2 )
			CU_ASSERT( copyctors = 0 )

			a.i = 1
			b.i = 2
			a = iif( condtrue, a, b )
			CU_ASSERT(  defctors = 2 )
			CU_ASSERT( copyctors = 1 )
			CU_ASSERT( a.i = 1 )

			a.i = 1
			b.i = 2
			a = iif( condfalse, a, b )
			CU_ASSERT(  defctors = 2 )
			CU_ASSERT( copyctors = 2 )
			CU_ASSERT( a.i = 2 )

			a.i = 1
			a = iif( condtrue, CtorUdt( ), a )
			CU_ASSERT(  defctors = 3 )
			CU_ASSERT( copyctors = 2 )
			CU_ASSERT( a.i = 0 )

			a.i = 1
			a = iif( condfalse, CtorUdt( ), a )
			CU_ASSERT(  defctors = 3 )
			CU_ASSERT( copyctors = 3 )
			CU_ASSERT( a.i = 1 )

			a.i = 1
			a = iif( condtrue, a, CtorUdt( ) )
			CU_ASSERT(  defctors = 3 )
			CU_ASSERT( copyctors = 4 )
			CU_ASSERT( a.i = 1 )

			a.i = 1
			a = iif( condfalse, a, CtorUdt( ) )
			CU_ASSERT(  defctors = 4 )
			CU_ASSERT( copyctors = 4 )
			CU_ASSERT( a.i = 0 )

			a.i = 1
			a = iif( condtrue, type<CtorUdt>( ), a )
			CU_ASSERT(  defctors = 5 )
			CU_ASSERT( copyctors = 4 )
			CU_ASSERT( a.i = 0 )

			a.i = 1
			a = iif( condfalse, type<CtorUdt>( ), a )
			CU_ASSERT(  defctors = 5 )
			CU_ASSERT( copyctors = 5 )
			CU_ASSERT( a.i = 1 )

			a.i = 1
			a = iif( condtrue, a, type<CtorUdt>( ) )
			CU_ASSERT(  defctors = 5 )
			CU_ASSERT( copyctors = 6 )
			CU_ASSERT( a.i = 1 )

			a.i = 1
			a = iif( condfalse, a, type<CtorUdt>( ) )
			CU_ASSERT(  defctors = 6 )
			CU_ASSERT( copyctors = 6 )
			CU_ASSERT( a.i = 0 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( iifTempVarIntCtor )
		dim shared as integer ctors

		type CtorUdt
			i as integer
			declare constructor( as integer )
		end type

		constructor CtorUdt( i as integer )
			ctors += 1
			this.i = i
		end constructor

		'' iif() ctors
		TEST( default )
			CU_ASSERT( ctors = 0 )
			dim as CtorUdt a = CtorUdt( 0 )
			CU_ASSERT( ctors = 1 )

			a = iif( condfalse, CtorUdt( 123 ), CtorUdt( 456 ) )
			CU_ASSERT( ctors = 2 )
			CU_ASSERT( a.i = 456 )

			a = iif( condtrue, CtorUdt( 123 ), CtorUdt( 456 ) )
			CU_ASSERT( ctors = 3 )
			CU_ASSERT( a.i = 123 )

			a = iif( condfalse, type<CtorUdt>( 123 ), type<CtorUdt>( 456 ) )
			CU_ASSERT( ctors = 4 )
			CU_ASSERT( a.i = 456 )

			a = iif( condtrue, type<CtorUdt>( 123 ), type<CtorUdt>( 456 ) )
			CU_ASSERT( ctors = 5 )
			CU_ASSERT( a.i = 123 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( iifTempVarIntCtorAndCopyCtor )
		dim shared as integer intctors, copyctors

		type CtorUdt
			i as integer
			declare constructor( as integer )
			declare constructor( as CtorUdt )
		end type

		constructor CtorUdt( i as integer )
			intctors += 1
			this.i = i
		end constructor

		constructor CtorUdt( rhs as CtorUdt )
			copyctors += 1
			this.i = rhs.i
		end constructor

		'' iif() ctors
		TEST( default )
			CU_ASSERT(  intctors = 0 )
			CU_ASSERT( copyctors = 0 )

			dim as CtorUdt a = CtorUdt( 0 )
			CU_ASSERT(  intctors = 1 )
			CU_ASSERT( copyctors = 0 )

			a.i = 456
			a = iif( condfalse, CtorUdt( 123 ), a )
			CU_ASSERT(  intctors = 1 )
			CU_ASSERT( copyctors = 1 )
			CU_ASSERT( a.i = 456 )

			a.i = 0
			a = iif( condtrue, CtorUdt( 123 ), a )
			CU_ASSERT(  intctors = 2 )
			CU_ASSERT( copyctors = 1 )
			CU_ASSERT( a.i = 123 )

			a.i = 0
			a = iif( condfalse, a, CtorUdt( 789 ) )
			CU_ASSERT(  intctors = 3 )
			CU_ASSERT( copyctors = 1 )
			CU_ASSERT( a.i = 789 )

			a.i = 0
			a = iif( condtrue, a, CtorUdt( 789 ) )
			CU_ASSERT(  intctors = 3 )
			CU_ASSERT( copyctors = 2 )
			CU_ASSERT( a.i = 0 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( iifTempVarDefCtorAndIntCtor )
		dim shared as integer defctors, intctors

		type CtorUdt
			i as integer
			declare constructor( )
			declare constructor( as integer )
		end type

		constructor CtorUdt( )
			defctors += 1
		end constructor

		constructor CtorUdt( i as integer )
			intctors += 1
			this.i = i
		end constructor

		'' iif() ctors
		TEST( default )
			CU_ASSERT( defctors = 0 )
			CU_ASSERT( intctors = 0 )

			dim as CtorUdt a, b
			CU_ASSERT( defctors = 2 )
			CU_ASSERT( intctors = 0 )

			a.i = 1
			b.i = 2
			a = iif( condtrue, a, b )
			CU_ASSERT( defctors = 3 )
			CU_ASSERT( intctors = 0 )
			CU_ASSERT( a.i = 1 )

			a.i = 1
			b.i = 2
			a = iif( condfalse, a, b )
			CU_ASSERT( defctors = 4 )
			CU_ASSERT( intctors = 0 )
			CU_ASSERT( a.i = 2 )

			a.i = 1
			a = iif( condtrue, CtorUdt( 123 ), a )
			CU_ASSERT( defctors = 4 )
			CU_ASSERT( intctors = 1 )
			CU_ASSERT( a.i = 123 )

			a.i = 1
			a = iif( condfalse, CtorUdt( 123 ), a )
			CU_ASSERT( defctors = 5 )
			CU_ASSERT( intctors = 1 )
			CU_ASSERT( a.i = 1 )

			a.i = 1
			a = iif( condtrue, a, CtorUdt( 123 ) )
			CU_ASSERT( defctors = 6 )
			CU_ASSERT( intctors = 1 )
			CU_ASSERT( a.i = 1 )

			a.i = 1
			a = iif( condfalse, a, CtorUdt( 123 ) )
			CU_ASSERT( defctors = 6 )
			CU_ASSERT( intctors = 2 )
			CU_ASSERT( a.i = 123 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( iifStringIndexingOrMemberAccess )
		type UDT
			as integer i, j
		end type

		'' member access
		TEST( default )
			'' member access
			dim as UDT xa = ( 1, 2 ), xb = ( 3, 4 )
			CU_ASSERT( iif( condtrue , xa, xb ).i = 1 )
			CU_ASSERT( iif( condtrue , xa, xb ).j = 2 )
			CU_ASSERT( iif( condfalse, xa, xb ).i = 3 )
			CU_ASSERT( iif( condfalse, xa, xb ).j = 4 )

			'' member deref
			dim as UDT ptr pxa = @xa, pxb = @xb
			CU_ASSERT( iif( condtrue , pxa, pxb )->i = 1 )
			CU_ASSERT( iif( condtrue , pxa, pxb )->j = 2 )
			CU_ASSERT( iif( condfalse, pxa, pxb )->i = 3 )
			CU_ASSERT( iif( condfalse, pxa, pxb )->j = 4 )

			'' pointer indexing
			dim as integer iarray1(0 to 1) = { 11, 22 }
			dim as integer iarray2(0 to 1) = { 33, 44 }
			dim as integer ptr pi1 = @iarray1(0), pi2 = @iarray2(0)
			CU_ASSERT( iif( condtrue , pi1, pi2 )[0] = 11 )
			CU_ASSERT( iif( condtrue , pi1, pi2 )[1] = 22 )
			CU_ASSERT( iif( condfalse, pi1, pi2 )[0] = 33 )
			CU_ASSERT( iif( condfalse, pi1, pi2 )[1] = 44 )

			'' string indexing
			dim as string sa = "123", sb = "456"
			CU_ASSERT( iif( condtrue , sa, sb )[0] = asc( "1" ) )
			CU_ASSERT( iif( condtrue , sa, sb )[1] = asc( "2" ) )
			CU_ASSERT( iif( condtrue , sa, sb )[2] = asc( "3" ) )
			CU_ASSERT( iif( condfalse, sa, sb )[0] = asc( "4" ) )
			CU_ASSERT( iif( condfalse, sa, sb )[1] = asc( "5" ) )
			CU_ASSERT( iif( condfalse, sa, sb )[2] = asc( "6" ) )

			'' wstring indexing
			dim as wstring * 32 wa = wstr( "123" ), wb = wstr( "456" )
			CU_ASSERT( iif( condtrue , wa, wb )[0] = wa[0] )
			CU_ASSERT( iif( condtrue , wa, wb )[1] = wa[1] )
			CU_ASSERT( iif( condtrue , wa, wb )[2] = wa[2] )
			CU_ASSERT( iif( condfalse, wa, wb )[0] = wb[0] )
			CU_ASSERT( iif( condfalse, wa, wb )[1] = wb[1] )
			CU_ASSERT( iif( condfalse, wa, wb )[2] = wb[2] )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( iifProcPtrs )
		sub sub1( )
		end sub

		sub sub2( )
		end sub

		function f1( ) as integer
			function = 1
		end function

		function f2( ) as integer
			function = 2
		end function

		'' procptrs
		TEST( default )
			dim as sub( ) psub1, psub2
			CU_ASSERT( iif( condtrue, psub1, psub2 ) = 0 )

			psub1 = @sub1
			psub2 = @sub2
			CU_ASSERT( iif( condtrue , psub1, psub2 ) = @sub1 )
			CU_ASSERT( iif( condfalse, psub1, psub2 ) = @sub2 )
			(iif( condtrue , psub1, psub2 ))( )
			(iif( condfalse, psub1, psub2 ))( )

			dim as function( ) as integer pf1 = @f1, pf2 = @f2
			CU_ASSERT( (iif( condtrue , pf1, pf2 ))( ) = 1 )
			CU_ASSERT( (iif( condfalse, pf1, pf2 ))( ) = 2 )
		END_TEST
	END_TEST_GROUP

	'' string iif vs. rtl error checking
	TEST( iifRtlErrorChecking )
		scope
			dim as string ln
			CU_ASSERT( ln = "" )

			var i = -1

			var f = freefile( )
			open iif( i, "data/123.txt", "data/empty.txt" ) for input as #f
			line input #f, ln
			close #f

			CU_ASSERT( ln = "1234567890" )
		end scope

		scope
			dim as string ln
			CU_ASSERT( ln = "" )

			var a = 1, b = 0
			var ext = ".txt"

			var f = freefile( )
			open "data/" + iif( a, str( a ) + "2", "x" ) + iif( b, "x", "3" + ext ) for input as #f
			line input #f, ln
			close #f

			CU_ASSERT( ln = "1234567890" )
		end scope
	END_TEST

END_SUITE
