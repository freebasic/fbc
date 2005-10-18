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
 * strw_bin.c -- binw$ routines
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_unicode.h"

#ifndef TARGET_WIN32
/*:::::*/
static void hToBin( unsigned int num, FB_WCHAR *dst, int len )
{
	unsigned int mask = 1UL << ((len*8)-1);   
	int i; 
	
	if( num == 0 )
		fb_wstr_PutChar( &dst, '0' );
	else
    {
		for( i = 0; i < len*8; i++, num <<= 1 )
            if( num & mask )
				break;   
    
			for( ; i < len*8; i++, num <<= 1 )   
            	if( num & mask ) 
					fb_wstr_PutChar( &dst, '1' );
				else
                	fb_wstr_PutChar( &dst, '0' );
	}
	
	/* add null-term */
	fb_wstr_PutChar( &dst, 0 );
}
#endif

/*:::::*/
static FB_WCHAR *hBin ( unsigned int num, int len )
{
	FB_WCHAR *dst;

	/* alloc temp string, chars won't be above 127 */
    dst = fb_wstr_AllocTemp( len * 8 );
	if( dst != NULL )
	{
		/* convert */
#ifdef TARGET_WIN32
		_itow( num, dst, 2 );
#else
		hToBin( num, dst, len );
#endif
	}

	return dst;
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrBin_b ( unsigned char num )
{
	return hBin( num, sizeof( char ) );
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrBin_s ( unsigned short num )
{
	return hBin( num, sizeof( short ) );
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrBin_i ( unsigned int num )
{
	return hBin( num, sizeof( int ) );
}

