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
 * strw_set.c -- lsetw and rsetw functions
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL void fb_WstrLset ( FB_WCHAR *dst, FB_WCHAR *src )
{
    int slen, dlen, len;

	if( (dst != NULL) && (src != NULL) )
	{
		slen = fb_wstr_Len( src );
		dlen = fb_wstr_Len( dst );

		if( dlen > 0 )
		{
			len = (dlen <= slen? dlen: slen );

			fb_wstr_Copy( dst, src, len );

			len = dlen - slen;
			if( len > 0 )
				fb_wstr_Fill( &dst[slen], 32, len );
		}
	}

}

/*:::::*/
FBCALL void fb_WstrRset ( FB_WCHAR *dst, FB_WCHAR *src )
{
    int slen, dlen, len, padlen;

	if( (dst != NULL) && (src != NULL) )
	{
		slen = fb_wstr_Len( src );
		dlen = fb_wstr_Len( dst );

		if( dlen > 0 )
		{
			padlen = dlen - slen;
			if( padlen > 0 )
				fb_wstr_Fill( dst, 32, padlen );
			else
				padlen = 0;

			len = (dlen <= slen? dlen: slen );

			fb_wstr_Copy( &dst[padlen], src, len );
		}
	}
}

