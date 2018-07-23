# include "fbcunit.bi"

SUITE( fbc_tests.file_.large_dbl )

	dim shared as double correct(0 to 6) = {57847922012.0, 57847922012, 11940917156.0, 11940917156, 1194091715, 119409171, 11940917}
	
	TEST( doubleInput )
		Dim a As Double
		Open "./file/large_dbl.csv" For Input As 1
		for i as integer = 0 to 6
			Input #1, a
			CU_ASSERT( a = correct(i) )
		next
		Close 1
	END_TEST
	
END_SUITE
