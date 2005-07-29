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
 *	file_put - put # function
 *
 * chng: oct/2004 written [marzec/v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
int fb_FilePutDataEx( FB_FILE *handle,
					  long pos,
					  const void *data,
					  size_t length,
					  int adjust_rec_pos,
					  int checknewline )
{
    const char *pachText = (const char *) data;
    size_t i;
	int res;

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    FB_LOCK();

    res = fb_ErrorSetNum( FB_RTERROR_OK );

    /* clear put back buffer for every modifying non-read operation */
    handle->putback_size = 0;

    /* seek to newpos */
    if( pos > 0 )
        res = fb_FileSeekEx( handle, pos );

    if (res==FB_RTERROR_OK)
    {
        /* do write */
        if( handle->hooks->pfnWrite != NULL )
            res = handle->hooks->pfnWrite( handle, data, length );
        else
            res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if (res==FB_RTERROR_OK && adjust_rec_pos
        && handle->len!=0 && handle->hooks->pfnSeek!=NULL
        && handle->mode == FB_FILE_MODE_RANDOM )
    {
        /* if in random mode, writes must be of reclen.
         * The device must also support the SEEK method and the length
         * must be non-null */
        size_t skip_size = handle->len - (length % handle->len);
        if (skip_size != 0)
        {
            /* devices that don't support seek should simulate it
             with write or never allow to be opened for random access */
            handle->hooks->pfnSeek( handle, skip_size, SEEK_CUR );
        }
    }

#ifndef FB_NATIVE_TAB
    if( checknewline )
    	if ( res == FB_RTERROR_OK ) {
        	/* search for last printed CR or LF */
        	i=length;
        	while (i--) {
            	char ch = pachText[i];
            	if (ch=='\n' || ch=='\r') {
	                break;
    	        }
        	}
        	++i;
        	handle = FB_HANDLE_DEREF(handle);
        	if (i==0) {
	            handle->line_length += length;
    	    } else {
        	    handle->line_length = length - i;
        	}
        	{
            	int iWidth = FB_HANDLE_DEREF(handle)->width;
            	if( iWidth!=0 ) {
                	handle->line_length %= iWidth;
            	}
        	}
    	}
#endif

	FB_UNLOCK();

	return res;
}

/*:::::*/
int fb_FilePutData( int fnum,
					long pos,
					const void *data,
					size_t length,
					int adjust_rec_pos,
					int checknewline )
{
    return fb_FilePutDataEx( FB_FILE_TO_HANDLE(fnum),
    						 pos, data, length, adjust_rec_pos, checknewline );
}

/*:::::*/
FBCALL int fb_FilePut( int fnum, long pos, void* value, unsigned int valuelen )
{
	return fb_FilePutData( fnum, pos, value, valuelen, TRUE, FALSE );
}
