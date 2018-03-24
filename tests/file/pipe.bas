# include "fbcunit.bi"

SUITE( fbc_tests.file_.pipe_ )

	const filename = "./file/pipe.bas"

	TEST( pipeInput )

		if open pipe ( "ls " + filename for input As #1) = 0 then

			dim as string text
			dim as integer files = 0

			do while not eof(1)
				input #1, text
				if len( trim( text ) ) > 0 then files += 1
			loop

			CU_ASSERT_EQUAL( files, 1 )

			close #1

		else
			CU_FAIL( "file not found" )
		end if

	END_TEST

END_SUITE
