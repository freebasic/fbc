/* graphical mode text output */

#include "fb_gfx.h"

typedef struct _fb_PrintInfo {
	FB_GFXCTX *context;
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
void fb_hHookConScrollGfx (FB_GFXCTX *context, int x1, int y1,
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

        while( h-- )
            fb_hPixelCpy(context->line[y_dst++], context->line[y_src++], w);
    }

    for( clear_row=clear_start; clear_row!=clear_end; ++clear_row )
        context->pixel_set(context->line[clear_row], context->bg_color, w);

    fb_hSetDirty( dirty_start, dirty_end, y1, y2 );
}

static void fb_hHookConScroll
	(
		fb_ConHooks *handle,
		int x1, int y1,
		int x2, int y2,
		int rows
	)
{
    int w = x2 - x1 + 1;
    int h = y2 - y1 + 1;
    int clear_start, clear_end;
    fb_PrintInfo *pInfo = (fb_PrintInfo*) handle->Opaque;
    int font_w = __fb_gfx->font->w;
    int font_h = __fb_gfx->font->h;
    fb_hHookConScrollGfx( pInfo->context, x1 * font_w, y1 * font_h,
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
        size_t con_width = __fb_gfx->text_w;
        GFX_CHAR_CELL *src = __fb_gfx->con_pages[ pInfo->context->work_page ] + y_src * con_width;
        GFX_CHAR_CELL *dst = __fb_gfx->con_pages[ pInfo->context->work_page ] + y_dst * con_width;
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
                        pInfo->context->work_page, 32,
                        pInfo->context->fg_color, pInfo->context->bg_color );
    handle->Coord.Y = handle->Border.Bottom;
}

static int fb_hHookConWriteGfx
	(
		FB_GFXCTX *context,
		int target_x, int target_y,
        const void *buffer, size_t length,
        int *dirty_start, int *dirty_end
	)
{

	const unsigned char *pachText = (const unsigned char *) buffer;

    /* cursor? */
    if( (length == 1) && ((size_t)*pachText == 255) )
    {
    	/* note: can't use 'mask' because it will be always 0 (due the endless
    	         levels if indirection */
    	int x;
    	for( x = 0; x < __fb_gfx->font->w; x++ )
    	{
    		context->put_pixel( context,
    							target_x + x,
    							target_y + __fb_gfx->font->h - 1,
    							context->fg_color );
    	}
    }
    else
    {
	    int char_bit_mask;
	    int char_row_byte_count = BYTES_PER_PIXEL(__fb_gfx->font->w);
	    size_t i, char_size = char_row_byte_count * __fb_gfx->font->h;

	    for( i=0; i!=length; ++i ) {
	        size_t char_index = (size_t) *pachText++;
	        const unsigned char *src = &__fb_gfx->font->data[char_index * char_size];
	        int char_y;
	        for (char_y = 0; char_y != __fb_gfx->font->h; char_y++)
	        {
	            int char_x, char_row_byte;
	            int text_y = target_y + char_y;
	            int text_x = target_x;
	            for( char_row_byte=0; char_row_byte!=char_row_byte_count; ++char_row_byte )
	            {
	                unsigned char char_data = *src++;
	                for (char_x = 0, char_bit_mask = 1;
	                     char_x != 8;
	                     char_x++, char_bit_mask <<= 1)
	                {
	                    unsigned color = (char_data & char_bit_mask) ? context->fg_color : context->bg_color;
	                    context->put_pixel(context, text_x++, text_y, color);
	                }
	            }
	        }
	        target_x += __fb_gfx->font->w;
	    }
	}

    fb_hSetDirty( dirty_start, dirty_end,
                  target_y, target_y + __fb_gfx->font->h );

    return TRUE;
}

static int fb_hHookConWrite
	(
		fb_ConHooks *handle,
		const void *buffer,
		size_t length
	)
{
    const unsigned char *pachText = (const unsigned char *) buffer;
    fb_PrintInfo *pInfo = (fb_PrintInfo*) handle->Opaque;
    int target_x = handle->Coord.X * __fb_gfx->font->w;
    int target_y = handle->Coord.Y * __fb_gfx->font->h;
    int res = fb_hHookConWriteGfx( pInfo->context, target_x, target_y,
                                   buffer, length,
                                   &pInfo->dirty_start, &pInfo->dirty_end );

    /* Don't forget to update character cells */
    GFX_CHAR_CELL *cell =
        __fb_gfx->con_pages[pInfo->context->work_page]
        + handle->Coord.Y * __fb_gfx->text_w
        + handle->Coord.X + length;
    unsigned fg = pInfo->context->fg_color;
    unsigned bg = pInfo->context->bg_color;

    while( length-- ) {
        --cell;
        cell->ch = pachText[length];
        cell->fg = fg;
        cell->bg = bg;
    }

    return res;
}

void fb_GfxPrintBufferEx( const void *buffer, size_t len, int mask )
{
	FB_GFXCTX *context;
    const char *pachText = (const char *) buffer;
    int win_left, win_top, win_cols, win_rows;
    int view_top, view_bottom;
    fb_PrintInfo info;
    fb_ConHooks hooks;

	FB_GRAPHICS_LOCK( );

    /* Do we want to correct the console cursor position? */
    if( (mask & FB_PRINT_FORCE_ADJUST)==0 ) {
        /* No, we can check for the length to avoid unnecessary stuff ... */
        if( len==0 ) {
            FB_GRAPHICS_UNLOCK( );
            return;
        }
    }

	context = fb_hGetContext( );
	fb_hPrepareTarget(context, NULL);
	fb_hSetPixelTransfer(context, MASK_A_32);

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

	info.context = context;
    info.dirty_start = info.dirty_end = 0;

    {
        hooks.Coord.X = __fb_gfx->cursor_x;
        hooks.Coord.Y = __fb_gfx->cursor_y;

        if( __fb_gfx->flags & PRINT_SCROLL_WAS_OFF ) {
            __fb_gfx->flags &= ~PRINT_SCROLL_WAS_OFF;
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
            __fb_gfx->flags |= PRINT_SCROLL_WAS_OFF;
            hooks.Coord.X = hooks.Border.Right;
            hooks.Coord.Y = hooks.Border.Bottom;
        }
        fb_GfxLocateRaw( hooks.Coord.Y, hooks.Coord.X, -1 );
    }

    SET_DIRTY(context, info.dirty_start, info.dirty_end - info.dirty_start);

    DRIVER_UNLOCK();
	FB_GRAPHICS_UNLOCK( );
}

void fb_GfxPrintBuffer( const char *buffer, int mask )
{
    fb_GfxPrintBufferEx(buffer, strlen(buffer), mask);
}

/* Caller is expected to hold FB_GRAPHICS_LOCK() */
int fb_GfxLocateRaw( int y, int x, int cursor )
{
	if (x > -1)
		__fb_gfx->cursor_x = x;
	if (y > -1)
		__fb_gfx->cursor_y = y;
	return (__fb_gfx->cursor_x & 0xFF) | ((__fb_gfx->cursor_y & 0xFF) << 8);
}

int fb_GfxLocate( int y, int x, int cursor )
{
    int ret;
	FB_GRAPHICS_LOCK( );
    __fb_gfx->flags &= ~PRINT_SCROLL_WAS_OFF;
    ret = fb_GfxLocateRaw( y - 1, x - 1, cursor ) + 0x0101;
    fb_SetPos( FB_HANDLE_SCREEN , __fb_gfx->cursor_x );
	FB_GRAPHICS_UNLOCK( );
    return ret;
}

int fb_GfxGetX( void )
{
	int x;
	FB_GRAPHICS_LOCK( );
	x = __fb_gfx->cursor_x + 1;
	FB_GRAPHICS_UNLOCK( );
	return x;
}

int fb_GfxGetY( void )
{
	int y;
	FB_GRAPHICS_LOCK( );
	y = __fb_gfx->cursor_y + 1;
	FB_GRAPHICS_UNLOCK( );
	return y;
}

void fb_GfxGetXY( int *col, int *row )
{
	if( col != NULL )
		*col = fb_GfxGetX( );

	if( row != NULL )
		*row = fb_GfxGetY( );
}

void fb_GfxGetSize( int *cols, int *rows )
{
	FB_GRAPHICS_LOCK( );

	if( cols != NULL )
		*cols = __fb_gfx->text_w;

	if( rows != NULL )
		*rows = __fb_gfx->text_h;

	FB_GRAPHICS_UNLOCK( );
}
