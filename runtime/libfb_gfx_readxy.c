/*
 * readxy.c -- implementation of SCREEN function for graphics mode
 *
 * chng: sep/2005 written [mjs]
 *
 */

#include "fb_gfx.h"


/*:::::*/
unsigned int fb_GfxReadXY( int col, int row, int colorflag )
{
	FB_GFXCTX *context = fb_hGetContext();
	GFX_CHAR_CELL *cell;

	if( __fb_gfx==NULL )
		return 0;

	if( col < 1 || col > __fb_gfx->text_w
	    || row < 1 || row > __fb_gfx->text_h )
		return 0;

	cell =
		__fb_gfx->con_pages[ context->work_page ]
		+ (row - 1) * __fb_gfx->text_w
		+ col - 1;
	if( colorflag == 0 ) {
		return cell->ch;
	}

	if( __fb_gfx->depth <= 4 ) {
		return cell->fg + (cell->bg << 4);
	} else if( __fb_gfx->depth <= 8 ) {
		return cell->fg + (cell->bg << 8);
	} else if( __fb_gfx->depth == 16 ) {
		unsigned c;
		if( colorflag == 2 )
			c = cell->bg;
		else
			c = cell->fg;
		return (((c & 0x001F) << 3) | ((c >> 2) & 0x7) |
		        ((c & 0x07E0) << 5) | ((c >> 1) & 0x300) |
		        ((c & 0xF800) << 8) | ((c << 3) & 0x70000) | 0xff000000);
	} else {
		if( colorflag == 2 )
			return cell->bg;
		return cell->fg;
	}
}
