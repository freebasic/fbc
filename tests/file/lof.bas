# include "fbcunit.bi"
#include "vbcompat.bi"

SUITE( fbc_tests.file_.lof_ )

	type FileInfo
		as zstring * 32 name
		as zstring * 6 encoding
		as integer size
	end type

	dim shared as FileInfo files(0 to 4) = _
	{ _
		( "file/2bytes.txt"   , ""     , 2  ), _
		( "file/lof-ascii.txt", "ascii", 11 ), _
		( "file/lof-utf8.txt" , "utf8" , 14 ), _
		( "file/lof-utf16.txt", "utf16", 24 ), _
		( "file/lof-utf32.txt", "utf32", 48 )  _
	}

	'' getting file size via Lof()
	TEST( lofToGetFileSize )
		for i as integer = 0 to 4
			if( open( files(i).name, for binary, access read, as #1 ) ) then
				CU_FAIL( )
			end if

			CU_ASSERT( lof( 1 ) = files(i).size )

			close #1
		next
	END_TEST

	'' Lof() and Open Encoding
	TEST( lofEncoding )
		for i as integer = 1 to 4
			if( open( files(i).name, for input, _
					  encoding files(i).encoding, as #1 ) ) then
				CU_FAIL( )
			end if

			'' Testing that Encoding doesn't affect Lof() which just
			'' returns the file size in bytes, not chars, and also that
			'' lof() still works after reading/seeking forward in the file.
			dim as string s
			line input #1, s
			CU_ASSERT( s = "Hello world" )

			CU_ASSERT( lof( 1 ) = files(i).size )

			close #1
		next
	END_TEST

	'' Lof() vs. FileLen()
	TEST( lofVsFilelen )
		const filename = "file/lof.bas"

		if( open( filename, for binary, access read, as #1 ) ) then
			CU_FAIL( )
		end if

		CU_ASSERT( lof( 1 ) = FileLen( filename ) )

		close #1
	END_TEST

END_SUITE
