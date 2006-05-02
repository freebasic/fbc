option explicit

const FALSE = 0
const TRUE = not FALSE

''::::
sub test_single_1( )

const TEST = 100
	
	dim as integer v = TEST
	dim as integer ok
	
	select case as const v
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
	
	assert( ok = TRUE )

end sub

''::::
sub test_single_2( )

const TEST = 1000
	
	dim as integer v = TEST
	dim as integer ok
	
	select case as const v
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
	
	assert( ok = TRUE )

end sub

''::::
sub test_range_1( )

const TEST = 100
	
	dim as integer v = TEST
	dim as integer ok
	
	select case as const v
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
	
	assert( ok = TRUE )

end sub

''::::
sub test_range_2( )

const TEST = 1000
	
	dim as integer v = TEST
	dim as integer ok
	
	select case as const v
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
	
	assert( ok = TRUE )

end sub

	test_single_1
	test_single_2
	test_range_1
	test_range_2
