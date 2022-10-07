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

	type T3
		m1 as T
		m2 as T2
	end type

	TEST( members_of_member )

		CU_ASSERT( sizeof( T3.m1.sb ) = sizeof( byte ) )
		CU_ASSERT( sizeof( T3.m1.ub ) = sizeof( ubyte ) )
		CU_ASSERT( sizeof( T3.m1.ss ) = sizeof( short ) )
		CU_ASSERT( sizeof( T3.m1.us ) = sizeof( ushort ) )
		CU_ASSERT( sizeof( T3.m1.sl ) = sizeof( long ) )
		CU_ASSERT( sizeof( T3.m1.ul ) = sizeof( ulong ) )
		CU_ASSERT( sizeof( T3.m1.si ) = sizeof( integer ) )
		CU_ASSERT( sizeof( T3.m1.ui ) = sizeof( uinteger ) )
		CU_ASSERT( sizeof( T3.m1.sli ) = sizeof( longint ) )
		CU_ASSERT( sizeof( T3.m1.uli ) = sizeof( ulongint ) )
		CU_ASSERT( sizeof( T3.m1.zs ) = sizeof( STRCONST ) )
		CU_ASSERT( sizeof( T3.m1.ws ) = sizeof( wstr( STRCONST ) ) )
		CU_ASSERT( sizeof( T3.m1.z ) = sizeof( zstring * 10 ) )
		CU_ASSERT( sizeof( T3.m1.w ) = sizeof( wstring * 10 ) )
		CU_ASSERT( sizeof( T3.m1.s ) = sizeof( string ) )
		CU_ASSERT( sizeof( T3.m1.p ) = sizeof( any ptr ) )
		CU_ASSERT( sizeof( T3.m1.udt ) = sizeof( U ) )

		CU_ASSERT( len( T3.m1.sb ) = len( byte ) )
		CU_ASSERT( len( T3.m1.ub ) = len( ubyte ) )
		CU_ASSERT( len( T3.m1.ss ) = len( short ) )
		CU_ASSERT( len( T3.m1.us ) = len( ushort ) )
		CU_ASSERT( len( T3.m1.sl ) = len( long ) )
		CU_ASSERT( len( T3.m1.ul ) = len( ulong ) )
		CU_ASSERT( len( T3.m1.si ) = len( integer ) )
		CU_ASSERT( len( T3.m1.ui ) = len( uinteger ) )
		CU_ASSERT( len( T3.m1.sli ) = len( longint ) )
		CU_ASSERT( len( T3.m1.uli ) = len( ulongint ) )
		CU_ASSERT( len( T3.m1.zs ) = len( STRCONST ) )
		CU_ASSERT( len( T3.m1.ws ) = len( wstr( STRCONST ) ) )
		CU_ASSERT( len( T3.m1.z ) = len( zstring * 10 ) )
		CU_ASSERT( len( T3.m1.w ) = len( wstring * 10 ) )
		CU_ASSERT( len( T3.m1.s ) = len( string ) )
		CU_ASSERT( len( T3.m1.p ) = len( any ptr ) )
		CU_ASSERT( len( T3.m1.udt ) = len( U ) )

		CU_ASSERT( len( T3.m2.s ) = sizeof( string ) )
		CU_ASSERT( sizeof( T3.m2.s ) = sizeof( string ) )

	END_TEST

	type TOuter
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
		type TInner
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
	end type

	TEST( inner_type )

		CU_ASSERT( sizeof( TOuter.sb ) = sizeof( byte ) )
		CU_ASSERT( sizeof( TOuter.ub ) = sizeof( ubyte ) )
		CU_ASSERT( sizeof( TOuter.ss ) = sizeof( short ) )
		CU_ASSERT( sizeof( TOuter.us ) = sizeof( ushort ) )
		CU_ASSERT( sizeof( TOuter.sl ) = sizeof( long ) )
		CU_ASSERT( sizeof( TOuter.ul ) = sizeof( ulong ) )
		CU_ASSERT( sizeof( TOuter.si ) = sizeof( integer ) )
		CU_ASSERT( sizeof( TOuter.ui ) = sizeof( uinteger ) )
		CU_ASSERT( sizeof( TOuter.sli ) = sizeof( longint ) )
		CU_ASSERT( sizeof( TOuter.uli ) = sizeof( ulongint ) )
		CU_ASSERT( sizeof( TOuter.zs ) = sizeof( STRCONST ) )
		CU_ASSERT( sizeof( TOuter.ws ) = sizeof( wstr( STRCONST ) ) )
		CU_ASSERT( sizeof( TOuter.z ) = sizeof( zstring * 10 ) )
		CU_ASSERT( sizeof( TOuter.w ) = sizeof( wstring * 10 ) )
		CU_ASSERT( sizeof( TOuter.s ) = sizeof( string ) )
		CU_ASSERT( sizeof( TOuter.p ) = sizeof( any ptr ) )
		CU_ASSERT( sizeof( TOuter.udt ) = sizeof( U ) )

		CU_ASSERT( len( TOuter.sb ) = len( byte ) )
		CU_ASSERT( len( TOuter.ub ) = len( ubyte ) )
		CU_ASSERT( len( TOuter.ss ) = len( short ) )
		CU_ASSERT( len( TOuter.us ) = len( ushort ) )
		CU_ASSERT( len( TOuter.sl ) = len( long ) )
		CU_ASSERT( len( TOuter.ul ) = len( ulong ) )
		CU_ASSERT( len( TOuter.si ) = len( integer ) )
		CU_ASSERT( len( TOuter.ui ) = len( uinteger ) )
		CU_ASSERT( len( TOuter.sli ) = len( longint ) )
		CU_ASSERT( len( TOuter.uli ) = len( ulongint ) )
		CU_ASSERT( len( TOuter.zs ) = len( STRCONST ) )
		CU_ASSERT( len( TOuter.ws ) = len( wstr( STRCONST ) ) )
		CU_ASSERT( len( TOuter.z ) = len( zstring * 10 ) )
		CU_ASSERT( len( TOuter.w ) = len( wstring * 10 ) )
		CU_ASSERT( len( TOuter.s ) = len( string ) )
		CU_ASSERT( len( TOuter.p ) = len( any ptr ) )
		CU_ASSERT( len( TOuter.udt ) = len( U ) )

		CU_ASSERT( sizeof( TOuter.TInner.sb ) = sizeof( byte ) )
		CU_ASSERT( sizeof( TOuter.TInner.ub ) = sizeof( ubyte ) )
		CU_ASSERT( sizeof( TOuter.TInner.ss ) = sizeof( short ) )
		CU_ASSERT( sizeof( TOuter.TInner.us ) = sizeof( ushort ) )
		CU_ASSERT( sizeof( TOuter.TInner.sl ) = sizeof( long ) )
		CU_ASSERT( sizeof( TOuter.TInner.ul ) = sizeof( ulong ) )
		CU_ASSERT( sizeof( TOuter.TInner.si ) = sizeof( integer ) )
		CU_ASSERT( sizeof( TOuter.TInner.ui ) = sizeof( uinteger ) )
		CU_ASSERT( sizeof( TOuter.TInner.sli ) = sizeof( longint ) )
		CU_ASSERT( sizeof( TOuter.TInner.uli ) = sizeof( ulongint ) )
		CU_ASSERT( sizeof( TOuter.TInner.zs ) = sizeof( STRCONST ) )
		CU_ASSERT( sizeof( TOuter.TInner.ws ) = sizeof( wstr( STRCONST ) ) )
		CU_ASSERT( sizeof( TOuter.TInner.z ) = sizeof( zstring * 10 ) )
		CU_ASSERT( sizeof( TOuter.TInner.w ) = sizeof( wstring * 10 ) )
		CU_ASSERT( sizeof( TOuter.TInner.s ) = sizeof( string ) )
		CU_ASSERT( sizeof( TOuter.TInner.p ) = sizeof( any ptr ) )
		CU_ASSERT( sizeof( TOuter.TInner.udt ) = sizeof( U ) )

		CU_ASSERT( len( TOuter.TInner.sb ) = len( byte ) )
		CU_ASSERT( len( TOuter.TInner.ub ) = len( ubyte ) )
		CU_ASSERT( len( TOuter.TInner.ss ) = len( short ) )
		CU_ASSERT( len( TOuter.TInner.us ) = len( ushort ) )
		CU_ASSERT( len( TOuter.TInner.sl ) = len( long ) )
		CU_ASSERT( len( TOuter.TInner.ul ) = len( ulong ) )
		CU_ASSERT( len( TOuter.TInner.si ) = len( integer ) )
		CU_ASSERT( len( TOuter.TInner.ui ) = len( uinteger ) )
		CU_ASSERT( len( TOuter.TInner.sli ) = len( longint ) )
		CU_ASSERT( len( TOuter.TInner.uli ) = len( ulongint ) )
		CU_ASSERT( len( TOuter.TInner.zs ) = len( STRCONST ) )
		CU_ASSERT( len( TOuter.TInner.ws ) = len( wstr( STRCONST ) ) )
		CU_ASSERT( len( TOuter.TInner.z ) = len( zstring * 10 ) )
		CU_ASSERT( len( TOuter.TInner.w ) = len( wstring * 10 ) )
		CU_ASSERT( len( TOuter.TInner.s ) = len( string ) )
		CU_ASSERT( len( TOuter.TInner.p ) = len( any ptr ) )
		CU_ASSERT( len( TOuter.TInner.udt ) = len( U ) )

	END_TEST

	TEST( inner_member )

		type inner1
			a as short
			b as byte
		end type

		type outer1
			a as byte
			b as short
			m as inner1
		end type

		type outer
			a as byte
			b as short
			type inner
				a as short
				b as byte
			end type
			m as inner
		end type

		CU_ASSERT( sizeof( outer ) = sizeof( outer1 ) )
		CU_ASSERT( sizeof( outer.inner ) = sizeof( inner1 ) ) 

		CU_ASSERT( sizeof( outer.a ) = sizeof( byte ) )
		CU_ASSERT( sizeof( outer.b ) = sizeof( short ) )
		CU_ASSERT( sizeof( outer.inner.a ) = sizeof( short ) )
		CU_ASSERT( sizeof( outer.inner.b ) = sizeof( byte ) )

		CU_ASSERT( len( outer.a ) = sizeof( byte ) )
		CU_ASSERT( len( outer.b ) = sizeof( short ) )
		CU_ASSERT( len( outer.inner.a ) = sizeof( short ) )
		CU_ASSERT( len( outer.inner.b ) = sizeof( byte ) )

		dim x as outer
		CU_ASSERT( sizeof( x.a ) = sizeof( byte ) )
		CU_ASSERT( sizeof( x.b ) = sizeof( short ) )

		CU_ASSERT( len( x.a ) = sizeof( byte ) )
		CU_ASSERT( len( x.b ) = sizeof( short ) )

		dim y as outer.inner ptr
		CU_ASSERT( sizeof( y->a ) = sizeof( short ) )
		CU_ASSERT( sizeof( y->b ) = sizeof( byte ) )

		CU_ASSERT( len( y->a ) = sizeof( short ) )
		CU_ASSERT( len( y->b ) = sizeof( byte ) )

	END_TEST

END_SUITE
