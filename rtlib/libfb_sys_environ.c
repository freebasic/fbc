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
	char 		*p;

	p = getenv( varname->data );

	if( p != NULL )
	{
		dst = (FBSTRING *)fb_hStrAllocTmpDesc( );
		fb_StrAssign( (void *)dst, -1, (void *)p, strlen( p ) );
		dst->len |= FB_TEMPSTRBIT;					/* mark as temp */
	}
	else
		dst = &fb_strNullDesc;

	/* del if temp */
	fb_hStrDelTemp( varname );

	return dst;
}


/*:::::*/
FBCALL int fb_SetEnviron ( FBSTRING *str )
{
	int res;

#if WIN32
	res = _putenv( str->data );
#else
	!!!WRITEME!!!
#endif

	/* del if temp */
	fb_hStrDelTemp( str );

	return res;
}

