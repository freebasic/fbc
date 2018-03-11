# include "fbcunit.bi"

SUITE( fbc_tests.file_.text_in )

	TEST( inputEOF )
		dim i as integer
		dim l as string

		if( open( "data/empty.txt", for input, as #1 ) <> 0 ) then
			CU_FAIL( "ERROR" )
			exit sub
		end if
			
		i=0
		while not eof(1)
    		line input #1, l
			select case i
			case 0
        		if l<>"" and l<>chr(26) then CU_FAIL( "ERROR" )
			case else
				CU_FAIL( "ERROR" )
			end select
			i+=1
		wend
		close #1

		' we cannot check for i=0 because on some platforms we can only detect
		' the EOF after a read access (e.g. line input statement)
		CU_ASSERT_TRUE( i>=0 and i<=1 )
		exit sub

	END_TEST

	TEST( inputContentsEOF1 )
		dim i as integer
		dim l as string
  
		if( open( "data/two.txt" for input as #1 ) <> 0 ) then
			CU_FAIL( "ERROR" )
			exit sub
		end if

		i=0
		while not eof(1)
    		line input #1, l
			select case i
			case 0
        		if l<>"1" then CU_FAIL( "ERROR" )
			case 1
        		if l<>"2" and l<>"2"+chr(26) then CU_FAIL( "ERROR" )
			case else
				CU_FAIL( "ERROR" )
			end select
			i+=1
		wend
		close #1

		CU_ASSERT_EQUAL( i, 2 )
		exit sub

	END_TEST

	TEST( InputContentsEOF2 )
		dim i as integer
		dim l as string
  
		if( open( "data/three.txt" for input as #1 ) <> 0 ) then
			CU_FAIL( "ERROR" )
			exit sub
		end if

		i=0
		while not eof(1)
    		line input #1, l
			select case i
			case 0
        		if l<>"1" then CU_FAIL( "ERROR" )
			case 1
        		if l<>"2" then CU_FAIL( "ERROR" )
			case 2
        		if l<>"" and l<>chr(26) then CU_FAIL( "ERROR" )
			case else
				CU_FAIL( "ERROR" )
			end select
			i+=1
		wend
		close #1

		' we cannot check for i=2 because on some platforms we can only detect
		' the EOF after a read access (e.g. line input statement)
		CU_ASSERT_TRUE( i>=2 and i<=3 )
		exit sub

	END_TEST

	TEST( InputContentsEOF3 )
		dim i as integer
		dim l as string
  
		if( open( "data/threebin.txt" for input as #1 ) <> 0 ) then
			CU_FAIL( "ERROR" )
			exit sub
		end if
		
		i=0
		while not eof(1)
    		line input #1, l
			select case i
			case 0
        		if l<>"1" then CU_FAIL( "ERROR" )
			case 1
        		if l<>"2" and l<>"2"+chr(26) then CU_FAIL( "ERROR" )
			case 2
        		if l<>"" and l<>"3" then CU_FAIL( "ERROR" )
			case else
				CU_FAIL( "ERROR" )
			end select
			i+=1
		wend
		close #1

		' we cannot check for i=2 because on some platforms we can only detect
		' the EOF after a read access (e.g. line input statement)
		CU_ASSERT_TRUE( i>=2 and i<=3 )
		exit sub

	END_TEST

	TEST( InputContentsEOF4 )
		dim i as integer
		dim l as string
  
		if( open( "data/fourbin.txt" for input as #1 ) <> 0 ) then
			CU_FAIL( "ERROR" )
			exit sub
		end if

		i=0
		while not eof(1)
    		line input #1, l
			select case i
			case 0
        		if l<>"1" then CU_FAIL( "ERROR" )
			case 1
        		if l<>"2" then CU_FAIL( "ERROR" )
			case 2
        		if l<>"" and l<>chr(26)+"3" then CU_FAIL( "ERROR" )
			case 3
				if l<>"4" then CU_FAIL( "ERROR" )
			case else
				CU_FAIL( "ERROR" )
			end select
			i+=1
		wend
		close #1

		' we cannot check for i=2 because on some platforms we can only detect
		' the EOF after a read access (e.g. line input statement)
		CU_ASSERT_TRUE( i>=2 and i<=4 )
		exit sub

	END_TEST

	TEST( BinaryEOF )
		dim i as integer
		dim l as string

		if( open( "data/empty.txt" for binary access read as #1 ) <> 0 ) then
			CU_FAIL( "ERROR" )
			exit sub
		end if
		
		i=0
		while not eof(1)
    		line input #1, l
			select case i
			case 0
        		if l<>chr(26) then CU_FAIL( "ERROR" )
			case else
				CU_FAIL( "ERROR" )
			end select
			i+=1
		wend
		close #1

		CU_ASSERT_EQUAL( i, 1 )
		exit sub

	END_TEST

	TEST( BinaryContentsEOF1 )
		dim i as integer
		dim l as string
  
		if( open( "data/two.txt" for binary access read as #1 ) <> 0 ) then
			CU_FAIL( "ERROR" )
			exit sub
		end if
		
		i=0
		while not eof(1)
    		line input #1, l
			select case i
			case 0
        		if l<>"1" then CU_FAIL( "ERROR" )
			case 1
        		if l<>"2"+chr(26) then CU_FAIL( "ERROR" )
			case else
				CU_FAIL( "ERROR" )
			end select
			i+=1
		wend
		close #1

		CU_ASSERT_EQUAL( i, 2 )
		exit sub

	END_TEST

	TEST( BinaryContentsEOF2 )
		dim i as integer
		dim l as string

		if( open( "data/three.txt" for binary access read as #1 ) <> 0 ) then
			CU_FAIL( "ERROR" )
			exit sub
		end if
		
		i=0
		while not eof(1)
    		line input #1, l
			select case i
			case 0
        		if l<>"1" then CU_FAIL( "ERROR" )
			case 1
        		if l<>"2" then CU_FAIL( "ERROR" )
			case 2
        		if l<>chr(26) then CU_FAIL( "ERROR" )
			case else
				CU_FAIL( "ERROR" )
			end select
			i+=1
		wend
		close #1

		CU_ASSERT_EQUAL( i, 3 )
		exit sub

	file_access_failed:
		close 1
		CU_FAIL( "ERROR" )
	END_TEST

	TEST( BinaryContentsEOF3 )
		dim i as integer
		dim l as string
  
		if( open( "data/threebin.txt" for binary access read as #1 ) <> 0 ) then
			CU_FAIL( "ERROR" )
			exit sub
		end if
		
		i=0
		while not eof(1)
    		line input #1, l
			select case i
			case 0
        		if l<>"1" then CU_FAIL( "ERROR" )
			case 1
        		if l<>"2"+chr(26) then CU_FAIL( "ERROR" )
			case 2
        		if l<>"3" then CU_FAIL( "ERROR" )
			case else
				CU_FAIL( "ERROR" )
			end select
			i+=1
		wend
		close #1

		CU_ASSERT_EQUAL( i, 3 )
		exit sub

	END_TEST

	TEST( BinaryContentsEOF4 )
		dim i as integer
		dim l as string
  
		if( open( "data/fourbin.txt" for binary access read as #1 ) <> 0 ) then
			CU_FAIL( "ERROR" )
			exit sub
		end if

		i=0
		while not eof(1)
    		line input #1, l
			select case i
			case 0
        		if l<>"1" then CU_FAIL( "ERROR" )
			case 1
        		if l<>"2" then CU_FAIL( "ERROR" )
			case 2
        		if l<>chr(26)+"3" then CU_FAIL( "ERROR" )
			case 3
        		if l<>"4" then CU_FAIL( "ERROR" )
			case else
				CU_FAIL( "ERROR" )
			end select
			i+=1
		wend
		close #1

		CU_ASSERT_EQUAL( i, 4 )
		exit sub

	END_TEST

END_SUITE
