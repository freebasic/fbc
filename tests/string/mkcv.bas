# include "fbcu.bi"




namespace fbc_tests.string_.mkcv

sub mkConstTest cdecl ()

	''note: MK* constants not supported yet

	dim as string ss, si, sl, sll

	ss  = mkshort(   &h4847464544434241ll )
	si  = mki(       &h4847464544434241ll )
	sl  = mkl(       &h4847464544434241ll )
	sll = mklongint( &h4847464544434241ll )

	CU_ASSERT_EQUAL( ss,  "AB" )
	CU_ASSERT_EQUAL( si,  "ABCD" )
	CU_ASSERT_EQUAL( sl,  "ABCD" )
	CU_ASSERT_EQUAL( sll, "ABCDEFGH" )

end sub

sub mkVarTest cdecl ()

	dim as string ss, si, sl, sll
	dim as longint ll = &h4847464544434241ll

	ss  = mkshort(   ll )
	si  = mki(       ll )
	sl  = mkl(       ll )
	sll = mklongint( ll )

	CU_ASSERT_EQUAL( ss,  "AB" )
	CU_ASSERT_EQUAL( si,  "ABCD" )
	CU_ASSERT_EQUAL( sl,  "ABCD" )
	CU_ASSERT_EQUAL( sll, "ABCDEFGH" )

end sub

sub cvConstTest cdecl ()

	const as longint sh = cvshort(   "ABCDEFGH" )
	const as longint i  = cvi(       "ABCDEFGH" )
	const as longint l  = cvl(       "ABCDEFGH" )
	const as longint ll = cvlongint( "ABCDEFGH" )

	#define s cvs( "ABCDEFGH" ) '' floating-point constants not supported yet
	#define d cvd( "ABCDEFGH" )

	CU_ASSERT_EQUAL( sh,             &h4241 )
	CU_ASSERT_EQUAL( i,          &h44434241 )
	CU_ASSERT_EQUAL( l,          &h44434241 )
	CU_ASSERT_EQUAL( ll, &h4847464544434241 )

	CU_ASSERT_EQUAL( s, 781.03521! )
	CU_ASSERT_EQUAL( d, 1.5839800103804824e+40 )

end sub

sub cvVarTest cdecl ()

	dim as string sll = "ABCDEFGH"

	dim as longint sh = cvshort(   sll )
	dim as longint i  = cvi(       sll )
	dim as longint l  = cvl(       sll )
	dim as longint ll = cvlongint( sll )

	dim as single s = cvs( sll )
	dim as double d = cvd( sll )

	CU_ASSERT_EQUAL( sh,             &h4241 )
	CU_ASSERT_EQUAL( i,          &h44434241 )
	CU_ASSERT_EQUAL( l,          &h44434241 )
	CU_ASSERT_EQUAL( ll, &h4847464544434241 )

	CU_ASSERT_EQUAL( s, 781.03521! )
	CU_ASSERT_EQUAL( d, 1.5839800103804824e+40 )

end sub

sub cvNumTest cdecl ()

	dim as longint i  = cvi( 781.03521! )
	dim as longint l  = cvl( 781.03521! )
	dim as longint ll = cvlongint( 1.5839800103804824e+40 )

	dim as single s  = cvs( &H44434241 )
	dim as double d  = cvd( &H4847464544434241 )

	CU_ASSERT_EQUAL( s,             781.03521! )
	CU_ASSERT_EQUAL( i,             &h44434241 )
	CU_ASSERT_EQUAL( l,             &h44434241 )
	CU_ASSERT_EQUAL( d, 1.5839800103804824e+40 )
	CU_ASSERT_EQUAL( ll,    &h4847464544434241 )

	CU_ASSERT_EQUAL( mks( s ), mkl( l ) )
	CU_ASSERT_EQUAL( mkd( d ), mklongint( ll ) )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.string_.mkcv")
	fbcu.add_test("mkConstTest", @mkConstTest)
	fbcu.add_test("mkVarTest", @mkVarTest)
	fbcu.add_test("cvConstTest", @cvConstTest)
	fbcu.add_test("cvVarTest", @cvVarTest)
	fbcu.add_test("cvNumTest", @cvNumTest)

end sub

end namespace
