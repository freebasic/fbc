# include "fbcunit.bi"

SUITE( fbc_tests.file_.encod_check )

	const testFile = "./file/test_encod_check.txt"

	const FILE_MODE_INPUT = 0
	const FILE_MODE_OUTPUT = 1
	const FILE_MODE_APPEND = 2

	private function createTestFile( byref encod as string ) as boolean
		dim ret as boolean
		ret = (open( testFile, for output, encoding encod, as #1 ) = 0)
		if( ret = false ) then
			CU_FAIL_FATAL("couldn't create test file.")
			return false
		end if

		print #1, "hello"
		close #1
		return true
	end function

	private function openTestFile( byval file_mode as integer, byref encod as string ) as boolean
		dim ret as boolean
		select case file_mode
		case FILE_MODE_INPUT
			ret = (open( testFile, for input, encoding encod, as #1 ) = 0)
		case FILE_MODE_OUTPUT
			ret = (open( testFile, for output, encoding encod, as #1 ) = 0)
		case FILE_MODE_APPEND
			ret = (open( testFile, for append, encoding encod, as #1 ) = 0)
		case else
			ret = false
		end select
		return ret
	end function

	private sub closeTestFile( )
		close #1
	end sub

	private sub killTestFile( )
		kill testFile
	end sub

	TEST( create_new )

		'' check creating a new file with various encodings

		#macro do_check( expected_ret, file_mode, encod )
			scope
				dim ret as boolean
				ret = openTestFile( file_mode, encod )
				CU_ASSERT( ret = expected_ret )

				if( ret ) then
					closeTestFile( )
				end if

				killTestFile( )
			end scope
		#endmacro

		#macro do_mode_check( expected_ret, file_mode )
			do_check( expected_ret, file_mode, "ascii" )
			do_check( expected_ret, file_mode, "utf8" )
			do_check( expected_ret, file_mode, "utf16" )
			do_check( expected_ret, file_mode, "utf32" )
		#endmacro

		do_mode_check( false, FILE_MODE_INPUT )
		do_mode_check( true, FILE_MODE_OUTPUT )
		do_mode_check( true, FILE_MODE_APPEND )
		
	END_TEST

	TEST( open_existing )

		'' check open an existing file with same & different encodings

		#macro do_check( expected_ret, file_mode, encod1, encod2 )
			scope
				killTestFile()
				createTestFile( encod1 )

				dim ret as boolean
				ret = openTestFile( file_mode, encod2 )
				CU_ASSERT( ret = expected_ret )

				if( ret ) then
					closeTestFile( )
				end if

				killTestFile( )
			end scope
		#endmacro

		'' ASCII
		do_check( true , FILE_MODE_INPUT, "ascii", "ascii" )
		do_check( false, FILE_MODE_INPUT, "ascii", "utf8" )
		do_check( false, FILE_MODE_INPUT, "ascii", "utf16" )
		do_check( false, FILE_MODE_INPUT, "ascii", "utf32" )

		do_check( true , FILE_MODE_OUTPUT, "ascii", "ascii" )
		do_check( true , FILE_MODE_OUTPUT, "ascii", "utf8" )
		do_check( true , FILE_MODE_OUTPUT, "ascii", "utf16" )
		do_check( true , FILE_MODE_OUTPUT, "ascii", "utf32" )

		do_check( true , FILE_MODE_APPEND, "ascii", "ascii" )
		do_check( false, FILE_MODE_APPEND, "ascii", "utf8" )
		do_check( false, FILE_MODE_APPEND, "ascii", "utf16" )
		do_check( false, FILE_MODE_APPEND, "ascii", "utf32" )

		'' UTF-8
		do_check( true , FILE_MODE_INPUT, "utf8", "ascii" )
		do_check( true , FILE_MODE_INPUT, "utf8", "utf8" )
		do_check( false, FILE_MODE_INPUT, "utf8", "utf16" )
		do_check( false, FILE_MODE_INPUT, "utf8", "utf32" )

		do_check( true , FILE_MODE_OUTPUT, "utf8", "ascii" )
		do_check( true , FILE_MODE_OUTPUT, "utf8", "utf8" )
		do_check( true , FILE_MODE_OUTPUT, "utf8", "utf16" )
		do_check( true , FILE_MODE_OUTPUT, "utf8", "utf32" )

		do_check( true , FILE_MODE_APPEND, "utf8", "ascii" )
		do_check( true , FILE_MODE_APPEND, "utf8", "utf8" )
		do_check( false, FILE_MODE_APPEND, "utf8", "utf16" )
		do_check( false, FILE_MODE_APPEND, "utf8", "utf32" )

		'' UTF-16
		do_check( true , FILE_MODE_INPUT, "utf16", "ascii" )
		do_check( false, FILE_MODE_INPUT, "utf16", "utf8" )
		do_check( true , FILE_MODE_INPUT, "utf16", "utf16" )
		do_check( false, FILE_MODE_INPUT, "utf16", "utf32" )

		do_check( true , FILE_MODE_OUTPUT, "utf16", "ascii" )
		do_check( true , FILE_MODE_OUTPUT, "utf16", "utf8" )
		do_check( true , FILE_MODE_OUTPUT, "utf16", "utf16" )
		do_check( true , FILE_MODE_OUTPUT, "utf16", "utf32" )

		do_check( true , FILE_MODE_APPEND, "utf16", "ascii" )
		do_check( false, FILE_MODE_APPEND, "utf16", "utf8" )
		do_check( true , FILE_MODE_APPEND, "utf16", "utf16" )
		do_check( false, FILE_MODE_APPEND, "utf16", "utf32" )
	
		'' UTF-32
		'' ** checking for utf16le when file was encoded in utf32le
		'' maybe gives false positives .. something for users to watch for
		'' utf32le & utf16le have same start bytes and so the check
		'' passes when maybe user would expect it to fail

		do_check( true , FILE_MODE_INPUT, "utf32", "ascii" )
		do_check( false, FILE_MODE_INPUT, "utf32", "utf8" )
		do_check( true , FILE_MODE_INPUT, "utf32", "utf16" )
		do_check( true , FILE_MODE_INPUT, "utf32", "utf32" )

		do_check( true , FILE_MODE_OUTPUT, "utf32", "ascii" )
		do_check( true , FILE_MODE_OUTPUT, "utf32", "utf8" )
		do_check( true , FILE_MODE_OUTPUT, "utf32", "utf16" ) '' **
		do_check( true , FILE_MODE_OUTPUT, "utf32", "utf32" )

		do_check( true , FILE_MODE_APPEND, "utf32", "ascii" )
		do_check( false, FILE_MODE_APPEND, "utf32", "utf8" )
		do_check( true , FILE_MODE_APPEND, "utf32", "utf16" ) '' **
		do_check( true , FILE_MODE_APPEND, "utf32", "utf32" )

	END_TEST

END_SUITE
