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
 * lzw.h -- tiny LZW codec
 *          Based on code by Mark Nelson, Dr. Dobb's Journal October, 1989
 *
 * chng: mar/2005 written [lillo]
 *
 */

#ifndef __FB_GFX_LZW_H__
#define __FB_GFX_LZW_H__


#define MAX_CODE	4095
#define TABLE_SIZE	5021

#define OUTPUT_CODE(c)						\
{											\
	if (bit) {								\
		*out_buffer++ |= (c & 0xF) << 4;	\
		*out_buffer++ = c >> 4;				\
		size++;								\
	}										\
	else {									\
		*out_buffer++ = c & 0xFF;			\
		*out_buffer = c >> 8;				\
	}										\
	size++;									\
	if (size >= *out_size)					\
		return -1;							\
	bit ^= 1;								\
}

#define INPUT_CODE(c)						\
{											\
	if (bit) {								\
		c = *in_buffer++ >> 4;				\
		c |= *in_buffer++ << 4;				\
		in_size--;							\
	}										\
	else {									\
		c = *in_buffer++;					\
		c |= (*in_buffer & 0xF) << 8;		\
	}										\
	in_size--;								\
	bit ^= 1;								\
}


typedef struct LZW_ENTRY
{
	short code;
	unsigned short prefix;
	unsigned char value;
} LZW_ENTRY;

extern LZW_ENTRY fb_lzw_entry[TABLE_SIZE];

#endif
