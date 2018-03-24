#include "fbcunit.bi"

SUITE( fbc_tests.overload_.pointers )

	type T
		as integer a, b, c, d
	end type

	type Forward as MyUndefinedType

	dim shared pb as byte ptr, ppb as byte ptr ptr
	dim shared pub as ubyte ptr, ppub as ubyte ptr ptr
	dim shared ps as short ptr, pps as short ptr ptr
	dim shared pus as ushort ptr, ppus as ushort ptr ptr
	dim shared i as integer, pi as integer ptr, ppi as integer ptr ptr
	dim shared pui as uinteger ptr, ppui as uinteger ptr ptr
	dim shared pl as long ptr, ppl as long ptr ptr
	dim shared pul as ulong ptr, ppul as ulong ptr ptr
	dim shared pll as longint ptr, ppll as longint ptr ptr
	dim shared pull as ulongint ptr, ppull as ulongint ptr ptr
	dim shared pt as T ptr, ppt as T ptr ptr
	dim shared pany as any ptr, ppany as any ptr ptr
	dim shared pfwd as Forward ptr, ppfwd as Forward ptr ptr

	dim shared pds as string ptr, ppds as string ptr ptr
	dim shared pzs as zstring ptr, ppzs as zstring ptr ptr
	dim shared pws as wstring ptr, ppws as wstring ptr ptr

	#macro proc( T )
		function f overload( byval p as T ) as string
			function = #T
		end function
	#endmacro

	TEST_GROUP( pointerTypes )
		proc( byte ptr )
		proc( byte ptr ptr )
		proc( short ptr )
		proc( short ptr ptr )
		proc( integer ptr )
		proc( integer ptr ptr )
		proc( long ptr )
		proc( long ptr ptr )
		proc( longint ptr )
		proc( longint ptr ptr )
		proc( T ptr )
		proc( T ptr ptr )
		proc( any ptr )
		proc( any ptr ptr )
		proc( Forward ptr )
		proc( Forward ptr ptr )
		proc( string ptr )
		proc( string ptr ptr )
		proc( zstring ptr )
		proc( zstring ptr ptr )
		proc( wstring ptr )
		proc( wstring ptr ptr )

		TEST( default )
			CU_ASSERT( f( pb ) = "byte ptr" )
			CU_ASSERT( f( ps ) = "short ptr" )
			CU_ASSERT( f( pi ) = "integer ptr" )
			CU_ASSERT( f( pl ) = "long ptr" )
			CU_ASSERT( f( pll ) = "longint ptr" )
			CU_ASSERT( f( pt ) = "T ptr" )
			CU_ASSERT( f( pany ) = "any ptr" )
			CU_ASSERT( f( pfwd ) = "Forward ptr" )
			CU_ASSERT( f( pds ) = "string ptr" )
			CU_ASSERT( f( pzs ) = "zstring ptr" )
			CU_ASSERT( f( pws ) = "wstring ptr" )

			CU_ASSERT( f( ppb ) = "byte ptr ptr" )
			CU_ASSERT( f( pps ) = "short ptr ptr" )
			CU_ASSERT( f( ppi ) = "integer ptr ptr" )
			CU_ASSERT( f( ppl ) = "long ptr ptr" )
			CU_ASSERT( f( ppll ) = "longint ptr ptr" )
			CU_ASSERT( f( ppt ) = "T ptr ptr" )
			CU_ASSERT( f( ppany ) = "any ptr ptr" )
			CU_ASSERT( f( ppfwd ) = "Forward ptr ptr" )
			CU_ASSERT( f( ppds ) = "string ptr ptr" )
			CU_ASSERT( f( ppzs ) = "zstring ptr ptr" )
			CU_ASSERT( f( ppws ) = "wstring ptr ptr" )

			CU_ASSERT( f( @ppb ) = "any ptr" )
			CU_ASSERT( f( @pps ) = "any ptr" )
			CU_ASSERT( f( @ppi ) = "any ptr" )
			CU_ASSERT( f( @ppt ) = "any ptr" )
			CU_ASSERT( f( @ppany ) = "any ptr" )
			CU_ASSERT( f( @ppfwd ) = "any ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( anyptrParam1 )
		'' Any Ptr params accept all pointers
		proc( any ptr )

		TEST( default )
			CU_ASSERT( f( pb ) = "any ptr" )
			CU_ASSERT( f( ps ) = "any ptr" )
			CU_ASSERT( f( pi ) = "any ptr" )
			CU_ASSERT( f( pl ) = "any ptr" )
			CU_ASSERT( f( pll ) = "any ptr" )
			CU_ASSERT( f( pt ) = "any ptr" )
			CU_ASSERT( f( pany ) = "any ptr" )
			CU_ASSERT( f( pfwd ) = "any ptr" )
			CU_ASSERT( f( pds ) = "any ptr" )
			CU_ASSERT( f( pzs ) = "any ptr" )
			CU_ASSERT( f( pws ) = "any ptr" )

			CU_ASSERT( f( ppb ) = "any ptr" )
			CU_ASSERT( f( pps ) = "any ptr" )
			CU_ASSERT( f( ppi ) = "any ptr" )
			CU_ASSERT( f( ppl ) = "any ptr" )
			CU_ASSERT( f( ppll ) = "any ptr" )
			CU_ASSERT( f( ppt ) = "any ptr" )
			CU_ASSERT( f( ppany ) = "any ptr" )
			CU_ASSERT( f( ppfwd ) = "any ptr" )
			CU_ASSERT( f( ppds ) = "any ptr" )
			CU_ASSERT( f( ppzs ) = "any ptr" )
			CU_ASSERT( f( ppws ) = "any ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( anyptrParam2 )
		proc( integer ptr )
		proc( any ptr )

		TEST( default )
			CU_ASSERT( f( pb ) = "any ptr" )
			CU_ASSERT( f( ps ) = "any ptr" )
			CU_ASSERT( f( pi ) = "integer ptr" ) '' Full match - not ambigious
			CU_ASSERT( f( pl ) = "any ptr" )
			CU_ASSERT( f( pll ) = "any ptr" )
			CU_ASSERT( f( pt ) = "any ptr" )
			CU_ASSERT( f( pany ) = "any ptr" ) '' Full match - not ambigious
			CU_ASSERT( f( pfwd ) = "any ptr" )
			CU_ASSERT( f( pds ) = "any ptr" )
			CU_ASSERT( f( pzs ) = "any ptr" )
			CU_ASSERT( f( pws ) = "any ptr" )

			CU_ASSERT( f( ppb ) = "any ptr" )
			CU_ASSERT( f( pps ) = "any ptr" )
			CU_ASSERT( f( ppi ) = "any ptr" )
			CU_ASSERT( f( ppl ) = "any ptr" )
			CU_ASSERT( f( ppll ) = "any ptr" )
			CU_ASSERT( f( ppt ) = "any ptr" )
			CU_ASSERT( f( ppany ) = "any ptr" )
			CU_ASSERT( f( ppfwd ) = "any ptr" )
			CU_ASSERT( f( ppds ) = "any ptr" )
			CU_ASSERT( f( ppzs ) = "any ptr" )
			CU_ASSERT( f( ppws ) = "any ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( anyptrParam3 )
		proc( byte ptr )
		proc( short ptr )
		proc( integer ptr )
		proc( any ptr )

		TEST( default )
			CU_ASSERT( f( pb ) = "byte ptr" )
			CU_ASSERT( f( ps ) = "short ptr" )
			CU_ASSERT( f( pi ) = "integer ptr" )
			CU_ASSERT( f( pl ) = "any ptr" )
			CU_ASSERT( f( pll ) = "any ptr" )
			CU_ASSERT( f( pt ) = "any ptr" )
			CU_ASSERT( f( pany ) = "any ptr" )
			CU_ASSERT( f( pfwd ) = "any ptr" )
			CU_ASSERT( f( pds ) = "any ptr" )
			CU_ASSERT( f( pzs ) = "any ptr" )
			CU_ASSERT( f( pws ) = "any ptr" )

			'' With higher indirection level, these should all match the
			'' Any Ptr, since there are no full matches
			CU_ASSERT( f( ppb ) = "any ptr" )
			CU_ASSERT( f( pps ) = "any ptr" )
			CU_ASSERT( f( ppi ) = "any ptr" )
			CU_ASSERT( f( ppl ) = "any ptr" )
			CU_ASSERT( f( ppll ) = "any ptr" )
			CU_ASSERT( f( ppt ) = "any ptr" )
			CU_ASSERT( f( ppany ) = "any ptr" )
			CU_ASSERT( f( ppfwd ) = "any ptr" )
			CU_ASSERT( f( ppds ) = "any ptr" )
			CU_ASSERT( f( ppzs ) = "any ptr" )
			CU_ASSERT( f( ppws ) = "any ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( anyptrArg1 )
		'' Any Ptr args match all pointer params (unlike C++)
		proc( integer )
		proc( integer ptr )

		TEST( default )
			CU_ASSERT( f( i ) = "integer" )
			CU_ASSERT( f( pi ) = "integer ptr" )
			CU_ASSERT( f( pany ) = "integer ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( anyptrArg2 )
		proc( integer )
		proc( T ptr )

		TEST( default )
			CU_ASSERT( f( i ) = "integer" )
			CU_ASSERT( f( pt ) = "T ptr" )
			CU_ASSERT( f( pany ) = "T ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( anyptrArg3 )
		proc( integer )
		proc( T ptr ptr )

		TEST( default )
			CU_ASSERT( f( i ) = "integer" )
			CU_ASSERT( f( ppt ) = "T ptr ptr" )
			CU_ASSERT( f( pany ) = "T ptr ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( anyptrArgRegressionTest1 )
		'' Regression test (Any Ptr args were treated as Uintegers)
		proc( uinteger )
		proc( integer ptr )

		TEST( default )
			CU_ASSERT( f( i ) = "uinteger" )
			CU_ASSERT( f( pi ) = "integer ptr" )
			CU_ASSERT( f( pany ) = "integer ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( anyptrArgRegressionTest2 )
		proc( uinteger )
		proc( any ptr )

		TEST( default )
			CU_ASSERT( f( i ) = "uinteger" )
			CU_ASSERT( f( pi ) = "any ptr" )
			CU_ASSERT( f( pany ) = "any ptr" )
			CU_ASSERT( f( pt ) = "any ptr" )
		END_TEST
	END_TEST_GROUP
	
	TEST_GROUP( integerPointers.long_ulong )
		proc( long ptr )
		proc( ulong ptr )

		TEST( default )
			CU_ASSERT( f( pl ) = "long ptr" )
			CU_ASSERT( f( pul ) = "ulong ptr" )
			#ifndef __FB_64BIT__
				CU_ASSERT( f( pi ) = "long ptr" )
				CU_ASSERT( f( pui ) = "ulong ptr" )
			#endif
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.long_longint )
		proc( long ptr )
		proc( longint ptr )

		TEST( default )
			CU_ASSERT( f( pl ) = "long ptr" )
			CU_ASSERT( f( pul ) = "long ptr" )
			CU_ASSERT( f( pll ) = "longint ptr" )
			CU_ASSERT( f( pull ) = "longint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "longint ptr" )
				CU_ASSERT( f( pui ) = "longint ptr" )
			#else
				CU_ASSERT( f( pi ) = "long ptr" )
				CU_ASSERT( f( pui ) = "long ptr" )
			#endif
		END_TEST
	END_TEST_GROUP
	
	TEST_GROUP( integerPointers.long_ulongint )
		proc( long ptr )
		proc( ulongint ptr )

		TEST( default )
			CU_ASSERT( f( pl ) = "long ptr" )
			CU_ASSERT( f( pul ) = "long ptr" )
			CU_ASSERT( f( pll ) = "ulongint ptr" )
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "ulongint ptr" )
				CU_ASSERT( f( pui ) = "ulongint ptr" )
			#else
				CU_ASSERT( f( pi ) = "long ptr" )
				CU_ASSERT( f( pui ) = "long ptr" )
			#endif
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.long_integer )
		proc( long ptr )
		proc( integer ptr )

		TEST( default )
			CU_ASSERT( f( pl ) = "long ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pul ) = "long ptr" )
				CU_ASSERT( f( pll ) = "integer ptr" )
				CU_ASSERT( f( pull ) = "integer ptr" )
			#else
				CU_ASSERT( f( pul ) = "long ptr" )
			#endif
			CU_ASSERT( f( pi ) = "integer ptr" )
			CU_ASSERT( f( pui ) = "integer ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.long_uinteger )
		proc( long ptr )
		proc( uinteger ptr )

		TEST( default )
			CU_ASSERT( f( pl ) = "long ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pul ) = "long ptr" )
				CU_ASSERT( f( pll ) = "uinteger ptr" )
				CU_ASSERT( f( pull ) = "uinteger ptr" )
				CU_ASSERT( f( pi ) = "uinteger ptr" )
			#else
				CU_ASSERT( f( pul ) = "uinteger ptr" )
				CU_ASSERT( f( pi ) = "long ptr" )
			#endif
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.ulong_long )
		proc( ulong ptr )
		proc( long ptr )

		TEST( default )
			CU_ASSERT( f( pl ) = "long ptr" )
			CU_ASSERT( f( pul ) = "ulong ptr" )
			#ifndef __FB_64BIT__
				CU_ASSERT( f( pi ) = "long ptr" )
				CU_ASSERT( f( pui ) = "ulong ptr" )
			#endif
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.ulong_longint )
		proc( ulong ptr )
		proc( longint ptr )

		TEST( default )
			CU_ASSERT( f( pl ) = "ulong ptr" )
			CU_ASSERT( f( pul ) = "ulong ptr" )
			CU_ASSERT( f( pll ) = "longint ptr" )
			CU_ASSERT( f( pull ) = "longint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "longint ptr" )
				CU_ASSERT( f( pui ) = "longint ptr" )
			#else
				CU_ASSERT( f( pi ) = "ulong ptr" )
				CU_ASSERT( f( pui ) = "ulong ptr" )
			#endif
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.ulong_ulongint )
		proc( ulong ptr )
		proc( ulongint ptr )

		TEST( default )
			CU_ASSERT( f( pl ) = "ulong ptr" )
			CU_ASSERT( f( pul ) = "ulong ptr" )
			CU_ASSERT( f( pll ) = "ulongint ptr" )
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "ulongint ptr" )
				CU_ASSERT( f( pui ) = "ulongint ptr" )
			#else
				CU_ASSERT( f( pi ) = "ulong ptr" )
				CU_ASSERT( f( pui ) = "ulong ptr" )
			#endif
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.ulong_integer )
		proc( ulong ptr )
		proc( integer ptr )

		TEST( default )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pl ) = "ulong ptr" )
			#else
				CU_ASSERT( f( pl ) = "integer ptr" )
			#endif
			CU_ASSERT( f( pul ) = "ulong ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pll ) = "integer ptr" )
				CU_ASSERT( f( pull ) = "integer ptr" )
			#endif
			CU_ASSERT( f( pi ) = "integer ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pui ) = "integer ptr" )
			#else
				CU_ASSERT( f( pui ) = "ulong ptr" )
			#endif
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.ulong_uinteger )
		proc( ulong ptr )
		proc( uinteger ptr )

		TEST( default )
			CU_ASSERT( f( pl ) = "ulong ptr" )
			CU_ASSERT( f( pul ) = "ulong ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pll ) = "uinteger ptr" )
				CU_ASSERT( f( pull ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pi ) = "uinteger ptr" )
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.longint_long )
		proc( longint ptr )
		proc( long ptr )

		TEST( default )
			CU_ASSERT( f( pl ) = "long ptr" )
			CU_ASSERT( f( pul ) = "long ptr" )
			CU_ASSERT( f( pll ) = "longint ptr" )
			CU_ASSERT( f( pull ) = "longint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "longint ptr" )
				CU_ASSERT( f( pui ) = "longint ptr" )
			#else
				CU_ASSERT( f( pi ) = "long ptr" )
				CU_ASSERT( f( pui ) = "long ptr" )
			#endif
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.longint_ulong )
		proc( longint ptr )
		proc( ulong ptr )

		TEST( default )
			CU_ASSERT( f( pl ) = "ulong ptr" )
			CU_ASSERT( f( pul ) = "ulong ptr" )
			CU_ASSERT( f( pll ) = "longint ptr" )
			CU_ASSERT( f( pull ) = "longint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "longint ptr" )
				CU_ASSERT( f( pui ) = "longint ptr" )
			#else
				CU_ASSERT( f( pi ) = "ulong ptr" )
				CU_ASSERT( f( pui ) = "ulong ptr" )
			#endif
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.longint_ulongint )
		proc( longint ptr )
		proc( ulongint ptr )

		TEST( default )
			CU_ASSERT( f( pll ) = "longint ptr" )
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "longint ptr" )
				CU_ASSERT( f( pui ) = "ulongint ptr" )
			#endif
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.longint_integer )
		proc( longint ptr )
		proc( integer ptr )

		TEST( default )
			#ifndef __FB_64BIT__
				CU_ASSERT( f( pl ) = "integer ptr" )
				CU_ASSERT( f( pul ) = "integer ptr" )
			#endif
			CU_ASSERT( f( pll ) = "longint ptr" )
			CU_ASSERT( f( pull ) = "longint ptr" )
			CU_ASSERT( f( pi ) = "integer ptr" )
			CU_ASSERT( f( pui ) = "integer ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.longint_uinteger )
		proc( longint ptr )
		proc( uinteger ptr )

		TEST( default )
			#ifndef __FB_64BIT__
				CU_ASSERT( f( pl ) = "uinteger ptr" )
				CU_ASSERT( f( pul ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pll ) = "longint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pull ) = "uinteger ptr" )
				CU_ASSERT( f( pi ) = "longint ptr" )
			#else
				CU_ASSERT( f( pull ) = "longint ptr" )
				CU_ASSERT( f( pi ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.ulongint_long )
		proc( ulongint ptr )
		proc( long ptr )

		TEST( default )
			CU_ASSERT( f( pl ) = "long ptr" )
			CU_ASSERT( f( pul ) = "long ptr" )
			CU_ASSERT( f( pll ) = "ulongint ptr" )
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "ulongint ptr" )
				CU_ASSERT( f( pui ) = "ulongint ptr" )
			#else
				CU_ASSERT( f( pi ) = "long ptr" )
				CU_ASSERT( f( pui ) = "long ptr" )
			#endif
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.ulongint_ulong )
		proc( ulongint ptr )
		proc( ulong ptr )

		TEST( default )
			CU_ASSERT( f( pl ) = "ulong ptr" )
			CU_ASSERT( f( pul ) = "ulong ptr" )
			CU_ASSERT( f( pll ) = "ulongint ptr" )
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "ulongint ptr" )
				CU_ASSERT( f( pui ) = "ulongint ptr" )
			#else
				CU_ASSERT( f( pi ) = "ulong ptr" )
				CU_ASSERT( f( pui ) = "ulong ptr" )
			#endif
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.ulongint_longint )
		proc( ulongint ptr )
		proc( longint ptr )

		TEST( default )
			CU_ASSERT( f( pll ) = "longint ptr" )
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "longint ptr" )
				CU_ASSERT( f( pui ) = "ulongint ptr" )
			#endif
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.ulongint_integer )
		proc( ulongint ptr )
		proc( integer ptr )

		TEST( default )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pll ) = "integer ptr" )
			#else
				CU_ASSERT( f( pl ) = "integer ptr" )
				CU_ASSERT( f( pul ) = "integer ptr" )
				CU_ASSERT( f( pll ) = "ulongint ptr" )
			#endif
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			CU_ASSERT( f( pi ) = "integer ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pui ) = "ulongint ptr" )
			#else
				CU_ASSERT( f( pui ) = "integer ptr" )
			#endif
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.ulongint_uinteger )
		proc( ulongint ptr )
		proc( uinteger ptr )

		TEST( default )
			#ifndef __FB_64BIT__
				CU_ASSERT( f( pl ) = "uinteger ptr" )
				CU_ASSERT( f( pul ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pll ) = "ulongint ptr" )
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			CU_ASSERT( f( pi ) = "uinteger ptr" )
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.integer_long )
		proc( integer ptr )
		proc( long ptr )

		TEST( default )
			CU_ASSERT( f( pl ) = "long ptr" )
			CU_ASSERT( f( pul ) = "long ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pll ) = "integer ptr" )
				CU_ASSERT( f( pull ) = "integer ptr" )
			#endif
			CU_ASSERT( f( pi ) = "integer ptr" )
			CU_ASSERT( f( pui ) = "integer ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.integer_ulong )
		proc( integer ptr )
		proc( ulong ptr )

		TEST( default )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pl ) = "ulong ptr" )
			#else
				CU_ASSERT( f( pl ) = "integer ptr" )
			#endif
			CU_ASSERT( f( pul ) = "ulong ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pll ) = "integer ptr" )
				CU_ASSERT( f( pull ) = "integer ptr" )
			#endif
			CU_ASSERT( f( pi ) = "integer ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pui ) = "integer ptr" )
			#else
				CU_ASSERT( f( pui ) = "ulong ptr" )
			#endif
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.integer_longint )
		proc( integer ptr )
		proc( longint ptr )

		TEST( default )
			#ifndef __FB_64BIT__
				CU_ASSERT( f( pl ) = "integer ptr" )
				CU_ASSERT( f( pul ) = "integer ptr" )
			#endif
			CU_ASSERT( f( pll ) = "longint ptr" )
			CU_ASSERT( f( pull ) = "longint ptr" )
			CU_ASSERT( f( pi ) = "integer ptr" )
			CU_ASSERT( f( pui ) = "integer ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.integer_ulongint )
		proc( integer ptr )
		proc( ulongint ptr )

		TEST( default )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pll ) = "integer ptr" )
			#else
				CU_ASSERT( f( pl ) = "integer ptr" )
				CU_ASSERT( f( pul ) = "integer ptr" )
				CU_ASSERT( f( pll ) = "ulongint ptr" )
			#endif
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			CU_ASSERT( f( pi ) = "integer ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pui ) = "ulongint ptr" )
			#else
				CU_ASSERT( f( pui ) = "integer ptr" )
			#endif
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.integer_uinteger )
		proc( integer ptr )
		proc( uinteger ptr )

		TEST( default )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pll ) = "integer ptr" )
				CU_ASSERT( f( pull ) = "uinteger ptr" )
			#else
				CU_ASSERT( f( pl ) = "integer ptr" )
				CU_ASSERT( f( pul ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pi ) = "integer ptr" )
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.uinteger_long )
		proc( uinteger ptr )
		proc( long ptr )

		TEST( default )
			CU_ASSERT( f( pl ) = "long ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pul ) = "long ptr" )
				CU_ASSERT( f( pll ) = "uinteger ptr" )
				CU_ASSERT( f( pull ) = "uinteger ptr" )
				CU_ASSERT( f( pi ) = "uinteger ptr" )
			#else
				CU_ASSERT( f( pul ) = "uinteger ptr" )
				CU_ASSERT( f( pi ) = "long ptr" )
			#endif
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.uinteger_ulong )
		proc( uinteger ptr )
		proc( ulong ptr )

		TEST( default )
			CU_ASSERT( f( pl ) = "ulong ptr" )
			CU_ASSERT( f( pul ) = "ulong ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pll ) = "uinteger ptr" )
				CU_ASSERT( f( pull ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pi ) = "uinteger ptr" )
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.uinteger_longint )
		proc( uinteger ptr )
		proc( longint ptr )

		TEST( default )
			#ifndef __FB_64BIT__
				CU_ASSERT( f( pl ) = "uinteger ptr" )
				CU_ASSERT( f( pul ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pll ) = "longint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pull ) = "uinteger ptr" )
				CU_ASSERT( f( pi ) = "longint ptr" )
			#else
				CU_ASSERT( f( pull ) = "longint ptr" )
				CU_ASSERT( f( pi ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.uinteger_ulongint )
		proc( uinteger ptr )
		proc( ulongint ptr )

		TEST( default )
			#ifndef __FB_64BIT__
				CU_ASSERT( f( pl ) = "uinteger ptr" )
				CU_ASSERT( f( pul ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pll ) = "ulongint ptr" )
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			CU_ASSERT( f( pi ) = "uinteger ptr" )
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integerPointers.uinteger_integer )
		proc( uinteger ptr )
		proc( integer ptr )

		TEST( default )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pll ) = "integer ptr" )
				CU_ASSERT( f( pull ) = "uinteger ptr" )
			#else
				CU_ASSERT( f( pl ) = "integer ptr" )
				CU_ASSERT( f( pul ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pi ) = "integer ptr" )
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		END_TEST
	END_TEST_GROUP
	
	TEST_GROUP( const0 )
		'' It's possible to pass constant zero to pointer parameters

		sub a overload( byval p as any ptr ) :            : end sub
		sub a overload( byref s as string  ) : CU_FAIL( ) : end sub

		#macro makeFunction1( suffix, inttype )
			function f1_##suffix overload( byval p as any ptr ) as string : function = "any ptr" : end function
			function f1_##suffix overload( byval i as inttype ) as string : function = #inttype  : end function
		#endmacro

		makeFunction1( b, byte )
		makeFunction1( ub, ubyte )
		makeFunction1( sh, short )
		makeFunction1( ush, ushort )
		makeFunction1( l, long )
		makeFunction1( ul, ulong )
		makeFunction1( ll, longint )
		makeFunction1( ull, ulongint )
		makeFunction1( i, integer )
		makeFunction1( ui, uinteger )

		TEST( const_ )
			a( 0l )
			a( 0ul )
			a( 0ll )
			a( 0ull )
			a( 0 )
			a( 0u )
			a( cbyte( 0 ) )
			a( cubyte( 0 ) )
			a( cshort( 0 ) )
			a( cushort( 0 ) )
			a( clng( 0 ) )
			a( culng( 0 ) )
			a( clngint( 0 ) )
			a( culngint( 0 ) )
			a( cint( 0 ) )
			a( cuint( 0 ) )
			a( cptr( any ptr, 0 ) )

			#macro makeTest1( suffix, result )
				CU_ASSERT( f1_##suffix( cptr( any ptr, 0 ) ) = "any ptr" )
				CU_ASSERT( f1_##suffix( cbyte  ( 0 ) ) = #result )
				CU_ASSERT( f1_##suffix( cubyte ( 0 ) ) = #result )
				CU_ASSERT( f1_##suffix( cshort ( 0 ) ) = #result )
				CU_ASSERT( f1_##suffix( cushort( 0 ) ) = #result )
				CU_ASSERT( f1_##suffix( 0l   ) = #result )
				CU_ASSERT( f1_##suffix( 0ul  ) = #result )
				CU_ASSERT( f1_##suffix( 0ll  ) = #result )
				CU_ASSERT( f1_##suffix( 0ull ) = #result )
				CU_ASSERT( f1_##suffix( 0    ) = #result )
				CU_ASSERT( f1_##suffix( 0u   ) = #result )
			#endmacro

			makeTest1( b, byte )
			makeTest1( ub, ubyte )
			makeTest1( sh, short )
			makeTest1( ush, ushort )
			makeTest1( l, long )
			makeTest1( ul, ulong )
			makeTest1( ll, longint )
			makeTest1( ull, ulongint )
			makeTest1( i, integer )
			makeTest1( ui, uinteger )
		END_TEST
	END_TEST_GROUP

END_SUITE
