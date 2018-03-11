# include "fbcunit.bi"

SUITE( fbc_tests.file_.input_ )

	'' The test data must match the test file's content
	type DataEntry
		as zstring * 8 field1
		as double field2, field3, field4, field5
	end type

	'' Note: Input only skips space at the beginning but then, after finding
	'' non-space chars, it reads everything including space up to the next
	'' delimiter, as in QB. That's why the DEF456 string has a \t at the end,
	'' as in the input.csv test file.
	dim shared as DataEntry testdata(1 to 3) = _
	{ _
		( "ABC123", 9.43750000,  9.56250000, 9.31250000, &b11100111 ), _
		( "DEF456	", 9.25000000, 10.00000000, 9.09375000, &o777      ), _
		( "GHI789", 9.84375000, 10.00000000, 9.70312500, &h123      )  _
	}

	TEST( integerInput )
		dim as string field1(1 to 3)
		dim as integer field2(1 to 3), field3(1 to 3), field4(1 to 3), field5(1 to 3)

		if( open( "file/input.csv", for input, as #1 ) ) then
			CU_FAIL( )
		end if

		for i as integer = 1 to 3
			input #1, field1(i), field2(i), field3(i), field4(i), field5(i)
			CU_ASSERT_EQUAL( field1(i), testdata(i).field1 )
			CU_ASSERT_EQUAL( field2(i), cint( testdata(i).field2 ) )
			CU_ASSERT_EQUAL( field3(i), cint( testdata(i).field3 ) )
			CU_ASSERT_EQUAL( field4(i), cint( testdata(i).field4 ) )
			CU_ASSERT_EQUAL( field5(i), cint( testdata(i).field5 ) )
		next 

		close #1
	END_TEST

	TEST( doubleInput )
		dim as string field1(1 to 3)
		dim as double field2(1 to 3), field3(1 to 3), field4(1 to 3), field5(1 to 3)

		if( open( "file/input.csv", for input, as #1 ) ) then
			CU_FAIL( )
		end if

		for i as integer = 1 to 3
			input #1, field1(i), field2(i), field3(i), field4(i), field5(i)
			CU_ASSERT_EQUAL( field1(i), testdata(i).field1 )
			CU_ASSERT_EQUAL( field2(i), testdata(i).field2 )
			CU_ASSERT_EQUAL( field3(i), testdata(i).field3 )
			CU_ASSERT_EQUAL( field4(i), testdata(i).field4 )
			CU_ASSERT_EQUAL( field5(i), testdata(i).field5 )
		next 

		close #1
	END_TEST

	'' Input to user-allocated zstring
	TEST( fixlenZstringInput )
		dim as zstring * 32 z

		if( open( "file/2bytes.txt", for input, as #1 ) ) then
			CU_FAIL( )
		end if

		input #1, z

		close #1

		CU_ASSERT( z = "bb" )
	END_TEST

	'' Input to user-allocated wstring
	TEST( fixlenWstringInput )
		dim as wstring * 32 w

		if( open( "file/2bytes.txt", for input, as #1 ) ) then
			CU_FAIL( )
		end if

		input #1, w

		close #1

		CU_ASSERT( w = wstr( "bb" ) )
	END_TEST

	'' Input to fixed-length zstring
	TEST( derefZstringInput )
		dim as zstring * 32 z
		dim as zstring ptr pz = @z

		if( open( "file/2bytes.txt", for input, as #1 ) ) then
			CU_FAIL( )
		end if

		'' Note: this is dangerous, since the buffer length isn't being checked
		'' and will be overflown if the data in the file is long enough.
		input #1, *pz

		close #1

		CU_ASSERT( z = "bb" )
	END_TEST

	'' Input to fixed-length wstring
	TEST( derefWstringInput )
		dim as wstring * 32 w
		dim as wstring ptr pw = @w

		if( open( "file/2bytes.txt", for input, as #1 ) ) then
			CU_FAIL( )
		end if

		'' Note: this is dangerous, since the buffer length isn't being checked
		'' and will be overflown if the data in the file is long enough.
		input #1, *pw

		close #1

		CU_ASSERT( w = wstr( "bb" ) )
	END_TEST

	'' wstring buffer overflow regression test
	TEST( wstringOverflowInput )
		type T field = 1
			as wstring * 2 w
			as integer i
		end type

		dim as T x
		x.w = wstr( "a" )
		x.i = -1

		CU_ASSERT( x.i = -1 )

		if( open( "file/2bytes.txt", for input, as #1 ) ) then
			CU_FAIL( )
		end if
		input #1, x.w
		close #1

		CU_ASSERT( x.w = wstr( "b" ) )
		CU_ASSERT( x.i = -1 )
	END_TEST

	'' [W]INPUT() function
	TEST( inputFunction )
		if( open( "file/2bytes.txt", for input, as #1 ) ) then
			CU_FAIL( )
		end if
		CU_ASSERT( input( 2, #1 ) = "bb" )
		close #1

		if( open( "file/2bytes.txt", for input, as #1 ) ) then
			CU_FAIL( )
		end if
		CU_ASSERT( winput( 2, #1 ) = wstr( "bb" ) )
		close #1
	END_TEST

END_SUITE
