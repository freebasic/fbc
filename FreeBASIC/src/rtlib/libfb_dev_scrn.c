/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2005 Mark Junker (mjscod@gmx.de)
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
#include <assert.h>
#include "fb.h"
#include "fb_rterr.h"

FBCALL void 		fb_PrintBufferEx	( const void *buffer, size_t len, int mask );

typedef struct _DEV_SCRN_INFO {
    char            buffer[16];
    unsigned        length;
} DEV_SCRN_INFO;

static void fb_DevScrnFillInput( DEV_SCRN_INFO *info )
{
    FBSTRING *str;
    size_t len;

    FB_STRLOCK();

    str = fb_Inkey( );
    len = FB_STRSIZE( str );
    assert(len <= sizeof(info->buffer));
    memcpy(info->buffer, str->data, len);

    fb_hStrDelTemp( str );

    FB_STRUNLOCK();

    info->length = len;
}

/*:::::*/
static int fb_DevScrnEof( struct _FB_FILE *handle )
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

/*:::::*/
static int fb_DevScrnClose( struct _FB_FILE *handle )
{
    FB_LOCK();

    if( handle->opaque != NULL )
        free(handle->opaque);

    FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

static int fb_DevScrnRead( struct _FB_FILE *handle, void* value, size_t *pLength )
{
    size_t length;
    DEV_SCRN_INFO *info;
    int copy_length;
    char *pachBuffer = (char*) value;

    FB_LOCK();

    assert(pLength!=NULL);
    length = *pLength;

    info = (DEV_SCRN_INFO*) FB_HANDLE_DEREF(handle)->opaque;

    while( length!=0 ) {
        copy_length = (length > info->length) ? info->length : length;
        if (copy_length==0) {
            fb_DevScrnFillInput( info );
            if( info->length!=0 )
                continue;
            break;
        }
        memcpy(pachBuffer, info->buffer, copy_length);
        info->length -= copy_length;
        if (info->length!=0) {
            memmove(info->buffer,
                    info->buffer + copy_length,
                    info->length);
        }
        length -= copy_length;
        pachBuffer += copy_length;
    }

    FB_UNLOCK();

    if (length!=0)
        memset(pachBuffer, 0, length);

    *pLength -= length;

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

static int fb_DevScrnWrite( struct _FB_FILE *handle, const void* value, size_t valuelen )
{
    fb_PrintBufferEx( value, valuelen, 0 );
	return fb_ErrorSetNum( FB_RTERROR_OK );
}

#if 0

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

static int fb_DevScrnReadLine( struct _FB_FILE *handle, FBSTRING *dst )
{
#if 0
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
    return fb_DevFileReadLineDumb( NULL, dst );
#endif
}

static const FB_FILE_HOOKS fb_hooks_dev_scrn = {
    fb_DevScrnEof,
    fb_DevScrnClose,
    NULL,
    NULL,
    fb_DevScrnRead,
    fb_DevScrnWrite,
    NULL,
    NULL,
    fb_DevScrnReadLine
};

int fb_DevScrnOpen( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{
    FB_LOCK();

    if (handle!=FB_HANDLE_SCREEN) {
        DEV_SCRN_INFO *info = (DEV_SCRN_INFO*) FB_HANDLE_SCREEN->opaque;
        handle->hooks = &fb_hooks_dev_scrn;
        handle->opaque = info;
        handle->redirection_to = FB_HANDLE_SCREEN;

    } else if( handle->hooks == NULL ) {
        DEV_SCRN_INFO *info = (DEV_SCRN_INFO*) malloc(sizeof(DEV_SCRN_INFO));
        int cols;
        fb_GetSize( &cols, NULL );
        info->length = 0;
        handle->hooks = &fb_hooks_dev_scrn;
        handle->opaque = info;
        handle->line_length = fb_GetX() - 1;
        handle->width = cols;
    }

    FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
