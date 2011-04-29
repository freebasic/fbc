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

#ifndef __FB_UNICODE_W32__
#define __FB_UNICODE_W32__

#include <wchar.h>
#include <wctype.h>

#define swprintf _snwprintf

#define FB_WSTR_FROM_INT( buffer, num ) \
    _itow( num, buffer, 10 )

#define FB_WSTR_FROM_UINT( buffer, num ) \
    _ultow( (unsigned long) num, buffer, 10 )

#define FB_WSTR_FROM_UINT_OCT( buffer, num ) \
    _itow( num, buffer, 8 )

#define FB_WSTR_FROM_INT64( buffer, num ) \
    _i64tow( num, buffer, 10 )

#define FB_WSTR_FROM_UINT64( buffer, num ) \
    _ui64tow( num, buffer, 10 )

#define FB_WSTR_FROM_UINT64_OCT( buffer, num ) \
    _ui64tow( num, buffer, 8 )

/*:::::*/
static __inline__ void fb_wstr_WcharToChar( char *dst, const FB_WCHAR *src, int chars )
{
	UTF_16 c;

	while( chars-- )
	{
		c = *src++;

		if( c > 255 )
		{
			if( c >= UTF16_SUR_HIGH_START && c <= UTF16_SUR_HIGH_END )
    			++src;
    		c = '?';
    	}

		*dst++ = c;
	}
}

#define FB_WSTR_WCHARTOCHAR fb_wstr_WcharToChar

#endif /* __FB_UNICODE_W32__ */
