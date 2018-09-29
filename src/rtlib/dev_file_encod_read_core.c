/* UTF-encoded to char or wchar file reading
 * (based on ConvertUTF.c free implementation from Unicode, Inc)
 */

#include "fb.h"

extern const char __fb_utf8_trailingTb[256];
extern const UTF_32 __fb_utf8_offsetsTb[6];

/*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*
 * to char                                                                              *
 *::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/

static ssize_t hReadUTF8ToChar( FILE *fp, char *dst, ssize_t max_chars )
{
	UTF_32 wc;
	unsigned char c[7], *p;
	ssize_t chars, extbytes;

	chars = max_chars;
    while( chars > 0 )
    {
		if( fread( &c[0], 1, 1, fp ) != 1 )
			break;

		extbytes = __fb_utf8_trailingTb[c[0]];

		if( extbytes > 0 )
			if( fread( &c[1], extbytes, 1, fp ) != 1 )
				break;

		wc = 0;
		p = &c[0];
		switch( extbytes )
		{
			case 5:
				wc += *p++;
				wc <<= 6;
				/* fall through */
			case 4:
				wc += *p++;
				wc <<= 6;
				/* fall through */
			case 3:
				wc += *p++;
				wc <<= 6;
				/* fall through */
			case 2:
				wc += *p++;
				wc <<= 6;
				/* fall through */
			case 1:
				wc += *p++;
				wc <<= 6;
				/* fall through */
			case 0:
				wc += *p++;
		}

		wc -= __fb_utf8_offsetsTb[extbytes];

		if( wc > 255 )
			wc = '?';

		*dst++ = wc;
		--chars;
	}

	return max_chars - chars;
}

static ssize_t hReadUTF16ToChar( FILE *fp, char *dst, ssize_t max_chars )
{
    ssize_t chars;
    UTF_16 c;

    chars = max_chars;
    while( chars > 0 )
    {
        if( fread( &c, sizeof( UTF_16 ), 1, fp ) != 1 )
            break;

        if( c > 255 )
        {
            if( c >= UTF16_SUR_HIGH_START && c <= UTF16_SUR_HIGH_END )
            {
                if( fread( &c, sizeof( UTF_16 ), 1, fp ) != 1 )
                    break;
            }
            c = '?';
        }

        *dst++ = c;
        --chars;
    }

	return max_chars - chars;
}

static ssize_t hReadUTF32ToChar( FILE *fp, char *dst, ssize_t max_chars )
{
	ssize_t chars;
	UTF_32 c;

	chars = max_chars;
    while( chars > 0 )
    {
        if( fread( &c, sizeof( UTF_32 ), 1, fp ) != 1 )
            break;

        if( c > 255 )
            c = '?';

        *dst++ = c;
        --chars;
    }

    return max_chars - chars;
}

ssize_t fb_hFileRead_UTFToChar( FILE *fp, FB_FILE_ENCOD encod, char *dst, ssize_t max_chars )
{
	switch( encod )
	{
	case FB_FILE_ENCOD_UTF8:
		return hReadUTF8ToChar( fp, dst, max_chars );

	case FB_FILE_ENCOD_UTF16:
		return hReadUTF16ToChar( fp, dst, max_chars );

	case FB_FILE_ENCOD_UTF32:
		return hReadUTF32ToChar( fp, dst, max_chars );

	default:
		return 0;
	}

}

/*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*
 * to wchar                                                                             *
 *::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/

static ssize_t hUTF8ToUTF16( FILE *fp, FB_WCHAR *dst, ssize_t max_chars )
{
	UTF_32 wc;
	unsigned char c[7], *p;
	ssize_t chars, extbytes;

	chars = max_chars;
    while( chars > 0 )
    {
		if( fread( &c[0], 1, 1, fp ) != 1 )
			break;

		extbytes = __fb_utf8_trailingTb[c[0]];

		if( extbytes > 0 )
			if( fread( &c[1], extbytes, 1, fp ) != 1 )
				break;

		wc = 0;
		p = &c[0];
		switch( extbytes )
		{
			case 5:
				wc += *p++;
				wc <<= 6;
				/* fall through */
			case 4:
				wc += *p++;
				wc <<= 6;
				/* fall through */
			case 3:
				wc += *p++;
				wc <<= 6;
				/* fall through */
			case 2:
				wc += *p++;
				wc <<= 6;
				/* fall through */
			case 1:
				wc += *p++;
				wc <<= 6;
				/* fall through */
			case 0:
				wc += *p++;
		}

		wc -= __fb_utf8_offsetsTb[extbytes];

		if( wc <= UTF16_MAX_BMP )
		{
			*dst++ = wc;
		}
		else
		{
			if( chars > 1 )
			{
				wc -= UTF16_HALFBASE;
				*dst++ = ((wc >> UTF16_HALFSHIFT) +	UTF16_SUR_HIGH_START);
				*dst++ = ((wc & UTF16_HALFMASK)	+ UTF16_SUR_LOW_START);
				--chars;
			}
		}

		--chars;
	}

	return max_chars - chars;
}

static ssize_t hUTF8ToUTF32( FILE *fp, FB_WCHAR *dst, ssize_t max_chars )
{
	UTF_32 wc;
	unsigned char c[7], *p;
	ssize_t chars, extbytes;

	chars = max_chars;
    while( chars > 0 )
    {
		if( fread( &c[0], 1, 1, fp ) != 1 )
			break;

		extbytes = __fb_utf8_trailingTb[c[0]];

		if( extbytes > 0 )
			if( fread( &c[1], extbytes, 1, fp ) != 1 )
				break;

		wc = 0;
		p = &c[0];
		switch( extbytes )
		{
			case 5:
				wc += *p++;
				wc <<= 6;
				/* fall through */
			case 4:
				wc += *p++;
				wc <<= 6;
				/* fall through */
			case 3:
				wc += *p++;
				wc <<= 6;
				/* fall through */
			case 2:
				wc += *p++;
				wc <<= 6;
				/* fall through */
			case 1:
				wc += *p++;
				wc <<= 6;
				/* fall through */
			case 0:
				wc += *p++;
		}

		wc -= __fb_utf8_offsetsTb[extbytes];

		*dst++ = wc;
		--chars;
	}

	return max_chars - chars;
}

static ssize_t hReadUTF8ToWchar( FILE *fp, FB_WCHAR *dst, ssize_t max_chars )
{
	ssize_t res = 0;

	/* convert.. */
	switch( sizeof( FB_WCHAR ) )
	{
	case sizeof( char ):
		res = hReadUTF8ToChar( fp, (char *)dst, max_chars );
		break;

	case sizeof( UTF_16 ):
		res = hUTF8ToUTF16( fp, dst, max_chars );
		break;

	case sizeof( UTF_32 ):
		res = hUTF8ToUTF32( fp, dst, max_chars );
		break;
	}

	return res;
}

static ssize_t hUTF16ToUTF32( FILE *fp, FB_WCHAR *dst, ssize_t max_chars )
{
    UTF_32 c, c2;
	ssize_t chars;

    chars = max_chars;
    while( chars > 0 )
    {
        if( fread( &c, sizeof( UTF_16 ), 1, fp ) != 1 )
            break;

        c &= 0x0000FFFF;
        if( c >= UTF16_SUR_HIGH_START && c <= UTF16_SUR_HIGH_END )
        {
            if( fread( &c2, sizeof( UTF_16 ), 1, fp ) != 1 )
                break;

            c = ((c - UTF16_SUR_HIGH_START) << UTF16_HALFSHIFT) +
                 (c2 - UTF16_SUR_LOW_START) + UTF16_HALFBASE;
        }

        *dst++ = c;
        --chars;
    }

    return max_chars - chars;
}

static ssize_t hReadUTF16ToWchar( FILE *fp, FB_WCHAR *dst, ssize_t max_chars )
{
	ssize_t res = 0;

	/* same size? */
	if( sizeof( FB_WCHAR ) == sizeof( UTF_16 ) )
		return fread( (char *)dst, sizeof( UTF_16 ), max_chars, fp );

	/* convert.. */
	switch( sizeof( FB_WCHAR ) )
	{
	case sizeof( char ):
		res = hReadUTF16ToChar( fp, (char *)dst, max_chars );
		break;

	case sizeof( UTF_32 ):
		res = hUTF16ToUTF32( fp, dst, max_chars );
		break;
	}

	return res;
}

static ssize_t hUTF32ToUTF16( FILE *fp, FB_WCHAR *dst, ssize_t max_chars )
{
    UTF_32 c;
	ssize_t chars;

    chars = max_chars;
    while( chars > 0 )
    {
        if( fread( &c, sizeof( UTF_32 ), 1, fp ) != 1 )
            break;

		if( c > UTF16_MAX_BMP )
		{
			c -= UTF16_HALFBASE;
			if( chars > 1 )
			{
				*dst++ = (UTF_16)((c >> UTF16_HALFSHIFT) + UTF16_SUR_HIGH_START);
				--chars;
			}
			c = ((c & UTF16_HALFMASK) + UTF16_SUR_LOW_START);
		}

		*dst++ = (UTF_16)c;
		--chars;
    }

	return max_chars - chars;
}

static ssize_t hReadUTF32ToWchar( FILE *fp, FB_WCHAR *dst, ssize_t max_chars )
{
	ssize_t res = 0;

	switch( sizeof( FB_WCHAR ) )
	{
	case sizeof( char ):
		res = hReadUTF32ToChar( fp, (char *)dst, max_chars );
		break;

	case sizeof( UTF_16 ):
		res = hUTF32ToUTF16( fp, dst, max_chars );
		break;

	case sizeof( UTF_32 ):
		res = fread( (char *)dst, sizeof( UTF_32 ), max_chars, fp );
		break;
	}

	return res;
}

ssize_t fb_hFileRead_UTFToWchar( FILE *fp, FB_FILE_ENCOD encod, FB_WCHAR *dst, ssize_t max_chars )
{
	switch( encod )
	{
	case FB_FILE_ENCOD_UTF8:
		return hReadUTF8ToWchar( fp, dst, max_chars );

	case FB_FILE_ENCOD_UTF16:
		return hReadUTF16ToWchar( fp, dst, max_chars );

	case FB_FILE_ENCOD_UTF32:
		return hReadUTF32ToWchar( fp, dst, max_chars );

	default:
		return 0;
	}

}
