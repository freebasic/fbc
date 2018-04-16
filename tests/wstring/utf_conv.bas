#include "fbcunit.bi"
#include once "utf_conv.bi"
#include once "crt/string.bi"

SUITE( fbc_tests.wstring_.utf_conv )

	TEST( zstringToUTF )
		dim as zstring ptr srcstr = @"ã é ô"
		dim as byte ptr utfstr
		dim as integer bytes

		utfstr = CharToUTF( UTF_ENCOD_UTF8, srcstr, len( *srcstr ) + 1, NULL, @bytes )

		dim as zstring ptr newstr
		newstr = UTFToChar( UTF_ENCOD_UTF8, utfstr, NULL, @bytes )

		CU_ASSERT( *newstr = *srcstr )

		deallocate( newstr )
		deallocate( utfstr )
	END_TEST

	TEST( wstringToUTF )
		dim as wstring ptr srcstr = @wstr("ã é ô")
		dim as byte ptr utfstr
		dim as integer bytes

		utfstr = WCharToUTF( UTF_ENCOD_UTF8, srcstr, len( *srcstr ) + 1, NULL, @bytes )

		dim as wstring ptr newstr
		newstr = UTFToWChar( UTF_ENCOD_UTF8, utfstr, NULL, @bytes )
		
		CU_ASSERT( *newstr = *srcstr )

		deallocate( newstr )
		deallocate( utfstr )
	END_TEST

	'' If given a NULL destination, all conversion cases should allocate a result
	'' buffer that the caller must deallocate.
	TEST( wstringToNullDest )
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
	END_TEST

	'' If given a NULL destination, all conversion cases should allocate a result
	'' buffer that the caller must deallocate.
	TEST( zstringToNullDest )
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
	END_TEST

	'' Tests WCharToUTF and UTFToWChar with NULL dest.
	'' The rtlib has UTF encoding routines that can allocate memory for us. If using
	'' that version of them, they pre-allocate some chars (currently typically 8) at
	'' a time. To ensure this works correctly, we have to test with strings longer
	'' than that.
	TEST( UTFAndWCharNullDest )
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
	END_TEST

	'' Tests WCharToUTF and UTFToWChar with a preallocated destination buffer.
	'' These do not test the cases where the destination buffer is not long enough
	'' to hold the output string (which should work but result in no null
	'' terminators).
	TEST( UTFAndWCharPreallocDest )
		const TEXT = "testing with a long, but simple 7-bit ASCII string"
		dim src as wstring * 100 = wstr( TEXT )

		'' Use buffers shorter than the input buffer, but longer than the input string
		dim as integer buflen = (len( src ) + 2) * 4
		dim as ubyte ptr utfbuf = callocate( buflen )
		dim as ubyte ptr wbuf = callocate( buflen )

		scope
			'' Convert to UTF8, including null terminator
			dim as integer utf8bytes
			dim as ubyte ptr utf8 = WCharToUTF( UTF_ENCOD_UTF8, src, len( src ) + 1, utfbuf, @utf8bytes )
			CU_ASSERT( utf8 = utfbuf )
			CU_ASSERT( utf8bytes = (len( TEXT ) + 1) )
			CU_ASSERT( *cptr( zstring ptr, utf8 ) = TEXT )

			'' Convert back to wstring
			dim as integer chars = buflen  '' Input buffer length in characters
			dim as wstring ptr w = UTFToWChar( UTF_ENCOD_UTF8, utf8, wbuf, @chars )
			CU_ASSERT( w = wbuf )
			CU_ASSERT( chars = len( TEXT ) )
			CU_ASSERT( *w = src )
		end scope

		scope
			'' Convert to UTF16, including null terminator
			dim as integer utf16bytes
			memset( utfbuf, 0, buflen )
			dim as ushort ptr utf16 = WCharToUTF( UTF_ENCOD_UTF16, src, len( src ) + 1, utfbuf, @utf16bytes )
			CU_ASSERT( utf16 = cptr( ushort ptr, utfbuf ) )
			CU_ASSERT( (utf16bytes mod 2) = 0 )
			CU_ASSERT( (utf16bytes \ 2) = (len( TEXT ) + 1) )
			for i as integer = 0 to (utf16bytes \ 2) - 1
				CU_ASSERT( utf16[i] = src[i] )
			next

			'' Convert back to wstring
			dim as integer chars = buflen \ 2  '' Input buffer length in characters
			memset( wbuf, 0, buflen )
			dim as wstring ptr w = UTFToWChar( UTF_ENCOD_UTF16, utf16, wbuf, @chars )
			CU_ASSERT( w = wbuf )
			CU_ASSERT( chars = len( TEXT ) )
			CU_ASSERT( *w = src )
		end scope

		scope
			'' Convert to UTF32, including null terminator
			dim as integer utf32bytes
			memset( utfbuf, 0, buflen )
			dim as ulong ptr utf32 = WCharToUTF( UTF_ENCOD_UTF32, src, len( src ) + 1, utfbuf, @utf32bytes )
			CU_ASSERT( utf32 = cptr( ulong ptr, utfbuf ) )
			CU_ASSERT( (utf32bytes mod 4) = 0 )
			CU_ASSERT( (utf32bytes \ 4) = (len( TEXT ) + 1) )
			for i as integer = 0 to (utf32bytes \ 4) - 1
				CU_ASSERT( utf32[i] = src[i] )
			next

			'' Convert back to wstring
			dim as integer chars = buflen \ 4  '' Input buffer length in characters
			memset( wbuf, 0, buflen )
			dim as wstring ptr w = UTFToWChar( UTF_ENCOD_UTF32, utf32, wbuf, @chars )
			CU_ASSERT( w = wbuf )
			CU_ASSERT( chars = len( TEXT ) )
			CU_ASSERT( *w = src )
		end scope

		deallocate( utfbuf )
		deallocate( wbuf )
	END_TEST

	TEST( buildUtf16SurrogatePair )
		#ifdef __FB_LINUX__
			dim utf32 as wstring * 2
			utf32[0] = &h292B1
			dim utf16bytes as integer
			dim utf16 as ushort ptr = WCharToUTF( UTF_ENCOD_UTF16, @utf32, 1, NULL, @utf16bytes )
			CU_ASSERT( utf16bytes = sizeof( ushort ) * 2 )
			CU_ASSERT( utf16[0] = &hD864 )
			CU_ASSERT( utf16[1] = &hDEB1 )
		#elseif defined( __FB_WIN32__ )
			dim utf32(0 to 1) as ulong
			utf32(0) = &h292B1
			dim utf16chars as integer
			dim utf16 as wstring ptr = UTFToWchar( UTF_ENCOD_UTF32, @utf32(0), NULL, @utf16chars )
			CU_ASSERT( utf16chars = 2 )
			CU_ASSERT( (*utf16)[0] = &hD864 )
			CU_ASSERT( (*utf16)[1] = &hDEB1 )
		#endif
	END_TEST

	'' If there's not enough room for a full surrogate pair in the destination buffer,
	'' currently FB just writes the low surrogate (which is pretty weird, since it's
	'' normally behind (at a higher address than) the high surrogate, in an array of
	'' 16bit units).
	TEST( buildPartialUtf16SurrogatePair )
		#if defined( __FB_WIN32__ )
			dim utf32(0 to 1) as ulong
			utf32(0) = &h292B1
			dim utf16chars as integer = 1
			dim utf16 as wstring * 2
			UTFToWchar( UTF_ENCOD_UTF32, @utf32(0), @utf16, @utf16chars )
			CU_ASSERT( utf16chars = 1 )
			CU_ASSERT( utf16[0] = &hDEB1 )
			CU_ASSERT( utf16[1] = 0 )
		#endif
	END_TEST

END_SUITE
