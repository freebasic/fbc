#include "fbcunit.bi"

SUITE( fbc_tests.quirk.typeof_ )

	type UDT1
		x as integer
		y as integer
	end type

	operator +( l as UDT1, r as UDT1 ) as UDT1
		return type<UDT1>( 69, 69 )
	end operator

	function ret_int() as integer
		return 69
	end function

	type UDT2
		__ as string
		declare property something() as string
		declare property something(s as string)
	end type
	property UDT2.something(s as string)
		__ = s
	end property
	property UDT2.something() as string
		return __
	end property

	type UDT3
		__ as UDT2
	end type

	type SmallUDT
		a as integer
	end type

	type BigUDT
		as integer a, b, c, d, e, f, g, h, i, j
	end type

	type UDT4
		a as integer
		b as byte
		c as string
	end type

	type UDT5 field = 1
		i as integer
		b as byte
	end type

	function fb( ) as byte
		function = 5
	end function

	function fi( ) as integer
		function = 5
	end function

	function fll( ) as longint
		function = 5
	end function

	function fsmall( ) as SmallUDT
		function = type( 1 )
	end function

	function fbig( ) as BigUDT
		function = type( 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 )
	end function

	#macro checkVar( T )
		scope
			dim x as T
			dim y as typeof( x )
			CU_ASSERT( sizeof( x ) = sizeof( y ) )
			CU_ASSERT( sizeof( x ) = sizeof( T ) )
			CU_ASSERT( sizeof( y ) = sizeof( T ) )
		end scope
	#endmacro

	#macro checkExpr( T, expr )
		scope
			dim mytestvar as typeof( expr )
			CU_ASSERT( sizeof( mytestvar ) = sizeof( expr ) )
			CU_ASSERT( sizeof( mytestvar ) = sizeof( T ) )
			CU_ASSERT( sizeof( expr ) = sizeof( T ) )
		end scope
	#endmacro

	sub hCheckByrefParams _
		( _
			byref b as byte, _
			byref i as integer, _
			byref pi as integer ptr, _
			byref s as string _
		)

		checkExpr( byte, b )
		checkExpr( integer, i )
		checkExpr( integer ptr, pi )
		checkExpr( integer, *pi )
		checkExpr( string, s )

	end sub

	TEST( all )
		scope
			dim as UDT3 thingy
			dim as string bar(2)
			dim as const integer ptr ptr const ptr const ptr cp = 0
			dim as typeof(cp) dp = 0

			dim as string * 10 s10

			#assert typeof(cp) = typeof(dp)
			#assert typeof(bar(0)) = "STRING"
			#assert typeof(bar) = "STRING"
			#assert typeof(thingy.__) = "TESTS.FBC_TESTS.QUIRK.TYPEOF_.UDT2"
			#assert typeof(thingy.__.__) = "STRING"
			#assert typeof(thingy.__.something) = "STRING"
			#assert typeof(ret_int()) = "INTEGER"
			#assert typeof(s10) = typeof(string * 10)
		end scope

		scope
			dim as integer x
			dim as double y
			#assert typeof( x + y ) = "DOUBLE"
			dim as UDT1 f, g
			#assert typeof( f + g ) = "TESTS.FBC_TESTS.QUIRK.TYPEOF_.UDT1"
		end scope

		checkVar( byte )
		checkVar( ubyte )
		checkVar( short )
		checkVar( ushort )
		checkVar( integer )
		checkVar( uinteger )
		checkVar( long )
		checkVar( ulong )
		checkVar( longint )
		checkVar( ulongint )
		checkVar( single )
		checkVar( double )
		checkVar( any ptr )
		checkVar( integer ptr )
		checkVar( UDT1 ptr )
		checkVar( string ptr )
		checkVar( UDT1 )
		checkVar( UDT4 )
		checkVar( UDT5 )
		checkVar( string )
		checkVar( string * 11 )
		checkVar( zstring * 22 )
		checkVar( wstring * 33 )
		checkVar( sub( ) )
		checkVar( function( ) as byte )

		checkExpr(        byte, cbyte( 0 )   )
		checkExpr(       ubyte, cubyte( 0 )  )
		checkExpr(       short, cshort( 0 )  )
		checkExpr(      ushort, cushort( 0 ) )
		checkExpr(     integer, 0            )
		checkExpr(    uinteger, 0u           )
		checkExpr(        long, 0l           )
		checkExpr(       ulong, 0ul          )
		checkExpr(     longint, 0ll          )
		checkExpr(    ulongint, 0ull         )
		checkExpr(      single, 0.0f         )
		checkExpr(      double, 0.0          )
		checkExpr(     any ptr, cptr(     any ptr, 0 ) )
		checkExpr( integer ptr, cptr( integer ptr, 0 ) )
		checkExpr(        UDT1, type<UDT1>( 1, 2 )     )
		checkExpr(        UDT5, type<UDT5>( 1, 2 )     )
		checkExpr( zstring * 5,       "test"   )
		checkExpr( wstring * 5, wstr( "test" ) )
		checkExpr(        byte, fb( )        )
		checkExpr(     integer, fi( )        )
		checkExpr(     longint, fll( )       )
		checkExpr(    SmallUDT, fsmall( )    )
		checkExpr(      BigUDT, fbig( )      )

		scope
			dim i as integer
			checkExpr( integer ptr, @i )

			dim pi as integer ptr
			checkExpr( integer, *pi )

			dim ppi as integer ptr ptr
			checkExpr( integer, **ppi )

			dim px1 as UDT1 ptr
			checkExpr( UDT1, *px1 )

			dim ps as string ptr
			checkExpr( string, *ps )

			dim cond as integer
			checkExpr( string, iif( cond, "abc", "123456" ) )

			checkExpr( integer, typeof( integer ) )
			checkExpr( string, typeof( string ) )
			checkExpr( UDT1, typeof( UDT1 ) )

			dim s as string
			dim x1 as UDT1
			checkExpr( integer, typeof( i ) )
			checkExpr( string, typeof( s ) )
			checkExpr( UDT1, typeof( x1 ) )

			dim array1() as short
			dim array2(0 to 1) as short
			checkExpr( short, array1(0) )
			checkExpr( short, array1(i) )
			checkExpr( short, array2(0) )
			checkExpr( short, array2(i) )

			'' NIDXARRAY
			scope
				dim x1 as typeof( array1 )
				dim x2 as typeof( array2 )
				CU_ASSERT( sizeof( x1 ) = sizeof( short ) )
				CU_ASSERT( sizeof( x2 ) = sizeof( short ) )
			end scope

			dim z1 as zstring * 1
			dim w1 as wstring * 1
			checkExpr( zstring, z1 )
			checkExpr( wstring, w1 )

			dim pz as zstring ptr
			dim pw as wstring ptr
			checkExpr( zstring, *pz )
			checkExpr( wstring, *pw )

			dim pfb  as function( ) as byte
			dim pfi  as function( ) as integer
			dim pfll as function( ) as longint
			checkExpr(    byte, pfb( ) )
			checkExpr( integer, pfi( ) )
			checkExpr( longint, pfll( ) )

			checkExpr( sub(), sub() )
			checkExpr( function() as byte, function() as byte )
		end scope

		scope
			dim b as byte
			dim i as integer
			dim pi as integer ptr
			dim s as string
			hCheckByrefParams( b, i, pi, s )
		end scope
	END_TEST

	'' sizeof(typeof(deref))
	TEST( sizeofTypeofDeref )
		'' This was the example given in the bug report
		dim p as string ptr
		CU_ASSERT_EQUAL( sizeof( typeof( *p ) ), sizeof( string ) )

		#macro check( T )
			CU_ASSERT( sizeof( typeof( *cptr( T ptr, 123 ) ) ) = sizeof( T ) )
		#endmacro

		check( integer )
		check( byte )
		check( string )
		check( UDT4 )
	END_TEST

	'' sizeof(typeof(...))
	TEST( sizeofTypeofOthers )
		'' Before the fix any op expression would cause typeof() to return a
		'' zero length

		CU_ASSERT( sizeof( typeof( cptr( UDT4 ptr, 123 )->a ) ) = sizeof( integer ) )
		CU_ASSERT( sizeof( typeof( cptr( UDT4 ptr, 123 )->b ) ) = sizeof( byte    ) )
		CU_ASSERT( sizeof( typeof( cptr( UDT4 ptr, 123 )->c ) ) = sizeof( string  ) )

		dim as integer a
		CU_ASSERT( sizeof( typeof( a + 5   ) ) = sizeof( integer ) )
		CU_ASSERT( sizeof( typeof( a and 5 ) ) = sizeof( integer ) )

		dim as integer ptr p
		CU_ASSERT( sizeof( typeof( p[1] ) ) = sizeof( integer ) )
	END_TEST

	dim shared as integer mysubcalls

	private sub mySub( )
		mysubcalls += 1
	end sub

	private function myFunc( ) as integer
		function = 123
	end function

	'' typeof( sub|function(...) )
	TEST( typeofProcPtr )
		dim pSub as typeof( sub( ) )
		pSub = @mySub
		CU_ASSERT( mysubcalls = 0 )
		pSub( )
		CU_ASSERT( mysubcalls = 1 )

		dim ppSub as typeof( sub( ) ) ptr
		ppSub = @pSub
		CU_ASSERT( mysubcalls = 1 )
		(*ppSub)( )
		CU_ASSERT( mysubcalls = 2 )

		dim pFunc as typeof( function( ) as integer )
		pFunc = @myFunc
		CU_ASSERT( pFunc( ) = 123 )

		dim ppFunc as typeof( function( ) as integer ) ptr
		ppFunc = @pFunc
		CU_ASSERT( (*ppFunc)( ) = 123 )
	END_TEST

END_SUITE
