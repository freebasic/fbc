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
 * strw_concat.c -- wstring concatenation function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL FB_WCHAR *fb_WstrConcat ( const FB_WCHAR *str1, const FB_WCHAR *str2 )
{
	FB_WCHAR *dst, *d;
	int str1_len, str2_len;

	if( str1 != NULL )
		str1_len = fb_wstr_Len( str1 );
	else
		str1_len = 0;

	if( str2 != NULL )
		str2_len = fb_wstr_Len( str2 );
	else
		str2_len = 0;

	/* NULL? */
	if( str1_len + str2_len == 0 )
		return NULL;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( str1_len + str2_len );

	/* do the concatenation */
    d = fb_wstr_Move( dst, str1, str1_len );
    d = fb_wstr_Move( d, str2, str2_len );
    *d = L'\0';

	return dst;
}

