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
 *	file_put - put # function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"

/*:::::*/
int fb_FilePutDataEx
	(
		FB_FILE *handle,
		fb_off_t pos,
		const void *data,
		size_t length,
		int adjust_rec_pos,
		int checknewline,
		int is_unicode
	)
{
	int res;

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	if( pos < 0 )
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
        if( !is_unicode )
        {
        	if( handle->hooks->pfnWrite != NULL )
            	res = handle->hooks->pfnWrite( handle, data, length );
        	else
            	res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
        else
        {
        	if( handle->hooks->pfnWriteWstr != NULL )
            	res = handle->hooks->pfnWriteWstr( handle, (FB_WCHAR *)data, length );
        	else
            	res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }

    }

    if( handle->mode == FB_FILE_MODE_RANDOM &&
    	res==FB_RTERROR_OK &&
    	adjust_rec_pos &&
        handle->len!=0 &&
        handle->hooks->pfnSeek!=NULL )
    {
        /* if in random mode, writes must be of reclen.
         * The device must also support the SEEK method and the length
         * must be non-null */

		if( length != handle->len )
			res = fb_ErrorSetNum( FB_RTERROR_FILEIO );

        size_t skip_size = (handle->len -
        				   ((!is_unicode? length: length*sizeof( FB_WCHAR )) % handle->len)) % handle->len;
        if (skip_size != 0)
        {
            /* devices that don't support seek should simulate it
             with write or never allow to be opened for random access */
            handle->hooks->pfnSeek( handle, skip_size, SEEK_CUR );
        }
    }

#ifndef FB_NATIVE_TAB
    if( checknewline )
    	if ( res == FB_RTERROR_OK )
    	{
    		size_t i = length;
    		if( !is_unicode )
    		{
    			const char *pachText = (const char *) data;

        		/* search for last printed CR or LF */
        		while (i--)
        		{
            		char ch = pachText[i];
            		if (ch=='\n' || ch=='\r')
	                	break;
        		}
        	}
        	else
        	{
    			const FB_WCHAR *pachText = (const FB_WCHAR *) data;

        		/* search for last printed CR or LF */
        		while (i--)
        		{
            		FB_WCHAR ch = pachText[i];
            		if (ch == _LC('\n') || ch== _LC('\r') )
	                	break;
        		}

        	}

	       	handle = FB_HANDLE_DEREF(handle);
        	++i;
        	if (i==0)
	            handle->line_length += length;
    	    else
        	    handle->line_length = length - i;

        	{
            	int iWidth = FB_HANDLE_DEREF(handle)->width;
            	if( iWidth!=0 ) {
                	handle->line_length %= iWidth;
            	}
        	}
    	}
#endif

	FB_UNLOCK();

	/* set the error code again - handle->hooks->pfnSeek() may have reset it */
	return fb_ErrorSetNum( res );
}

/*:::::*/
int fb_FilePutData
	(
		int fnum,
		fb_off_t pos,
		const void *data,
		size_t length,
		int adjust_rec_pos,
		int checknewline
	)
{
    return fb_FilePutDataEx( FB_FILE_TO_HANDLE(fnum),
    						 pos, data, length, adjust_rec_pos, checknewline, FALSE );
}

/*:::::*/
FBCALL int fb_FilePut
	(
		int fnum,
		long pos,
		void* value,
		unsigned int valuelen
	)
{
	return fb_FilePutData( fnum, pos, value, valuelen, TRUE, FALSE );
}

/*:::::*/
FBCALL int fb_FilePutLarge
	(
		int fnum,
		long long pos,
		void *value,
		unsigned int valuelen
	)
{
	return fb_FilePutData( fnum, pos, value, valuelen, TRUE, FALSE );
}

