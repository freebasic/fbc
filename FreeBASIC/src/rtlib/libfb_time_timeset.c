/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
 * time_timeset.c -- settime function
 *
 * chng: jan/2005 written [DrV]
 *
 */


#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "fb.h"
#include "fb_rterr.h"


/*:::::*/
FBCALL int fb_SetTime( FBSTRING *time )
{

/* valid formats:
   hh
   hh:mm
   hh:mm:ss
*/
	FB_STRLOCK();

	if( (time != NULL) && (time->data != NULL) )
	{

    	char *t, c;
    	int i, h, m = 0, s = 0;

    	/* get hours */
    	h = 0;
		for (i = 0, t = time->data; (c = *t) && isdigit(c); t++, i += 10)
			h = h * i + c - '0';

		if( (h > 23) || (c != '\0' && c != ':') ) {
			FB_STRUNLOCK();
			return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		}

    	if (c != '\0')
    	{
			/* get minutes */
     		m = 0;
     		for (i = 0, t++; (c = *t) && isdigit(c); t++, i += 10)
        		 m = m * i + c - '0';

     		if( (m > 59) || (c != '\0' && c != ':') ) {
				FB_STRUNLOCK();
     			return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
     		}

     		if (c != '\0')
     		{
     			/* get seconds */
     			s = 0;
     			for (i = 0, t++; (c = *t) && isdigit(c); t++, i += 10)
         			s = s * i + c - '0';
    		}
    	}

    	if ((s > 59) || (c != '\0')) {
			FB_STRUNLOCK();
			return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		}


		fb_hSetTime( h, m, s );

	}

	/* del if temp */
	fb_hStrDelTemp( time );

	FB_STRUNLOCK();
		
	return fb_ErrorSetNum( FB_RTERROR_OK );
}

