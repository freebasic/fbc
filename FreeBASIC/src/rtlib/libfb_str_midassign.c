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
 * str_midassign.c -- mid$ statement
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include <string.h>
#include "fb.h"


/*:::::*/
FBCALL void fb_StrAssignMid ( FBSTRING *dst, int start, int len, FBSTRING *src )
{
    int 	src_len, dst_len;

	FB_STRLOCK();

    if( (dst == NULL) || (dst->data == NULL) || (FB_STRSIZE( dst ) == 0) )
    {
    	fb_hStrDelTemp_NoLock( src );
    	fb_hStrDelTemp_NoLock( dst );
    	FB_STRUNLOCK();
    	return;
    }

    if(	(src == NULL) || (src->data == NULL) || (FB_STRSIZE( src ) == 0) ) {
        fb_hStrDelTemp_NoLock( src );
    	fb_hStrDelTemp_NoLock( dst );
    	FB_STRUNLOCK();
    	return ;
    }


	src_len = FB_STRSIZE( src );
	dst_len = FB_STRSIZE( dst );

	if( (start > 0) && (start <= dst_len) && (len != 0) )
    {
		--start;

		if( (len < 0) || (len > src_len) )
			len = src_len;

        if( start + len > dst_len )
        	len = (dst_len - start);

		memcpy( dst->data + start, src->data, len );
    }

	/* del if temp */
	fb_hStrDelTemp_NoLock( src );
    fb_hStrDelTemp_NoLock( dst );

   	FB_STRUNLOCK();
}
