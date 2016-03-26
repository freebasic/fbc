# include "fbcu.bi"

#include once "utf_conv.bi"

namespace fbc_tests.wstrings.utf_conv

sub test_z cdecl ()
	dim as zstring ptr srcstr = @"ã é ô"
	dim as byte ptr utfstr
	dim as integer bytes

	utfstr = CharToUTF( UTF_ENCOD_UTF8, srcstr, len( *srcstr ) + 1, NULL, @bytes )

	dim as zstring ptr newstr
	newstr = UTFToChar( UTF_ENCOD_UTF8, utfstr, NULL, @bytes )

	CU_ASSERT( *newstr = *srcstr )

	deallocate( newstr )
	deallocate( utfstr )
end sub

sub test_w cdecl ()
	dim as wstring ptr srcstr = @wstr("ã é ô")
	dim as byte ptr utfstr
	dim as integer bytes

	utfstr = WCharToUTF( UTF_ENCOD_UTF8, srcstr, len( *srcstr ) + 1, NULL, @bytes )

	dim as wstring ptr newstr
	newstr = UTFToWChar( UTF_ENCOD_UTF8, utfstr, NULL, @bytes )
	
	CU_ASSERT( *newstr = *srcstr )

	deallocate( newstr )
	deallocate( utfstr )
end sub

'' If given a NULL destination, all conversion cases should allocate a result
'' buffer that the caller must deallocate.
sub testWstringToNullDest cdecl( )
	dim w as wstring * 10 = "123"
	dim as integer bytes

	dim as ubyte ptr utf8 = WCharToUTF( UTF_ENCOD_UTF8, w, len( w ), NULL, @bytes )
	CU_ASSERT( cuint( utf8 ) <> cuint( @w ) )
	deallocate( utf8 )

	dim as ushort ptr utf16 = WCharToUTF( UTF_ENCOD_UTF16, w, len( w ), NULL, @bytes )
	CU_ASSERT( cuint( utf16 ) <> cuint( @w ) )
	deallocate( utf16 )

	dim as ulong ptr utf32 = WCharToUTF( UTF_ENCOD_UTF32, w, len( w ), NULL, @bytes )
	CU_ASSERT( cuint( utf32 ) <> cuint( @w ) )
	deallocate( utf32 )
end sub

'' If given a NULL destination, all conversion cases should allocate a result
'' buffer that the caller must deallocate.
sub testZstringToNullDest cdecl( )
	dim z as zstring * 10 = "123"
	dim as integer bytes

	dim as ubyte ptr utf8 = CharToUTF( UTF_ENCOD_UTF8, z, len( z ), NULL, @bytes )
	CU_ASSERT( cuint( utf8 ) <> cuint( @z ) )
	deallocate( utf8 )

	dim as ushort ptr utf16 = CharToUTF( UTF_ENCOD_UTF16, z, len( z ), NULL, @bytes )
	CU_ASSERT( cuint( utf16 ) <> cuint( @z ) )
	deallocate( utf16 )

	dim as ulong ptr utf32 = CharToUTF( UTF_ENCOD_UTF32, z, len( z ), NULL, @bytes )
	CU_ASSERT( cuint( utf32 ) <> cuint( @z ) )
	deallocate( utf32 )
end sub

sub ctor () constructor
	fbcu.add_suite("fbc_tests.wstrings.utf_conv")
	fbcu.add_test("test_z", @test_z)
	fbcu.add_test("test_w", @test_w)
	fbcu.add_test( "testWstringToNullDest", @testWstringToNullDest )
	fbcu.add_test( "testZstringToNullDest", @testZstringToNullDest )
end sub

end namespace
