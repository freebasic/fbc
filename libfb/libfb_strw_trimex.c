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
 * strw_trim.c -- enhanced trimw$ function
 *
 * chng: nov/2005 written [mjs]
 *
 */

#include <stdlib.h>
#include "fb.h"


/*:::::*/
FBCALL FB_WCHAR *fb_WstrTrimEx ( const FB_WCHAR *src, const FB_WCHAR *pattern )
{
	FB_WCHAR 	*dst;
	size_t       len;
	const FB_WCHAR *p = NULL;

    if( src == NULL ) {
        return NULL;
    }

    {
        size_t len_pattern = fb_wstr_Len( pattern );
        len = fb_wstr_Len( src );
        if( len >= len_pattern ) {
            if( len_pattern==1 ) {
                p = fb_wstr_SkipChar( src,
                                      len,
                                      *pattern );
                len = len - (int)(p - src);

            } else if( len_pattern != 0 ) {
                p = src;
                while (len >= len_pattern ) {
                    if( fb_wstr_Compare( p, pattern, len_pattern )!=0 )
                        break;
                    p += len_pattern;
                    len -= len_pattern;
                }
            }
        }
        if( len >= len_pattern ) {
            if( len_pattern==1 ) {
                const FB_WCHAR *p_tmp =
                    fb_wstr_SkipCharRev( p,
                                         len,
                                         *pattern );
                len = (int)(p_tmp - p) + 1;

            } else if( len_pattern != 0 ) {
                size_t test_index = len - len_pattern;
                while (len >= len_pattern ) {
                    if( fb_wstr_Compare( p + test_index,
                                         pattern,
                                         len_pattern )!=0 )
                        break;
                    test_index -= len_pattern;
                }
                len = test_index + len_pattern;

            }
        }
	}

	if( len > 0 )
	{
		/* alloc temp string */
        dst = fb_wstr_AllocTemp( len );
		if( dst != NULL )
		{
			/* simple copy */
			fb_wstr_Copy( dst, p, len );
		}
		else
			dst = NULL;
    }
	else
		dst = NULL;

	return dst;
}
