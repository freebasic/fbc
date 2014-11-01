# include "fbcu.bi"

namespace fbc_tests.file_.pipe_

const filename = "./file/pipe.bas"

sub test cdecl ()

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

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.file.pipe")
	fbcu.add_test("1", @test)
	
end sub

end namespace
