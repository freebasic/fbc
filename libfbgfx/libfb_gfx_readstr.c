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
 * readstr.c -- gfx hook for INPUT support
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
static void move_back(void)
{
	__fb_gfx->cursor_x--;
	if (__fb_gfx->cursor_x < 0) {
		__fb_gfx->cursor_x = __fb_gfx->text_w - 1;
		__fb_gfx->cursor_y--;
	}
}


/*:::::*/
char *fb_GfxReadStr(char *buffer, int maxlen)
{
	int key, len = 0;
	char cursor_normal[2] = { 219, '\0' };
	char cursor_backspace[3] = { 219, ' ', '\0' };
	char space[2] = { ' ', '\0' };
	char character[2] = { 0, '\0' };
	char *cursor = cursor_normal;
	
	if (!__fb_gfx)
		return NULL;
	
	do {
		fb_GfxPrintBuffer(cursor, 0);
		
		if (cursor == cursor_backspace) {
			move_back();
			cursor = cursor_normal;
		}
		move_back();
		
		key = fb_Getkey();
		if (key < 0x100) {
			if (key == 8) {
				if (len > 0) {
					cursor = cursor_backspace;
					move_back();
					if (__fb_gfx->cursor_y < 0) {
						__fb_gfx->cursor_y = __fb_gfx->cursor_x = 0;
						cursor = cursor_normal;
					}
					len--;
				}
			}
			else if ((key != 7) && (len < maxlen - 1)) {
				if (key == 13) {
					fb_GfxPrintBuffer(space, 0);
					move_back();
				}
				buffer[len++] = key;
				character[0] = key;
				fb_GfxPrintBuffer(character, 0);
			}
		}
	} while (key != 13);
	
	buffer[len] = '\0';
	
	return buffer;
}
