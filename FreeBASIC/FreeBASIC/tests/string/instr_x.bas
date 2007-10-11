# include "fbcu.bi"



'option escape

namespace fbc_tests.string_.instr_0

sub wholeStringTest cdecl ()

	CU_ASSERT( 2 = instr("d"+chr(0), any chr(0)) )
	CU_ASSERT( 1 = instr("d"+chr(0), any chr(0)+"d") )
	CU_ASSERT( 1 = instr("d"+chr(0), any "d"+chr(0)) )
	CU_ASSERT( 2 = instr("d"+chr(0)+"x", any "x"+chr(0)) )
	CU_ASSERT( 1 = instr("d"+chr(0)+"x", any "") )
	CU_ASSERT( 0 = instr("d"+chr(0)+"x", any "q") )
	CU_ASSERT( 0 = instr("d"+chr(0)+"x", any "qb") )

end sub

sub partialStringTest cdecl ()

	CU_ASSERT( 2 = instr(2, "d"+chr(0), any chr(0)) )
	CU_ASSERT( 2 = instr(2, "d"+chr(0), any chr(0)+"d") )
	CU_ASSERT( 2 = instr(2, "d"+chr(0), any "d"+chr(0)) )
	CU_ASSERT( 2 = instr(2, "d"+chr(0)+"x", any "x"+chr(0)) )
	CU_ASSERT( 2 = instr(2, "d"+chr(0)+"x", any "") )
	CU_ASSERT( 0 = instr(2, "d"+chr(0)+"x", any "q") )
	CU_ASSERT( 0 = instr(2, "d"+chr(0)+"x", any "qb") )
	CU_ASSERT( 0 = instr(3, "d"+chr(0)+"x", any "d"+chr(0)) )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.string_.instr_X")
	fbcu.add_test("whole string test", @wholeStringTest)
	fbcu.add_test("partial string test", @partialStringTest)

end sub

end namespace
