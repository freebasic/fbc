#include "fbcunit.bi"

SUITE( fbc_tests.quirk.len_sizeof_udt_member )

	#define STRCONST "hello"

	type U
		x(0 to 15) as byte
	end type

	type T
		sb as byte
		ub as ubyte
		ss as short
		us as ushort
		sl as long
		ul as ulong
		si as integer
		ui as uinteger
		sli as longint
		uli as ulongint
		const zs = STRCONST
		const ws = wstr( STRCONST )
		z as zstring * 10
		w as wstring * 10
		s as string
		p as any ptr
		udt as U
	end type

	TEST( members )

		CU_ASSERT( sizeof( T.sb ) = sizeof( byte ) )
		CU_ASSERT( sizeof( T.ub ) = sizeof( ubyte ) )
		CU_ASSERT( sizeof( T.ss ) = sizeof( short ) )
		CU_ASSERT( sizeof( T.us ) = sizeof( ushort ) )
		CU_ASSERT( sizeof( T.sl ) = sizeof( long ) )
		CU_ASSERT( sizeof( T.ul ) = sizeof( ulong ) )
		CU_ASSERT( sizeof( T.si ) = sizeof( integer ) )
		CU_ASSERT( sizeof( T.ui ) = sizeof( uinteger ) )
		CU_ASSERT( sizeof( T.sli ) = sizeof( longint ) )
		CU_ASSERT( sizeof( T.uli ) = sizeof( ulongint ) )
		CU_ASSERT( sizeof( T.zs ) = sizeof( STRCONST ) )
		CU_ASSERT( sizeof( T.ws ) = sizeof( wstr( STRCONST ) ) )
		CU_ASSERT( sizeof( T.z ) = sizeof( zstring * 10 ) )
		CU_ASSERT( sizeof( T.w ) = sizeof( wstring * 10 ) )
		CU_ASSERT( sizeof( T.s ) = sizeof( string ) )
		CU_ASSERT( sizeof( T.p ) = sizeof( any ptr ) )
		CU_ASSERT( sizeof( T.udt ) = sizeof( U ) )

		CU_ASSERT( len( T.sb ) = len( byte ) )
		CU_ASSERT( len( T.ub ) = len( ubyte ) )
		CU_ASSERT( len( T.ss ) = len( short ) )
		CU_ASSERT( len( T.us ) = len( ushort ) )
		CU_ASSERT( len( T.sl ) = len( long ) )
		CU_ASSERT( len( T.ul ) = len( ulong ) )
		CU_ASSERT( len( T.si ) = len( integer ) )
		CU_ASSERT( len( T.ui ) = len( uinteger ) )
		CU_ASSERT( len( T.sli ) = len( longint ) )
		CU_ASSERT( len( T.uli ) = len( ulongint ) )
		CU_ASSERT( len( T.zs ) = len( STRCONST ) )
		CU_ASSERT( len( T.ws ) = len( wstr( STRCONST ) ) )
		CU_ASSERT( len( T.z ) = len( zstring * 10 ) )
		CU_ASSERT( len( T.w ) = len( wstring * 10 ) )
		CU_ASSERT( len( T.s ) = len( string ) )
		CU_ASSERT( len( T.p ) = len( any ptr ) )
		CU_ASSERT( len( T.udt ) = len( U ) )

	END_TEST

	type T2
		s as string
	end type

	TEST( strings )

		CU_ASSERT( len( T2.s ) = sizeof( string ) )
		CU_ASSERT( sizeof( T2.s ) = sizeof( string ) )

		dim x as T2
		x.s = STRCONST

		CU_ASSERT( len( x.s ) = len( STRCONST ) )
		CU_ASSERT( sizeof( x.s ) = sizeof( string ) )
		CU_ASSERT( len( (x).s ) = len( STRCONST ) )
		CU_ASSERT( sizeof( (x).s ) = sizeof( string ) )

		dim t2 as T2
		t2.s = "hello"

		CU_ASSERT( len( t2.s ) = sizeof( string ) )
		CU_ASSERT( sizeof( t2.s ) = sizeof( string ) )
		CU_ASSERT( len( (t2).s ) = len( STRCONST ) )
		CU_ASSERT( sizeof( (t2).s ) = sizeof( string ) )

	END_TEST

END_SUITE
