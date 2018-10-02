/* input function core */

#include "fb.h"

static int hReadChar( FB_INPUTCTX *ctx )
{
    /* device? */
    if( FB_HANDLE_USED(ctx->handle) )
    {
		int res, c;
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

static int hUnreadChar( FB_INPUTCTX *ctx, int c )
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

static int hSkipWhiteSpc( FB_INPUTCTX *ctx )
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

static void hSkipDelimiter( FB_INPUTCTX *ctx, int c )
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

int fb_FileInputNextToken
	(
		char *buffer,
		ssize_t max_chars,
		int is_string,
		int *isfp
	)
{
	/* max_chars does not include the null terminator, the buffer is
	   assumed to be big enough to hold at least the null terminator */

	int c, isquote, hasamp, skipdelim;
	ssize_t len;
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
			goto savechar;

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
