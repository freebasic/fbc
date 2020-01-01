/* wstring to UTF conversion
 * (based on ConvertUTF.c free implementation from Unicode, Inc)
 */

#include "fb.h"

static void hUTF16ToUTF8( const FB_WCHAR *src, ssize_t chars, UTF_8 *dst, ssize_t *total_bytes )
{
	UTF_32 c;
	ssize_t bytes;

	*total_bytes = 0;
	while( chars > 0 )
	{
		c = *src++;
		if( c >= UTF16_SUR_HIGH_START && c <= UTF16_SUR_HIGH_END )
		{
			c = ((c - UTF16_SUR_HIGH_START) << UTF16_HALFSHIFT) +
			     (((UTF_32)*src++) - UTF16_SUR_LOW_START) + UTF16_HALFBASE;

			--chars;
		}

		if( c < (UTF_32)0x80 )
			bytes =	1;
		else if( c < (UTF_32)0x800 )
			bytes = 2;
		else if( c < (UTF_32)0x10000 )
			bytes = 3;
		else
			bytes =	4;

		dst += bytes;

		switch( bytes )
		{
		case 4:
			*--dst = ((c | UTF8_BYTEMARK) & UTF8_BYTEMASK);
			c >>= 6;
			/* fall through */
		case 3:
			*--dst = ((c | UTF8_BYTEMARK) & UTF8_BYTEMASK);
			c >>= 6;
			/* fall through */
		case 2:
			*--dst = ((c | UTF8_BYTEMARK) & UTF8_BYTEMASK);
			c >>= 6;
			/* fall through */
		case 1:
			*--dst = (c | __fb_utf8_bmarkTb[bytes]);
		}

		dst += bytes;
		--chars;
		*total_bytes += bytes;
	}
}

static void hUTF32ToUTF8( const FB_WCHAR *src, ssize_t chars, UTF_8 *dst, ssize_t *total_bytes )
{
	UTF_32 c;
	ssize_t bytes;

	*total_bytes = 0;
	while( chars > 0 )
	{
		c = *src++;
		if( c < (UTF_32)0x80 )
			bytes =	1;
		else if( c < (UTF_32)0x800 )
			bytes = 2;
		else if( c < (UTF_32)0x10000 )
			bytes = 3;
		else
			bytes =	4;

		dst += bytes;

		switch( bytes )
		{
		case 4:
			*--dst = ((c | UTF8_BYTEMARK) & UTF8_BYTEMASK);
			c >>= 6;
			/* fall through */
		case 3:
			*--dst = ((c | UTF8_BYTEMARK) & UTF8_BYTEMASK);
			c >>= 6;
			/* fall through */
		case 2:
			*--dst = ((c | UTF8_BYTEMARK) & UTF8_BYTEMASK);
			c >>= 6;
			/* fall through */
		case 1:
			*--dst = (c | __fb_utf8_bmarkTb[bytes]);
		}

		dst += bytes;
		--chars;
		*total_bytes += bytes;
	}
}

static char *hToUTF8( const FB_WCHAR *src, ssize_t chars, char *dst, ssize_t *bytes )
{
	if( chars > 0 )
	{
		if( dst == NULL )
		{
			dst = malloc( chars * 4 );
			if( dst == NULL )
				return NULL;
		}
	}

	switch( sizeof( FB_WCHAR ) )
	{
	case sizeof( UTF_8 ):
        fb_hCharToUTF8( (const char *)src, chars, dst, bytes );
		break;

	case sizeof( UTF_16 ):
		hUTF16ToUTF8( src, chars, (UTF_8 *)dst, bytes );
		break;

	case sizeof( UTF_32 ):
        hUTF32ToUTF8( src, chars, (UTF_8 *)dst, bytes );
		break;
	}

	return dst;
}

static void hCharToUTF16( const FB_WCHAR *src, ssize_t chars, UTF_16 *dst, ssize_t *bytes )
{
	while( chars > 0 )
	{
		*dst++ = (unsigned char)*src++;
		--chars;
	}
}

static UTF_16 *hUTF32ToUTF16( const FB_WCHAR *src, ssize_t chars, UTF_16 *dst, ssize_t *bytes )
{
	UTF_16 *buffer = dst;
	ssize_t i, dst_size = *bytes;
	UTF_32 c;

	i = 0;
	while( chars > 0 )
	{
		c = *src++;
		if( c > UTF16_MAX_BMP )
		{
			if( *bytes == dst_size )
			{
				dst_size += sizeof( UTF_16 ) * 8;
				UTF_16 *newbuffer = realloc( buffer, dst_size );
				if( newbuffer == NULL )
				{
					free( buffer );
					return NULL;
				}
				buffer = newbuffer;
				dst = (UTF_16 *)buffer;
			}

			*bytes += sizeof( UTF_16 );

			c -= UTF16_HALFBASE;
			dst[i++] = (UTF_16)((c >> UTF16_HALFSHIFT) + UTF16_SUR_HIGH_START);
			c = ((c & UTF16_HALFMASK) + UTF16_SUR_LOW_START);
		}

		dst[i++] = (UTF_16)c;

		--chars;
	}

	return buffer;
}

static char *hToUTF16( const FB_WCHAR *src, ssize_t chars, char *dst, ssize_t *bytes )
{
	/* !!!FIXME!!! only litle-endian supported */

	*bytes = chars * sizeof( UTF_16 );

	if( chars > 0 )
	{
		if( dst == NULL )
		{
			dst = malloc( chars * sizeof( UTF_16 ) );
			if( dst == NULL )
				return NULL;
		}
	}

	switch( sizeof( FB_WCHAR ) )
	{
	case sizeof( char ):
		hCharToUTF16( src, chars, (UTF_16 *)dst, bytes );
		break;

	case sizeof( UTF_16 ):
		memcpy( dst, src, chars * sizeof( UTF_16 ) );
		break;

	case sizeof( UTF_32 ):
        dst = (char *)hUTF32ToUTF16( src, chars, (UTF_16 *)dst, bytes );
		break;
	}

	return dst;
}

static void hCharToUTF32( const FB_WCHAR *src, ssize_t chars, UTF_32 *dst, ssize_t *bytes )
{
	while( chars > 0 )
	{
		*dst++ = (unsigned char)*src++;
		--chars;
	}
}

static void hUTF16ToUTF32( const FB_WCHAR *src, ssize_t chars, UTF_32 *dst, ssize_t *bytes )
{
	UTF_32 c;

	while( chars > 0 )
	{
		c = (UTF_32)*src++;
		if( c >= UTF16_SUR_HIGH_START && c <= UTF16_SUR_HIGH_END )
		{
			c = ((c - UTF16_SUR_HIGH_START) << UTF16_HALFSHIFT) +
			     (((UTF_32)*src++) - UTF16_SUR_LOW_START) + UTF16_HALFBASE;

			*bytes -= sizeof( UTF_32 );
			--chars;
		}

		*dst++ = c;

		--chars;
	}
}

static char *hToUTF32( const FB_WCHAR *src, ssize_t chars, char *dst, ssize_t *bytes )
{
	/* !!!FIXME!!! only litle-endian supported */

	*bytes = chars * sizeof( UTF_32 );

	if( chars > 0 )
	{
		if( dst == NULL )
		{
			dst = malloc( chars * sizeof( UTF_32 ) );
			if( dst == NULL )
				return NULL;
		}
	}

	switch( sizeof( FB_WCHAR ) )
	{
	case sizeof( char ):
		hCharToUTF32( src, chars, (UTF_32 *)dst, bytes );
		break;

	case sizeof( UTF_16 ):
        hUTF16ToUTF32( src, chars, (UTF_32 *)dst, bytes );
		break;

	case sizeof( UTF_32 ):
		memcpy( dst, src, chars * sizeof( UTF_32 ) );
		break;

	default:
		break;
	}

	return dst;
}

/* chars is the length of the input in characters, with UTF16 surrogate pairs
   counting as 2.
   dst is an optional output buffer (which must be large enough); if NULL, one
   is malloc'd.
   A NUL is only appended to the output if it occurs in the input (unlike
   fb_UTFToWChar this does NOT stop on seeing a NUL, as the length is known).
   Returns the output buffer and sets *bytes to the number of bytes written.
*/
char *fb_WCharToUTF
	(
		FB_FILE_ENCOD encod,
		const FB_WCHAR *src,
		ssize_t chars,
		char *dst,
		ssize_t *bytes
	)
{
	switch( encod )
	{
	case FB_FILE_ENCOD_UTF8:
		return hToUTF8( src, chars, dst, bytes );

	case FB_FILE_ENCOD_UTF16:
		return hToUTF16( src, chars, dst, bytes );

	case FB_FILE_ENCOD_UTF32:
		return hToUTF32( src, chars, dst, bytes );

	default:
		return NULL;
	}
}
