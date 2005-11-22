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
 *	dev_file - file device
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include "fb.h"
#include "fb_rterr.h"

static char *hWrapper( char *buffer, size_t count, FILE *fp )
{
    return fgets( buffer, count, fp );
}

/*:::::*/
int fb_DevFileReadLineDumb( FILE *fp, FBSTRING *dst, fb_FnDevReadString pfnReadString )
{
    int res = fb_ErrorSetNum( FB_RTERROR_OK );
    char buffer[512];
    size_t buffer_len = sizeof(buffer);
    int found;
    FBSTRING *src;

    DBG_ASSERT( dst!=NULL );

	FB_LOCK();

	if( pfnReadString == NULL )
		pfnReadString = hWrapper;

    found = FALSE;
    while (!found) {
        int tmp_buf_len;

        memset( buffer, 0, buffer_len );

        if( pfnReadString( buffer, sizeof( buffer ), fp ) == NULL )
        {
            /* EOF reached ... this is not an error !!! */
            res = FB_RTERROR_FILEIO; /* but we have to notify the caller */
            break;
        }

        /* the last character always is NUL */
        buffer_len = sizeof(buffer) - 1;

        /* now let's find the end of the buffer */
        while (buffer_len--)
        {
            char ch = buffer[buffer_len];
            if (ch==13 || ch==10)
            {
                /* accept both CR and LF */
                found = TRUE;
                break;
            }
            else if( ch!=0 )
            {
                /* a character other than CR/LF found ... i.e. buffer full */
                break;
            }
        }

        if( !found )
        {
            /* remember the real length */
            tmp_buf_len = buffer_len += 1;

            /* not found ... so simply add this to the result string */

        }
        else
        {
            /* remember the real length */
            tmp_buf_len = buffer_len + 1;

            /* filter a (possibly valid) CR/LF sequence */
            if( buffer[buffer_len]==10 && buffer_len!=0 )
            {
                if( buffer[buffer_len-1]==13 )
                {
                    --buffer_len;
                }
            }

            /* set the CR or LF to NUL */
            buffer[buffer_len] = 0;
        }

        /* create temporary string to ensure that NUL's are preserved ...
         * this function wants the length WITH the NUL character!!! */
        src = fb_StrAllocTempDescF( buffer, buffer_len + 1);

        /* concatenate */
        fb_StrConcatAssign ( dst, -1, src, -1, FALSE );

        /* the temporary string is already deleted by fb_StrConcatAssign */

        buffer_len = tmp_buf_len;
    }

	FB_UNLOCK();

	return res;

}

/*:::::*/
int fb_DevFileReadLine( struct _FB_FILE *handle, FBSTRING *dst )
{
    int res;
    FILE *fp;

	FB_LOCK();

    fp = (FILE*) handle->opaque;
    if( fp==stdout || fp==stderr )
        fp = stdin;

	if( fp == NULL )
	{
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

    res = fb_DevFileReadLineDumb( fp, dst, NULL );

	FB_UNLOCK();

	return res;
}
