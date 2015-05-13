/* float to wstring, internal usage */

#include "fb.h"

FB_WCHAR *fb_FloatExToWstr( double val, FB_WCHAR *buffer, int digits, int mask )
{
	FB_WCHAR *p;
	ssize_t len;

	if( mask & FB_F2A_ADDBLANK )
		p = &buffer[1];
	else
		p = buffer;

	swprintf( p, 16+8+1, _LC("%.*g"), digits, val );

	len = fb_wstr_Len( p );

	if( len > 0 )
	{
		/* skip the dot at end if any */
		if( len > 0 )
			if( p[len-1] == _LC('.') )
				p[len-1] = _LC('\0');
	}

	/* */
	if( (mask & FB_F2A_ADDBLANK) > 0 )
	{
		if( *p != _LC('-') )
		{
			*buffer = _LC(' ');
			return buffer;
		}
		else
			return p;
	}
	else
		return p;

}
