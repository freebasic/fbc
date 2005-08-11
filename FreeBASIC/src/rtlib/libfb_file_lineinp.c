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
 * file_lineinput - line input function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

#define BUFFER_LEN 1024

typedef enum _eInputMode {
    eIM_Invalid,
    eIM_ReadLine,
    eIM_Read
} eInputMode;

/*:::::*/
static int fb_hFileLineInputEx( FB_FILE *handle,
                                FBSTRING *text, void *dst, int dst_len,
                                int fillrem, int addquestion, int addnewline )
{
	int			len, readlen, is_console;
	char		buffer[BUFFER_LEN];
    FBSTRING   *str_result;
    eInputMode  mode = eIM_Invalid;

    fb_DevScrnInit_ReadLine( );

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    FB_LOCK();

    is_console = FB_HANDLE_IS_SCREEN(handle);

    if( handle->hooks->pfnReadLine != NULL ) {
        mode = eIM_ReadLine;
    } else if( handle->hooks->pfnRead != NULL &&
               handle->hooks->pfnEof != NULL )
    {
        mode = eIM_Read;
    }

    FB_UNLOCK();

    if( mode==eIM_Invalid )
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    /* Only devices with a width and read function are allowed to print
     * a question. Currently, I don't test for the width and read function
     * pointers ... */
    if( is_console )
    {
        FB_STRLOCK();
		if( text != NULL )
		{
            if( text->data != NULL ) {
                fb_PrintStringEx( handle, text, 0 );
			}

			if( addquestion != FB_FALSE )
			{
				strcpy( buffer, "? " );
				fb_PrintFixStringEx( handle, buffer, 0 );
			}
		}

        FB_STRUNLOCK();
	}


    FB_LOCK();

    switch( mode ) {
    case eIM_Read:
        /* This is the VFS-compatible way to read a line ... but it's slow */
        len = readlen = 0;
        while (!handle->hooks->pfnEof(handle)) {
            int do_add = FALSE, do_break = FALSE;
            size_t read_len = 1;
            int res = fb_FileGetDataEx( handle, 0, buffer+len, &read_len, FALSE );
            if( res==FB_RTERROR_OK && read_len==1) {
                char ch = buffer[len];
                if( ch==13 ) {
                    res = fb_FileGetDataEx( handle, 0, &ch, &read_len, FALSE );
                    if( res==FB_RTERROR_OK && ch!=10 && read_len==1) {
                        fb_FilePutBackEx( handle, &ch, 1 );
                    }
                    ch = 10;
                }
                if( ch==10 ) {
                    do_add = do_break = TRUE;
                } else {
                    do_add = len==(sizeof(buffer)-1);
                }
            } else {
                do_add = len!=0;
            }
            if( do_add || handle->hooks->pfnEof( handle ) ) {
                /* create temporary string to ensure that NUL's are preserved ...
                 * this function wants the length WITH the NUL character!!! */
                buffer[len] = 0;
                FBSTRING *src = fb_StrAllocTempDescF( buffer, len + 1);
                if( readlen==0 ) {
                    fb_StrAssign( dst, dst_len, src, -1, fillrem );
                } else {
                    fb_StrConcatAssign ( dst, dst_len, src, -1, fillrem );
                }
                readlen += len;
                len = 0;
            } else {
                ++len;
            }
            if( res!=FB_RTERROR_OK || do_break )
                break;
        }
        if( readlen == 0 ) {
            /* del destine string */
            if( dst_len == -1 )
                fb_StrDelete( (FBSTRING *)dst );
            else
                *(char *)dst = '\0';
        }
        break;
    case eIM_ReadLine:
        /* The read line mode is the most comfortable ... but IMHO it's
         * only useful for special devices (like SCRN:) */
        {
            /* create temporary string */
            str_result = fb_StrAllocTempDescZ( NULL );
            DBG_ASSERT(str_result != NULL);

            /* read complete line (may include NULs) */
            handle->hooks->pfnReadLine( handle, str_result );

            /* add contents of tempporary string to result buffer */
            fb_StrAssign( dst, dst_len, str_result, -1, fillrem );
            /* INFO: temporary string will be deleted during assignment */
            readlen = FB_STRSIZE( dst );
        }
        break;
    case eIM_Invalid:
        /* the "invalid" mode was already handled above ... so we don't
         * need to do anything here ... */
        break;
    }

	/* - */
    if( is_console ) {
        if( addnewline ) {
            fb_FilePutDataEx( handle, 0, FB_NEWLINE, sizeof(FB_NEWLINE)-1, FALSE, TRUE );
        }
    }

    FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
static int fb_hFileLineInput( int fnum, FBSTRING *text, void *dst, int dst_len,
                              int fillrem, int addquestion, int addnewline )
{
    return fb_hFileLineInputEx( FB_FILE_TO_HANDLE(fnum), text, dst, dst_len,
                                fillrem, addquestion, addnewline);
}

/*:::::*/
FBCALL int fb_FileLineInput( int fnum, void *dst, int dst_len, int fillrem )
{
	int res;

	FB_LOCK();
	res = fb_hFileLineInput( fnum, NULL, dst, dst_len, fillrem, FB_FALSE, FB_FALSE );
	FB_UNLOCK();

	return res;
}

/*:::::*/
FBCALL int fb_LineInput( FBSTRING *text, void *dst, int dst_len, int fillrem, int addquestion, int addnewline )
{
	int res;

	FB_LOCK();
	res = fb_hFileLineInput( 0, text, dst, dst_len, fillrem, addquestion, addnewline );
	FB_UNLOCK();

	return res;
}

