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
 * strw_comp.c -- wstring compare function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL int fb_WstrCompare
	(
		const FB_WCHAR *str1,
		const FB_WCHAR *str2
	)
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
	if( str1 == NULL )
	{
		/* right also null? return eq */
		if( (str2 == NULL) || (fb_wstr_Len( str2 ) == 0) )
			return 0;

		/* return lt */
		return -1;
	}

    /* only right is null. is left empty? return eq */
    if( fb_wstr_Len( str1 ) == 0 )
    	return 0;

	/* return gt */
	return 1;

}


