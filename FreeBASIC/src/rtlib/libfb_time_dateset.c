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
 * time_dateset.c -- setdate function
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
FBCALL int fb_SetDate( FBSTRING *date )
{

/* valid formats:
   mm/dd/yy
   mm/dd/yyy
   mm-dd-yy
   mm-dd-yyyy

   assumes 2-digit years are 1900 + year - !!!FIXME!!! - not sure how QB handles these
*/

	if( (date != NULL) && (date->data != NULL) )
	{

    	char *t, c, sep;
    	int i, m, d, y;

     	/* get month */
    	m = 0;
    	for (i = 0, t = date->data; (c = *t) && isdigit(c); t++, i += 10)
			m = m * i + c - '0';

    	if (((c != '/') && (c != '-')) || (m < 1) || (m > 12))
			return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    	sep = c;

    	/* get day */
    	d = 0;
    	for (i = 0, t++; (c = *t) && isdigit(c); t++, i += 10)
        	d = d * i + c - '0';

    	if ((c != sep) || (d < 1) || (d > 31))
			return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    	/* get year */
    	y = 0;
    	for (i = 0, t++; (c = *t) && isdigit(c); t++, i += 10)
        	y = y * i + c - '0';

    	if (y < 100) y += 1900;


		fb_hSetDate( y, m, d );

	}

	/* del if temp */
	fb_hStrDelTemp( date );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
