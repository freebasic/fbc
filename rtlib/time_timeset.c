/* settime function */

#include "fb.h"
#include <ctype.h>

/*:::::*/
FBCALL int fb_SetTime( FBSTRING *time )
{

/* valid formats:
   hh
   hh:mm
   hh:mm:ss
*/
	if( (time != NULL) && (time->data != NULL) )
	{

		char *t, c;
		int i, h, m = 0, s = 0;

		/* get hours */
		h = 0;
		for( i = 0, t = time->data; (c = *t) && isdigit(c); t++, i += 10 )
		{
			h = h * i + c - '0';
		}

		if( (h > 23) || (c != '\0' && c != ':') )
		{
			return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		}

		if( c != '\0' )
		{
			/* get minutes */
			m = 0;
			for( i = 0, t++; (c = *t) && isdigit(c); t++, i += 10 )
			{
				 m = m * i + c - '0';
			}

			if( (m > 59) || (c != '\0' && c != ':') )
			{
				return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
			}

			if( c != '\0' )
			{
				/* get seconds */
				s = 0;
				for (i = 0, t++; (c = *t) && isdigit(c); t++, i += 10)
					s = s * i + c - '0';
			}
		}

		if( (s > 59) || (c != '\0') )
		{
			return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		}


		if ( fb_hSetTime( h, m, s ) )
		{
			return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );	
		}
	}

	/* del if temp */
	fb_hStrDelTemp( time );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

