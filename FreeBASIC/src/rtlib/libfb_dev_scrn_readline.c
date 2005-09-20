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
#include "fb.h"
#include "fb_rterr.h"

#define FB_USE_COMFORTABLE_READLINE FALSE

#if FB_USE_COMFORTABLE_READLINE

void DoMove( FB_FILE *handle, int *x, int *y, int dx, int dy, int cols, int rows )
{
    DBG_ASSERT( x!=NULL && y!=NULL );

    *x -= 1;
    *y -= 1;

    *x += dx;
    if( *x < 0 ) {
        *x = -*x + cols;
        *y -= *x / cols;
        *x = cols - (*x % cols);
    }
    *y += *x / cols;
    *x %= cols;
    *y += dy;

    *x += 1;
    *y += 1;

    if( *y==(rows+1) && *x==1 ) {
        fb_Locate( rows, cols, -1 );
        handle->hooks->pfnWrite( handle, "\n", 1 );
    } else {
        fb_Locate( *y, *x, -1 );
    }
}

#endif

int fb_DevScrnReadLine( struct _FB_FILE *handle, FBSTRING *dst )
{
#if FB_USE_COMFORTABLE_READLINE
    int tmp_x, tmp_y;
    int cols, rows;
    size_t pos, len, tmp_buffer_len = 0;
    int cursor_visible;
    int res = fb_ErrorSetNum( FB_RTERROR_OK );
    int k;
    char ch, tmp_buffer[12];

    fb_GetSize(&cols, &rows);

    cursor_visible = (fb_Locate( -1, -1, -1 ) & 0x10000) != 0;
    fb_Locate( -1, -1, 0 );

    pos = len = FB_STRSIZE(dst);
    handle->hooks->pfnWrite( handle, dst->data, len );

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

        fb_GetXY(&tmp_x, &tmp_y);

        switch (k) {
        case 8:
            /* DEL */
			if (pos!=0) {
                DoMove( handle, &tmp_x, &tmp_y, -1, 0, cols, rows );
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
            if( len!=pos ) {
                delete_char = TRUE;
            } else {
                fb_Beep();
            }
            break;
        case FB_MAKE_EXT_KEY(0x4B):
            /* Cursor LEFT */
            if( pos != 0 ) {
                DoMove( handle, &tmp_x, &tmp_y, -1, 0, cols, rows );
                --pos;
            }
            break;
        case FB_MAKE_EXT_KEY(0x4D):
            /* Cursor RIGHT */
            if( pos != len ) {
                DoMove( handle, &tmp_x, &tmp_y, 1, 0, cols, rows );
                ++pos;
            }
            break;
        case FB_MAKE_EXT_KEY(0x47):
            /* HOME */
            DoMove( handle, &tmp_x, &tmp_y, -pos, 0, cols, rows );
            pos = 0;
            break;
        case FB_MAKE_EXT_KEY(0x4F):
            /* END */
            DoMove( handle, &tmp_x, &tmp_y, len-pos, 0, cols, rows );
            pos = len;
            break;
        case FB_MAKE_EXT_KEY(0x48):
            /* Cursor UP */
            if( pos >= cols) {
                DoMove( handle, &tmp_x, &tmp_y, -cols, 0, cols, rows );
                pos -= cols;
            }
            break;
        case FB_MAKE_EXT_KEY(0x50):
            /* Cursor DOWN */
            if( ( pos + cols ) <= len ) {
                DoMove( handle, &tmp_x, &tmp_y, cols, 0, cols, rows );
                pos += cols;
            }
            break;
        default:
            if( k>=32 && k<=255 ) {
                tmp_buffer[0] = (char) k;
                tmp_buffer_len = 1;
                add_char = TRUE;
                /* DoMove( &tmp_x, &tmp_y, 1, 0, cols ); */
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

            handle->hooks->pfnWrite( handle, dst->data + pos, len - pos );
            handle->hooks->pfnWrite( handle, " ", 1 );
            fb_Locate( tmp_y, tmp_x, -1 );
        }

        if( add_char ) {
            tmp_buffer[tmp_buffer_len] = 0;
        }

        if( add_char ) {
            int old_x = tmp_x, old_y = tmp_y;
            FBSTRING *str_add = fb_StrAllocTempDescF( tmp_buffer, tmp_buffer_len + 1 );
            FBSTRING *str_tmp1 = fb_StrAllocTempDescV( dst );
            FBSTRING *str_tmp2 = fb_StrAllocTempDescV( dst );
            FBSTRING *str_left = fb_StrMid( str_tmp1, 1, pos );
            FBSTRING *str_right = fb_StrMid( str_tmp2, pos + 1, len - pos);
            fb_StrAssign( dst, -1, str_left, -1, FALSE );
            fb_StrConcatAssign( dst, -1, str_add, -1, FALSE );
            fb_StrConcatAssign( dst, -1, str_right, -1, FALSE );
            len += tmp_buffer_len;

            handle->hooks->pfnWrite( handle, dst->data + pos, len - pos );

            pos += tmp_buffer_len;

            fb_GetXY(&tmp_x, &tmp_y);
            if( old_x==tmp_x && old_y==tmp_y ) {
                handle->hooks->pfnWrite( handle, "\n", 1 );
                fb_GetXY(&tmp_x, &tmp_y);
            }
            DoMove( handle, &tmp_x, &tmp_y, pos - len, 0, cols, rows );
        }

        fb_Locate( -1, -1, cursor_visible );

	} while (k!='\r' && k!='\n');

    FB_UNLOCK();

    /* set cursor to end of line */
    fb_GetXY(&tmp_x, &tmp_y);
    DoMove( handle, &tmp_x, &tmp_y, len - pos, 0, cols, rows );
    return res;

#else

    return fb_LineInput( NULL, dst, -1, FALSE, FALSE, TRUE );

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
    if( FB_HANDLE_SCREEN->hooks->pfnWrite == NULL )
        FB_HANDLE_SCREEN->hooks->pfnWrite = fb_DevScrnWrite;
#endif
}
