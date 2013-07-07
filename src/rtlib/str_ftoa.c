/* float to string, internal usage */

#include "fb.h"

char *fb_hFloat2Str( double val, char *buffer, int digits, int mask )
{
	ssize_t len, maxlen;
	char *p;
	char fmtstr[16], *fstr;

	if( mask & FB_F2A_ADDBLANK )
		p = &buffer[1];
	else
		p = buffer;

	switch( digits )
	{
	case 7:
		fstr = (char *)&"%.7g";
		break;
	case 16:
		fstr = (char *)&"%.16g";
		break;
	default:
		sprintf( fmtstr, "%%.%dg", digits );
		fstr = &fmtstr[0];
	}

	maxlen = 1+digits+6+1;

	len = snprintf( p, maxlen, fstr, val );

	if( len <= 0 || len >= maxlen )
	{
		buffer[0] = '\0';
		return NULL;
	}

	if( len > 0 )
	{
		/* skip the dot at end if any */
		if( len > 0 )
			if( p[len-1] == '.' )
				p[len-1] = '\0';
	}

	/* */
	if( (mask & FB_F2A_ADDBLANK) > 0 )
	{
		if( p[0] != '-' )
		{
			buffer[0] = ' ';
			return &buffer[0];
		}
		else
			return p;
	}
	else
		return p;
}
