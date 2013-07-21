/* ascii to UTF conversion */

#include "fb.h"

static char *hToUTF8( const char *src, ssize_t chars, char *dst, ssize_t *bytes )
{
	if( chars > 0 )
	{
		if( dst == NULL )
		{
			dst = malloc( chars * 2 );
			if( dst == NULL )
				return NULL;
		}

		fb_hCharToUTF8( src, chars, dst, bytes );
	}
	else
		*bytes = 0;

	return dst;
}

static char *hToUTF16( const char *src, ssize_t chars, char *dst, ssize_t *bytes )
{
	UTF_16 *p;

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

	p = (UTF_16 *)dst;
	while( chars > 0 )
	{
		*p++ = (unsigned char)*src++;
		--chars;
	}

	return dst;
}

static char *hToUTF32( const char *src, ssize_t chars, char *dst, ssize_t *bytes )
{
	UTF_32 *p;

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

	p = (UTF_32 *)dst;
	while( chars > 0 )
	{
		*p++ = (unsigned char)*src++;
		--chars;
	}

	return dst;
}

char *fb_CharToUTF
	(
		FB_FILE_ENCOD encod,
		const char *src,
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
