# include "fbcu.bi"

namespace fbc_tests.string_.instr_0

private sub wholeStringTest cdecl ()

	CU_ASSERT_EQUAL( 4, instr("asd"+chr(0), chr(0)) )
	CU_ASSERT_EQUAL( 3, instr("asd"+chr(0), "d") )
	CU_ASSERT_EQUAL( 1, instr("asd"+chr(0), "a") )
	CU_ASSERT_EQUAL( 2, instr("asd"+chr(0), "sd") )
	CU_ASSERT_EQUAL( 0, instr("asd"+chr(0), "") )
	CU_ASSERT_EQUAL( 0, instr("asd"+chr(0), "asdfg") )
	CU_ASSERT_EQUAL( 0, instr("asd"+chr(0), "qwe") )
	CU_ASSERT_EQUAL( 0, instr("", "asdf") )
	CU_ASSERT_EQUAL( 0, instr("", "") )

end sub

private sub partialStringTest cdecl ()

	CU_ASSERT_EQUAL( 4, instr(2, "asd"+chr(0), chr(0)) )
	CU_ASSERT_EQUAL( 3, instr(2, "asd"+chr(0), "d") )
	CU_ASSERT_EQUAL( 0, instr(2, "asd"+chr(0), "a") )
	CU_ASSERT_EQUAL( 2, instr(2, "asd"+chr(0), "sd") )
	CU_ASSERT_EQUAL( 0, instr(2, "asd"+chr(0), "") )
	CU_ASSERT_EQUAL( 0, instr(2, "asd"+chr(0), "asdfg") )
	CU_ASSERT_EQUAL( 0, instr(2, "asd"+chr(0), "qwe") )
	CU_ASSERT_EQUAL( 0, instr(2, "", "asdf") )
	CU_ASSERT_EQUAL( 0, instr(2, "", "") )

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.string_.instr_0")
	fbcu.add_test("whole string test", @wholeStringTest)
	fbcu.add_test("partial string test", @partialStringTest)

end sub

end namespace
