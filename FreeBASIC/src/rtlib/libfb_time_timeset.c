/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
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

