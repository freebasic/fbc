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
 * inkey.c -- inkey$ handling
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


static int key_buffer[KEY_BUFFER_LEN], key_head = 0, key_tail = 0;


/*:::::*/
void fb_hPostKey(int key)
{
	key_buffer[key_tail] = key;
	if (((key_tail + 1) & (KEY_BUFFER_LEN - 1)) == key_head)
		key_head = (key_head + 1) & (KEY_BUFFER_LEN - 1);
	key_tail = (key_tail + 1) & (KEY_BUFFER_LEN - 1);
}


/*:::::*/
static int get_key(void)
{
	int key = 0;
	
	fb_mode->driver->lock();
	
	if (key_head != key_tail) {
		key = key_buffer[key_head];
		key_head = (key_head + 1) & (KEY_BUFFER_LEN - 1);
	}
	
	fb_mode->driver->unlock();
	
	return key;
}


/*:::::*/
int fb_GfxGetkey(void)
{
	int key = 0;
	
	if (!fb_mode)
		return 0;
	
	do {
		key = get_key();
		fb_Sleep(20);
	} while (key == 0);
	
	return key;
}


/*:::::*/
FBSTRING *fb_GfxInkey(void)
{
	const unsigned char code[KEY_MAX_SPECIALS] = {
		'X', 'H', 'P', 'K', 'M', 'R', 'S', 'G', 'O', 'I', 'Q',
		';', '<', '=', '>', '?', '@', 'A', 'B', 'C', 'D'
	};
	FBSTRING *res;
	int key;

	if ((fb_mode) && (key = get_key())) {
		if (key > 0xFF) {
			key = MIN(key - 0x100, KEY_MAX_SPECIALS - 1);
			res = (FBSTRING *)fb_hStrAllocTmpDesc();
			fb_hStrAllocTemp(res, 2);
			res->data[0] = 0xFF;
			res->data[1] = code[key];
			res->data[2] = '\0';
			
			return res;
		}
		else
			return fb_CHR(key);
	}
	
	return &fb_strNullDesc;
}
