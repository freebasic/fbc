# include "fbcu.bi"

namespace fbc_tests.file_.text_in2

const filename = "file\text_in2.txt"

sub test_lineinp cdecl
	
	dim as integer lines = 0
	dim as string ln
	
	open filename for input as #1 
	
	do while not eof(1) 
		line input #1, ln
		lines += 1
	loop 
	
	close #1 

	CU_ASSERT_EQUAL( lines, 2 )
	
end sub

sub test_input cdecl
	
	dim as integer lines = 0, int_
	
	open filename for input as #1 
	
	do while not eof(1) 
		input #1, int_
		lines += 1
	loop 
	
	close #1 

	CU_ASSERT_EQUAL( lines, 2 )
	
end sub
	
private sub ctor () constructor

	fbcu.add_suite("fbc_tests.file.text_in2")
	fbcu.add_test("test_lineinp", @test_lineinp)
	fbcu.add_test("test_input", @test_input)

end sub
	
end namespace