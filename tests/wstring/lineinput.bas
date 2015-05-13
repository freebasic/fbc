# include "fbcu.bi"

namespace fbc_tests.wstrings.lineinput

dim shared as zstring ptr encodings(0 to ...) = _
{ _
	@"ascii", _
	@"utf8", _
	@"utf16", _
	@"utf32" _
}

sub testWstring cdecl()
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
end sub

sub testString cdecl()
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
end sub

sub ctor() constructor
	fbcu.add_suite("fbc_tests.wstrings.lineinput")
	fbcu.add_test("Line Input to wstring", @testWstring)
	fbcu.add_test("Line Input to string", @testString)
end sub

end namespace
