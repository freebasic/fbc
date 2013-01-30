# include "fbcu.bi"

namespace fbc_tests.compound.if_

sub test_multiline_scope cdecl ()

	dim as integer a = 1, b = 2

	if 0 then
		dim as integer a = 3
		b = a
	elseif 1 then
		dim as integer a = 4
		b = a
	else
		dim as integer a = 5
		b = a
	end if

	CU_ASSERT_EQUAL( a, 1 )
	CU_ASSERT_EQUAL( b, 4 )

end sub

sub test_singleline_scope cdecl ()

	dim as integer a = 1, b = 2

	if 0 then _
		dim as integer a = 3: _
		b = a _
	else if 1 then _
		dim as integer a = 4: _
		b = a _
	else _
		dim as integer a = 5: _
		b = a

	CU_ASSERT_EQUAL( a, 1 )
	CU_ASSERT_EQUAL( b, 4 )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.compound.if_")
	fbcu.add_test("test single-line if scope", @test_singleline_scope)
	fbcu.add_test("test multi-line if scope", @test_multiline_scope)

end sub

end namespace
