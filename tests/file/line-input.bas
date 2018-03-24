# include "fbcunit.bi"

SUITE( fbc_tests.file_.line_input )

	TEST( bigList )
		'' FB should be able to read in big-list.txt line by line using Line Input.
		'' All 3351 lines of that file should be read.
		'' Since reading the last line may not trigger EOF yet, we can end up
		'' doing an extra unnecessary Line Input which gives an empty line --
		'' but that should be the only empty line returned.

		var f = freefile( )

		if( open( "file/big-list-eol-lf.txt", for input, as #f ) <> 0 ) then
			CU_FAIL( )
		end if

		dim as integer lines, have_empty_line
		dim ln as string
		while( eof( f ) = FALSE )
			line input #f, ln
			if( len( ln ) > 0 ) then
				CU_ASSERT( have_empty_line = FALSE )
				lines += 1
			else
				CU_ASSERT( have_empty_line = FALSE )
				have_empty_line = TRUE
			end if
		wend
		CU_ASSERT( lines = 3351 )

		close #f
	END_TEST

END_SUITE
