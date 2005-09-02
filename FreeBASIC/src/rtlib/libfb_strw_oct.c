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
 * strw_oct.c -- octw$ routines
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_unicode.h"

/*:::::*/
static FB_WCHAR *hOCT ( unsigned int num, int len )
{
	FB_WCHAR 	*dst;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( len * 4 );
	if( dst != NULL )
	{
		/* convert */
#ifdef TARGET_WIN32
		_itow( num, dst, 8 );
#else
		swprintf( dst, L"%o", num );
#endif
	}

	return dst;
}

/*:::::*/
FBCALL FB_WCHAR *fb_wStrOct_b ( unsigned char num )
{
	return hOCT( num, sizeof( char ) );
}

/*:::::*/
FBCALL FB_WCHAR *fb_wStrOct_s ( unsigned short num )
{
	return hOCT( num, sizeof( short ) );
}

/*:::::*/
FBCALL FB_WCHAR *fb_wStrOct_i ( unsigned int num )
{
	return hOCT( num, sizeof( int ) );
}

