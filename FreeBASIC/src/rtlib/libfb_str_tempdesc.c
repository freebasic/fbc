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
 * str_tempdesc.c -- temp string descriptor allocation
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"

/*:::::*/
FBCALL FBSTRING *fb_StrAllocTempDesc( void *str, int str_size )
{
	FBSTRING *dsc;

 	/* alloc a temporary descriptor */
 	dsc = (FBSTRING *)fb_hStrAllocTmpDesc( );
    if( dsc == NULL )
    	return &fb_strNullDesc;

	/* fill it */
	if( str_size == -1 )
	{
		dsc->data = ((FBSTRING *)str)->data;
		dsc->len  = FB_STRSIZE( str );
		dsc->size = ((FBSTRING *)str)->size;
	}
	else
	{
		dsc->data = (char *)str;
		/* can't use strlen() if the size is known, otherwise GET# or PUT# 
		  would not work with fixed-len's */
		if( str_size != 0 )
		{
			dsc->len = str_size - 1;			/* less the null-term */
		}
		else
		{
			if( str != NULL )
				dsc->len = strlen( str );
			else
				dsc->len = 0;
		}
		dsc->size = dsc->len;
	}

	return dsc;
}
