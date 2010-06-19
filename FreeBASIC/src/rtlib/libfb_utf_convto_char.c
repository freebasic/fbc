/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 * utf_convto_char - UTF to zstring conversion
 *
 * chng: mar/2006 written [v1ctor]
 *		 (based on ConvertUTF.c free implementation from Unicode, Inc)
 *
 */

#include <stdlib.h>

#include "fb.h"

extern const char __fb_utf8_trailingTb[256];
extern const UTF_32 __fb_utf8_offsetsTb[6];

/*:::::*/
char *fb_hUTF8ToChar( const UTF_8 *src, char *dst, int *chars )
{
	UTF_32 c;
	int extbytes;
	int charsleft;
	char *buffer = dst;
	
    if( dst == NULL )
    {
	    int dst_size = 0;
	    charsleft = 0;
	    do 
	    {
			extbytes = __fb_utf8_trailingTb[(unsigned int)*src];
	
			c = 0;
			switch( extbytes )
			{
				case 5:
					c += *src++; c <<= 6;
				case 4:
					c += *src++; c <<= 6;
				case 3:
					c += *src++; c <<= 6;
				case 2:
					c += *src++; c <<= 6;
				case 1:
					c += *src++; c <<= 6;
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
				case 4:
					c += *src++; c <<= 6;
				case 3:
					c += *src++; c <<= 6;
				case 2:
					c += *src++; c <<= 6;
				case 1:
					c += *src++; c <<= 6;
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

/*:::::*/
char *fb_hUTF16ToChar( const UTF_16 *src, char *dst, int *chars )
{
	UTF_16 c;
	int charsleft;
	char *buffer = dst;
	
    if( dst == NULL )
    {
	    int dst_size = 0;
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

/*:::::*/
char *fb_hUTF32ToChar( const UTF_32 *src, char *dst, int *chars )
{
	UTF_32 c;
	int charsleft;
	char *buffer = dst;
	
    if( dst == NULL )
    {
	    int dst_size = 0;
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

/*:::::*/
char *fb_UTFToChar( FB_FILE_ENCOD encod, const void *src, char *dst, int *chars )
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

