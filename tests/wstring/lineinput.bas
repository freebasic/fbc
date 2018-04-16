#include "fbcunit.bi"

SUITE( fbc_tests.wstring_.lineinput )

	dim shared as zstring ptr encodings(0 to ...) = _
	{ _
		@"ascii", _
		@"utf8", _
		@"utf16", _
		@"utf32" _
	}

	TEST( lineinput_wstring )
		for enc as integer = 0 to ubound(encodings)
			if open( "wstring/lineinput-" + *encodings(enc) + ".txt" for input encoding *encodings(enc) as #1 ) <> 0 then
				CU_FAIL("failed to open file")
			end if

			dim s as wstring * 32
			dim i as integer = 0

			do until eof( 1 )
				line input #1, s
				if( len(s) = 0 ) then
					continue do
				end if

				if( i = 10 ) then
					CU_ASSERT( s = wstr(i) + wstr(" 'no newline") )
				else
					CU_ASSERT( s = wstr(i) )
				end if
				i += 1
			loop

			close #1
		next
	END_TEST

	TEST( lineinput_string )
		for enc as integer = 0 to ubound(encodings)
			if open( "wstring/lineinput-" + *encodings(enc) + ".txt" for input encoding *encodings(enc) as #1 ) <> 0 then
				CU_FAIL("failed to open file")
			end if

			dim s as string
			dim i as integer = 0

			do until eof( 1 )
				line input #1, s
				if( i = 10 ) then
					CU_ASSERT( s = str(i) + " 'no newline" )
				else
					CU_ASSERT( s = str(i) )
				end if
				i += 1
			loop

			close #1
		next
	END_TEST

END_SUITE
