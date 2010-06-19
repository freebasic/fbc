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
 * io_printbuff_wstr.c -- low-level print to console function for wstrings
 *
 * chng: nov/2005 written [v1ctor]
 *
 */

#include "fb.h"

#define ENTER_UTF8  "\e%G"
#define EXIT_UTF8   "\e%@"

/*:::::*/
void fb_ConsolePrintBufferWstrEx( const FB_WCHAR *buffer, size_t chars, int mask )
{
	size_t avail, avail_len;
	char *temp;

	if( !__fb_con.inited )
	{
		/* !!!FIXME!!! is this ok or should it be converted to UTF-8 too? */
		fwrite( buffer, sizeof( FB_WCHAR ), chars, stdout );
		fflush( stdout );
		return;
	}

	temp = alloca( chars * 4 + 1 );

	/* ToDo: handle scrolling for internal characters/attributes buffer? */
	avail = (__fb_con.w * __fb_con.h) - (((__fb_con.cur_y - 1) * __fb_con.w) + __fb_con.cur_x - 1);
	avail_len = chars;
	if (avail < avail_len)
		avail_len = avail;

	/* !!!FIXME!!! to support unicode the char_buffer would have to be a wchar_t,
				   slowing down non-unicode printing.. */
	fb_wstr_ConvToA( temp, buffer, avail_len );

	memcpy( __fb_con.char_buffer + ((__fb_con.cur_y - 1) * __fb_con.w) + __fb_con.cur_x - 1,
	        temp,
	        avail_len );

	memset( __fb_con.attr_buffer + ((__fb_con.cur_y - 1) * __fb_con.w) + __fb_con.cur_x - 1,
	        __fb_con.fg_color | (__fb_con.bg_color << 4),
	        avail_len );

	/* convert wchar_t to UTF-8 */
	int bytes;

	fb_WCharToUTF( FB_FILE_ENCOD_UTF8, buffer, chars, temp, &bytes );
	/* add null-term */
	temp[bytes] = '\0';

	fputs( ENTER_UTF8, __fb_con.f_out );

	fputs( temp, __fb_con.f_out );

	fputs( EXIT_UTF8, __fb_con.f_out );

	/* update x and y coordinates.. */
	for( ; chars; chars--, buffer++ )
	{
		++__fb_con.cur_x;
		if( (*buffer == _LC('\n')) || (__fb_con.cur_x >= __fb_con.w) )
		{
			__fb_con.cur_x = 1;
			++__fb_con.cur_y;
			if( __fb_con.cur_y > __fb_con.h )
				__fb_con.cur_y = __fb_con.h;
		}
	}

	fflush( __fb_con.f_out );
}

/*:::::*/
void fb_ConsolePrintBufferWstr( const FB_WCHAR *buffer, int mask )
{
	return fb_ConsolePrintBufferWstrEx( buffer, fb_wstr_Len( buffer ), mask );
}
