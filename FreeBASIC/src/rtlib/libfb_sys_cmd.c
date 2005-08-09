/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
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
 * sys_cmd.c -- command$
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"


/*:::::*/
FBCALL FBSTRING *fb_Command ( int argc )
{
	FBSTRING 	*dst;
	char		*cline, *p, c;
	int			len, arg, isstr;

	cline = fb_hGetCommandLine( );

	if( cline == NULL )
		return &fb_strNullDesc;

	if( argc < 0 )
	{

#ifdef TARGET_WIN32
		/* exe paths with white-spaces are quoted on Windows */
		if( cline[0] == '"' )
		{
			cline = strchr( &cline[1], '"' );
			if( cline != NULL )
				++cline;
			else
				return &fb_strNullDesc;
		}
#endif

		/* skip argv[0] */
		cline = strchr( cline, ' ' );

		if( cline == NULL )
			return &fb_strNullDesc;
		++cline;

        len = strlen( cline );

        /* remove spaces at end of line */
        while( len!=0 && cline[len-1]==' ' )
            --len;
	}
	else
	{
		p = cline;
		arg = 0;
		len = 0;

		while( *p != '\0' )
		{
			/* skip white-spc */
			while( 1 )
			{
				c = *p;
				if( (c != ' ') && (c != '\t') )
					break;
				++p;
			}

			/* end? */
			if( (c == '\r') || (c == '\0') )
				break;

			cline = p;

			/* read until next white-space */
			isstr = 0;
			do
			{
				++p;

				/* handle quotes */
				if( c == '"' )
				{
					if( isstr != 0 )
					{
						if( arg == argc )
							--p;
						break;
					}
					else
					{
						isstr = 1;
						if( arg == argc )
							++cline;
					}
				}

				c = *p;
				if( isstr == 0 )
					if( (c == ' ') || (c == '\t') )
						break;

			} while( (c != '\r') && (c != '\0') );

			/* found? */
			if( arg == argc )
			{
				len = p - cline;
				break;
			}

			++arg;
		}
	}

	if( len <= 0 )
		return &fb_strNullDesc;

	FB_STRLOCK();
	
	/* alloc temp string */
    dst = fb_hStrAllocTemp( NULL, len );
	if( dst != NULL )
	{
		memcpy( dst->data, cline, len );
		dst->data[len] = '\0';
	}
	else {
		FB_STRUNLOCK();
		return &fb_strNullDesc;
	}

	FB_STRUNLOCK();

	return dst;
}
