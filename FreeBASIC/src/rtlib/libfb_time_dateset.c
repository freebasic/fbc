/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 * time_dateset.c -- setdate function
 *
 * chng: jan/2005 written [DrV]
 *       dec/2005 major string to int conversion bug fixed [DrV]
 *
 */


#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "fb.h"


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
