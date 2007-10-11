# include "fbcu.bi"




namespace fbc_tests.compound.select_

const FALSE = 0
const TRUE = not FALSE

''::::
sub test_single_1 cdecl ( )

const TEST = 100
	
	dim as integer v = TEST
	dim as integer ok
	
	select case v
	case TEST - 5
		ok = FALSE
	case TEST - 4
		ok = FALSE
	case TEST - 3
		ok = FALSE
	case TEST - 2
		ok = FALSE
	case TEST - 1
		ok = FALSE
	case TEST + 1
		ok = FALSE
	case TEST + 2
		ok = FALSE
	case TEST + 3
		ok = FALSE
	case TEST + 4
		ok = FALSE
	case TEST + 5
		ok = FALSE
	case TEST
		ok = TRUE
	case else
		ok = FALSE
	end select
	
	CU_ASSERT_EQUAL( ok, TRUE )

end sub

''::::
sub test_single_2 cdecl ( )

const TEST = -100
	
	dim as integer v = TEST
	dim as integer ok
	
	select case v
	case TEST - 5, TEST - 6, TEST - 7, TEST - 8
		ok = FALSE
	case TEST - 4, TEST - 5, TEST - 6
		ok = FALSE
	case TEST - 3, TEST - 4
		ok = FALSE
	case TEST - 2
		ok = FALSE
	case TEST - 1
		ok = FALSE
	case TEST + 1
		ok = FALSE
	case TEST + 2
		ok = FALSE
	case TEST + 3, TEST + 4
		ok = FALSE
	case TEST + 4, TEST + 5, TEST + 6
		ok = FALSE
	case TEST + 5, TEST + 6, TEST + 7, TEST + 8
		ok = FALSE
	case TEST
		ok = TRUE
	case else
		ok = FALSE
	end select
	
	CU_ASSERT_EQUAL( ok, TRUE )

end sub

''::::
sub test_range_1 cdecl ( )

const TEST = 100
	
	dim as integer v = TEST
	dim as integer ok
	
	select case v
	case TEST - 8 to TEST - 5
		ok = FALSE
	case TEST - 6 to TEST - 4
		ok = FALSE
	case TEST - 4 to TEST - 3
		ok = FALSE
	case TEST - 2 to TEST - 2
		ok = FALSE
	case TEST - 1 
		ok = FALSE
	case TEST + 1
		ok = FALSE
	case TEST + 2 to TEST + 2
		ok = FALSE
	case TEST + 3 to TEST + 4
		ok = FALSE
	case TEST + 4 to TEST + 6
		ok = FALSE
	case TEST + 5 to TEST + 8
		ok = FALSE
	case TEST - 1 to TEST + 1
		ok = TRUE
	case else
		ok = FALSE
	end select
	
	CU_ASSERT_EQUAL( ok, TRUE )

end sub

''::::
sub test_range_2 cdecl ( )

const TEST = -100
	
	dim as integer v = TEST
	dim as integer ok
	
	select case v
	case TEST - 8 to TEST - 5, TEST - 12 to TEST - 9
		ok = FALSE
	case TEST - 6 to TEST - 4, TEST - 7 to TEST - 5
		ok = FALSE
	case TEST - 4 to TEST - 3, TEST - 5 to TEST - 4
		ok = FALSE
	case TEST - 2 to TEST - 2
		ok = FALSE
	case TEST - 1 
		ok = FALSE
	case TEST + 1
		ok = FALSE
	case TEST + 2 to TEST + 2
		ok = FALSE
	case TEST + 3 to TEST + 4, TEST + 4 to TEST + 5
		ok = FALSE
	case TEST + 4 to TEST + 6, TEST + 4 to TEST + 7
		ok = FALSE
	case TEST + 5 to TEST + 8, TEST + 9 to TEST + 12
		ok = FALSE
	case TEST - 1 to TEST + 1
		ok = TRUE
	case else
		ok = FALSE
	end select
	
	CU_ASSERT_EQUAL( ok, TRUE )

end sub

''::::
sub test_is_1 cdecl ( )

const TEST = 100
	
	dim as integer v = TEST
	dim as integer ok
	
	select case v
	case is < TEST - 5
		ok = FALSE
	case is <= TEST - 4
		ok = FALSE
	case is < TEST - 3
		ok = FALSE
	case is < TEST - 2
		ok = FALSE
	case is <= TEST - 1
		ok = FALSE
	case is > TEST + 1
		ok = FALSE
	case is >= TEST + 2
		ok = FALSE
	case is > TEST + 3
		ok = FALSE
	case is >= TEST + 4
		ok = FALSE
	case is > TEST + 5
		ok = FALSE
	case is >= TEST
		ok = TRUE
	case else
		ok = FALSE
	end select
	
	CU_ASSERT_EQUAL( ok, TRUE )

end sub

''::::
sub test_is_2 cdecl ( )

const TEST = -100
	
	dim as integer v = TEST
	dim as integer ok
	
	select case v
	case is < TEST - 5, is < TEST - 6, is < TEST - 7, is < TEST - 8
		ok = FALSE
	case is <= TEST - 4, is <= TEST - 5, is <= TEST - 6
		ok = FALSE
	case is < TEST - 3, is < TEST - 4
		ok = FALSE
	case is < TEST - 2
		ok = FALSE
	case is <= TEST - 1
		ok = FALSE
	case is > TEST + 1
		ok = FALSE
	case is >= TEST + 2
		ok = FALSE
	case is > TEST + 3, is > TEST + 4
		ok = FALSE
	case is >= TEST + 4, is >= TEST + 5, is >= TEST + 6
		ok = FALSE
	case is > TEST + 5, is > TEST + 6, is > TEST + 7, is > TEST + 8
		ok = FALSE
	case is <= TEST
		ok = TRUE
	case else
		ok = FALSE
	end select
	
	CU_ASSERT_EQUAL( ok, TRUE )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests-compound:select")
	fbcu.add_test("test single1", @test_single_1)
	fbcu.add_test("test single2", @test_single_2)
	fbcu.add_test("test range1", @test_range_1)
	fbcu.add_test("test range2", @test_range_2)
	fbcu.add_test("test is1", @test_is_1)
	fbcu.add_test("test is2", @test_is_2)

end sub

end namespace
