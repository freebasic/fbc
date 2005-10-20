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
 * strw_comp.c -- wstring compare function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL int fb_WstrCompare ( const FB_WCHAR *str1, const FB_WCHAR *str2 )
{
	int res, str1_len, str2_len;

	/* both not null? */
	if( (str1 != NULL) && (str2 != NULL) )
	{
		str1_len = fb_wstr_Len( str1 );
        str2_len = fb_wstr_Len( str2 );

        res = fb_wstr_Compare( str1, str2, ((str1_len < str2_len) ? str1_len : str2_len) );
        if( (res == 0) && (str1_len != str2_len) )
        	res = (( str1_len > str2_len ) ? 1 : -1 );

        return res;

	}
	/* left null? */
	else if( str1 == NULL )
	{
		/* right also null? return == */
		if( str2 == NULL )
			return 0;
		else
		{
			/* return < */
			return -1;
		}
	}
    /* only right is null */
    else
    {
		/* return > */
		return 1;
	}
}


