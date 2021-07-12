/* input function core */

#include "fb.h"

static FB_WCHAR hReadChar( FB_INPUTCTX *ctx )
{
    /* device? */
    if( FB_HANDLE_USED(ctx->handle) )
    {
        int res;
        FB_WCHAR c;

        size_t len;
        res = fb_FileGetDataEx( ctx->handle, 0, &c, 1, &len, FALSE, TRUE );
        if( (res != FB_RTERROR_OK) || (len == 0) )
            return FB_WEOF;

        return c;
    }
    /* console.. */
    else
    {
		if( ctx->index >= FB_STRSIZE( &ctx->str ) )
			return FB_WEOF;
		else
			return (unsigned char)ctx->str.data[ctx->index++];
	}

}

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

static FB_WCHAR hSkipWhiteSpc( FB_INPUTCTX *ctx )
{
	FB_WCHAR c;

	/* skip white space */
	do
	{
		c = hReadChar( ctx );
		if( c == FB_WEOF )
			break;
	} while( (c == _LC(' ')) || (c == _LC('\t')) );

	return c;
}

static void hSkipDelimiter( FB_INPUTCTX *ctx, FB_WCHAR c )
{
	/* skip white space */
	while( (c == _LC(' ')) || (c == _LC('\t')) )
		c = hReadChar( ctx );

	switch( c )
	{
	case _LC(','):
	case FB_WEOF:
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

void fb_FileInputNextTokenWstr( FB_WCHAR *buffer, ssize_t max_chars, int is_string )
{
	/* max_chars does not include the null terminator, the buffer is
	   assumed to be big enough to hold at least the null terminator */

	ssize_t len;
	int isquote, skipdelim;
    FB_WCHAR c;
	FB_INPUTCTX *ctx = FB_TLSGETCTX( INPUT );

	/* */
	skipdelim = TRUE;
	isquote = 0;
	len = 0;

	c = hSkipWhiteSpc( ctx );

	while( (c != FB_WEOF) && (len < max_chars) )
	{
		switch( c )
		{
		case _LC('\n'):
			skipdelim = FALSE;
			goto exit;

		case _LC('\r'):
			if( (c = hReadChar( ctx )) != _LC('\n') )
				hUnreadChar( ctx, c );

			skipdelim = FALSE;
			goto exit;

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
					goto exit;
				}
			}

			break;

		case _LC(','):
			if( !isquote )
			{
				skipdelim = FALSE;
				goto exit;
			}

			goto savechar;

		case _LC('\t'):
		case _LC(' '):
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
	*buffer = _LC('\0');

	/* skip comma or newline */
	if( skipdelim )
		hSkipDelimiter( ctx, c );
}
