# include "fbcu.bi"

#define TEST_1 "Hello_"
#define TEST_2 wstr( "World!" )
#define TEST_3 1234
#define TEST_4 5.678

namespace fbc_tests.file_.encod

private sub WriteToFile (byref encod as string)

	if( open( "test_" + encod + ".txt", for output, encoding encod, as #1 ) <> 0 ) then
		CU_FAIL_FATAL("couldn't open test file.")
	end if

	write #1, TEST_1, TEST_2, TEST_3, TEST_4

	print #1, TEST_1
	print #1, TEST_2
	print #1, TEST_3; TEST_4
	
	close #1

end sub

private sub ReadFromFile (byref encod as string)

	dim s as string
	dim ws as wstring * 100
	dim i as integer
	dim d as double
	
	if( open( "test_" + encod + ".txt", for input, encoding encod, as #1 ) <> 0 ) then
		CU_FAIL_FATAL("couldn't open test file.")
	end if
	
	input #1, s, ws, i, d
	
	CU_ASSERT_EQUAL( s, TEST_1 )
	CU_ASSERT_EQUAL( ws, TEST_2 )
	CU_ASSERT_EQUAL( i, TEST_3 )
	CU_ASSERT_EQUAL( d, TEST_4 )
	
	input #1, s, ws, i, d
	
	CU_ASSERT_EQUAL( s, TEST_1 )
	CU_ASSERT_EQUAL( ws, TEST_2 )
	CU_ASSERT_EQUAL( i, TEST_3 )
	CU_ASSERT_EQUAL( d, TEST_4 )
	
	close #1

end sub

private sub performTest (byref encod as string)

	'//
	'// write
	'//

	WriteToFile(encod)
	
	'//
	'// read
	'//

	ReadFromFile(encod)

	kill "test_" + encod + ".txt"

end sub

sub encodingTest cdecl ()

	performTest("utf8")
	performTest("utf16")
	performTest("utf32")
	performTest("ascii")

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.file.encod")
	fbcu.add_test("encodingTest", @encodingTest)

end sub

end namespace
