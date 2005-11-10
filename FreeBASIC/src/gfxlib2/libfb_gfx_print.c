/*
 *  libgfx2 - FreeBASIC's alternative gfx library
 *	Copyright (C) 2005 Angelo Mottola (a.mottola@libero.it)
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
 * print.c -- graphical mode text output
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"
#include "../rtlib/fb_con.h"

typedef struct _fb_PrintInfo {
    int dirty_start;
    int dirty_end;
} fb_PrintInfo;

static __inline__
void fb_hSetDirty( int *dirty_start, int *dirty_end,
                   int test_start, int test_end )
{
    if( *dirty_start==*dirty_end ) {
        *dirty_start = test_start;
        *dirty_end = test_end;
    } else {
        if( test_start < *dirty_start )
            *dirty_start = test_start;
        if( test_end > *dirty_end )
            *dirty_end = test_end;
    }
}

static
void fb_hHookConScrollGfx (int x1, int y1,
                           int x2, int y2,
                           int lines,
                           int *dirty_start, int *dirty_end )
{
    int h = y2 - y1;
    int w = x2 - x1;
    int clear_row, clear_start = 0, clear_end = 0;

    if( lines==0 )
        return;

    clear_end = y2;

    if( lines >= h || lines < 0 ) {
        clear_start = y1;
    } else {
        int y_src = y1 + lines;
        int y_dst = y1;

        h -= lines;
        clear_start = y1 + h;

        while( h-- ) {
            fb_hPixelCpy(fb_mode->line[y_dst++],
                         fb_mode->line[y_src++],
                         w);
        }
    }

    for( clear_row=clear_start; clear_row!=clear_end; ++clear_row ) {
        fb_hPixelSet(fb_mode->line[clear_row],
                     fb_mode->bg_color,
                     w);
    }

    fb_hSetDirty( dirty_start, dirty_end, y1, y2 );
}

static
void fb_hHookConScroll(struct _fb_ConHooks *handle,
                       int x1,
                       int y1,
                       int x2,
                       int y2,
                       int rows)
{
    int w = x2 - x1 + 1;
    int h = y2 - y1 + 1;
    int clear_start, clear_end;
    fb_PrintInfo *pInfo = (fb_PrintInfo*) handle->Opaque;
    int font_w = fb_mode->font->w;
    int font_h = fb_mode->font->h;
    fb_hHookConScrollGfx( x1 * font_w, y1 * font_h,
                          (x2 + 1) * font_w, (y2 + 1) * font_h,
                          rows * font_h,
                          &pInfo->dirty_start, &pInfo->dirty_end );

    /* Don't foget to update the character cells */
    clear_end = y2 + 1;
    if( rows >= h ) {
        clear_start = y1;
    } else {
        int y_src = y1 + rows;
        int y_dst = y1;
        size_t con_width = fb_mode->text_w;
        GFX_CHAR_CELL *src = fb_mode->con_pages[ fb_mode->work_page ] + y_src * con_width;
        GFX_CHAR_CELL *dst = fb_mode->con_pages[ fb_mode->work_page ] + y_dst * con_width;
        size_t cell_line_width = w * sizeof( GFX_CHAR_CELL );

        h -= rows;
        clear_start = y1 + h;

        while( h-- ) {
            memcpy( dst, src, cell_line_width );
            dst += con_width;
            src += con_width;
        }
    }
    fb_hClearCharCells( x1, clear_start, x2+1, clear_end,
                        fb_mode->work_page, 32,
                        fb_mode->fg_color, fb_mode->bg_color );
    handle->Coord.Y = handle->Border.Bottom;
}

static
int  fb_hHookConWriteGfx (int target_x, int target_y,
                          const void *buffer, size_t length,
                          int *dirty_start, int *dirty_end )
{
	const unsigned char *pachText = (const unsigned char *) buffer;
    int char_bit_mask;
    int char_row_byte_count = BYTES_PER_PIXEL(fb_mode->font->w);
    size_t i, char_size = char_row_byte_count * fb_mode->font->h;

    for( i=0; i!=length; ++i ) {
        size_t char_index = (size_t) *pachText++;
        const unsigned char *src = &fb_mode->font->data[char_index * char_size];
        int char_y;
        for (char_y = 0;
             char_y != fb_mode->font->h;
             char_y++)
        {
            int char_x, char_row_byte;
            int text_y = target_y + char_y;
            int text_x = target_x;
            for( char_row_byte=0;
                 char_row_byte!=char_row_byte_count;
                 ++char_row_byte )
            {
                unsigned char char_data = *src++;
                for (char_x = 0, char_bit_mask = 1;
                     char_x != 8;
                     char_x++, char_bit_mask <<= 1)
                {
                    unsigned color = (char_data & char_bit_mask) ? fb_mode->fg_color : fb_mode->bg_color;
                    fb_hPutPixel(text_x++, text_y, color);
                }
            }
        }
        target_x += fb_mode->font->w;
    }

    fb_hSetDirty( dirty_start, dirty_end,
                  target_y, target_y + fb_mode->font->h );

    return TRUE;
}

static
int  fb_hHookConWrite (struct _fb_ConHooks *handle,
                       const void *buffer,
                       size_t length )
{
    const char *pachText = (const char *) buffer;
    fb_PrintInfo *pInfo = (fb_PrintInfo*) handle->Opaque;
    int target_x = handle->Coord.X * fb_mode->font->w;
    int target_y = handle->Coord.Y * fb_mode->font->h;
    int res = fb_hHookConWriteGfx( target_x, target_y,
                                   buffer, length,
                                   &pInfo->dirty_start, &pInfo->dirty_end );

    /* Don't forget to update character cells */
    GFX_CHAR_CELL *cell =
        fb_mode->con_pages[fb_mode->work_page]
        + handle->Coord.Y * fb_mode->text_w
        + handle->Coord.X + length;
    unsigned fg = fb_mode->fg_color;
    unsigned bg = fb_mode->bg_color;

    while( length-- ) {
        --cell;
        cell->ch = pachText[length];
        cell->fg = fg;
        cell->bg = bg;
    }

    return res;
}

/*:::::*/
void fb_GfxPrintBufferEx(const void *buffer, size_t len, int mask)
{
    const char *pachText = (const char *) buffer;
    int win_left, win_top, win_cols, win_rows;
    int view_top, view_bottom;
    fb_PrintInfo info;
    fb_ConHooks hooks;

    /* Do we want to correct the console cursor position? */
    if( (mask & FB_PRINT_FORCE_ADJUST)==0 ) {
        /* No, we can check for the length to avoid unnecessary stuff ... */
        if( len==0 )
            return;
    }

	fb_hPrepareTarget(NULL);

	DRIVER_LOCK();

    fb_GetSize( &win_cols, &win_rows );
    fb_ConsoleGetView( &view_top, &view_bottom );
    win_left = win_top = 0;

    hooks.Opaque        = &info;
    hooks.Scroll        = fb_hHookConScroll;
    hooks.Write         = fb_hHookConWrite;
    hooks.Border.Left   = win_left;
    hooks.Border.Top    = win_top + view_top - 1;
    hooks.Border.Right  = win_left + win_cols - 1;
    hooks.Border.Bottom = win_top + view_bottom - 1;

    info.dirty_start = info.dirty_end = 0;

    {
        hooks.Coord.X = fb_mode->cursor_x;
        hooks.Coord.Y = fb_mode->cursor_y;

        if( fb_mode->flags & PRINT_SCROLL_WAS_OFF ) {
            fb_mode->flags &= ~PRINT_SCROLL_WAS_OFF;
            ++hooks.Coord.Y;
            hooks.Coord.X = hooks.Border.Left;
            fb_hConCheckScroll( &hooks );
        }

        fb_ConPrintTTY( &hooks,
                        pachText,
                        len,
                        TRUE );

        if( hooks.Coord.X != hooks.Border.Left
            || hooks.Coord.Y != (hooks.Border.Bottom+1) )
        {
            fb_hConCheckScroll( &hooks );
        } else {
            fb_mode->flags |= PRINT_SCROLL_WAS_OFF;
            hooks.Coord.X = hooks.Border.Right;
            hooks.Coord.Y = hooks.Border.Bottom;
        }
        fb_GfxLocateRaw( hooks.Coord.Y, hooks.Coord.X, -1 );
    }

    SET_DIRTY(info.dirty_start, info.dirty_end - info.dirty_start);

    DRIVER_UNLOCK();
}


/*:::::*/
void fb_GfxPrintBuffer(const char *buffer, int mask)
{
    fb_GfxPrintBufferEx(buffer, strlen(buffer), mask);
}


/*:::::*/
int fb_GfxLocateRaw(int y, int x, int cursor)
{
	if (x > -1)
		fb_mode->cursor_x = x;
	if (y > -1)
		fb_mode->cursor_y = y;
	return (fb_mode->cursor_x & 0xFF) | ((fb_mode->cursor_y & 0xFF) << 8);
}


/*:::::*/
int fb_GfxLocate(int y, int x, int cursor)
{
    int ret;
    fb_mode->flags &= ~PRINT_SCROLL_WAS_OFF;
    ret = fb_GfxLocateRaw( y - 1, x - 1, cursor ) + 0x0101;
    fb_SetPos( FB_HANDLE_SCREEN , fb_mode->cursor_x );
    return ret;
}


/*:::::*/
int fb_GfxGetX(void)
{
	return fb_mode->cursor_x + 1;
}


/*:::::*/
int fb_GfxGetY(void)
{
	return fb_mode->cursor_y + 1;
}

/*:::::*/
void fb_GfxGetXY( int *col, int *row )
{
	if( col != NULL )
		*col = fb_GfxGetX( );

	if( row != NULL )
		*row = fb_GfxGetY( );

}

/*:::::*/
void fb_GfxGetSize( int *cols, int *rows )
{
	if( cols != NULL )
		*cols = fb_mode->text_w;

	if( rows != NULL )
		*rows = fb_mode->text_h;

}

