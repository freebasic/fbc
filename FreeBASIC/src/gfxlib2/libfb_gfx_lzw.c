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

#define MAX_CODE	4095
#define TABLE_SIZE	5021

#define OUTPUT_CODE(c)				\
{						\
	if (bit) {				\
		*out_buffer++ |= (c & 0xF) << 4;\
		*out_buffer++ = c >> 4;		\
		size++;				\
	}					\
	else {					\
		*out_buffer++ = c & 0xFF;	\
		*out_buffer = c >> 8;		\
	}					\
	size++;					\
	if (size >= *out_size)			\
		return -1;			\
	bit ^= 1;				\
}

#define INPUT_CODE(c)				\
{						\
	if (bit) {				\
		c = *in_buffer++ >> 4;		\
		c |= *in_buffer++ << 4;		\
		in_size--;			\
	}					\
	else {					\
		c = *in_buffer++;		\
		c |= (*in_buffer & 0xF) << 8;	\
	}					\
	in_size--;				\
	bit ^= 1;				\
}


typedef struct LZW_ENTRY
{
	short code;
	short prefix;
	unsigned char value;
} LZW_ENTRY;

static LZW_ENTRY entry[TABLE_SIZE];


/*:::::*/
static LZW_ENTRY *find_match(int prefix, int value)
{
	int index, offset = 1;
	
	index = (value << 4) ^ prefix;
	if (index)
		offset = TABLE_SIZE - index;
	while (1) {
		if ((entry[index].code == -1) ||
		    ((entry[index].prefix == prefix) && (entry[index].value == value)))
			return &entry[index];
		index = (index + offset) % TABLE_SIZE;
	}
}


/*:::::*/
static char *decode_string(unsigned char *buffer, int code)
{
	int index = 0;
	
	while (code > 255) {
		*buffer++ = entry[code].value;
		code = entry[code].prefix;
		if (index++ >= MAX_CODE - 1)
			return NULL;
	}
	*buffer = code;
	return buffer;
}


/*:::::*/
int fb_hEncode(const unsigned char *in_buffer, int in_size, unsigned char *out_buffer, int *out_size)
{
	LZW_ENTRY *e;
	int string_code, next_code = 256;
	int size, bit = 0;
	
	size = 0;
	fb_hMemSet(entry, -1, sizeof(entry));
	string_code = *in_buffer++;
	in_size--;
	while (in_size) {
		e = find_match(string_code, *in_buffer);
		if (e->code != -1)
			string_code = e->code;
		else {
			if (next_code < MAX_CODE) {
				e->code = next_code++;
				e->prefix = string_code;
				e->value = *in_buffer;
			}
			OUTPUT_CODE(string_code);
			string_code = *in_buffer;
		}
		in_buffer++;
		in_size--;
	}
	OUTPUT_CODE(string_code);
	OUTPUT_CODE(MAX_CODE);
	if (bit)
		size++;
	*out_size = size;
	return 0;
}


/*:::::*/
int fb_hDecode(const unsigned char *in_buffer, int in_size, unsigned char *out_buffer, int *out_size)
{
	int next_code = 256;
	int new_code, old_code;
	int bit = 0;
	unsigned char *limit, decode_stack[MAX_CODE], *string, byte;
	
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
			entry[next_code].prefix = old_code;
			entry[next_code].value = byte;
			next_code++;
		}
		old_code = new_code;
	}
	return -1;
}

