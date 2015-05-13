/* graphical text console mode changing */

#include "fb_gfx.h"

int fb_GfxWidth(int w, int h)
{
	int font_w, font_h;
	const FONT *font = NULL;
	int cur;

	FB_GRAPHICS_LOCK( );

	cur = __fb_gfx->text_w | (__fb_gfx->text_h << 16);

	if( (w < 1) && (h < 1) ) {
		FB_GRAPHICS_UNLOCK( );
		return cur;
	}

	if (w > 0) {
		font_w = __fb_gfx->w / w;
	} else {
		font_w = __fb_gfx->font->w;
		w = __fb_gfx->text_w;
	}

	if (h > 0) {
		font_h = __fb_gfx->h / h;
	} else {
		font_h = __fb_gfx->font->h;
		h = __fb_gfx->text_h;
	}

	switch( font_w ) {
	case 8:
		switch( font_h ) {
		case 8:
			font = &__fb_font[FB_FONT_8];
			break;
		case 14:
			font = &__fb_font[FB_FONT_14];
			break;
		case 16:
			font = &__fb_font[FB_FONT_16];
			break;
		}
		break;
	}

	if (font) {
		/* Update font data */
		__fb_gfx->text_w = w;
		__fb_gfx->text_h = h;
		__fb_gfx->font = font;

		fb_hResetCharCells(fb_hGetContext(), TRUE);

		/* Reset graphics VIEW */
		fb_GfxView( -32768, -32768,
		            -32768, -32768,
		            0, 0,
		            DEFAULT_COLOR_1 | DEFAULT_COLOR_2 );

		/* Reset VIEW PRINT */
		fb_ConsoleView( 0, 0 );

		/* Clear the whole screen */
		fb_GfxClear(0);
	}

	FB_GRAPHICS_UNLOCK( );
	return cur;
}
