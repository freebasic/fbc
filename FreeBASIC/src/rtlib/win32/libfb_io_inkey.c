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
 * io_inkey.c -- inkey$ function for Windows console mode apps
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include <assert.h>
#include "fb.h"

#ifdef TARGET_WIN32
#include <conio.h>
#endif

/*:::::*/
FBSTRING *fb_ConsoleInkey( void )
{
	FBSTRING 	 *res;
#ifdef TARGET_WIN32
	int			 chars;
	unsigned int k;

	if( _kbhit( ) )
	{
		chars = 1;
		k = (unsigned int)_getch( );
		if( k == 0x00 || k == 0xE0 )
		{
			k = (unsigned int)_getch( );
			chars = 2;
		}

        res = fb_hStrAllocTemp( NULL, chars );
        assert( res != NULL );

		if( chars > 1 )
			res->data[0] = FB_EXT_CHAR; /* note: can't use '\0' here as in qb */

		res->data[chars-1] = (unsigned char)k;
		res->data[chars-0] = '\0';

    }
	else
		res = &fb_strNullDesc;
#else
    FBSTRING *buffer = fb_ConsoleGetKeyBuffer( );
    size_t buffer_len;
    FB_STRLOCK();
    buffer_len = FB_STRSIZE( buffer );
    if( buffer_len!=0 ) {
        size_t chars = FB_CHAR_TO_INT(buffer->data[0]);
        res = fb_StrMid ( buffer, 2, chars );
        if( res!=NULL ) {
            buffer_len -= chars + 1;
            memmove( buffer->data, buffer->data + chars + 1,
                     buffer_len );
            buffer->data[buffer_len] = 0;
            fb_hStrSetLength( buffer, buffer_len );
        } else {
            res = &fb_strNullDesc;
        }
    } else {
        res = &fb_strNullDesc;
    }
    FB_STRUNLOCK();
#endif

	return res;
}

/*:::::*/
int fb_ConsoleGetkey( void )
{
	int k = 0;
#ifdef TARGET_WIN32
	k = _getch( );
	if( k == 0x00 || k == 0xE0 )
		k = _getch( );
#else
    FBSTRING *tmp;
    FB_STRLOCK();
    tmp = fb_ConsoleInkey( );
    switch( FB_STRSIZE(tmp) ) {
    case 1:
        k = FB_CHAR_TO_INT( tmp->data[0] );
        break;
    case 2:
        k = FB_MAKE_EXT_KEY( tmp->data[1] );
        break;
    }
    fb_hStrDelTemp( tmp );
    FB_STRUNLOCK();
#endif
	return k;
}

/*:::::*/
int fb_ConsoleKeyHit( void )
{
#ifdef TARGET_WIN32
	return _kbhit( );
#else
    FBSTRING *buffer = fb_ConsoleGetKeyBuffer( );
    size_t buffer_len;
    FB_STRLOCK();
    buffer_len = FB_STRSIZE( buffer );
    FB_STRUNLOCK();
    return buffer_len!=0;
#endif
}

