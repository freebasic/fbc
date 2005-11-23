#ifndef __FB_UNICODE_W32__
#define __FB_UNICODE_W32__

#include <wchar.h>
#include <wctype.h>

#define swprintf _snwprintf

#define FB_WSTR_FROM_INT( buffer, num ) \
    _itow( num, buffer, 10 )

#define FB_WSTR_FROM_UINT( buffer, num ) \
    _ultow( (unsigned long) num, buffer, 10 )

#define FB_WSTR_FROM_UINT_OCT( buffer, num ) \
    _itow( num, buffer, 8 )

#define FB_WSTR_FROM_INT64( buffer, num ) \
    _i64tow( num, buffer, 10 )

#define FB_WSTR_FROM_UINT64( buffer, num ) \
    _ui64tow( num, buffer, 10 )

#define FB_WSTR_FROM_UINT64_OCT( buffer, num ) \
    _ui64tow( num, buffer, 8 )

/*:::::*/
static __inline__ void fb_wstr_WcharToChar( char *dst, const FB_WCHAR *src, int chars )
{
	UTF_16 c;

	while( chars-- )
	{
		c = *src++;

		if( c > 255 )
		{
			if( c >= UTF16_SUR_HIGH_START && c <= UTF16_SUR_HIGH_END )
    			++src;
    		c = '?';
    	}

		*dst++ = c;
	}
}

#define FB_WSTR_WCHARTOCHAR fb_wstr_WcharToChar

#endif /* __FB_UNICODE_W32__ */
