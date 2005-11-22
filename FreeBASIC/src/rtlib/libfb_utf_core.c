/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
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
 * utf_convfrom_wchar - wstring to UTF conversion
 *
 * chng: nov/2005 written [v1ctor]
 *		 (based on ConvertUTF.c free implementation from Unicode, Inc)
 *
 */

#include "fb.h"

const UTF_8 fb_utf8_bmarkTb[7] = { 0x00, 0x00, 0xC0, 0xE0, 0xF0, 0xF8, 0xFC };

/*:::::*/
void fb_hCharToUTF8( const char *src, int chars, char *dst, int *total_bytes )
{
	UTF_8 c;
	int bytes;

	*total_bytes = 0;
	while( chars > 0 )
	{
		c = *src++;
		if( c < 0x80 )
			bytes =	1;
		else
			bytes = 2;

		dst += bytes;

		switch( bytes )
		{
		case 2:
			*--dst = (UTF_8)((c | UTF8_BYTEMARK) & UTF8_BYTEMASK);
			c >>= 6;
		case 1:
			*--dst = (UTF_8) (c | fb_utf8_bmarkTb[bytes]);
		}

		--chars;
		*total_bytes += bytes;
	}
}

