#include "fbcunit.bi"
#include "file.bi"

SUITE( fbc_tests.file_.get_ )

	TEST( allTypes )
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
		dim z6 as zstring * 6
		dim w6 as wstring * 6
		dim pz6 as zstring ptr = callocate( 6 * sizeof( zstring ) )
		dim pw6 as wstring ptr = callocate( 6 * sizeof( wstring ) )
		dim array4b(0 to 3) as byte
		dim array4l(0 to 3) as long

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

		CU_ASSERT( get( #f, 1, z6 ) = 0 )
		CU_ASSERT( z6 = "12345" )

		CU_ASSERT( get( #f, 1, w6 ) = 0 )
		#if sizeof(wstring) = 1
			CU_ASSERT( w6 = "12345" )
		#elseif sizeof(wstring) = 2
			CU_ASSERT( w6[0] = cvshort( "12" ) )
			CU_ASSERT( w6[1] = cvshort( "34" ) )
			CU_ASSERT( w6[2] = cvshort( "56" ) )
			CU_ASSERT( w6[3] = cvshort( "78" ) )
			CU_ASSERT( w6[4] = cvshort( "90" ) )
		#elseif sizeof(wstring) = 4
			CU_ASSERT( w6[0] = cvl( "1234" ) )
			CU_ASSERT( w6[1] = cvl( "5678" ) )
			CU_ASSERT( w6[2] = cvshort( "90" ) )
			CU_ASSERT( w6[3] = 0 )
			CU_ASSERT( w6[4] = 0 )
		#endif
		CU_ASSERT( w6[5] = 0 )

		*pz6 = "00000"
		CU_ASSERT( get( #f, 1, *pz6 ) = 0 )
		CU_ASSERT( *pz6 = "12345" )

		*pw6 = "00000"
		CU_ASSERT( get( #f, 1, *pw6 ) = 0 )
		#if sizeof(wstring) = 1
			CU_ASSERT( (*pw6) = "12345" )
		#elseif sizeof(wstring) = 2
			CU_ASSERT( (*pw6)[0] = cvshort( "12" ) )
			CU_ASSERT( (*pw6)[1] = cvshort( "34" ) )
			CU_ASSERT( (*pw6)[2] = cvshort( "56" ) )
			CU_ASSERT( (*pw6)[3] = cvshort( "78" ) )
			CU_ASSERT( (*pw6)[4] = cvshort( "90" ) )
		#elseif sizeof(wstring) = 4
			CU_ASSERT( (*pw6)[0] = cvl( "1234" ) )
			CU_ASSERT( (*pw6)[1] = cvl( "5678" ) )
			CU_ASSERT( (*pw6)[2] = cvshort( "90" ) )
			CU_ASSERT( (*pw6)[3] = 0 )
			CU_ASSERT( (*pw6)[4] = 0 )
		#endif
		CU_ASSERT( (*pw6)[5] = 0 )

		CU_ASSERT( get( #f, 1, array4b() ) = 0 )
		CU_ASSERT( array4b(0) = asc( "1" ) )
		CU_ASSERT( array4b(1) = asc( "2" ) )
		CU_ASSERT( array4b(2) = asc( "3" ) )
		CU_ASSERT( array4b(3) = asc( "4" ) )

		CU_ASSERT( get( #f, 1, array4l() ) = 0 )
		CU_ASSERT( array4l(0) = cvl( "1234" ) )
		CU_ASSERT( array4l(1) = cvl( "5678" ) )
		CU_ASSERT( array4l(2) = cvshort( "90" ) )
		CU_ASSERT( array4l(3) = 0 )

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
		z6 = ""
		w6 = wstr( "" )
		array4b(0) = 0
		array4b(1) = 0
		array4b(2) = 0
		array4b(3) = 0
		array4l(0) = 0
		array4l(1) = 0
		array4l(2) = 0
		array4l(3) = 0

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
		CU_ASSERT( get( #f, 1, z6, , bytesread ) = 0 )
		CU_ASSERT( z6 = "12345" )
		CU_ASSERT( bytesread = 5 )

		bytesread = 0
		CU_ASSERT( get( #f, 1, w6, , bytesread ) = 0 )
		#if sizeof(wstring) = 1
			CU_ASSERT( w6 = "12345" )
			CU_ASSERT( bytesread = 5 )
		#elseif sizeof(wstring) = 2
			CU_ASSERT( w6[0] = cvshort( "12" ) )
			CU_ASSERT( w6[1] = cvshort( "34" ) )
			CU_ASSERT( w6[2] = cvshort( "56" ) )
			CU_ASSERT( w6[3] = cvshort( "78" ) )
			CU_ASSERT( w6[4] = cvshort( "90" ) )
			CU_ASSERT( bytesread = 10 )
		#elseif sizeof(wstring) = 4
			CU_ASSERT( w6[0] = cvl( "1234" ) )
			CU_ASSERT( w6[1] = cvl( "5678" ) )
			CU_ASSERT( w6[2] = cvshort( "90" ) )
			CU_ASSERT( w6[3] = 0 )
			CU_ASSERT( w6[4] = 0 )
			CU_ASSERT( bytesread = 10 )
		#endif
		CU_ASSERT( w6[5] = 0 )

		bytesread = 0
		*pz6 = "00000"
		CU_ASSERT( get( #f, 1, *pz6, , bytesread ) = 0 )
		CU_ASSERT( *pz6 = "12345" )
		CU_ASSERT( bytesread = 5 )

		bytesread = 0
		*pw6 = "00000"
		CU_ASSERT( get( #f, 1, *pw6, , bytesread ) = 0 )
		#if sizeof(wstring) = 1
			CU_ASSERT( (*pw6) = "12345" )
			CU_ASSERT( bytesread = 5 )
		#elseif sizeof(wstring) = 2
			CU_ASSERT( (*pw6)[0] = cvshort( "12" ) )
			CU_ASSERT( (*pw6)[1] = cvshort( "34" ) )
			CU_ASSERT( (*pw6)[2] = cvshort( "56" ) )
			CU_ASSERT( (*pw6)[3] = cvshort( "78" ) )
			CU_ASSERT( (*pw6)[4] = cvshort( "90" ) )
			CU_ASSERT( bytesread = 10 )
		#elseif sizeof(wstring) = 4
			CU_ASSERT( (*pw6)[0] = cvl( "1234" ) )
			CU_ASSERT( (*pw6)[1] = cvl( "5678" ) )
			CU_ASSERT( (*pw6)[2] = cvshort( "90" ) )
			CU_ASSERT( (*pw6)[3] = 0 )
			CU_ASSERT( (*pw6)[4] = 0 )
			CU_ASSERT( bytesread = 10 )
		#endif
		CU_ASSERT( (*pw6)[5] = 0 )

		bytesread = 0
		CU_ASSERT( get( #f, 1, array4b(), , bytesread ) = 0 )
		CU_ASSERT( array4b(0) = asc( "1" ) )
		CU_ASSERT( array4b(1) = asc( "2" ) )
		CU_ASSERT( array4b(2) = asc( "3" ) )
		CU_ASSERT( array4b(3) = asc( "4" ) )
		CU_ASSERT( bytesread = 4 )

		bytesread = 0
		CU_ASSERT( get( #f, 1, array4l(), , bytesread ) = 0 )
		CU_ASSERT( array4l(0) = cvl( "1234" ) )
		CU_ASSERT( array4l(1) = cvl( "5678" ) )
		CU_ASSERT( array4l(2) = cvshort( "90" ) )
		CU_ASSERT( array4l(3) = 0 )
		CU_ASSERT( bytesread = 10 )

		''
		'' LONGINT offset
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
		z6 = ""
		w6 = wstr( "" )
		array4b(0) = 0
		array4b(1) = 0
		array4b(2) = 0
		array4b(3) = 0
		array4l(0) = 0
		array4l(1) = 0
		array4l(2) = 0
		array4l(3) = 0

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

		CU_ASSERT( get( #f, 1ll, z6 ) = 0 )
		CU_ASSERT( z6 = "12345" )

		CU_ASSERT( get( #f, 1ll, w6 ) = 0 )
		#if sizeof(wstring) = 1
			CU_ASSERT( w6 = "12345" )
		#elseif sizeof(wstring) = 2
			CU_ASSERT( w6[0] = cvshort( "12" ) )
			CU_ASSERT( w6[1] = cvshort( "34" ) )
			CU_ASSERT( w6[2] = cvshort( "56" ) )
			CU_ASSERT( w6[3] = cvshort( "78" ) )
			CU_ASSERT( w6[4] = cvshort( "90" ) )
		#elseif sizeof(wstring) = 4
			CU_ASSERT( w6[0] = cvl( "1234" ) )
			CU_ASSERT( w6[1] = cvl( "5678" ) )
			CU_ASSERT( w6[2] = cvshort( "90" ) )
			CU_ASSERT( w6[3] = 0 )
			CU_ASSERT( w6[4] = 0 )
		#endif
		CU_ASSERT( w6[5] = 0 )

		*pz6 = "00000"
		CU_ASSERT( get( #f, 1ll, *pz6 ) = 0 )
		CU_ASSERT( *pz6 = "12345" )

		*pw6 = "00000"
		CU_ASSERT( get( #f, 1ll, *pw6 ) = 0 )
		#if sizeof(wstring) = 1
			CU_ASSERT( (*pw6) = "12345" )
		#elseif sizeof(wstring) = 2
			CU_ASSERT( (*pw6)[0] = cvshort( "12" ) )
			CU_ASSERT( (*pw6)[1] = cvshort( "34" ) )
			CU_ASSERT( (*pw6)[2] = cvshort( "56" ) )
			CU_ASSERT( (*pw6)[3] = cvshort( "78" ) )
			CU_ASSERT( (*pw6)[4] = cvshort( "90" ) )
		#elseif sizeof(wstring) = 4
			CU_ASSERT( (*pw6)[0] = cvl( "1234" ) )
			CU_ASSERT( (*pw6)[1] = cvl( "5678" ) )
			CU_ASSERT( (*pw6)[2] = cvshort( "90" ) )
			CU_ASSERT( (*pw6)[3] = 0 )
			CU_ASSERT( (*pw6)[4] = 0 )
		#endif
		CU_ASSERT( (*pw6)[5] = 0 )

		CU_ASSERT( get( #f, 1ll, array4b() ) = 0 )
		CU_ASSERT( array4b(0) = asc( "1" ) )
		CU_ASSERT( array4b(1) = asc( "2" ) )
		CU_ASSERT( array4b(2) = asc( "3" ) )
		CU_ASSERT( array4b(3) = asc( "4" ) )

		CU_ASSERT( get( #f, 1ll, array4l() ) = 0 )
		CU_ASSERT( array4l(0) = cvl( "1234" ) )
		CU_ASSERT( array4l(1) = cvl( "5678" ) )
		CU_ASSERT( array4l(2) = cvshort( "90" ) )
		CU_ASSERT( array4l(3) = 0 )

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
		z6 = ""
		w6 = wstr( "" )
		array4b(0) = 0
		array4b(1) = 0
		array4b(2) = 0
		array4b(3) = 0
		array4l(0) = 0
		array4l(1) = 0
		array4l(2) = 0
		array4l(3) = 0

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
		CU_ASSERT( get( #f, 1ll, z6, , bytesread ) = 0 )
		CU_ASSERT( z6 = "12345" )
		CU_ASSERT( bytesread = 5 )

		bytesread = 0
		CU_ASSERT( get( #f, 1ll, w6, , bytesread ) = 0 )
		#if sizeof(wstring) = 1
			CU_ASSERT( w6 = "12345" )
			CU_ASSERT( bytesread = 5 )
		#elseif sizeof(wstring) = 2
			CU_ASSERT( w6[0] = cvshort( "12" ) )
			CU_ASSERT( w6[1] = cvshort( "34" ) )
			CU_ASSERT( w6[2] = cvshort( "56" ) )
			CU_ASSERT( w6[3] = cvshort( "78" ) )
			CU_ASSERT( w6[4] = cvshort( "90" ) )
			CU_ASSERT( bytesread = 10 )
		#elseif sizeof(wstring) = 4
			CU_ASSERT( w6[0] = cvl( "1234" ) )
			CU_ASSERT( w6[1] = cvl( "5678" ) )
			CU_ASSERT( w6[2] = cvshort( "90" ) )
			CU_ASSERT( w6[3] = 0 )
			CU_ASSERT( w6[4] = 0 )
			CU_ASSERT( bytesread = 10 )
		#endif
		CU_ASSERT( w6[5] = 0 )

		bytesread = 0
		*pz6 = "00000"
		CU_ASSERT( get( #f, 1ll, *pz6, , bytesread ) = 0 )
		CU_ASSERT( *pz6 = "12345" )
		CU_ASSERT( bytesread = 5 )

		bytesread = 0
		*pw6 = "00000"
		CU_ASSERT( get( #f, 1ll, *pw6, , bytesread ) = 0 )
		#if sizeof(wstring) = 1
			CU_ASSERT( (*pw6) = "12345" )
			CU_ASSERT( bytesread = 5 )
		#elseif sizeof(wstring) = 2
			CU_ASSERT( (*pw6)[0] = cvshort( "12" ) )
			CU_ASSERT( (*pw6)[1] = cvshort( "34" ) )
			CU_ASSERT( (*pw6)[2] = cvshort( "56" ) )
			CU_ASSERT( (*pw6)[3] = cvshort( "78" ) )
			CU_ASSERT( (*pw6)[4] = cvshort( "90" ) )
			CU_ASSERT( bytesread = 10 )
		#elseif sizeof(wstring) = 4
			CU_ASSERT( (*pw6)[0] = cvl( "1234" ) )
			CU_ASSERT( (*pw6)[1] = cvl( "5678" ) )
			CU_ASSERT( (*pw6)[2] = cvshort( "90" ) )
			CU_ASSERT( (*pw6)[3] = 0 )
			CU_ASSERT( (*pw6)[4] = 0 )
			CU_ASSERT( bytesread = 10 )
		#endif
		CU_ASSERT( (*pw6)[5] = 0 )

		bytesread = 0
		CU_ASSERT( get( #f, 1ll, array4b(), , bytesread ) = 0 )
		CU_ASSERT( array4b(0) = asc( "1" ) )
		CU_ASSERT( array4b(1) = asc( "2" ) )
		CU_ASSERT( array4b(2) = asc( "3" ) )
		CU_ASSERT( array4b(3) = asc( "4" ) )
		CU_ASSERT( bytesread = 4 )

		bytesread = 0
		CU_ASSERT( get( #f, 1ll, array4l(), , bytesread ) = 0 )
		CU_ASSERT( array4l(0) = cvl( "1234" ) )
		CU_ASSERT( array4l(1) = cvl( "5678" ) )
		CU_ASSERT( array4l(2) = cvshort( "90" ) )
		CU_ASSERT( array4l(3) = 0 )
		CU_ASSERT( bytesread = 10 )

		deallocate( pw6 )
		deallocate( pz6 )
		close #f
	END_TEST

	TEST( getWstrFill )
		for n as integer = 0 to sizeof(wstring) * 2
			const TESTFILE = "data.tmp"

			'' Create test file with N bytes
			scope
				if( kill( TESTFILE ) ) then
				end if
				var f = freefile( )
				if( open( TESTFILE, for binary, access write, as #f ) <> 0 ) then
					CU_FAIL( "could not create file " & TESTFILE )
				end if
				for i as integer = 0 to n - 1
					var b = cubyte( asc( "a" ) )
					put #f, , b
				next
				close #f
				CU_ASSERT( filelen( TESTFILE ) = n )
			end scope

			scope
				var f = freefile( )
				if( open( TESTFILE, for binary, access read, as #f ) <> 0 ) then
					CU_FAIL( "could not open file " & TESTFILE )
				end if

				dim w as wstring * 10
				'' Fill all bytes in the wstring buffer with '?'
				for i as integer = 0 to sizeof(w) - 1
					cptr( ubyte ptr, @w )[i] = asc( "?" )
				next

				'' Try a Get# wstring. It should read the 'a' bytes from
				'' the file, fill the last wchar's remaining bytes with
				'' zeroes if needed to round up to sizeof(wstring),
				'' and add a null terminator.
				dim bytesread as integer
				CU_ASSERT( get( #f, , w, , bytesread ) = 0 )
				CU_ASSERT( bytesread = n )

				'' Check whether it worked

				'' 'a' bytes as read from file
				for i as integer = 0 to n - 1
					CU_ASSERT( cptr( ubyte ptr, @w )[i] = asc( "a" ) )
				next

				'' zero bytes padding, if needed
				dim as integer extra = bytesread mod sizeof( wstring )
				if extra > 0 then
					bytesread += sizeof( wstring ) - extra '' round up
					for i as integer = n to bytesread - 1
						CU_ASSERT( cptr( ubyte ptr, @w )[i] = 0 )
					next
				end if

				'' null terminator
				CU_ASSERT( (bytesread mod sizeof( wstring )) = 0 )
				CU_ASSERT( w[bytesread \ sizeof( wstring )] = 0 )

				close #f
			end scope

			'' Delete test file
			CU_ASSERT( kill( TESTFILE ) = 0 )
		next
	END_TEST

END_SUITE
