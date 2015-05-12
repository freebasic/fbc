/* setdate function */

#include "fb.h"
#include <ctype.h>

/** Sets the date to the specified value.
 *
 * Valid formats:
 * - mm/dd/yy
 * - mm/dd/yyyy
 * - mm-dd-yy
 * - mm-dd-yyyy
 *
 * VBDOS converts a 2-digit year by adding 1900.
 *
 * @see fb_Date()
 */
FBCALL int fb_SetDate( FBSTRING *date )
{
	if( (date != NULL) && (date->data != NULL) )
	{

		char *t, c, sep;
		int m, d, y;

		/* get month */
		m = 0;
		for( t = date->data; (c = *t) && isdigit(c); t++ )
		{
			m = m * 10 + c - '0';
		}

		if( ((c != '/') && (c != '-')) || (m < 1) || (m > 12) )
		{
			return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		}
		sep = c;

		/* get day */
		d = 0;
		for( t++; (c = *t) && isdigit(c); t++ )
		{
			d = d * 10 + c - '0';
		}

		if( (c != sep) || (d < 1) || (d > 31) )
		{
			return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		}

		/* get year */
		y = 0;
		for( t++; (c = *t) && isdigit(c); t++ )
		{
			y = y * 10 + c - '0';
		}

		if (y < 100) y += 1900;

		if( fb_hSetDate( y, m, d ) )
		{
			return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		}
	}

	/* del if temp */
	fb_hStrDelTemp( date );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
