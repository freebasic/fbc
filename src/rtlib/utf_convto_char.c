/* UTF to zstring conversion
 * (based on ConvertUTF.c free implementation from Unicode, Inc)
 */

#include "fb.h"

extern const char __fb_utf8_trailingTb[256];
extern const UTF_32 __fb_utf8_offsetsTb[6];

char *fb_hUTF8ToChar( const UTF_8 *src, char *dst, ssize_t *chars )
{
	UTF_32 c;
	ssize_t extbytes, charsleft;
	char *buffer = dst;
	
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
	
			if( c > 255 )
				c = '?';
	
			if( charsleft == 0 )
			{
				charsleft = 8;
				dst_size += charsleft;
				buffer = realloc( buffer, dst_size );
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

			if( c > 255 )
				c = '?';

			*dst++ = c;

			if( c == 0 )
				break;
			
			--charsleft;
		}
		
		*chars -= charsleft;
	}
	
	return buffer;
}

char *fb_hUTF16ToChar( const UTF_16 *src, char *dst, ssize_t *chars )
{
	UTF_16 c;
	ssize_t charsleft;
	char *buffer = dst;

    if( dst == NULL )
    {
		ssize_t dst_size = 0;
	    charsleft = 0;
	    do 
	    {
	    	c = *src++;
			if( c > 255 )
			{
				if( c >= UTF16_SUR_HIGH_START && c <= UTF16_SUR_HIGH_END )
	    			++src;
	    		c = '?';
	    	}
	
			if( charsleft == 0 )
			{
				charsleft = 8;
				dst_size += charsleft;
				buffer = realloc( buffer, dst_size );
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
	    	c = *src++;
			if( c > 255 )
			{
				if( c >= UTF16_SUR_HIGH_START && c <= UTF16_SUR_HIGH_END )
	    			++src;
				c = '?';
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

char *fb_hUTF32ToChar( const UTF_32 *src, char *dst, ssize_t *chars )
{
	UTF_32 c;
	ssize_t charsleft;
	char *buffer = dst;

    if( dst == NULL )
    {
		ssize_t dst_size = 0;
	    charsleft = 0;
	    do 
	    {
	    	c = *src++;
			if( c > 255 )
				c = '?';
	
			if( charsleft == 0 )
			{
				charsleft = 8;
				dst_size += charsleft;
				buffer = realloc( buffer, dst_size );
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
	    	c = *src++;
			if( c > 255 )
				c = '?';

			*dst++ = c;

			if( c == 0 )
				break;
			
			--charsleft;
		}
		
		*chars -= charsleft;
	}
	
	return buffer;
}

char *fb_UTFToChar( FB_FILE_ENCOD encod, const void *src, char *dst, ssize_t *chars )
{
	switch( encod )
	{
	case FB_FILE_ENCOD_UTF8:
		return fb_hUTF8ToChar( src, dst, chars );

	case FB_FILE_ENCOD_UTF16:
		return fb_hUTF16ToChar( src, dst, chars );

	case FB_FILE_ENCOD_UTF32:
		return fb_hUTF32ToChar( src, dst, chars );

	default:
		return NULL;
	}

}
