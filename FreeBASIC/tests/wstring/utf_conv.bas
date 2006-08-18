

#include once "utf_conv.bi"

#define NULL 0

sub test_z
	dim as zstring ptr srcstr = @"ã é ô"
	dim as byte ptr utfstr
	dim as integer bytes

	utfstr = CharToUTF( UTF_ENCOD_UTF8, srcstr, len( *srcstr ) + 1, NULL, @bytes )

	dim as zstring ptr newstr
	newstr = UTFToChar( UTF_ENCOD_UTF8, utfstr, NULL, @bytes )

	assert( *newstr = *srcstr )

	deallocate( newstr )
	deallocate( utfstr )
end sub

sub test_w
	
	dim as wstring ptr srcstr = @wstr("ã é ô")
	dim as byte ptr utfstr
	dim as integer bytes

	utfstr = WCharToUTF( UTF_ENCOD_UTF8, srcstr, len( *srcstr ) + 1, NULL, @bytes )

	dim as wstring ptr newstr
	newstr = UTFToWChar( UTF_ENCOD_UTF8, utfstr, NULL, @bytes )
	
	assert( *newstr = *srcstr )

	deallocate( newstr )
	deallocate( utfstr )
end sub


	test_z
	test_w