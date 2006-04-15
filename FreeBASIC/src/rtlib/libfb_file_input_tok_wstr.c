/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2006 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and
 *  the FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * file_input_tok - input function core
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
static FB_WCHAR hReadChar( FB_INPUTCTX *ctx )
{
    /* device? */
    if( FB_HANDLE_USED(ctx->handle) )
    {
        int res;
        FB_WCHAR c;

        size_t len = 1;
        res = fb_FileGetDataEx( ctx->handle, 0, &c, &len, FALSE, TRUE );
        if( (res != FB_RTERROR_OK) || (len == 0) )
            return WEOF;

        return c;
    }
    /* console.. */
    else
    {
		if( ctx->index >= FB_STRSIZE( &ctx->str.len ) )
			return WEOF;
		else
			return (unsigned char)ctx->str.data[ctx->index++];
	}

}

/*:::::*/
static int hUnreadChar( FB_INPUTCTX *ctx, FB_WCHAR c )
{
    /* device? */
    if( FB_HANDLE_USED(ctx->handle) )
    {
        return fb_FilePutBackWstrEx( ctx->handle, &c, 1 );
    }
    /* console .. */
    else
    {
		if( ctx->index <= 0 )
			return 0;
		else
		{
			--ctx->index;
			return 1;
		}
	}

}

/*:::::*/
static FB_WCHAR hSkipWhiteSpc( FB_INPUTCTX *ctx )
{
	FB_WCHAR c;

	/* skip white space */
	do
	{
		c = hReadChar( ctx );
		if( c == WEOF )
			break;
	} while( (c == _LC(' ')) || (c == _LC('\t')) || (c == _LC('\r')) || (c == _LC('\n')) );

	return c;
}

/*:::::*/
static void hSkipComma( FB_INPUTCTX *ctx, FB_WCHAR c )
{
	/* skip white space */
	while( (c == _LC(' ')) || (c == _LC('\t')) )
		c = hReadChar( ctx );

	switch( c )
	{
	case _LC(','):
	case WEOF:
		break;

    case _LC('\n'):
        break;

	case _LC('\r'):
		if( (c = hReadChar( ctx )) != _LC('\n') )
			hUnreadChar( ctx, c );
		break;

	default:
    	hUnreadChar( ctx, c );
        break;
	}
}

/*:::::*/
void fb_hGetNextTokenWstr( FB_WCHAR *buffer, int max_chars, int is_string )
{
    int len, isquote, skipcomma;
    FB_WCHAR c;
	FB_INPUTCTX *ctx = FB_TLSGETCTX( INPUT );

	c = hSkipWhiteSpc( ctx );

	/* */
	isquote = 0;
	len = 0;
	skipcomma = 0;

	while( c != WEOF )
	{
		switch( c )
		{
		case _LC('\n'):
			len = max_chars;						/* exit */
			break;

		case _LC('\r'):
			if( (c = hReadChar( ctx )) != _LC('\n') )
				hUnreadChar( ctx, c );

			len = max_chars;						/* exit */
			break;

		case _LC('"'):
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
				if( is_string )
				{
					c = hReadChar( ctx );
					skipcomma = 1;
					len = max_chars;				/* exit */
				}
			}

			break;

		case _LC(','):
			if( !isquote )
			{
				len = max_chars;					/* exit */
				break;
			}

			goto savechar;

		case _LC('\t'):
		case _LC(' '):
			if( len == 0 )
			{
				if( !is_string || !isquote )
					break;						/* skip white-space */
			}
			else if( !is_string && !isquote )
			{
				len = max_chars;					/* exit */
				break;
			}

		default:
savechar:
			*buffer++ = c;
            ++len;
            break;
		}

		if( len >= max_chars )
			break;

		c = hReadChar( ctx );
	}

	*buffer = _LC('\0');

	/* skip comma or newline */
	if( skipcomma )
		hSkipComma( ctx, c );
}


