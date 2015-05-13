# include "fbcu.bi"

#include "vbcompat.bi"

namespace fbc_tests.file_.lof_

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

sub lofToGetFileSize cdecl( )
	for i as integer = 0 to 4
		if( open( files(i).name, for binary, access read, as #1 ) ) then
			CU_FAIL( )
		end if

		CU_ASSERT( lof( 1 ) = files(i).size )

		close #1
	next
end sub

sub lofEncoding cdecl( )
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
end sub

sub lofVsFilelen cdecl( )
	const filename = "file/lof.bas"

	if( open( filename, for binary, access read, as #1 ) ) then
		CU_FAIL( )
	end if

	CU_ASSERT( lof( 1 ) = FileLen( filename ) )

	close #1
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.file.lof" )
	fbcu.add_test( "getting file size via Lof()", @lofToGetFileSize )
	fbcu.add_test( "Lof() and Open Encoding", @lofEncoding )
	fbcu.add_test( "Lof() vs. FileLen()", @lofVsFilelen )
end sub

end namespace
