# include "fbcu.bi"

namespace fbc_tests.wstrings.instr_X

private sub wholeStringTest cdecl ()

	CU_ASSERT_EQUAL( 0 , instr(wstr("yd"+chr(0)), any wstr(chr(0))) )
	CU_ASSERT_EQUAL( 0 , instr(wstr("yd"+chr(0)), any wstr(chr(0)+"d")) )
	CU_ASSERT_EQUAL( 2 , instr(wstr("yd"+chr(0)), any wstr("d"+chr(0))) )
	CU_ASSERT_EQUAL( 2 , instr(wstr("yd"+chr(0)), any wstr("zd"+chr(0))) )
	CU_ASSERT_EQUAL( 2 , instr(wstr("yd"+chr(0)), any wstr("dz"+chr(0))) )
	CU_ASSERT_EQUAL( 0 , instr(wstr("yd"+chr(0)+"x"), any wstr("x"+chr(0))) )
	CU_ASSERT_EQUAL( 0 , instr(wstr("yd"+chr(0)+"x"), any wstr("")) )
	CU_ASSERT_EQUAL( 0 , instr(wstr("yd"+chr(0)+"x"), any wstr("q")) )
	CU_ASSERT_EQUAL( 0 , instr(wstr("yd"+chr(0)+"x"), any wstr("qb")) )

end sub

private sub partialStringTest cdecl ()

	CU_ASSERT_EQUAL( 0 , instr(2, wstr("yd"+chr(0)), any wstr(chr(0))) )
	CU_ASSERT_EQUAL( 0 , instr(2, wstr("yd"+chr(0)), any wstr(chr(0)+"d")) )
	CU_ASSERT_EQUAL( 2 , instr(2, wstr("yd"+chr(0)), any wstr("d"+chr(0))) )
	CU_ASSERT_EQUAL( 2 , instr(2, wstr("yd"+chr(0)), any wstr("zd"+chr(0))) )
	CU_ASSERT_EQUAL( 2 , instr(2, wstr("yd"+chr(0)), any wstr("dz"+chr(0))) )
	CU_ASSERT_EQUAL( 0 , instr(2, wstr("yd"+chr(0)+"x"), any wstr("x"+chr(0))) )
	CU_ASSERT_EQUAL( 0 , instr(2, wstr("yd"+chr(0)+"x"), any wstr("")) )
	CU_ASSERT_EQUAL( 0 , instr(2, wstr("yd"+chr(0)+"x"), any wstr("q")) )
	CU_ASSERT_EQUAL( 0 , instr(2, wstr("yd"+chr(0)+"x"), any wstr("qb")) )
	CU_ASSERT_EQUAL( 0 , instr(3, wstr("yd"+chr(0)+"x"), any wstr("d"+chr(0))) )

end sub

#define DoTest( s1, s2, start, exp_result ) _
	CU_ASSERT_EQUAL( exp_result, Instr(start,wstr(s1),ANY wstr(s2)) )

private sub CheckEveryInputValueTest cdecl ()

	dim a as string 
	dim b as string 

	a = "thes is the the strint"
	b = "the"

	DoTest( a, b, 23, 0 )
	DoTest( a, b, 22, 22 )
	DoTest( a, b, 21, 22 )
	DoTest( a, b, 20, 22 )
	DoTest( a, b, 19, 22 )
	DoTest( a, b, 18, 18 )
	DoTest( a, b, 17, 18 )
	DoTest( a, b, 16, 18 )
	DoTest( a, b, 15, 15 )
	DoTest( a, b, 14, 14 )
	DoTest( a, b, 13, 13 )
	DoTest( a, b, 12, 13 )
	DoTest( a, b, 11, 11 )
	DoTest( a, b, 10, 10 )
	DoTest( a, b, 9, 9 )
	DoTest( a, b, 8, 9 )
	DoTest( a, b, 7, 9 )
	DoTest( a, b, 6, 9 )
	DoTest( a, b, 5, 9 )
	DoTest( a, b, 4, 9 )
	DoTest( a, b, 3, 3 )
	DoTest( a, b, 2, 2 )
	DoTest( a, b, 1, 1 )
	DoTest( a, b, 0, 0 )
	DoTest( a, b, -1, 0 )

	a = "xxx the"
	b = "the"

	DoTest( a, b, 8, 0 )
	DoTest( a, b, 7, 7 )
	DoTest( a, b, 6, 6 )
	DoTest( a, b, 5, 5 )
	DoTest( a, b, 4, 5 )
	DoTest( a, b, 3, 5 )
	DoTest( a, b, 2, 5 )
	DoTest( a, b, 1, 5 )
	DoTest( a, b, 0, 0 )
	DoTest( a, b, -1, 0 )

	a = "the xxx"
	b = "the"

	DoTest( a, b, 8, 0 )
	DoTest( a, b, 7, 0 )
	DoTest( a, b, 6, 0 )
	DoTest( a, b, 5, 0 )
	DoTest( a, b, 4, 0 )
	DoTest( a, b, 3, 3 )
	DoTest( a, b, 2, 2 )
	DoTest( a, b, 1, 1 )
	DoTest( a, b, 0, 0 )
	DoTest( a, b, -1, 0 )

	a = "xxx"
	b = "xxx"

	DoTest( "", "", 0, 0 )
	DoTest( a , "", 0, 0 )
	DoTest( "",  b, 0, 0 )

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.wstrings.instr_X")
	fbcu.add_test("whole string test", @wholeStringTest)
	fbcu.add_test("partial string test", @partialStringTest)
	fbcu.add_test("check every input value test", @CheckEveryInputValueTest)

end sub

end namespace
