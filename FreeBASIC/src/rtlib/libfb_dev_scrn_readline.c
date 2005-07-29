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
#include <assert.h>
#include "fb.h"
#include "fb_rterr.h"

#define FB_USE_COMFORTABLE_READLINE FALSE

#if FB_USE_COMFORTABLE_READLINE

static void fb_ScrnSetCursorPos( int start_x, int start_y, int cols, size_t pos )
{
    int x = start_x + pos;
    int y = start_y + (x - 1) / cols;
    x = ((x - 1) % cols) + 1;
    fb_Locate( y, x, -1 );
}

#else

int fb_DevFileReadLineDumb( FILE *fp, FBSTRING *dst );

#endif

int fb_DevScrnReadLine( struct _FB_FILE *handle, FBSTRING *dst )
{
#if FB_USE_COMFORTABLE_READLINE
    int start_x, start_y, cols;
    size_t pos, len, tmp_buffer_len = 0;
    int cursor_visible;
    int res = fb_ErrorSetNum( FB_RTERROR_OK );
    int k;
    char ch, tmp_buffer[9];

    fb_GetSize(&cols, NULL);
    fb_GetXY(&start_x, &start_y);

    cursor_visible = (fb_Locate( -1, -1, -1 ) & 0x10000) != 0;
    fb_Locate( -1, -1, 0 );

    FB_STRLOCK();
    pos = len = FB_STRSIZE(dst);
    handle->hooks->pfnWrite( handle, dst->data, len );
    FB_STRUNLOCK();

    fb_Locate( -1, -1, cursor_visible );

    FB_LOCK();

    do {
        int delete_char = FALSE, add_char = FALSE;
        size_t read_len;

        while( handle->hooks->pfnEof( handle ) ) {
            /* release time slice - does this work on other platforms the
             * same way? */
            fb_hSleep(25);
        }

        read_len = 1;
        res = handle->hooks->pfnRead( handle, &ch, &read_len );
        if( res!=0 ) {
            break;
        }
        if( ch==FB_EXT_CHAR ) {
            read_len = 1;
            res = handle->hooks->pfnRead( handle, &ch, &read_len );
            if( res!=0 ) {
                break;
            }
            k = FB_MAKE_EXT_KEY(ch);
        } else {
            k = FB_MAKE_KEY(ch);
        }

        switch (k) {
        case 8:
            /* DEL */
			if (pos!=0) {
				--pos;
                delete_char = TRUE;
            }
            break;
        case 9:
            /* TAB */
            tmp_buffer_len = ((pos + 8) / 8 * 8) - pos;
            memset(tmp_buffer, 32, tmp_buffer_len);
            add_char = TRUE;
            break;
        case FB_MAKE_EXT_KEY(0x53):
            /* CLeaR */
            delete_char = TRUE;
            break;
        case FB_MAKE_EXT_KEY(0x4B):
            /* Cursor LEFT */
            if( pos != 0 )
                --pos;
            break;
        case FB_MAKE_EXT_KEY(0x4D):
            /* Cursor RIGHT */
            if( pos != len )
                ++pos;
            break;
        case FB_MAKE_EXT_KEY(0x47):
            /* HOME */
            pos = 0;
            break;
        case FB_MAKE_EXT_KEY(0x4F):
            /* END */
            pos = len;
            break;
        case FB_MAKE_EXT_KEY(0x48):
            /* Cursor UP */
            if( pos >= cols) {
                pos -= cols;
            }
            break;
        case FB_MAKE_EXT_KEY(0x50):
            /* Cursor DOWN */
            if( ( pos + cols ) <= len ) {
                pos += cols;
            }
            break;
        default:
            if( k>=32 && k<=255 ) {
                tmp_buffer[0] = (char) k;
                tmp_buffer_len = 1;
                add_char = TRUE;
            }
            break;
        }

        if( delete_char ) {
            FBSTRING *str_tmp1 = fb_StrAllocTempDescV( dst );
            FBSTRING *str_tmp2 = fb_StrAllocTempDescV( dst );
            FBSTRING *str_left = fb_StrMid( str_tmp1, 1, pos );
            FBSTRING *str_right = fb_StrMid( str_tmp2, pos + 2, len - pos - 1);
            fb_StrAssign( dst, -1, str_left, -1, FALSE );
            fb_StrConcatAssign( dst, -1, str_right, -1, FALSE );
            --len;

            /* TODO: Optimize */
            fb_Locate( start_y, start_x, FALSE );
            FB_STRLOCK();
            handle->hooks->pfnWrite( handle, dst->data, len );
            FB_STRUNLOCK();
            handle->hooks->pfnWrite( handle, " ", 1 );
        }

        if( add_char ) {
            tmp_buffer[tmp_buffer_len] = 0;
        }

        if( add_char ) {
            FBSTRING *str_add = fb_StrAllocTempDescF( tmp_buffer, tmp_buffer_len + 1 );
            FBSTRING *str_tmp1 = fb_StrAllocTempDescV( dst );
            FBSTRING *str_tmp2 = fb_StrAllocTempDescV( dst );
            FBSTRING *str_left = fb_StrMid( str_tmp1, 1, pos );
            FBSTRING *str_right = fb_StrMid( str_tmp2, pos + 1, len - pos);
            fb_StrAssign( dst, -1, str_left, -1, FALSE );
            fb_StrConcatAssign( dst, -1, str_add, -1, FALSE );
            fb_StrConcatAssign( dst, -1, str_right, -1, FALSE );
            pos += tmp_buffer_len;
            len += tmp_buffer_len;

            /* TODO: Optimize */
            fb_Locate( start_y, start_x, FALSE );
            FB_STRLOCK();
            handle->hooks->pfnWrite( handle, dst->data, len );
            FB_STRUNLOCK();
        }

        fb_ScrnSetCursorPos( start_x, start_y, cols, pos );
        fb_Locate( -1, -1, cursor_visible );

	} while (k!='\r' && k!='\n');

    FB_UNLOCK();

    /* set cursor to end of line */
    fb_ScrnSetCursorPos( start_x, start_y, cols, len );
    return res;
#else
    int old_x, old_y, rows, cols;
    size_t len;
    int res;

    fb_GetSize( &cols, &rows );

    fb_GetXY( &old_x, &old_y );
    res = fb_DevFileReadLineDumb( stdin, dst );

    FB_STRLOCK();
    len = FB_STRSIZE(dst);
    FB_STRUNLOCK();

    assert(handle->width!=0);

    old_x += len;
    old_y += old_x / handle->width;
    old_x %= handle->width;

    if( old_y >= rows )
        old_y = rows - 1;

    fb_Locate( old_y, old_x, -1 );

    return res;
#endif
}


/*:::::*/
void fb_DevScrnInit_ReadLine( void )
{
	fb_DevScrnInit_NoOpen( );

    if( FB_HANDLE_SCREEN->hooks->pfnReadLine == NULL )
        FB_HANDLE_SCREEN->hooks->pfnReadLine = fb_DevScrnReadLine;
#if FB_USE_COMFORTABLE_READLINE
    if( FB_HANDLE_SCREEN->hooks->pfnEof == NULL )
        FB_HANDLE_SCREEN->hooks->pfnEof = fb_DevScrnEof;
    if( FB_HANDLE_SCREEN->hooks->pfnRead == NULL )
        FB_HANDLE_SCREEN->hooks->pfnRead = fb_DevScrnRead;
#endif
}
