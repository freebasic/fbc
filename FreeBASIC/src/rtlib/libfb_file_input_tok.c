/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
 * file_input - input function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

/*****************************************************************************/
/* low level 																 */
/*****************************************************************************/

/*:::::*/
static int fb_hReadChar( void )
{
    FB_FILE *handle = (FB_FILE*) FB_TLSGET( fb_inpctx.handle );
	char *data;
	int i, res;

    if( handle ) {
        char ch;
        size_t len = 1;
        res = fb_FileGetDataEx( handle, 0, &ch, &len, FALSE );
        if( res!=FB_RTERROR_OK || len==0) {
            return EOF;
        }
        return ch;

    } else {
		if( (int)FB_TLSGET( fb_inpctx.i ) >= ( (int)FB_TLSGET( fb_inpctx.s.len ) & ~FB_TEMPSTRBIT ) )
			return EOF;
		else {
			data = (char *)FB_TLSGET( fb_inpctx.s.data );
			i = (int)FB_TLSGET( fb_inpctx.i );
			res = (int)data[i++];
			FB_TLSSET( fb_inpctx.i, i );
			return res;
		}
	}

}

/*:::::*/
static int fb_hUnreadChar( int c )
{
    FB_FILE *handle = (FB_FILE*) FB_TLSGET( fb_inpctx.handle );
    int i;

    if( handle!=NULL ) {
        char ch = (char) c;
        return fb_FilePutBackEx( handle, &ch, 1 );
    } else {
		i = (int)FB_TLSGET( fb_inpctx.i );
		if( i <= 0 )
			return 0;
		else
		{
			FB_TLSSET( fb_inpctx.i, i - 1 );
			return 1;
		}
	}

}

/*:::::*/
void fb_hGetNextToken( char *buffer, int maxlen, int isstring )
{
    int 	c, len, isquote, skipcomma;
    char    *p;

	/* skip white space */
	do
	{
		c = fb_hReadChar( );
		if( c == EOF )
			break;
	} while( (c == 32) || (c == 9) || (c == 10) || (c == 13) );

	/* */
	isquote = 0;
	p = buffer;
	len = 0;
	skipcomma = 0;

	while( c != EOF )
	{
		switch( c )
		{
		case 10:
			len = maxlen;						/* exit */
			break;

		case 13:
			if( (c = fb_hReadChar( )) != 10 )
				fb_hUnreadChar( c );

			len = maxlen;						/* exit */
			break;

		case '"':
			if( !isquote )
			{
				if( len == 0 )
					isquote = 1;
				else
					goto savechar;
			}
			else
			{
				isquote = 0;
				if( isstring )
				{
					c = fb_hReadChar( );
					skipcomma = 1;
					len = maxlen;				/* exit */
				}
			}

			break;

		case ',':
			if( !isquote )
			{
				len = maxlen;					/* exit */
				break;
			}

			goto savechar;

		case 9:
		case ' ':
			if( len == 0 )
			{
				if( !isstring || !isquote )
					break;						/* skip white-space */
			}
			else if( !isstring && !isquote )
			{
				len = maxlen;					/* exit */
				break;
			}

		default:
savechar:
			*p++ = (char)c;
            ++len;
            break;
		}

		if( len >= maxlen )
			break;

		c = fb_hReadChar( );
	}

	/* null term */
	*p = '\0';

	/* skip comma or newline */
	if( skipcomma )
	{
		/* skip white space */
		while( (c == 32) || (c == 9) )
			c = fb_hReadChar( );

		switch( c )
		{
		case ',':
		case EOF:
			break;

		case 13:
			if( (c = fb_hReadChar( )) != 10 )
				fb_hUnreadChar( c );
			break;

		default:
            fb_hUnreadChar( c );
            break;
		}
	}
}
