#include "fbcunit.bi"

SUITE( fbc_tests.wstring_.instrrev_x )

	TEST( wholeString )

		CU_ASSERT_EQUAL( 0 , instrrev(wstr("yd"+chr(0)), any wstr(chr(0))) )
		CU_ASSERT_EQUAL( 0 , instrrev(wstr("yd"+chr(0)), any wstr(chr(0)+"d")) )
		CU_ASSERT_EQUAL( 2 , instrrev(wstr("yd"+chr(0)), any wstr("d"+chr(0))) )
		CU_ASSERT_EQUAL( 2 , instrrev(wstr("yd"+chr(0)), any wstr("dz"+chr(0))) )
		CU_ASSERT_EQUAL( 2 , instrrev(wstr("yd"+chr(0)), any wstr("zd"+chr(0))) )
		CU_ASSERT_EQUAL( 0 , instrrev(wstr("yd"+chr(0)+"x"), any wstr("x"+chr(0))) )
		CU_ASSERT_EQUAL( 2 , instrrev(wstr("yd"+chr(0)+"x"), any wstr("d"+chr(0))) )
		CU_ASSERT_EQUAL( 0 , instrrev(wstr("yd"+chr(0)+"x"), any wstr("")) )
		CU_ASSERT_EQUAL( 0 , instrrev(wstr("yd"+chr(0)+"x"), any wstr("q")) )
		CU_ASSERT_EQUAL( 0 , instrrev(wstr("yd"+chr(0)+"x"), any wstr("qb")) )

	END_TEST

	TEST( partialString )

		CU_ASSERT_EQUAL( 0 , instrrev(wstr("yd"+chr(0)), any wstr(chr(0)), 2) )
		CU_ASSERT_EQUAL( 0 , instrrev(wstr("yd"+chr(0)), any wstr(chr(0)+"d"), 2) )
		CU_ASSERT_EQUAL( 2 , instrrev(wstr("yd"+chr(0)), any wstr("d"+chr(0)), 2) )
		CU_ASSERT_EQUAL( 0 , instrrev(wstr("yd"+chr(0)+"x"), any wstr("x"+chr(0)), 2) )
		CU_ASSERT_EQUAL( 2 , instrrev(wstr("yd"+chr(0)+"x"), any wstr("d"+chr(0)), 2) )
		CU_ASSERT_EQUAL( 0 , instrrev(wstr("yd"+chr(0)+"x"), any wstr(""), 2) )
		CU_ASSERT_EQUAL( 0 , instrrev(wstr("yd"+chr(0)+"x"), any wstr("q"), 2) )
		CU_ASSERT_EQUAL( 0 , instrrev(wstr("yd"+chr(0)+"x"), any wstr("qb"), 2) )
		CU_ASSERT_EQUAL( 0 , instrrev(wstr("yd"+chr(0)+"x"), any wstr("x"+chr(0)), 2) )
		CU_ASSERT_EQUAL( 2 , instrrev(wstr("yd"+chr(0)+"x"), any wstr("d"+chr(0)), 2) )

	END_TEST

	#define DoTest( s1, s2, start, exp_result ) _
		CU_ASSERT_EQUAL( exp_result, InstrRev(wstr(s1),ANY wstr(s2),start) )

	TEST( checkEveryInputValue )

		dim a as string 
		dim b as string

		a = "thes is the the strint"
		b = "the"

		DoTest( a, b, 23, 0 )
		DoTest( a, b, 22, 22 )
		DoTest( a, b, 21, 18 )
		DoTest( a, b, 20, 18 )
		DoTest( a, b, 19, 18 )
		DoTest( a, b, 18, 18 )
		DoTest( a, b, 17, 15 )
		DoTest( a, b, 16, 15 )
		DoTest( a, b, 15, 15 )
		DoTest( a, b, 14, 14 )
		DoTest( a, b, 13, 13 )
		DoTest( a, b, 12, 11 )
		DoTest( a, b, 11, 11 )
		DoTest( a, b, 10, 10 )
		DoTest( a, b, 9, 9 )
		DoTest( a, b, 8, 3 )
		DoTest( a, b, 7, 3 )
		DoTest( a, b, 6, 3 )
		DoTest( a, b, 5, 3 )
		DoTest( a, b, 4, 3 )
		DoTest( a, b, 3, 3 )
		DoTest( a, b, 2, 2 )
		DoTest( a, b, 1, 1 )
		DoTest( a, b, 0, 0 )
		DoTest( a, b, -1, 22 )

		a = "xxx the"
		b = "the"

		DoTest( a, b, 8, 0 )
		DoTest( a, b, 7, 7 )
		DoTest( a, b, 6, 6 )
		DoTest( a, b, 5, 5 )
		DoTest( a, b, 4, 0 )
		DoTest( a, b, 3, 0 )
		DoTest( a, b, 2, 0 )
		DoTest( a, b, 1, 0 )
		DoTest( a, b, 0, 0 )
		DoTest( a, b, -1, 7 )

		a = "xxx"
		b = "xxx"

		DoTest( "", "", 0, 0 )
		DoTest( a , "", 0, 0 )
		DoTest( "",  b, 0, 0 )

	END_TEST

END_SUITE
