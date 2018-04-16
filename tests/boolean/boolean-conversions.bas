# include "fbcunit.bi"

'' - don't mix false/true intrinsic constants 
''   of the compiler in with the tests
#undef FALSE
#undef TRUE

const FALSE = 0
const TRUE = -1

SUITE( fbc_tests.boolean_.boolean_conversions )

	TEST( compileTime )

		'' test compile time conversion of constant=>boolean

		CU_ASSERT( cbool( cbyte  ( 0 ) ) = FALSE )
		CU_ASSERT( cbool( cubyte ( 0 ) ) = FALSE )
		CU_ASSERT( cbool( cshort ( 0 ) ) = FALSE )
		CU_ASSERT( cbool( cushort( 0 ) ) = FALSE )
		CU_ASSERT( cbool( 0l   ) = FALSE )
		CU_ASSERT( cbool( 0ul  ) = FALSE )
		CU_ASSERT( cbool( 0ll  ) = FALSE )
		CU_ASSERT( cbool( 0ull ) = FALSE )
		CU_ASSERT( cbool( 0    ) = FALSE )
		CU_ASSERT( cbool( 0u   ) = FALSE )
		CU_ASSERT( cbool( 0.0f ) = FALSE )
		CU_ASSERT( cbool( 0.0  ) = FALSE )
		CU_ASSERT( cbool( -0.0f ) = FALSE )
		CU_ASSERT( cbool( -0.0  ) = FALSE )
		CU_ASSERT( cbool( cbool( 0 ) ) = FALSE )

		CU_ASSERT( cbool( cbyte  ( -1 ) ) = TRUE )
		CU_ASSERT( cbool( cubyte ( -1 ) ) = TRUE )
		CU_ASSERT( cbool( cshort ( -1 ) ) = TRUE )
		CU_ASSERT( cbool( cushort( -1 ) ) = TRUE )
		CU_ASSERT( cbool( -1l   ) = TRUE )
		CU_ASSERT( cbool( -1ul  ) = TRUE )
		CU_ASSERT( cbool( -1ll  ) = TRUE )
		CU_ASSERT( cbool( -1ull ) = TRUE )
		CU_ASSERT( cbool( -1    ) = TRUE )
		CU_ASSERT( cbool( -1u   ) = TRUE )
		CU_ASSERT( cbool( -1.0f ) = TRUE )
		CU_ASSERT( cbool( -1.0  ) = TRUE )
		CU_ASSERT( cbool( cbool( -1 ) ) = TRUE )

		CU_ASSERT( cbool( cbyte  ( -123 ) ) = TRUE )
		CU_ASSERT( cbool( cubyte ( -123 ) ) = TRUE )
		CU_ASSERT( cbool( cshort ( -123 ) ) = TRUE )
		CU_ASSERT( cbool( cushort( -123 ) ) = TRUE )
		CU_ASSERT( cbool( -123l   ) = TRUE )
		CU_ASSERT( cbool( -123ul  ) = TRUE )
		CU_ASSERT( cbool( -123ll  ) = TRUE )
		CU_ASSERT( cbool( -123ull ) = TRUE )
		CU_ASSERT( cbool( -123    ) = TRUE )
		CU_ASSERT( cbool( -123u   ) = TRUE )
		CU_ASSERT( cbool( -123.0f ) = TRUE )
		CU_ASSERT( cbool( -123.0  ) = TRUE )
		CU_ASSERT( cbool( cbool( -123 ) ) = TRUE )

		CU_ASSERT( cbool( cbyte  ( 123 ) ) = TRUE )
		CU_ASSERT( cbool( cubyte ( 123 ) ) = TRUE )
		CU_ASSERT( cbool( cshort ( 123 ) ) = TRUE )
		CU_ASSERT( cbool( cushort( 123 ) ) = TRUE )
		CU_ASSERT( cbool( 123l   ) = TRUE )
		CU_ASSERT( cbool( 123ul  ) = TRUE )
		CU_ASSERT( cbool( 123ll  ) = TRUE )
		CU_ASSERT( cbool( 123ull ) = TRUE )
		CU_ASSERT( cbool( 123    ) = TRUE )
		CU_ASSERT( cbool( 123u   ) = TRUE )
		CU_ASSERT( cbool( 123.0f ) = TRUE )
		CU_ASSERT( cbool( 123.0  ) = TRUE )
		CU_ASSERT( cbool( cbool( 123 ) ) = TRUE )

		CU_ASSERT( cbool( &h80000000l   ) = TRUE )
		CU_ASSERT( cbool( &h80000000ul  ) = TRUE )
		CU_ASSERT( cbool( &h80000000ll  ) = TRUE )
		CU_ASSERT( cbool( &h80000000ull ) = TRUE )
		CU_ASSERT( cbool( &h80000000    ) = TRUE )
		CU_ASSERT( cbool( &h80000000u   ) = TRUE )

		CU_ASSERT( cbool( &h8000000000000000ll  ) = TRUE )
		CU_ASSERT( cbool( &h8000000000000000ull ) = TRUE )

		'' size of integer and uinteger depends on target platform
		#ifdef __FB_64BIT__
			CU_ASSERT( cbool( &h8000000000000000  ) = TRUE )
			CU_ASSERT( cbool( &h8000000000000000u ) = TRUE )
		#endif

	END_TEST

	TEST( runTime )

		'' test run time conversion of variable=>boolean

		dim b as byte
		dim ub as ubyte
		dim sh as short
		dim ush as ushort
		dim l as long
		dim ul as ulong
		dim ll as longint
		dim ull as ulongint
		dim i as integer
		dim ui as uinteger
		dim f as single
		dim d as double
		dim bool as boolean

		b   = 0 : CU_ASSERT( cbool( b   ) = FALSE )
		ub  = 0 : CU_ASSERT( cbool( ub  ) = FALSE )
		sh  = 0 : CU_ASSERT( cbool( sh  ) = FALSE )
		ush = 0 : CU_ASSERT( cbool( ush ) = FALSE )
		l   = 0 : CU_ASSERT( cbool( l   ) = FALSE )
		ul  = 0 : CU_ASSERT( cbool( ul  ) = FALSE )
		ll  = 0 : CU_ASSERT( cbool( ll  ) = FALSE )
		ull = 0 : CU_ASSERT( cbool( ull ) = FALSE )
		i   = 0 : CU_ASSERT( cbool( i   ) = FALSE )
		ui  = 0 : CU_ASSERT( cbool( ui  ) = FALSE )
		f   = 0 : CU_ASSERT( cbool( f   ) = FALSE )
		d   = 0 : CU_ASSERT( cbool( d   ) = FALSE )
		f   = -0.0f : CU_ASSERT( cbool( f   ) = FALSE )
		d   = -0.0# : CU_ASSERT( cbool( d   ) = FALSE )
		bool = 0 : CU_ASSERT( cbool( bool ) = FALSE )

		b   = -1 : CU_ASSERT( cbool( b   ) = TRUE )
		ub  = -1 : CU_ASSERT( cbool( ub  ) = TRUE )
		sh  = -1 : CU_ASSERT( cbool( sh  ) = TRUE )
		ush = -1 : CU_ASSERT( cbool( ush ) = TRUE )
		l   = -1 : CU_ASSERT( cbool( l   ) = TRUE )
		ul  = -1 : CU_ASSERT( cbool( ul  ) = TRUE )
		ll  = -1 : CU_ASSERT( cbool( ll  ) = TRUE )
		ull = -1 : CU_ASSERT( cbool( ull ) = TRUE )
		i   = -1 : CU_ASSERT( cbool( i   ) = TRUE )
		ui  = -1 : CU_ASSERT( cbool( ui  ) = TRUE )
		f   = -1 : CU_ASSERT( cbool( f   ) = TRUE )
		d   = -1 : CU_ASSERT( cbool( d   ) = TRUE )
		bool = -1 : CU_ASSERT( cbool( bool ) = TRUE )

		b   = -123 : CU_ASSERT( cbool( b   ) = TRUE )
		ub  = -123 : CU_ASSERT( cbool( ub  ) = TRUE )
		sh  = -123 : CU_ASSERT( cbool( sh  ) = TRUE )
		ush = -123 : CU_ASSERT( cbool( ush ) = TRUE )
		l   = -123 : CU_ASSERT( cbool( l   ) = TRUE )
		ul  = -123 : CU_ASSERT( cbool( ul  ) = TRUE )
		ll  = -123 : CU_ASSERT( cbool( ll  ) = TRUE )
		ull = -123 : CU_ASSERT( cbool( ull ) = TRUE )
		i   = -123 : CU_ASSERT( cbool( i   ) = TRUE )
		ui  = -123 : CU_ASSERT( cbool( ui  ) = TRUE )
		f   = -123 : CU_ASSERT( cbool( f   ) = TRUE )
		d   = -123 : CU_ASSERT( cbool( d   ) = TRUE )
		bool = -123 : CU_ASSERT( cbool( bool ) = TRUE )

		b   = 123 : CU_ASSERT( cbool( b   ) = TRUE )
		ub  = 123 : CU_ASSERT( cbool( ub  ) = TRUE )
		sh  = 123 : CU_ASSERT( cbool( sh  ) = TRUE )
		ush = 123 : CU_ASSERT( cbool( ush ) = TRUE )
		l   = 123 : CU_ASSERT( cbool( l   ) = TRUE )
		ul  = 123 : CU_ASSERT( cbool( ul  ) = TRUE )
		ll  = 123 : CU_ASSERT( cbool( ll  ) = TRUE )
		ull = 123 : CU_ASSERT( cbool( ull ) = TRUE )
		i   = 123 : CU_ASSERT( cbool( i   ) = TRUE )
		ui  = 123 : CU_ASSERT( cbool( ui  ) = TRUE )
		f   = 123 : CU_ASSERT( cbool( f   ) = TRUE )
		d   = 123 : CU_ASSERT( cbool( d   ) = TRUE )
		bool = 123 : CU_ASSERT( cbool( bool ) = TRUE )

		l   = &h80000000 : CU_ASSERT( cbool( l   ) = TRUE )
		ul  = &h80000000 : CU_ASSERT( cbool( ul  ) = TRUE )
		ll  = &h80000000 : CU_ASSERT( cbool( ll  ) = TRUE )
		ull = &h80000000 : CU_ASSERT( cbool( ull ) = TRUE )
		i   = &h80000000 : CU_ASSERT( cbool( i   ) = TRUE )
		ui  = &h80000000 : CU_ASSERT( cbool( ui  ) = TRUE )

		ll  = &h8000000000000000ll  : CU_ASSERT( cbool( ll  ) = TRUE )
		ull = &h8000000000000000ull : CU_ASSERT( cbool( ull ) = TRUE )

		'' size of integer and uinteger depends on target platform
		#ifdef __FB_64BIT__
			i   = &h8000000000000000 : CU_ASSERT( cbool( i   ) = TRUE )
			ui  = &h8000000000000000 : CU_ASSERT( cbool( ui  ) = TRUE )
		#endif

	END_TEST

	TEST( assignToBoolVar )
		
		'' test implicit conversion of variable=>boolean on 
		'' assignment to boolean variable
		
		dim b as byte
		dim ub as ubyte
		dim sh as short
		dim ush as ushort
		dim l as long
		dim ul as ulong
		dim ll as longint
		dim ull as ulongint
		dim i as integer
		dim ui as uinteger
		dim f as single
		dim d as double
		dim bool as boolean
		dim boolvar as boolean

		b    = 0 : boolvar = b    : CU_ASSERT( boolvar = FALSE )
		ub   = 0 : boolvar = ub   : CU_ASSERT( boolvar = FALSE )
		sh   = 0 : boolvar = sh   : CU_ASSERT( boolvar = FALSE )
		ush  = 0 : boolvar = ush  : CU_ASSERT( boolvar = FALSE )
		l    = 0 : boolvar = l    : CU_ASSERT( boolvar = FALSE )
		ul   = 0 : boolvar = ul   : CU_ASSERT( boolvar = FALSE )
		ll   = 0 : boolvar = ll   : CU_ASSERT( boolvar = FALSE )
		ull  = 0 : boolvar = ull  : CU_ASSERT( boolvar = FALSE )
		i    = 0 : boolvar = i    : CU_ASSERT( boolvar = FALSE )
		ui   = 0 : boolvar = ui   : CU_ASSERT( boolvar = FALSE )
		f    = 0 : boolvar = f    : CU_ASSERT( boolvar = FALSE )
		d    = 0 : boolvar = d    : CU_ASSERT( boolvar = FALSE )
		f    = -0.0f : boolvar = f    : CU_ASSERT( boolvar = FALSE )
		d    = -0.0# : boolvar = d    : CU_ASSERT( boolvar = FALSE )
		bool = 0 : boolvar = bool : CU_ASSERT( boolvar = FALSE )

		b    = -1 : boolvar = b    : CU_ASSERT( boolvar = TRUE )
		ub   = -1 : boolvar = ub   : CU_ASSERT( boolvar = TRUE )
		sh   = -1 : boolvar = sh   : CU_ASSERT( boolvar = TRUE )
		ush  = -1 : boolvar = ush  : CU_ASSERT( boolvar = TRUE )
		l    = -1 : boolvar = l    : CU_ASSERT( boolvar = TRUE )
		ul   = -1 : boolvar = ul   : CU_ASSERT( boolvar = TRUE )
		ll   = -1 : boolvar = ll   : CU_ASSERT( boolvar = TRUE )
		ull  = -1 : boolvar = ull  : CU_ASSERT( boolvar = TRUE )
		i    = -1 : boolvar = i    : CU_ASSERT( boolvar = TRUE )
		ui   = -1 : boolvar = ui   : CU_ASSERT( boolvar = TRUE )
		f    = -1 : boolvar = f    : CU_ASSERT( boolvar = TRUE )
		d    = -1 : boolvar = d    : CU_ASSERT( boolvar = TRUE )
		bool = -1 : boolvar = bool : CU_ASSERT( boolvar = TRUE )

		b    = -123 : boolvar = b    : CU_ASSERT( boolvar = TRUE )
		ub   = -123 : boolvar = ub   : CU_ASSERT( boolvar = TRUE )
		sh   = -123 : boolvar = sh   : CU_ASSERT( boolvar = TRUE )
		ush  = -123 : boolvar = ush  : CU_ASSERT( boolvar = TRUE )
		l    = -123 : boolvar = l    : CU_ASSERT( boolvar = TRUE )
		ul   = -123 : boolvar = ul   : CU_ASSERT( boolvar = TRUE )
		ll   = -123 : boolvar = ll   : CU_ASSERT( boolvar = TRUE )
		ull  = -123 : boolvar = ull  : CU_ASSERT( boolvar = TRUE )
		i    = -123 : boolvar = i    : CU_ASSERT( boolvar = TRUE )
		ui   = -123 : boolvar = ui   : CU_ASSERT( boolvar = TRUE )
		f    = -123 : boolvar = f    : CU_ASSERT( boolvar = TRUE )
		d    = -123 : boolvar = d    : CU_ASSERT( boolvar = TRUE )
		bool = -123 : boolvar = bool : CU_ASSERT( boolvar = TRUE )

		b    = 123 : boolvar = b    : CU_ASSERT( boolvar = TRUE )
		ub   = 123 : boolvar = ub   : CU_ASSERT( boolvar = TRUE )
		sh   = 123 : boolvar = sh   : CU_ASSERT( boolvar = TRUE )
		ush  = 123 : boolvar = ush  : CU_ASSERT( boolvar = TRUE )
		l    = 123 : boolvar = l    : CU_ASSERT( boolvar = TRUE )
		ul   = 123 : boolvar = ul   : CU_ASSERT( boolvar = TRUE )
		ll   = 123 : boolvar = ll   : CU_ASSERT( boolvar = TRUE )
		ull  = 123 : boolvar = ull  : CU_ASSERT( boolvar = TRUE )
		i    = 123 : boolvar = i    : CU_ASSERT( boolvar = TRUE )
		ui   = 123 : boolvar = ui   : CU_ASSERT( boolvar = TRUE )
		f    = 123 : boolvar = f    : CU_ASSERT( boolvar = TRUE )
		d    = 123 : boolvar = d    : CU_ASSERT( boolvar = TRUE )
		bool = 123 : boolvar = bool : CU_ASSERT( boolvar = TRUE )

		l   = &h80000000 : boolvar = l   : CU_ASSERT( boolvar = TRUE )
		ul  = &h80000000 : boolvar = ul  : CU_ASSERT( boolvar = TRUE )
		ll  = &h80000000 : boolvar = ll  : CU_ASSERT( boolvar = TRUE )
		ull = &h80000000 : boolvar = ull : CU_ASSERT( boolvar = TRUE )
		i   = &h80000000 : boolvar = i   : CU_ASSERT( boolvar = TRUE )
		ui  = &h80000000 : boolvar = ui  : CU_ASSERT( boolvar = TRUE )

		ll  = &h8000000000000000ll  : boolvar = ll : CU_ASSERT( boolvar = TRUE )
		ull = &h8000000000000000ull : boolvar = ull : CU_ASSERT( boolvar = TRUE )

		'' size of integer and uinteger depends on target platform
		#ifdef __FB_64BIT__
			i   = &h8000000000000000 : boolvar = i : CU_ASSERT( boolvar = TRUE )
			ui  = &h8000000000000000 : boolvar = ui : CU_ASSERT( boolvar = TRUE )
		#endif

	END_TEST

	TEST( assignFromBoolConst )

		'' test conversion of boolean=>constant

		dim b as byte
		dim ub as ubyte
		dim sh as short
		dim ush as ushort
		dim l as long
		dim ul as ulong
		dim ll as longint
		dim ull as ulongint
		dim i as integer
		dim ui as uinteger
		dim f as single
		dim d as double
		dim bool as boolean
		dim boolvar as boolean

		const bool_F as boolean = cbool(FALSE)
		boolvar = FALSE
		
		b    = boolvar : CU_ASSERT( b = cbyte(bool_F) )
		ub   = boolvar : CU_ASSERT( ub = cubyte(bool_F) )
		sh   = boolvar : CU_ASSERT( sh = cshort(bool_F) )
		ush  = boolvar : CU_ASSERT( ush = cushort(bool_F) )
		l    = boolvar : CU_ASSERT( l = clng(bool_F) )
		ul   = boolvar : CU_ASSERT( ul = culng(bool_F) )
		ll   = boolvar : CU_ASSERT( ll= clngint(bool_F) )
		ull  = boolvar : CU_ASSERT( ull = culngint(bool_F) )
		i    = boolvar : CU_ASSERT( i = cint(bool_F) )
		ui   = boolvar : CU_ASSERT( ui = cuint(bool_F) )
		f    = boolvar : CU_ASSERT( f = csng(bool_F) )
		d    = boolvar : CU_ASSERT( d = cdbl(bool_F) )
		bool = boolvar : CU_ASSERT( bool = cbool(bool_F) )

		const bool_T as boolean = cbool(TRUE)
		boolvar = TRUE

		b    = boolvar : CU_ASSERT( b = cbyte(bool_T) )
		ub   = boolvar : CU_ASSERT( ub = cubyte(bool_T) )
		sh   = boolvar : CU_ASSERT( sh = cshort(bool_T) )
		ush  = boolvar : CU_ASSERT( ush = cushort(bool_T) )
		l    = boolvar : CU_ASSERT( l = clng(bool_T) )
		ul   = boolvar : CU_ASSERT( ul = culng(bool_T) )
		ll   = boolvar : CU_ASSERT( ll= clngint(bool_T) )
		ull  = boolvar : CU_ASSERT( ull = culngint(bool_T) )
		i    = boolvar : CU_ASSERT( i = cint(bool_T) )
		ui   = boolvar : CU_ASSERT( ui = cuint(bool_T) )
		f    = boolvar : CU_ASSERT( f = csng(bool_T) )
		d    = boolvar : CU_ASSERT( d = cdbl(bool_T) )
		bool = boolvar : CU_ASSERT( bool = cbool(bool_T) )

	END_TEST

	TEST( assignFromBoolVar )

		'' test conversion of boolean=>variable

		dim b as byte
		dim ub as ubyte
		dim sh as short
		dim ush as ushort
		dim l as long
		dim ul as ulong
		dim ll as longint
		dim ull as ulongint
		dim i as integer
		dim ui as uinteger
		dim f as single
		dim d as double
		dim bool as boolean
		dim boolvar as boolean

		boolvar = FALSE
		
		b    = boolvar : CU_ASSERT( b = cbyte(boolvar) )
		ub   = boolvar : CU_ASSERT( ub = cubyte(boolvar) )
		sh   = boolvar : CU_ASSERT( sh = cshort(boolvar) )
		ush  = boolvar : CU_ASSERT( ush = cushort(boolvar) )
		l    = boolvar : CU_ASSERT( l = clng(boolvar) )
		ul   = boolvar : CU_ASSERT( ul = culng(boolvar) )
		ll   = boolvar : CU_ASSERT( ll= clngint(boolvar) )
		ull  = boolvar : CU_ASSERT( ull = culngint(boolvar) )
		i    = boolvar : CU_ASSERT( i = cint(boolvar) )
		ui   = boolvar : CU_ASSERT( ui = cuint(boolvar) )
		f    = boolvar : CU_ASSERT( f = csng(boolvar) )
		d    = boolvar : CU_ASSERT( d = cdbl(boolvar) )
		bool = boolvar : CU_ASSERT( bool = cbool(boolvar) )

		boolvar = TRUE

		b    = boolvar : CU_ASSERT( b = cbyte(boolvar) )
		ub   = boolvar : CU_ASSERT( ub = cubyte(boolvar) )
		sh   = boolvar : CU_ASSERT( sh = cshort(boolvar) )
		ush  = boolvar : CU_ASSERT( ush = cushort(boolvar) )
		l    = boolvar : CU_ASSERT( l = clng(boolvar) )
		ul   = boolvar : CU_ASSERT( ul = culng(boolvar) )
		ll   = boolvar : CU_ASSERT( ll= clngint(boolvar) )
		ull  = boolvar : CU_ASSERT( ull = culngint(boolvar) )
		i    = boolvar : CU_ASSERT( i = cint(boolvar) )
		ui   = boolvar : CU_ASSERT( ui = cuint(boolvar) )
		f    = boolvar : CU_ASSERT( f = csng(boolvar) )
		d    = boolvar : CU_ASSERT( d = cdbl(boolvar) )
		bool = boolvar : CU_ASSERT( bool = cbool(boolvar) )

	END_TEST

END_SUITE
