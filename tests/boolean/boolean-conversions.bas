# include "fbcu.bi"

const FALSE = 0
const TRUE = -1

namespace fbc_tests.boolean_.boolean_conversions

sub testCompileTime cdecl( )
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
	#ifdef __FB_64BIT__
		CU_ASSERT( cbool( &h8000000000000000  ) = TRUE )
		CU_ASSERT( cbool( &h8000000000000000u ) = TRUE )
	#endif
end sub

sub testRunTime cdecl( )
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
	#ifdef __FB_64BIT__
		i   = &h8000000000000000 : CU_ASSERT( cbool( i   ) = TRUE )
		ui  = &h8000000000000000 : CU_ASSERT( cbool( ui  ) = TRUE )
	#endif
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/boolean/boolean-conversions" )
	fbcu.add_test( "testCompileTime", @testCompileTime )
	fbcu.add_test( "testRunTime", @testRunTime )
end sub

end namespace
