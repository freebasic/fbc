/* wstring to UTF conversion
 * (based on ConvertUTF.c free implementation from Unicode, Inc)
 */

#include "fb.h"

const UTF_8 __fb_utf8_bmarkTb[7] = 
	{ 
		0x00, 0x00, 0xC0, 0xE0, 0xF0, 0xF8, 0xFC	
	};

const char __fb_utf8_trailingTb[256] =
	{
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2, 3,3,3,3,3,3,3,3,4,4,4,4,5,5,5,5
	};

const UTF_32 __fb_utf8_offsetsTb[6] =
	{
		0x00000000UL, 0x00003080UL, 0x000E2080UL, 0x03C82080UL, 0xFA082080UL, 0x82082080UL
	};

/*:::::*/
void fb_hCharToUTF8( const char *src, int chars, char *dst, int *total_bytes )
{
	UTF_8 c;

	*total_bytes = 0;
	while( chars > 0 )
	{
		c = *src++;
		if( c < 0x80 )
		{
			*dst++ = c;
			*total_bytes += 1;
		}
		else
		{
			*dst++ = 0xC0 | (c >> 6);
			*dst++ = ((c | UTF8_BYTEMARK) & UTF8_BYTEMASK);
			*total_bytes += 2;
		}

		--chars;
	}
}

