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
 * width.c -- graphical text console mode changing
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
int fb_GfxWidth(int w, int h)
{
	int font_w, font_h;
	const FONT *font = NULL;
	int cur = __fb_gfx->text_w | (__fb_gfx->text_h << 16);
	
	if( (w < 1) && (h < 1) )
		return cur;
	
	if (w > 0)
		font_w = __fb_gfx->w / w;
	else {
		font_w = __fb_gfx->font->w;
		w = __fb_gfx->text_w;
	}
	
	if (h > 0)
		font_h = __fb_gfx->h / h;
	else {
		font_h = __fb_gfx->font->h;
		h = __fb_gfx->text_h;
	}
	
	switch( font_w ) {
	case 8:
		switch (font_h) {
		case 8:
			font = &fb_font_8x8;
			break;
		case 14:
			font = &fb_font_8x14;
			break;
		case 16:
			font = &fb_font_8x16;
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
	
	return cur;
}
