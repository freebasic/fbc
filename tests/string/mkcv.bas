#include "fbcunit.bi"

SUITE( fbc_tests.string_.mkcv )

	TEST( mkConstTest )

		''note: MK* constants not supported yet

		dim as string ss, si, sl, sll
		dim as string si16, si32, si64

		ss  = mkshort(   &h4847464544434241ll )
		si  = mki(       &h4847464544434241ll )
		sl  = mkl(       &h4847464544434241ll )
		sll = mklongint( &h4847464544434241ll )
		
		si16 = mki<16>( &h4847464544434241ll )
		si32 = mki<32>( &h4847464544434241ll )
		si64 = mki<64>( &h4847464544434241ll )

		CU_ASSERT_EQUAL( ss,  "AB" )
	#ifdef __FB_64BIT__
		CU_ASSERT_EQUAL( si,  "ABCDEFGH" )
	#else
		CU_ASSERT_EQUAL( si,  "ABCD" )
	#endif
		CU_ASSERT_EQUAL( sl,  "ABCD" )
		CU_ASSERT_EQUAL( sll, "ABCDEFGH" )

		CU_ASSERT_EQUAL( si16, "AB" )
		CU_ASSERT_EQUAL( si32, "ABCD" )
		CU_ASSERT_EQUAL( si64, "ABCDEFGH" )

	END_TEST

	TEST( mkVarTest )

		dim as string ss, si, sl, sll
		dim as string si16, si32, si64
		dim as longint ll = &h4847464544434241ll

		ss  = mkshort(   ll )
		si  = mki(       ll )
		sl  = mkl(       ll )
		sll = mklongint( ll )
		
		si16 = mki<16>( ll )
		si32 = mki<32>( ll )
		si64 = mki<64>( ll )

		CU_ASSERT_EQUAL( ss,  "AB" )
	#ifdef __FB_64BIT__
		CU_ASSERT_EQUAL( si,  "ABCDEFGH" )
	#else
		CU_ASSERT_EQUAL( si,  "ABCD" )
	#endif
		CU_ASSERT_EQUAL( sl,  "ABCD" )
		CU_ASSERT_EQUAL( sll, "ABCDEFGH" )

		CU_ASSERT_EQUAL( si16, "AB" )
		CU_ASSERT_EQUAL( si32, "ABCD" )
		CU_ASSERT_EQUAL( si64, "ABCDEFGH" )

	END_TEST

	TEST( cvConstTest )

		const as longint SH = cvshort(   "ABCDEFGH" )
		const as longint I  = cvi(       "ABCDEFGH" )
		const as longint L  = cvl(       "ABCDEFGH" )
		const as longint LL = cvlongint( "ABCDEFGH" )

		const as longint I16  = cvi<16>( "ABCDEFGH" )
		const as longint I32  = cvi<32>( "ABCDEFGH" )
		const as longint I64  = cvi<64>( "ABCDEFGH" )

		#define S cvs( "ABCDEFGH" ) '' floating-point constants not supported yet
		#define D cvd( "ABCDEFGH" )

		CU_ASSERT_EQUAL( SH,             &h4241 )
	#ifdef __FB_64BIT__
		CU_ASSERT_EQUAL( I,  &h4847464544434241 )
	#else
		CU_ASSERT_EQUAL( I,          &h44434241 )
	#endif
		CU_ASSERT_EQUAL( L,          &h44434241 )
		CU_ASSERT_EQUAL( LL, &h4847464544434241 )

		CU_ASSERT_EQUAL( I16,             &h4241 )
		CU_ASSERT_EQUAL( I32,          &h44434241 )
		CU_ASSERT_EQUAL( I64, &h4847464544434241 )

		CU_ASSERT_EQUAL( S, 781.03521! )
		CU_ASSERT_EQUAL( D, 1.5839800103804824e+40 )

	END_TEST

	TEST( cvVarTest )

		dim as string sll = "ABCDEFGH"

		dim as longint sh = cvshort(   sll )
		dim as longint i  = cvi(       sll )
		dim as longint l  = cvl(       sll )
		dim as longint ll = cvlongint( sll )

		dim as longint i16 = cvi<16>( sll )
		dim as longint i32 = cvi<32>( sll )
		dim as longint i64 = cvi<64>( sll )

		dim as single s = cvs( sll )
		dim as double d = cvd( sll )

		CU_ASSERT_EQUAL( sh,             &h4241 )
	#ifdef __FB_64BIT__
		CU_ASSERT_EQUAL( i,  &h4847464544434241 )
	#else
		CU_ASSERT_EQUAL( i,          &h44434241 )
	#endif
		CU_ASSERT_EQUAL( l,          &h44434241 )
		CU_ASSERT_EQUAL( ll, &h4847464544434241 )

		CU_ASSERT_EQUAL( i16,             &h4241 )
		CU_ASSERT_EQUAL( i32,         &h44434241 )
		CU_ASSERT_EQUAL( i64, &h4847464544434241 )

		CU_ASSERT_EQUAL( s, 781.03521! )
		CU_ASSERT_EQUAL( d, 1.5839800103804824e+40 )

	END_TEST

	TEST( cvNumTest )

	#ifdef __FB_64BIT__
		dim as longint i  = cvi( 1.5839800103804824e+40 )
	#else
		dim as longint i  = cvi( 781.03521! )
	#endif
		dim as longint l  = cvl( 781.03521! )
		dim as longint ll = cvlongint( 1.5839800103804824e+40 )

		dim as longint i32 = cvi<32>( 781.03521! )
		dim as longint i64 = cvi<64>( 1.5839800103804824e+40 )

		dim as single s  = cvs( &H44434241 )
		dim as double d  = cvd( &H4847464544434241 )

		CU_ASSERT_EQUAL( s,             781.03521! )
	#ifdef __FB_64BIT__
		CU_ASSERT_EQUAL( i,     &h4847464544434241 )
	#else
		CU_ASSERT_EQUAL( i,             &h44434241 )
	#endif
		CU_ASSERT_EQUAL( l,             &h44434241 )
		CU_ASSERT_EQUAL( d, 1.5839800103804824e+40 )
		CU_ASSERT_EQUAL( ll,    &h4847464544434241 )

		CU_ASSERT_EQUAL( i32,         &h44434241 )
		CU_ASSERT_EQUAL( i64, &h4847464544434241 )
		
		CU_ASSERT_EQUAL( mks( s ), mkl( l ) )
		CU_ASSERT_EQUAL( mkd( d ), mklongint( ll ) )

	END_TEST

END_SUITE
