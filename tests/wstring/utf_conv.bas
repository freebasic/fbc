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

sub ctor () constructor
	fbcu.add_suite("fbc_tests.wstrings.utf_conv")
	fbcu.add_test("test_z", @test_z)
	fbcu.add_test("test_w", @test_w)
end sub

end namespace
