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
 * str_trim.c -- enhanced trim$ function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"


/*:::::*/
FBCALL FBSTRING *fb_TrimEx 
	( 
		FBSTRING *src, 
		FBSTRING *pattern 
	)
{
	FBSTRING *dst;
	size_t len;
	char *src_ptr = NULL;

    if( src == NULL ) 
    {
        fb_hStrDelTemp( pattern );
        return &__fb_ctx.null_desc;
    }

	FB_STRLOCK();

	if( src->data != NULL )
    {
        size_t len_pattern = ((pattern != NULL) && (pattern->data != NULL)? FB_STRSIZE( pattern ) : 0);
        len = FB_STRSIZE( src );
        src_ptr = src->data;
        if( len >= len_pattern ) 
        {
            if( len_pattern==1 ) 
            {
                src_ptr = fb_hStrSkipChar( src_ptr,
                                     	   len,
                                     	   FB_CHAR_TO_INT(pattern->data[0]) );
                len = len - (int)(src_ptr - src->data);

            } 
            else if( len_pattern != 0 ) 
            {                
                while (len >= len_pattern ) 
                {
                    if( FB_MEMCMP( src_ptr, pattern->data, len_pattern )!=0 )
                        break;
                    src_ptr += len_pattern;
                    len -= len_pattern;
                }
            }
        }
        
        if( len >= len_pattern ) 
        {
            if( len_pattern==1 ) 
            {
                char *p_tmp =
                    fb_hStrSkipCharRev( src_ptr,
                                        len,
                                        FB_CHAR_TO_INT(pattern->data[0]) );
                len = (int)(p_tmp - src_ptr) + 1;

            } 
            else if( len_pattern != 0 ) 
            {
                size_t test_index = len - len_pattern;
                while (len >= len_pattern ) 
                {
                    if( FB_MEMCMP( src_ptr + test_index,
                                   pattern->data,
                                   len_pattern )!=0 )
                        break;
                    test_index -= len_pattern;
                }
                len = test_index + len_pattern;

            }
        }
	}
	else
		len = 0;

	if( len > 0 )
	{
		/* alloc temp string */
        dst = fb_hStrAllocTemp_NoLock( NULL, len );
		if( dst != NULL )
		{
			/* simple copy */
			fb_hStrCopy( dst->data, src_ptr, len );
		}
		else
			dst = &__fb_ctx.null_desc;
    }
	else
		dst = &__fb_ctx.null_desc;

	/* del if temp */
	fb_hStrDelTemp_NoLock( src );
    fb_hStrDelTemp_NoLock( pattern );

	FB_STRUNLOCK();

	return dst;
}




