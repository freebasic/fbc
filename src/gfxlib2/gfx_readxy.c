/* implementation of SCREEN function for graphics mode */

#include "fb_gfx.h"

unsigned int fb_GfxReadXY( int col, int row, int colorflag )
{
	unsigned int result;
	FB_GFXCTX *context;
	GFX_CHAR_CELL *cell;

	FB_GRAPHICS_LOCK( );

	if( __fb_gfx == NULL ||
	    col < 1 || col > __fb_gfx->text_w ||
	    row < 1 || row > __fb_gfx->text_h ) {
		FB_GRAPHICS_UNLOCK( );
		return 0;
	}

	context = fb_hGetContext( );
	cell = __fb_gfx->con_pages[context->work_page] +
		((row - 1) * __fb_gfx->text_w) + (col - 1);
	if( colorflag == 0 ) {
		result = cell->ch;
	} else if( __fb_gfx->depth <= 4 ) {
		result = cell->fg + (cell->bg << 4);
	} else if( __fb_gfx->depth <= 8 ) {
		result = cell->fg + (cell->bg << 8);
	} else if( __fb_gfx->depth == 16 ) {
		unsigned c = colorflag == 2 ? cell->bg : cell->fg;
		result = (((c & 0x001F) << 3) | ((c >> 2) & 0x7) |
			  ((c & 0x07E0) << 5) | ((c >> 1) & 0x300) |
			  ((c & 0xF800) << 8) | ((c << 3) & 0x70000) | 0xff000000);
	} else {
		result = colorflag == 2 ? cell->bg : cell->fg;
	}

	FB_GRAPHICS_UNLOCK( );
	return result;
}
