# include "fbcu.bi"



namespace fbc_tests.pointers.arith
	
	dim shared as integer ptr p1, p2, tb
	
sub pointerDiffTest cdecl ()
	CU_ASSERT_EQUAL( p2 - p1, 1 )
	CU_ASSERT_EQUAL( p1 - p2, -1 )
	CU_ASSERT( sizeof( p2 - p1 ) >= sizeof( p2 ) )
end sub
	 
sub integralAdditionTest cdecl ()
	CU_ASSERT_EQUAL( p1 + 1, @tb[1] )
end sub

sub integralAdditionAssignmentTest cdecl ()
	p1 += 1
	CU_ASSERT_EQUAL( p1, @tb[1] )
end sub

sub integralSubtractionTest cdecl ()
	CU_ASSERT_EQUAL( p2 - 1, @tb[0] )
end sub

sub integralSubtractionAssignmentTest cdecl ()
	p2 -= 1
	CU_ASSERT_EQUAL( p2, @tb[0] )
end sub

private function init cdecl () as integer

	tb = allocate(2 * sizeof(integer))
	if (0 = tb) then
		return -1
	end if

	p1 = @tb[0]
	p2 = @tb[1]

	return 0

end function

private function cleanup cdecl () as integer

	deallocate(tb)
	return 0

end function

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.pointers.arith", @init)
	fbcu.add_test("pointerDiffTest", @pointerDiffTest)
	fbcu.add_test("integralAdditionTest", @integralAdditionTest)
	fbcu.add_test("integralAdditionAssignmentTest", @integralAdditionAssignmentTest)
	fbcu.add_test("integralSubtractionTest", @integralSubtractionTest)
	fbcu.add_test("integralSubtractionAssignmentTest", @integralSubtractionAssignmentTest)

end sub

end namespace
