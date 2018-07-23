#include "fbcunit.bi"

SUITE( fbc_tests.structs.bitfield_logic )

	Type mytype
		flag_0 : 1 As Integer
		flag_1 : 1 As Integer
		flag_2 : 1 As Integer
	End Type

	TEST( all )
		Dim t As mytype

		t.flag_0 = 1
		t.flag_1 = 0
		t.flag_2 = 1

		CU_ASSERT( (t.flag_0 And t.flag_1 And t.flag_2) = 0 )
		CU_ASSERT( (t.flag_0 And t.flag_2) <> 0 )
	END_TEST

END_SUITE
