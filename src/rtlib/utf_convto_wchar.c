/* UTF to wstring conversion
 * (based on ConvertUTF.c free implementation from Unicode, Inc)
 */

#include "fb.h"

extern const char __fb_utf8_trailingTb[256];
extern const UTF_32 __fb_utf8_offsetsTb[6];

char *fb_hUTF8ToChar( const UTF_8 *src, char *dst, ssize_t *chars );
char *fb_hUTF16ToChar( const UTF_16 *src, char *dst, ssize_t *chars );
char *fb_hUTF32ToChar( const UTF_32 *src, char *dst, ssize_t *chars );

static FB_WCHAR *hUTF8ToUTF16( const UTF_8 *src, FB_WCHAR *dst, ssize_t *chars )
{
	UTF_32 c;
	ssize_t extbytes, charsleft;
	FB_WCHAR *buffer = dst;
	
    if( dst == NULL )
    {
		ssize_t dst_size = 0;
	    charsleft = 0;
	    do 
	    {
			extbytes = __fb_utf8_trailingTb[(unsigned int)*src];
	
			c = 0;
			switch( extbytes )
			{
				case 5:
					c += *src++; c <<= 6;
					/* fall through */
				case 4:
					c += *src++; c <<= 6;
					/* fall through */
				case 3:
					c += *src++; c <<= 6;
					/* fall through */
				case 2:
					c += *src++; c <<= 6;
					/* fall through */
				case 1:
					c += *src++; c <<= 6;
					/* fall through */
				case 0:
					c += *src++;
			}
	
			c -= __fb_utf8_offsetsTb[extbytes];

			/* Ensure we have room for at least 2 UTF16 units (surrogate pair) */
			if( charsleft < 2 )
			{
				/* If we still have room for 1 char, reclaim it */
				dst_size -= charsleft;

				/* Make room for some chars */
				charsleft = 8;
				dst_size += charsleft;

				FB_WCHAR *newbuffer = realloc( buffer, dst_size * sizeof( FB_WCHAR ) );
				if( newbuffer == NULL )
				{
					free( buffer );
					return NULL;
				}
				buffer = newbuffer;
				dst = buffer + dst_size - charsleft;
			}

			if( c <= UTF16_MAX_BMP )
				*dst++ = c;
			else
			{
				c -= UTF16_HALFBASE;
				*dst++ = ((c >> UTF16_HALFSHIFT) + UTF16_SUR_HIGH_START);
				*dst++ = ((c & UTF16_HALFMASK) + UTF16_SUR_LOW_START);
				--charsleft;
			}
	
			if( c == 0 )
				break;
			
			--charsleft;
		} while( 1 );
		
		*chars = dst_size - charsleft;
	}
	else
	{
	    charsleft = *chars;
	    while( charsleft > 0 )
	    {
			extbytes = __fb_utf8_trailingTb[*src];
	
			c = 0;
			switch( extbytes )
			{
				case 5:
					c += *src++; c <<= 6;
					/* fall through */
				case 4:
					c += *src++; c <<= 6;
					/* fall through */
				case 3:
					c += *src++; c <<= 6;
					/* fall through */
				case 2:
					c += *src++; c <<= 6;
					/* fall through */
				case 1:
					c += *src++; c <<= 6;
					/* fall through */
				case 0:
					c += *src++;
			}
	
			c -= __fb_utf8_offsetsTb[extbytes];

			if( c <= UTF16_MAX_BMP )
				*dst++ = c;
			else
			{
				c -= UTF16_HALFBASE;
				*dst++ = ((c >> UTF16_HALFSHIFT) + UTF16_SUR_HIGH_START);
				if( charsleft > 1 )
				{
					*dst++ = ((c & UTF16_HALFMASK) + UTF16_SUR_LOW_START);
					--charsleft;
				}
			}

			if( c == 0 )
				break;
			
			--charsleft;
		}
		
		*chars -= charsleft;
	}
	
	return buffer;
}

static FB_WCHAR *hUTF8ToUTF32( const UTF_8 *src, FB_WCHAR *dst, ssize_t *chars )
{
	UTF_32 c;
	ssize_t extbytes, charsleft;
	FB_WCHAR *buffer = dst;
	
    if( dst == NULL )
    {
		ssize_t dst_size = 0;
	    charsleft = 0;
	    do 
	    {
			extbytes = __fb_utf8_trailingTb[(unsigned int)*src];
	
			c = 0;
			switch( extbytes )
			{
				case 5:
					c += *src++; c <<= 6;
					/* fall through */
				case 4:
					c += *src++; c <<= 6;
					/* fall through */
				case 3:
					c += *src++; c <<= 6;
					/* fall through */
				case 2:
					c += *src++; c <<= 6;
					/* fall through */
				case 1:
					c += *src++; c <<= 6;
					/* fall through */
				case 0:
					c += *src++;
			}

			c -= __fb_utf8_offsetsTb[extbytes];

			if( charsleft == 0 )
			{
				charsleft = 8;
				dst_size += charsleft;
				FB_WCHAR *newbuffer = realloc( buffer, dst_size * sizeof( FB_WCHAR ) );
				if( newbuffer == NULL )
				{
					free( buffer );
					return NULL;
				}
				buffer = newbuffer;
				dst = buffer + dst_size - charsleft;
			}
			
			*dst++ = c;
	
			if( c == 0 )
				break;
			
			--charsleft;
		} while( 1 );
		
		*chars = dst_size - charsleft;
	}
	else
	{
	    charsleft = *chars;
	    while( charsleft > 0 )
	    {
			extbytes = __fb_utf8_trailingTb[*src];
	
			c = 0;
			switch( extbytes )
			{
				case 5:
					c += *src++; c <<= 6;
					/* fall through */
				case 4:
					c += *src++; c <<= 6;
					/* fall through */
				case 3:
					c += *src++; c <<= 6;
					/* fall through */
				case 2:
					c += *src++; c <<= 6;
					/* fall through */
				case 1:
					c += *src++; c <<= 6;
					/* fall through */
				case 0:
					c += *src++;
			}
	
			c -= __fb_utf8_offsetsTb[extbytes];

			*dst++ = c;

			if( c == 0 )
				break;
			
			--charsleft;
		}
		
		*chars -= charsleft;
	}
	
	return buffer;
}

static FB_WCHAR *hUTF8ToWChar( const UTF_8 *src, FB_WCHAR *dst, ssize_t *chars )
{
	FB_WCHAR *res = NULL;
	
	/* convert.. */
	switch( sizeof( FB_WCHAR ) )
	{
	case sizeof( char ):
		res = (FB_WCHAR *)fb_hUTF8ToChar( src, (char *)dst, chars );
		break;

	case sizeof( UTF_16 ):
		res = hUTF8ToUTF16( src, dst, chars );
		break;

	case sizeof( UTF_32 ):
		res = hUTF8ToUTF32( src, dst, chars );
		break;
	}
	
	return res;
}

static FB_WCHAR *hUTF16ToUTF16( const UTF_16 *src, FB_WCHAR *dst, ssize_t *chars )
{
	/* Have to determine and return actual string length */
	ssize_t len = 0;
	if( dst == NULL ) {
		while( src[len] )
			len++;
		dst = malloc( (len + 1) * sizeof( UTF_16 ) );
		if( dst == NULL )
			return NULL;
		memcpy( dst, src, (len + 1) * sizeof( UTF_16 ) );
	} else {
		while( src[len] && len < *chars )
			len++;
		memcpy( dst, src, len * sizeof( UTF_16 ) );
		if (len < *chars)
			/* The input buffer has a trailing NUL character, copy it */
			dst[len] = 0;
	}
	*chars = len;
	return dst;
}

static FB_WCHAR *hUTF16ToUTF32( const UTF_16 *src, FB_WCHAR *dst, ssize_t *chars )
{
	UTF_16 c;
	ssize_t charsleft;
	FB_WCHAR *buffer = dst;
	
    if( dst == NULL )
    {
		ssize_t dst_size = 0;
	    charsleft = 0;
	    do 
	    {
	    	c = *src++ & 0x0000FFFF;
			if( c >= UTF16_SUR_HIGH_START && c <= UTF16_SUR_HIGH_END )
			{
				c = ((c - UTF16_SUR_HIGH_START) << UTF16_HALFSHIFT) +
				     ((FB_WCHAR)*src++ - UTF16_SUR_LOW_START) + UTF16_HALFBASE;
	    	}
	
			if( charsleft == 0 )
			{
				charsleft = 8;
				dst_size += charsleft;
				FB_WCHAR *newbuffer = realloc( buffer, dst_size * sizeof( FB_WCHAR ) );
				if( newbuffer == NULL ) {
					free( buffer );
					return NULL;
				}
				buffer = newbuffer;
				dst = buffer + dst_size - charsleft;
			}
			
			*dst++ = c;

			if( c == 0 )
				break;
			
			--charsleft;
		} while( 1 );
		
		*chars = dst_size - charsleft;
	}
	else
	{
	    charsleft = *chars;
	    while( charsleft > 0 )
	    {
	    	c = *src++ & 0x0000FFFF;
			if( c >= UTF16_SUR_HIGH_START && c <= UTF16_SUR_HIGH_END )
			{
				c = ((c - UTF16_SUR_HIGH_START) << UTF16_HALFSHIFT) +
				     ((FB_WCHAR)*src++ - UTF16_SUR_LOW_START) + UTF16_HALFBASE;
			}

			*dst++ = c;

			if( c == 0 )
				break;
			
			--charsleft;
		}
		
		*chars -= charsleft;
	}
	
	return buffer;
}

static FB_WCHAR *hUTF16ToWChar( const UTF_16 *src, FB_WCHAR *dst, ssize_t *chars )
{
	switch( sizeof( FB_WCHAR ) )
	{
	case sizeof( char ):
		dst = (FB_WCHAR *)fb_hUTF16ToChar( src, (char *)dst, chars );
		break;

	case sizeof( UTF_16 ):
		dst = hUTF16ToUTF16( src, dst, chars );
		break;

	case sizeof( UTF_32 ):
		dst = hUTF16ToUTF32( src, dst, chars );
		break;
	}

	return dst;
}

static FB_WCHAR *hUTF32ToUTF16( const UTF_32 *src, FB_WCHAR *dst, ssize_t *chars )
{
	UTF_32 c;
	ssize_t charsleft;
	FB_WCHAR *buffer = dst;
	
    if( dst == NULL )
    {
		ssize_t dst_size = 0;
	    charsleft = 0;
	    do 
	    {
	    	c = *src++;
	
			/* Ensure we have room for at least 2 UTF16 units (surrogate pair) */
			if( charsleft < 2 )
			{
				/* If we still have room for 1 char, reclaim it */
				dst_size -= charsleft;

				/* Make room for some chars */
				charsleft = 8;
				dst_size += charsleft;
				FB_WCHAR *newbuffer = realloc( buffer, dst_size * sizeof( FB_WCHAR ) );
				if( newbuffer == NULL ) {
					free( buffer );
					return NULL;
				}
				buffer = newbuffer;
				dst = buffer + dst_size - charsleft;
			}
			
			if( c > UTF16_MAX_BMP )
			{
				c -= UTF16_HALFBASE;
				*dst++ = (UTF_16)((c >> UTF16_HALFSHIFT) + UTF16_SUR_HIGH_START);				
				c = ((c & UTF16_HALFMASK) + UTF16_SUR_LOW_START);
				--charsleft;
			}
			
			*dst++ = c;

			if( c == 0 )
				break;
			
			--charsleft;
		} while( 1 );
		
		*chars = dst_size - charsleft;
	}
	else
	{
	    charsleft = *chars;
	    while( charsleft > 0 )
	    {
	    	c = *src++;

			if( c > UTF16_MAX_BMP )
			{
				c -= UTF16_HALFBASE;
				if( charsleft > 1 )
				{
					*dst++ = (UTF_16)((c >> UTF16_HALFSHIFT) + UTF16_SUR_HIGH_START);				
					--charsleft;
				}
				c = ((c & UTF16_HALFMASK) + UTF16_SUR_LOW_START);
			}

			*dst++ = c;

			if( c == 0 )
				break;
			
			--charsleft;
		}
		
		*chars -= charsleft;
	}
	
	return buffer;
}

static FB_WCHAR *hUTF32ToUTF32( const UTF_32 *src, FB_WCHAR *dst, ssize_t *chars )
{
	/* Have to determine and return actual string length */
	ssize_t len = 0;
	if( dst == NULL ) {
		while( src[len] )
			len++;
		dst = malloc( (len + 1) * sizeof( UTF_32 ) );
		if( dst == NULL )
			return NULL;
		memcpy( dst, src, (len + 1) * sizeof( UTF_32 ) );
	} else {
		while( src[len] && len < *chars )
			len++;
		memcpy( dst, src, len * sizeof( UTF_32 ) );
		/* Can't copy trailing NUL character if dst is too small */
		if (len < *chars)
			dst[len] = 0;
	}
	*chars = len;
	return dst;
}

static FB_WCHAR *hUTF32ToWChar( const UTF_32 *src, FB_WCHAR *dst, ssize_t *chars )
{
	switch( sizeof( FB_WCHAR ) )
	{
	case sizeof( char ):
		dst = (FB_WCHAR *)fb_hUTF32ToChar( src, (char *)dst, chars );
		break;

	case sizeof( UTF_16 ):
		dst = hUTF32ToUTF16( src, dst, chars );
		break;

	case sizeof( UTF_32 ):
		dst = hUTF32ToUTF32( src, dst, chars );
		break;
	}
	return dst;
}

/* Convert a NUL-terminated UTF string to FB_WCHARs.
   dst is an output buffer, or NULL to allocate a new one.
   If dst is not NULL, then *chars is the length of the output buffer in
   characters. If it's too short then no trailing NUL character is appended!
   Returns the output buffer and sets *chars to the number of wchars written
   to the buffer, NOT including any trailing NUL, and counting UTF16 surrogate
   pairs (if WCHAR is 16 bit) as 2. */
FB_WCHAR *fb_UTFToWChar( FB_FILE_ENCOD encod, const void *src, FB_WCHAR *dst, ssize_t *chars )
{
	switch( encod )
	{
	case FB_FILE_ENCOD_UTF8:
		return hUTF8ToWChar( src, dst, chars );

	case FB_FILE_ENCOD_UTF16:
		return hUTF16ToWChar( src, dst, chars );

	case FB_FILE_ENCOD_UTF32:
		return hUTF32ToWChar( src, dst, chars );

	default:
		return NULL;
	}
}
