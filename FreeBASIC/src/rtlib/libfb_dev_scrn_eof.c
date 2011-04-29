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
 *	dev_file_eof - detects EOF for file device
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"

void fb_DevScrnFillInput( DEV_SCRN_INFO *info )
{
    FBSTRING *str;
    size_t len = 0;

    str = fb_Inkey( );
    if( str != NULL )
    {
    	len = FB_STRSIZE( str );
	    if( (str->data != NULL) && (len > 0) )
	    {
	    	DBG_ASSERT(len < sizeof(info->buffer));
    		/* copy null-term too */
    		memcpy( info->buffer, str->data, len+1 );
    	}

    	fb_hStrDelTemp( str );
    }

    info->length = len;
}

/*:::::*/
int fb_DevScrnEof( struct _FB_FILE *handle )
{
    DEV_SCRN_INFO *info;
    int       got_data;

    FB_LOCK();
    info = (DEV_SCRN_INFO*) FB_HANDLE_DEREF(handle)->opaque;
    got_data = info->length!=0;
    FB_UNLOCK();
    if( !got_data ) {
        FB_LOCK();
        fb_DevScrnFillInput( info );
        got_data = info->length!=0;
        FB_UNLOCK();
    }
	return !got_data;
}


