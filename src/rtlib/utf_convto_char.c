/* UTF to zstring conversion
 * (based on ConvertUTF.c free implementation from Unicode, Inc)
 */

#include "fb.h"

extern const char __fb_utf8_trailingTb[256];
extern const UTF_32 __fb_utf8_offsetsTb[6];

/*
char * fb_hUTF8ToChar( const UTF_8 *src, char *dst, ssize_t *chars )
char * fb_hUTF16ToChar( const UTF_8 *src, char *dst, ssize_t *chars )
char * fb_hUTF32ToChar( const UTF_8 *src, char *dst, ssize_t *chars )

if 'dst' is null

	src 
		- 'src' is the address of the source utf-8 encoded string
		- must not be null
		- must have a null terminating character

	dst
		- ignored

	chars
		- 'chars' must not be null
		- 'chars' value is ignored on entry
		- on return, 'chars' is set to the number of characters 
		  converted not including the null terminator

	return value
		- the pointer to the newly allocated (realloc) memory
		  containing the converted string which includes a
		  terminating null character, or NULL pointer if
		  unable to allocate memory
		- 'chars' contains the number of characters 
		  converted not including the null terminator

	NOTE: caller is responsible to free the memory


if 'dst' is not null

	src
		- 'src' is the address of the source utf-8 encoded string
		- must not be null
		- may have null terminating character

	dst
		- 'dst' is the destination buffer for the ascii string

	chars
		- 'chars' must not be null
		- caller must set 'chars' to the maximum number of
		  characters to convert which may include the 
		  terminating null character
		- on return, 'chars' is set to the number characters
		  converted not including the terminating null
		  character
	
	NOTE: the caller will not know if a terminating null
	character was written based on the value of 'chars'.  The 
	value of 'chars' will be the same if the conversion ended
	on a terminating null character or the character
	immediately before it.  In either case, the terminating
	null character is not written.

*/

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
				char *newbuffer = realloc( buffer, dst_size );
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
				char *newbuffer = realloc( buffer, dst_size );
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
				char *newbuffer = realloc( buffer, dst_size );
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
