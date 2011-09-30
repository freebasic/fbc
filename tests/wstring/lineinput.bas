# include "fbcu.bi"




namespace fbc_tests.wstrings.lineinput
	
sub test_1 cdecl ()

	if open( ".\wstring\lineinput.txt" for input encoding "utf-16" as #1 ) <> 0 then
		CU_FAIL("failed to open file")
	end if

	dim s as wstring * 32 
	dim i as integer = 0

	do until eof( 1 )
		line input #1, s
		CU_ASSERT( left( s, 2 ) = wstr( i ) )
		i += 1
	loop 

	close #1

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.wstrings.lineinput")
	fbcu.add_test("test_1", @test_1)

end sub

end namespace
