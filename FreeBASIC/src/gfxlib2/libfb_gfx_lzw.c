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
 * lzw.c -- tiny LZW codec
 *          Based on code by Mark Nelson, Dr. Dobb's Journal October, 1989
 *
 * chng: mar/2005 written [lillo]
 *
 */

#include "fb_gfx.h"
#include "fb_gfx_lzw.h"


LZW_ENTRY fb_lzw_entry[TABLE_SIZE];


/*:::::*/
static unsigned char *decode_string(unsigned char *buffer, int code)
{
	int index = 0;

	while (code > 255) {
		*buffer++ = fb_lzw_entry[code].value;
		code = fb_lzw_entry[code].prefix;
		if (index++ >= MAX_CODE - 1)
			return NULL;
	}
	*buffer = code;
	return buffer;
}


/*:::::*/
FBCALL int fb_hDecode(const unsigned char *in_buffer, int in_size, unsigned char *out_buffer, int *out_size)
{
	unsigned short new_code, old_code, next_code = 256;
	unsigned char *limit, decode_stack[MAX_CODE], *string, byte, bit = 0;

	INPUT_CODE(old_code);
	byte = old_code;
	*out_buffer++ = old_code;
	limit = out_buffer + *out_size;
	*out_size = 1;
	while (in_size > 0) {
		INPUT_CODE(new_code);
		if (new_code == MAX_CODE)
			return 0;
		if (new_code >= next_code) {
			*decode_stack = byte;
			string = decode_string(decode_stack + 1, old_code);
		}
		else
			string = decode_string(decode_stack, new_code);
		if (!string)
			return -1;
		byte = *string;
		while (string >= decode_stack) {
			if (out_buffer >= limit)
				return -1;
			*out_buffer++ = *string--;
			(*out_size)++;
		}
		if (next_code < MAX_CODE) {
			fb_lzw_entry[next_code].prefix = old_code;
			fb_lzw_entry[next_code].value = byte;
			next_code++;
		}
		old_code = new_code;
	}
	return -1;
}

