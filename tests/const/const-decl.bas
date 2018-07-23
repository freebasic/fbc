# include "fbcunit.bi"

SUITE( fbc_tests.const_.const_decl )

	TEST_GROUP( syntax )
		const a = 1
		const b as integer = 2
		const as integer c = 3
		const as integer d = 4, e = 5, f = 6
		const g = 7, h = 8, i = 9
		const j = 3 + (2 * 300)

		TEST( default )
			CU_ASSERT( a = 1 )
			CU_ASSERT( b = 2 )
			CU_ASSERT( c = 3 )
			CU_ASSERT( d = 4 )
			CU_ASSERT( e = 5 )
			CU_ASSERT( f = 6 )
			CU_ASSERT( g = 7 )
			CU_ASSERT( h = 8 )
			CU_ASSERT( i = 9 )
			CU_ASSERT( j = 603 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( explicitTypes )
		type UDT
			i as integer
		end type

		const b    as        byte = 0
		const ub   as       ubyte = 0
		const sh   as       short = 0
		const ush  as      ushort = 0
		const l    as        long = 0
		const ul   as       ulong = 0
		const ll   as     longint = 0
		const ull  as    ulongint = 0
		const i    as     integer = 0
		const ui   as    uinteger = 0
		const f    as      single = 0
		const d    as      double = 0
		const s    as      string = "a"
		const pany as     any ptr = 0
		const pi   as integer ptr = 0
		const pudt as     UDT ptr = 0
		const ps   as  string ptr = 0
		const pz   as zstring ptr = 0
		const pw   as wstring ptr = 0
		const psub as      sub( ) = 0

		#assert typeof( b    ) = typeof(        byte )
		#assert typeof( ub   ) = typeof(       ubyte )
		#assert typeof( sh   ) = typeof(       short )
		#assert typeof( ush  ) = typeof(      ushort )
		#assert typeof( l    ) = typeof(        long )
		#assert typeof( ul   ) = typeof(       ulong )
		#assert typeof( ll   ) = typeof(     longint )
		#assert typeof( ull  ) = typeof(    ulongint )
		#assert typeof( i    ) = typeof(     integer )
		#assert typeof( ui   ) = typeof(    uinteger )
		#assert typeof( f    ) = typeof(      single )
		#assert typeof( d    ) = typeof(      double )
		#assert typeof( s    ) = typeof( zstring * 2 )
		#assert typeof( pany ) = typeof(     any ptr )
		#assert typeof( pi   ) = typeof( integer ptr )
		#assert typeof( pudt ) = typeof(     UDT ptr )
		#assert typeof( ps   ) = typeof(  string ptr )
		#assert typeof( pz   ) = typeof( zstring ptr )
		#assert typeof( pw   ) = typeof( wstring ptr )
		#assert typeof( psub ) = typeof(      sub( ) )

		TEST( default )
			CU_ASSERT( b    = 0   )
			CU_ASSERT( ub   = 0   )
			CU_ASSERT( sh   = 0   )
			CU_ASSERT( ush  = 0   )
			CU_ASSERT( l    = 0   )
			CU_ASSERT( ul   = 0   )
			CU_ASSERT( ll   = 0   )
			CU_ASSERT( ull  = 0   )
			CU_ASSERT( i    = 0   )
			CU_ASSERT( ui   = 0   )
			CU_ASSERT( f    = 0   )
			CU_ASSERT( d    = 0   )
			CU_ASSERT( s    = "a" )
			CU_ASSERT( pany = 0   )
			CU_ASSERT( pi   = 0   )
			CU_ASSERT( pudt = 0   )
			CU_ASSERT( ps   = 0   )
			CU_ASSERT( pz   = 0   )
			CU_ASSERT( pw   = 0   )
			CU_ASSERT( psub = 0   )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( implicitTypes )
		type UDT
			i as integer
		end type

		const b    = cbyte( 0 )
		const ub   = cubyte( 0 )
		const sh   = cshort( 0 )
		const ush  = cushort( 0 )
		const l    = 0l
		const ul   = 0ul
		const ll   = 0ll
		const ull  = 0ull
		const i    = 0
		const ui   = 0u
		const f    = 0f
		const d    = 0.0
		const s    = "a"
		const pany = cptr(     any ptr, 0 )
		const pi   = cptr( integer ptr, 0 )
		const pudt = cptr(     UDT ptr, 0 )
		const ps   = cptr(  string ptr, 0 )
		const pz   = cptr( zstring ptr, 0 )
		const pw   = cptr( wstring ptr, 0 )
		const psub = cptr(      sub( ), 0 )

		#assert typeof( b    ) = typeof(        byte )
		#assert typeof( ub   ) = typeof(       ubyte )
		#assert typeof( sh   ) = typeof(       short )
		#assert typeof( ush  ) = typeof(      ushort )
		#assert typeof( l    ) = typeof(        long )
		#assert typeof( ul   ) = typeof(       ulong )
		#assert typeof( ll   ) = typeof(     longint )
		#assert typeof( ull  ) = typeof(    ulongint )
		#assert typeof( i    ) = typeof(     integer )
		#assert typeof( ui   ) = typeof(    uinteger )
		#assert typeof( f    ) = typeof(      single )
		#assert typeof( d    ) = typeof(      double )
		#assert typeof( s    ) = typeof( zstring * 2 )
		#assert typeof( pany ) = typeof(     any ptr )
		#assert typeof( pi   ) = typeof( integer ptr )
		#assert typeof( pudt ) = typeof(     UDT ptr )
		#assert typeof( ps   ) = typeof(  string ptr )
		#assert typeof( pz   ) = typeof( zstring ptr )
		#assert typeof( pw   ) = typeof( wstring ptr )
		#assert typeof( psub ) = typeof(      sub( ) )

		TEST( default )
			CU_ASSERT( b    = 0   )
			CU_ASSERT( ub   = 0   )
			CU_ASSERT( sh   = 0   )
			CU_ASSERT( ush  = 0   )
			CU_ASSERT( l    = 0   )
			CU_ASSERT( ul   = 0   )
			CU_ASSERT( ll   = 0   )
			CU_ASSERT( ull  = 0   )
			CU_ASSERT( i    = 0   )
			CU_ASSERT( ui   = 0   )
			CU_ASSERT( f    = 0   )
			CU_ASSERT( d    = 0   )
			CU_ASSERT( s    = "a" )
			CU_ASSERT( pany = 0   )
			CU_ASSERT( pi   = 0   )
			CU_ASSERT( pudt = 0   )
			CU_ASSERT( ps   = 0   )
			CU_ASSERT( pz   = 0   )
			CU_ASSERT( pw   = 0   )
			CU_ASSERT( psub = 0   )
		END_TEST
	END_TEST_GROUP

END_SUITE
