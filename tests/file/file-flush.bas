# include "fbcunit.bi"

#include "file.bi"

SUITE( fbc_tests.file_.file_flush )

	const filename = "./file/flush.tmp"

	TEST( flushbinary )
		if open( filename for binary as #1 ) = 0 then
			dim as string text = "hello"
			put #1,,text
			if( FileFlush( 1 ) = 0 ) then
				CU_PASS( )
			else
				CU_FAIL( "flushbinary: failed" )
			end if
			close #1
			kill filename
		else
			CU_FAIL( "flushbinary: open file error" )
		end if
	END_TEST

	TEST( flushbinary2 )
		if open( filename for binary as #1 ) = 0 then
			dim as string text = "hello"
			put #1,,text
			if( FileFlush( 1, true ) = 0 ) then
				CU_PASS( )
			else
				CU_FAIL( "flushbinary2: failed" )
			end if
			close #1
			kill filename
		else
			CU_FAIL( "flushbinary2: open file error" )
		end if
	END_TEST

	TEST( flushrandom )
		type T
			b(0 to 9) as ubyte
		end type
		if open( filename for binary as #1 len = len(T) ) = 0 then
			dim as T x
			put #1,,x
			if( FileFlush( 1 ) = 0 ) then
				CU_PASS( )
			else
				CU_FAIL( "flushrandom: failed" )
			end if
			close #1
			kill filename
		else
			CU_FAIL( "flushrandom: open file error" )
		end if
	END_TEST

	TEST( flushinput )
		if open( filename for output as #1 ) = 0 then
			dim as string text = "hello"
			print #1, text;
			close #1
			if open( filename for input as #1 ) = 0 then
				if( FileFlush( 1 ) = 0 ) then
					CU_FAIL( "flushinput: should have received error" )
				else
					CU_PASS( )
				end if
				close #1
			else
				CU_FAIL( "flushinput: read file error" )
			end if
			kill filename
		else
			CU_FAIL( "flushinput: write file error" )
		end if
	END_TEST

	TEST( flushoutput )
		if open( filename for output as #1 ) = 0 then
			dim as string text = "hello"
			print #1, text;
			if( FileFlush( 1 ) = 0 ) then
				CU_PASS( )
			else
				CU_FAIL( "flushoutput: failed" )
			end if
			close #1
			kill filename
		else
			CU_FAIL( "flushoutput: open file error" )
		end if
	END_TEST

	TEST( flushappend )
		if open( filename for append as #1 ) = 0 then
			dim as string text = "hello"
			print #1, text;
			if( FileFlush( 1 ) = 0 ) then
				CU_PASS( )
			else
				CU_FAIL( "flushappend: failed" )
			end if
			close #1
			kill filename
		else
			CU_FAIL( "flushappend: open file error" )
		end if
	END_TEST

END_SUITE
