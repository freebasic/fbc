#include "fbcu.bi"

namespace fbc_tests.file_.get_

private sub test cdecl( )
	const TESTFILE = "data/123.txt"

	var f = freefile( )
	if( open( TESTFILE, for binary, access read, as #f ) <> 0 ) then
		CU_FAIL( "could not open file " & TESTFILE )
	end if

	dim b as byte
	dim ub as ubyte
	dim sh as short
	dim ush as ushort
	dim l as long
	dim ul as ulong
	dim i as integer
	dim ui as uinteger
	dim ll as longint
	dim ull as ulongint
	dim s as string
	dim array4b(0 to 3) as byte

	''
	'' Expecting TESTFILE to contain this ASCII text: 1234567890
	''

	CU_ASSERT( get( #f, 1, b   ) = 0 ) : CU_ASSERT( b   = asc( "1" ) )
	CU_ASSERT( get( #f, 1, ub  ) = 0 ) : CU_ASSERT( ub  = asc( "1" ) )
	CU_ASSERT( get( #f, 1, sh  ) = 0 ) : CU_ASSERT( sh  = cvshort( "12" ) )
	CU_ASSERT( get( #f, 1, ush ) = 0 ) : CU_ASSERT( ush = cvshort( "12" ) )
	CU_ASSERT( get( #f, 1, l   ) = 0 ) : CU_ASSERT( l   = cvl( "1234" ) )
	CU_ASSERT( get( #f, 1, ul  ) = 0 ) : CU_ASSERT( ul  = cvl( "1234" ) )
	#ifdef __FB_64BIT__
		CU_ASSERT( get( #f, 1, i   ) = 0 ) : CU_ASSERT( i   = cvi( "12345678" ) )
		CU_ASSERT( get( #f, 1, ui  ) = 0 ) : CU_ASSERT( ui  = cvi( "12345678" ) )
	#else
		CU_ASSERT( get( #f, 1, i   ) = 0 ) : CU_ASSERT( i   = cvi( "1234" ) )
		CU_ASSERT( get( #f, 1, ui  ) = 0 ) : CU_ASSERT( ui  = cvi( "1234" ) )
	#endif
	CU_ASSERT( get( #f, 1, ll  ) = 0 ) : CU_ASSERT( ll  = cvlongint( "12345678" ) )
	CU_ASSERT( get( #f, 1, ull ) = 0 ) : CU_ASSERT( ull = cvlongint( "12345678" ) )

	s = space( 10 )
	CU_ASSERT( get( #f, 1, s ) = 0 )
	CU_ASSERT( s = "1234567890" )

	CU_ASSERT( get( #f, 1, array4b() ) = 0 )
	CU_ASSERT( array4b(0) = asc( "1" ) )
	CU_ASSERT( array4b(1) = asc( "2" ) )
	CU_ASSERT( array4b(2) = asc( "3" ) )
	CU_ASSERT( array4b(3) = asc( "4" ) )

	''
	'' Same again, but with bytesread variable given
	''

	dim as integer bytesread
	b = 0
	ub = 0
	sh = 0
	ush = 0
	l = 0
	ul = 0
	i = 0
	ui = 0
	ll = 0
	ull = 0
	s = ""
	array4b(0) = 0
	array4b(1) = 0
	array4b(2) = 0
	array4b(3) = 0

	bytesread = 0 : CU_ASSERT( get( #f, 1, b  , , bytesread ) = 0 ) : CU_ASSERT( b   = asc( "1" ) ) : CU_ASSERT( bytesread = 1 )
	bytesread = 0 : CU_ASSERT( get( #f, 1, ub , , bytesread ) = 0 ) : CU_ASSERT( ub  = asc( "1" ) ) : CU_ASSERT( bytesread = 1 )
	bytesread = 0 : CU_ASSERT( get( #f, 1, sh , , bytesread ) = 0 ) : CU_ASSERT( sh  = cvshort( "12" ) ) : CU_ASSERT( bytesread = 2 )
	bytesread = 0 : CU_ASSERT( get( #f, 1, ush, , bytesread ) = 0 ) : CU_ASSERT( ush = cvshort( "12" ) ) : CU_ASSERT( bytesread = 2 )
	bytesread = 0 : CU_ASSERT( get( #f, 1, l  , , bytesread ) = 0 ) : CU_ASSERT( l   = cvl( "1234" ) ) : CU_ASSERT( bytesread = 4 )
	bytesread = 0 : CU_ASSERT( get( #f, 1, ul , , bytesread ) = 0 ) : CU_ASSERT( ul  = cvl( "1234" ) ) : CU_ASSERT( bytesread = 4 )
	#ifdef __FB_64BIT__
		bytesread = 0 : CU_ASSERT( get( #f, 1, i , , bytesread ) = 0 ) : CU_ASSERT( i   = cvi( "12345678" ) ) : CU_ASSERT( bytesread = 8 )
		bytesread = 0 : CU_ASSERT( get( #f, 1, ui, , bytesread ) = 0 ) : CU_ASSERT( ui  = cvi( "12345678" ) ) : CU_ASSERT( bytesread = 8 )
	#else
		bytesread = 0 : CU_ASSERT( get( #f, 1, i , , bytesread ) = 0 ) : CU_ASSERT( i   = cvi( "1234" ) ) : CU_ASSERT( bytesread = 4 )
		bytesread = 0 : CU_ASSERT( get( #f, 1, ui, , bytesread ) = 0 ) : CU_ASSERT( ui  = cvi( "1234" ) ) : CU_ASSERT( bytesread = 4 )
	#endif
	bytesread = 0 : CU_ASSERT( get( #f, 1, ll , , bytesread ) = 0 ) : CU_ASSERT( ll  = cvlongint( "12345678" ) ) : CU_ASSERT( bytesread = 8 )
	bytesread = 0 : CU_ASSERT( get( #f, 1, ull, , bytesread ) = 0 ) : CU_ASSERT( ull = cvlongint( "12345678" ) ) : CU_ASSERT( bytesread = 8 )

	s = space( 10 )
	bytesread = 0
	CU_ASSERT( get( #f, 1, s, , bytesread ) = 0 )
	CU_ASSERT( s = "1234567890" )
	CU_ASSERT( bytesread = 10 )

	bytesread = 0
	CU_ASSERT( get( #f, 1, array4b(), , bytesread ) = 0 )
	CU_ASSERT( array4b(0) = asc( "1" ) )
	CU_ASSERT( array4b(1) = asc( "2" ) )
	CU_ASSERT( array4b(2) = asc( "3" ) )
	CU_ASSERT( array4b(3) = asc( "4" ) )
	CU_ASSERT( bytesread = 4 )

	''
	'' LONGINT offset
	''

	CU_ASSERT( get( #f, 1ll, b   ) = 0 ) : CU_ASSERT( b   = asc( "1" ) )
	CU_ASSERT( get( #f, 1ll, ub  ) = 0 ) : CU_ASSERT( ub  = asc( "1" ) )
	CU_ASSERT( get( #f, 1ll, sh  ) = 0 ) : CU_ASSERT( sh  = cvshort( "12" ) )
	CU_ASSERT( get( #f, 1ll, ush ) = 0 ) : CU_ASSERT( ush = cvshort( "12" ) )
	CU_ASSERT( get( #f, 1ll, l   ) = 0 ) : CU_ASSERT( l   = cvl( "1234" ) )
	CU_ASSERT( get( #f, 1ll, ul  ) = 0 ) : CU_ASSERT( ul  = cvl( "1234" ) )
	#ifdef __FB_64BIT__
		CU_ASSERT( get( #f, 1ll, i   ) = 0 ) : CU_ASSERT( i   = cvi( "12345678" ) )
		CU_ASSERT( get( #f, 1ll, ui  ) = 0 ) : CU_ASSERT( ui  = cvi( "12345678" ) )
	#else
		CU_ASSERT( get( #f, 1ll, i   ) = 0 ) : CU_ASSERT( i   = cvi( "1234" ) )
		CU_ASSERT( get( #f, 1ll, ui  ) = 0 ) : CU_ASSERT( ui  = cvi( "1234" ) )
	#endif
	CU_ASSERT( get( #f, 1ll, ll  ) = 0 ) : CU_ASSERT( ll  = cvlongint( "12345678" ) )
	CU_ASSERT( get( #f, 1ll, ull ) = 0 ) : CU_ASSERT( ull = cvlongint( "12345678" ) )

	s = space( 10 )
	CU_ASSERT( get( #f, 1ll, s ) = 0 )
	CU_ASSERT( s = "1234567890" )

	CU_ASSERT( get( #f, 1ll, array4b() ) = 0 )
	CU_ASSERT( array4b(0) = asc( "1" ) )
	CU_ASSERT( array4b(1) = asc( "2" ) )
	CU_ASSERT( array4b(2) = asc( "3" ) )
	CU_ASSERT( array4b(3) = asc( "4" ) )

	''
	'' LONGINT offset + bytesread
	''

	b = 0
	ub = 0
	sh = 0
	ush = 0
	l = 0
	ul = 0
	i = 0
	ui = 0
	ll = 0
	ull = 0
	s = ""
	array4b(0) = 0
	array4b(1) = 0
	array4b(2) = 0
	array4b(3) = 0

	bytesread = 0 : CU_ASSERT( get( #f, 1ll, b  , , bytesread ) = 0 ) : CU_ASSERT( b   = asc( "1" ) ) : CU_ASSERT( bytesread = 1 )
	bytesread = 0 : CU_ASSERT( get( #f, 1ll, ub , , bytesread ) = 0 ) : CU_ASSERT( ub  = asc( "1" ) ) : CU_ASSERT( bytesread = 1 )
	bytesread = 0 : CU_ASSERT( get( #f, 1ll, sh , , bytesread ) = 0 ) : CU_ASSERT( sh  = cvshort( "12" ) ) : CU_ASSERT( bytesread = 2 )
	bytesread = 0 : CU_ASSERT( get( #f, 1ll, ush, , bytesread ) = 0 ) : CU_ASSERT( ush = cvshort( "12" ) ) : CU_ASSERT( bytesread = 2 )
	bytesread = 0 : CU_ASSERT( get( #f, 1ll, l  , , bytesread ) = 0 ) : CU_ASSERT( l   = cvl( "1234" ) ) : CU_ASSERT( bytesread = 4 )
	bytesread = 0 : CU_ASSERT( get( #f, 1ll, ul , , bytesread ) = 0 ) : CU_ASSERT( ul  = cvl( "1234" ) ) : CU_ASSERT( bytesread = 4 )
	#ifdef __FB_64BIT__
		bytesread = 0 : CU_ASSERT( get( #f, 1ll, i , , bytesread ) = 0 ) : CU_ASSERT( i   = cvi( "12345678" ) ) : CU_ASSERT( bytesread = 8 )
		bytesread = 0 : CU_ASSERT( get( #f, 1ll, ui, , bytesread ) = 0 ) : CU_ASSERT( ui  = cvi( "12345678" ) ) : CU_ASSERT( bytesread = 8 )
	#else
		bytesread = 0 : CU_ASSERT( get( #f, 1ll, i , , bytesread ) = 0 ) : CU_ASSERT( i   = cvi( "1234" ) ) : CU_ASSERT( bytesread = 4 )
		bytesread = 0 : CU_ASSERT( get( #f, 1ll, ui, , bytesread ) = 0 ) : CU_ASSERT( ui  = cvi( "1234" ) ) : CU_ASSERT( bytesread = 4 )
	#endif
	bytesread = 0 : CU_ASSERT( get( #f, 1ll, ll , , bytesread ) = 0 ) : CU_ASSERT( ll  = cvlongint( "12345678" ) ) : CU_ASSERT( bytesread = 8 )
	bytesread = 0 : CU_ASSERT( get( #f, 1ll, ull, , bytesread ) = 0 ) : CU_ASSERT( ull = cvlongint( "12345678" ) ) : CU_ASSERT( bytesread = 8 )

	s = space( 10 )
	bytesread = 0
	CU_ASSERT( get( #f, 1ll, s, , bytesread ) = 0 )
	CU_ASSERT( s = "1234567890" )
	CU_ASSERT( bytesread = 10 )

	bytesread = 0
	CU_ASSERT( get( #f, 1ll, array4b(), , bytesread ) = 0 )
	CU_ASSERT( array4b(0) = asc( "1" ) )
	CU_ASSERT( array4b(1) = asc( "2" ) )
	CU_ASSERT( array4b(2) = asc( "3" ) )
	CU_ASSERT( array4b(3) = asc( "4" ) )
	CU_ASSERT( bytesread = 4 )

	close #f
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/file/get" )
	fbcu.add_test( "test", @test )
end sub

end namespace
