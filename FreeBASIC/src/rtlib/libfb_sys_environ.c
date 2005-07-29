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
 * sys_environ.c -- environ$ function and setenviron stmt
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"
#include <stdlib.h>

/*:::::*/
FBCALL FBSTRING *fb_GetEnviron ( FBSTRING *varname )
{
	FBSTRING 	*dst;
	char 		*tmp;
	int			len;

	FB_STRLOCK();
		
	if( (varname != NULL) && (varname->data != NULL) )
		tmp = getenv( varname->data );
	else
		tmp = NULL;

	if( tmp != NULL )
	{
		dst = (FBSTRING *)fb_hStrAllocTmpDesc( );
		if( dst != NULL )
		{
			len = strlen( tmp );
			fb_hStrAllocTemp( dst, len );
			fb_hStrCopy( dst->data, tmp, len );		
		} 
		else
			dst = &fb_strNullDesc;
	}
	else
		dst = &fb_strNullDesc;

	/* del if temp */
	fb_hStrDelTemp( varname );

	FB_STRUNLOCK();

	return dst;
}


/*:::::*/
FBCALL int fb_SetEnviron ( FBSTRING *str )
{
	int res = 0;

	FB_STRLOCK();

	if( (str != NULL) && (str->data != NULL) )
	{
#if TARGET_WIN32
		res = _putenv( str->data );
#else
		res = putenv( str->data );
#endif
	}

	/* del if temp */
	fb_hStrDelTemp( str );

	FB_STRUNLOCK();
		
	return res;
}

