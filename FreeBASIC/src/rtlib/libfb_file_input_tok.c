/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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

/*:::::*/
static int hReadChar
	(
		FB_INPUTCTX *ctx
	)
{
    /* device? */
    if( FB_HANDLE_USED(ctx->handle) )
    {
        int res;
        int c;

        size_t len;
        res = fb_FileGetDataEx( ctx->handle, 0, &c, 1, &len, FALSE, FALSE );
        if( (res != FB_RTERROR_OK) || (len == 0) )
            return EOF;

        return c & 0x000000FF;
    }
    /* console.. */
    else
    {
		if( ctx->index >= FB_STRSIZE( &ctx->str ) )
			return EOF;
		else
			return ctx->str.data[ctx->index++];
	}

}

/*:::::*/
static int hUnreadChar
	(
		FB_INPUTCTX *ctx, int c
	)
{
    /* device? */
    if( FB_HANDLE_USED(ctx->handle) )
    {
        return fb_FilePutBackEx( ctx->handle, &c, 1 );
    }
    /* console .. */
    else
    {
		if( ctx->index <= 0 )
			return FALSE;
		else
		{
			--ctx->index;
			return TRUE;
		}
	}

}

/*:::::*/
static int hSkipWhiteSpc
	(
		FB_INPUTCTX *ctx
	)
{
	int c;

	/* skip white space */
	do
	{
		c = hReadChar( ctx );
		if( c == EOF )
			break;
	} while( (c == ' ') || (c == '\t') );

	return c;
}

/*:::::*/
static void hSkipDelimiter
	(
		FB_INPUTCTX *ctx,
		int c
	)
{
	/* skip white space */
	while( (c == ' ') || (c == '\t') )
		c = hReadChar( ctx );

	switch( c )
	{
	case ',':
	case EOF:
		break;

    case '\n':
        break;

	case '\r':
		if( (c = hReadChar( ctx )) != '\n' )
			hUnreadChar( ctx, c );
		break;

	default:
    	hUnreadChar( ctx, c );
        break;
	}
}

/*:::::*/
int fb_FileInputNextToken
	(
		char *buffer,
		int max_chars,
		int is_string,
		int *isfp
	)
{
    int c, len, isquote, hasamp, skipdelim;
	FB_INPUTCTX *ctx = FB_TLSGETCTX( INPUT );

	*isfp = FALSE;

	/* */
	skipdelim = TRUE;
	isquote = FALSE;
	hasamp = FALSE;
	len = 0;

	c = hSkipWhiteSpc( ctx );

	while( (c != EOF) && (len < max_chars) )
	{
		switch( c )
		{
		case '\n':
			skipdelim = FALSE;
			goto exit;

		case '\r':
			if( (c = hReadChar( ctx )) != '\n' )
				hUnreadChar( ctx, c );

			skipdelim = FALSE;
			goto exit;

		case '"':
			if( !isquote )
			{
				if( len == 0 )
					isquote = TRUE;
				else
					goto savechar;
			}
			else
			{
				isquote = FALSE;
				if( is_string )
				{
					c = hReadChar( ctx );
					goto exit;
				}
			}

			break;

		case ',':
			if( !isquote )
			{
				skipdelim = FALSE;
				goto exit;
			}

			goto savechar;

		case '&':
			hasamp = TRUE;
			goto savechar;

		case 'd':
		case 'D':
			/* NOTE: if exponent letter is d|D, and
			 * is_string == FALSE, then convert the d|D
			 * to an e|E. strtod() which
			 * will later be used to convert the string
			 * to float won't accept d|D anywhere but
			 * on windows. (jeffm)
			 */
			if( !hasamp && !is_string )
			{
				++c;
			}
			/* fall through */

		case 'e':
		case 'E':
		case '.':
			if( !hasamp )
			{
				*isfp = TRUE;
			}
			goto savechar;

		case '\t':
		case ' ':
			if( !isquote )
			{
				if( !is_string )
				{
					goto exit;
				}
			}

		default:
savechar:
			*buffer++ = c;
            ++len;
            break;
		}

		c = hReadChar( ctx );
	}

exit:
	/* add the null-term */
	*buffer = '\0';

	/* skip comma or newline */
	if( skipdelim )
		hSkipDelimiter( ctx, c );

	return len;
}
