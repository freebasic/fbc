/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2008 The FreeBASIC development team.
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
 * str_ftoa.c -- float to string, internal usage
 *
 * chng: dec/2005 written [v1ctor]
 *
 */

#include <stdlib.h>
#include <stdio.h>
#include "fb.h"

/*:::::*/
char *fb_hFloat2Str( double val, char *buffer, int digits, int mask )
{
	int len, maxlen;
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

