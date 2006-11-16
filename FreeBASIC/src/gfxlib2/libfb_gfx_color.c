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
 * color.c -- color statement
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
int fb_GfxColor(int fg, int bg)
{
	FB_GFXCTX *context = fb_hGetContext();
	int cur = context->fg_color | (context->bg_color << 16);
	
	switch (__fb_gfx->mode_num) {
	
		case 1:
			if (bg >= 0)
				fb_GfxPalette(-(4 - (bg & 0x3)), 0, 0, 0);
			if (fg >= 0)
				fb_GfxPalette(0, fg, -1, -1);
			break;
		
		case 7:
		case 8:
		case 9:
			if (fg >= 0)
				context->fg_color = (fg & 0xF);
			if (bg >= 0)
				fb_GfxPalette(0, bg, -1, -1);
			break;
		
		default:
			if (fg != -1) {
				if (__fb_gfx->depth > 8)
					context->fg_color = fb_hMakeColor(fg, (fg >> 16) & 0xFF, (fg >> 8) & 0xFF, fg & 0xFF);
				else
					context->fg_color = (fg & __fb_gfx->color_mask);
			}
			if (bg != -1) {
				if (__fb_gfx->depth > 8)
					context->bg_color = fb_hMakeColor(bg, (bg >> 16) & 0xFF, (bg >> 8) & 0xFF, bg & 0xFF);
				else
					context->bg_color = (bg & __fb_gfx->color_mask);
			}
			break;
	}

	return cur;
}
