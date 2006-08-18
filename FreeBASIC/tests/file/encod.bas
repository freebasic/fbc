
#define TEST_1 "Hello_"
#define TEST_2 wstr( "World!" )
#define TEST_3 1234
#define TEST_4 5.678
	
sub test( byval encod as string )

	print encod; "..."
	
	''
	'' write
	''
	if( open( "test_" + encod + ".txt", for output, encoding encod, as #1 ) <> 0 ) then
		end
	end if

	write #1, TEST_1, TEST_2, TEST_3, TEST_4

	print #1, TEST_1
	print #1, TEST_2
	print #1, TEST_3; TEST_4
	
	close #1

	''
	'' read
	''
	dim s as string
	dim ws as wstring * 100
	dim i as integer
	dim d as double
	
	if( open( "test_" + encod + ".txt", for input, encoding encod, as #1 ) <> 0 ) then
		end
	end if

	input #1, s, ws, i, d
	
	assert( s = TEST_1 )
	assert( ws = TEST_2 )
	assert( i = TEST_3 )
	assert( d = TEST_4 )
	
	input #1, s, ws, i, d

	assert( s = TEST_1 )
	assert( ws = TEST_2 )
	assert( i = TEST_3 )
	assert( d = TEST_4 )

	close #1

	''
	'' remove
	''
	kill "test_" + encod + ".txt"

end sub

	test "utf8"
	test "utf16"
	test "utf32"
	test "ascii"
