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
	int res;
	FB_INPUTCTX *ctx = FB_TLSGETCTX( INPUT );

    if( FB_HANDLE_USED(ctx->handle) )
    {
        char ch;
        size_t len = 1;
        res = fb_FileGetDataEx( ctx->handle, 0, &ch, &len, FALSE );
        if( res!=FB_RTERROR_OK || len==0) {
            return EOF;
        }
        return ch;

    }
    else
    {
		if( ctx->i >= FB_STRSIZE( &ctx->s.len ) )
			return EOF;
		else {
			res = ctx->s.data[ctx->i++];
			return res;
		}
	}

}

/*:::::*/
static int fb_hUnreadChar( int c )
{
    FB_INPUTCTX *ctx = FB_TLSGETCTX( INPUT );

    if( FB_HANDLE_USED(ctx->handle) ) {
        char ch = (char) c;
        return fb_FilePutBackEx( ctx->handle, &ch, 1 );
    } else {
		if( ctx->i <= 0 )
			return 0;
		else
		{
			--ctx->i;
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

        case 10:
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
