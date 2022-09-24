# include "fbcunit.bi"

#define TEST_1 "Hello_"
#define TEST_2 wstr( "World!" )
#define TEST_3 1234
#define TEST_4 5.678

SUITE( fbc_tests.file_.encod )

	private function getTESTFILE( byref encod as string ) as string
		return "./file/test_" + encod + ".txt"
	end function

	private sub KillTestFile( byref encod as string )

		dim TESTFILE as string
		TESTFILE = getTESTFILE( encod )

		kill TESTFILE
	end sub

	private sub WriteToFile( byref encod as string )

		dim TESTFILE as string
		TESTFILE = getTESTFILE( encod )

		if( open( TESTFILE, for output, encoding encod, as #1 ) <> 0 ) then
			CU_FAIL_FATAL("couldn't open test file.")
		end if

		write #1, TEST_1, TEST_2, TEST_3, TEST_4

		print #1, TEST_1
		print #1, TEST_2
		print #1, TEST_3; TEST_4

		close #1

	end sub

	private sub ReadFromFile1( )
		dim s as string
		dim ws as wstring * 100
		dim i as integer
		dim d as double

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
	end sub

	private sub ReadFromFile2( )
		dim s as string
		dim ws as wstring * 100
		dim i as integer
		dim d as double

		input #1, d, i, ws, s

		CU_ASSERT_EQUAL( s, TEST_1 )
		CU_ASSERT_EQUAL( ws, TEST_2 )
		CU_ASSERT_EQUAL( i, TEST_3 )
		CU_ASSERT_EQUAL( d, TEST_4 )

		input #1, d, i, ws, s

		CU_ASSERT_EQUAL( s, TEST_1 )
		CU_ASSERT_EQUAL( ws, TEST_2 )
		CU_ASSERT_EQUAL( i, TEST_3 )
		CU_ASSERT_EQUAL( d, TEST_4 )
	end sub

	private sub ReadFromFile( byref encod as string, byval sections as integer )

		dim TESTFILE as string
		TESTFILE = getTESTFILE( encod )

		if( open( TESTFILE, for input, encoding encod, as #1 ) <> 0 ) then
			CU_FAIL_FATAL("couldn't open test file.")
		end if

		if( sections >= 1 ) then
			ReadFromFile1()
		end if

		if( sections >= 2 ) then
			ReadFromFile2()
		end if

		close #1

	end sub

	private sub AppendToNewFile( byref encod as string )

		dim TESTFILE as string
		TESTFILE = getTESTFILE( encod )

		if( open( TESTFILE, for append, encoding encod, as #1 ) <> 0 ) then
			CU_FAIL_FATAL("couldn't open test file.")
		end if

		write #1, TEST_1, TEST_2, TEST_3, TEST_4

		print #1, TEST_1
		print #1, TEST_2
		print #1, TEST_3; TEST_4

		close #1

	end sub

	private sub AppendToExistingFile( byref encod as string )

		dim TESTFILE as string
		TESTFILE = getTESTFILE( encod )

		if( open( TESTFILE, for append, encoding encod, as #1 ) <> 0 ) then
			CU_FAIL_FATAL("couldn't open test file.")
		end if

		write #1, TEST_4, TEST_3, TEST_2, TEST_1

		print #1, TEST_4; TEST_3
		print #1, TEST_2
		print #1, TEST_1

		close #1

	end sub

	private sub performTest( byref encod as string )

		WriteToFile( encod )
		ReadFromFile( encod, 1 )

		KillTestFile( encod )

		AppendToNewFile( encod )
		ReadFromFile( encod, 1 )
		AppendToExistingFile( encod )
		ReadFromFile( encod, 2 )

		KillTestFile( encod )

	end sub

	TEST( encoding )

		performTest( "utf8" )
		performTest( "utf16" )
		performTest( "utf32" )
		performTest( "ascii" )

	END_TEST

END_SUITE
