# include "fbcu.bi"




namespace fbc_tests.string_.mkcv

sub mkConstTest cdecl ()

	dim as string ss, si, sl, sll 'MK* constants not supported yet

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

	const as longint s  = cvshort(   "ABCDEFGH" )
	const as longint i  = cvi(       "ABCDEFGH" )
	const as longint l  = cvl(       "ABCDEFGH" )
	const as longint ll = cvlongint( "ABCDEFGH" )

	CU_ASSERT_EQUAL( s,              &h4241 )
	CU_ASSERT_EQUAL( i,          &h44434241 )
	CU_ASSERT_EQUAL( l,          &h44434241 )
	CU_ASSERT_EQUAL( ll, &h4847464544434241 )

end sub

sub cvVarTest cdecl ()

	dim as string sll = "ABCDEFGH"

	dim as longint s  = cvshort(   sll )
	dim as longint i  = cvi(       sll )
	dim as longint l  = cvl(       sll )
	dim as longint ll = cvlongint( sll )

	CU_ASSERT_EQUAL( s,              &h4241 )
	CU_ASSERT_EQUAL( i,          &h44434241 )
	CU_ASSERT_EQUAL( l,          &h44434241 )
	CU_ASSERT_EQUAL( ll, &h4847464544434241 )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.string_.mkcv")
	fbcu.add_test("mkConstTest", @mkConstTest)
	fbcu.add_test("mkVarTest", @mkVarTest)
	fbcu.add_test("cvConstTest", @cvConstTest)
	fbcu.add_test("cvVarTest", @cvVarTest)

end sub

end namespace
