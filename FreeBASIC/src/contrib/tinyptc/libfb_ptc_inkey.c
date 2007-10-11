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
 * ptc_inkey.c -- inkey$ handling
 *
 * chng: jan/2005 written [lillo]
 *       aug/2005 copied for use with TinyPTC [mjs]
 *
 */

#include "tinyptc.h"

static int key_buffer[KEY_BUFFER_LEN], key_head = 0, key_tail = 0;


/*:::::*/
void fb_hTinyPtcPostKey(int key)
{
    FB_LOCK();

	key_buffer[key_tail] = key;
	if (((key_tail + 1) & (KEY_BUFFER_LEN - 1)) == key_head)
		key_head = (key_head + 1) & (KEY_BUFFER_LEN - 1);
    key_tail = (key_tail + 1) & (KEY_BUFFER_LEN - 1);

    FB_UNLOCK();
}

#ifdef __DJGPP__
void fb_hTinyPtcPostKey_End(void)
{ /* this function is here to get the length of the fb_hPostKey function so
     the DOS gfxlib driver can lock it into physical memory for use in an
     interrupt handler */ }
#endif


/*:::::*/
static int get_key(void)
{
	int key = 0;

	FB_LOCK();

	if (key_head != key_tail) {
		key = key_buffer[key_head];
		key_head = (key_head + 1) & (KEY_BUFFER_LEN - 1);
	}

	FB_UNLOCK();

	return key;
}


/*:::::*/
int fb_TinyPtcGetkey(void)
{
	int key = 0;

	do {
		key = get_key();
		fb_Sleep(20);
	} while (key == 0);

	return key;
}

/*:::::*/
int fb_TinyPtcKeyHit(void)
{
	int res;

	FB_LOCK();

	res = (key_head != key_tail? 1: 0);

	FB_UNLOCK();

	return res;
}

/*:::::*/
FBSTRING *fb_TinyPtcInkey(void)
{
	static const unsigned char code[KEY_MAX_SPECIALS] = {
		'k', 'H', 'P', 'K', 'M', 'R', 'S', 'G', 'O', 'I', 'Q',
		';', '<', '=', '>', '?', '@', 'A', 'B', 'C', 'D'
	};
	FBSTRING *res;
	int key;

	if ((key = get_key())!=0) {
        if (key > 0xFF) {
            int key_code;
            if( (key & 0xFF)!=0xFF ) {
                key_code = code[MIN(key - 0x100, KEY_MAX_SPECIALS - 1)];
            } else {
                key_code = key;
            }

            res = fb_hStrAllocTemp(NULL, 2);
            if( res ) {
                res->data[0] = FB_EXT_CHAR;
                res->data[1] = key_code;
                res->data[2] = '\0';
            } else {
                res = &__fb_ctx.null_desc;
            }

			return res;
		}
		else
			return fb_CHR( 1, key );
	}

	return &__fb_ctx.null_desc;
}
