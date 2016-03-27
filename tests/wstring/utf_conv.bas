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

'' The rtlib has UTF encoding routines that can allocate memory for us. If using
'' that version of them, they pre-allocate some chars (currently typically 8) at
'' a time. To ensure this works correctly, we have to test with strings longer
'' than that.
sub testLongSimpleText cdecl( )
	const TEXT = "testing with a long, but simple 7-bit ASCII string"
	dim src as wstring * 100 = wstr( TEXT )

	CU_ASSERT( len( src ) = len( TEXT ) )
	CU_ASSERT( src = TEXT )

	scope
		'' Convert to UTF8, including null terminator
		dim as integer utf8bytes
		dim as ubyte ptr utf8 = WCharToUTF( UTF_ENCOD_UTF8, src, len( src ) + 1, NULL, @utf8bytes )
		CU_ASSERT( utf8bytes = (len( TEXT ) + 1) )
		CU_ASSERT( *cptr( zstring ptr, utf8 ) = TEXT )

		'' Convert back to wstring
		dim as integer chars
		dim as wstring ptr w = UTFToWChar( UTF_ENCOD_UTF8, utf8, NULL, @chars )
		CU_ASSERT( chars = len( TEXT ) )
		CU_ASSERT( *w = src )

		deallocate( utf8 )
		deallocate( w )
	end scope

	scope
		'' Convert to UTF16, including null terminator
		dim as integer utf16bytes
		dim as ushort ptr utf16 = WCharToUTF( UTF_ENCOD_UTF16, src, len( src ) + 1, NULL, @utf16bytes )
		CU_ASSERT( (utf16bytes mod 2) = 0 )
		CU_ASSERT( (utf16bytes \ 2) = (len( TEXT ) + 1) )
		for i as integer = 0 to (utf16bytes \ 2) - 1
			CU_ASSERT( utf16[i] = src[i] )
		next

		'' Convert back to wstring
		dim as integer chars
		dim as wstring ptr w = UTFToWChar( UTF_ENCOD_UTF16, utf16, NULL, @chars )
		CU_ASSERT( chars = len( TEXT ) )
		CU_ASSERT( *w = src )

		deallocate( utf16 )
		deallocate( w )
	end scope

	scope
		'' Convert to UTF32, including null terminator
		dim as integer utf32bytes
		dim as ulong ptr utf32 = WCharToUTF( UTF_ENCOD_UTF32, src, len( src ) + 1, NULL, @utf32bytes )
		CU_ASSERT( (utf32bytes mod 4) = 0 )
		CU_ASSERT( (utf32bytes \ 4) = (len( TEXT ) + 1) )
		for i as integer = 0 to (utf32bytes \ 4) - 1
			CU_ASSERT( utf32[i] = src[i] )
		next

		'' Convert back to wstring
		dim as integer chars
		dim as wstring ptr w = UTFToWChar( UTF_ENCOD_UTF32, utf32, NULL, @chars )
		CU_ASSERT( chars = len( TEXT ) )
		CU_ASSERT( *w = src )

		deallocate( utf32 )
		deallocate( w )
	end scope
end sub

sub ctor( ) constructor
	fbcu.add_suite( "tests/wstrings/utf_conv" )
	fbcu.add_test( "test_z", @test_z )
	fbcu.add_test( "test_w", @test_w )
	fbcu.add_test( "testWstringToNullDest", @testWstringToNullDest )
	fbcu.add_test( "testZstringToNullDest", @testZstringToNullDest )
	fbcu.add_test( "testLongSimpleText", @testLongSimpleText )
end sub

end namespace
