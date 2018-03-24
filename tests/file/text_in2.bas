# include "fbcunit.bi"

SUITE( fbc_tests.file_.text_in2 )

	const filename = "file\text_in2.txt"

	TEST( lineInputCountLines )
		
		dim as integer lines = 0
		dim as string ln
		
		open filename for input as #1 
		
		do while not eof(1) 
			line input #1, ln
			lines += 1
		loop 
		
		close #1 

		CU_ASSERT_EQUAL( lines, 2 )
		
	END_TEST

	TEST( inputCountLines )
		
		dim as integer lines = 0, int_
		
		open filename for input as #1 
		
		do while not eof(1) 
			input #1, int_
			lines += 1
		loop 
		
		close #1 

		CU_ASSERT_EQUAL( lines, 2 )
		
	END_TEST
		
END_SUITE
