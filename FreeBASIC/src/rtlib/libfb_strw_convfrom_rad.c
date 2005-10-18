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

#include "fb.h"
#include "fb_unicode.h"

/*:::::*/
FBCALL int fb_WstrRadix2Int( const FB_WCHAR *s, int len, int radix )
{
	int c, v;

	v = 0;

	switch( radix )
	{
		/* hex */
		case 16:
			while( --len >= 0 )
			{
				c = (int)fb_wstr_GetChar( (FB_WCHAR **)&s ) - 48;
                if( c > 9 )
                	c -= (65 - 57 - 1);
				if( c > 16 )
					c -= (97 - 65);

				v = (v * 16) + c;
			}
			break;

		/* oct */
		case 8:
			while( --len >= 0 )
				v = (v * 8) + ((int)fb_wstr_GetChar( (FB_WCHAR **)&s ) - 48);
			break;

		/* bin */
		case 2:
			while( --len >= 0 )
				v = (v * 2) + ((int)fb_wstr_GetChar( (FB_WCHAR **)&s ) - 48);
			break;
	}

	return v;
}
