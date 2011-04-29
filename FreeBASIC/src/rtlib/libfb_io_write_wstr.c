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

/*
 * io_write_wstr.c -- write [#] wstring functions
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_WriteWstr ( int fnum, FB_WCHAR *s, int mask )
{
    const FB_WCHAR *buff;
    int len, bufflen;
    FB_FILE *handle = FB_FILE_TO_HANDLE( fnum );

	if( s == NULL )
	{
		if( mask & FB_PRINT_BIN_NEWLINE )
			fb_hFilePrintBufferWstrEx( handle, _LC("\"\"" FB_BINARY_NEWLINE), 1+1+sizeof(FB_BINARY_NEWLINE)-1 );
		else if( mask & FB_PRINT_NEWLINE )
			fb_hFilePrintBufferWstrEx( handle, _LC("\"\"" FB_NEWLINE), 1+1+sizeof(FB_NEWLINE)-1 );
		else
			fb_hFilePrintBufferWstrEx( handle, _LC("\"\","), 1+1+1 );
		return;
	}

    /* close quote + new-line or comma */
    if( mask & FB_PRINT_BIN_NEWLINE )
    {
		buff = _LC("\"" FB_BINARY_NEWLINE);
		bufflen = fb_wstr_Len( _LC("\"" FB_BINARY_NEWLINE) );
	}
    else if( mask & FB_PRINT_NEWLINE )
    {
		buff = _LC("\"" FB_NEWLINE);
		bufflen = fb_wstr_Len( _LC("\"" FB_NEWLINE) );
	}
    else
    {
		buff = _LC("\",");
		bufflen = 2;
	}

    FB_LOCK( );

    /* open quote */
    fb_hFilePrintBufferWstrEx( handle, _LC("\""), 1 );

    len = fb_wstr_Len( s );
    if( len != 0 )
        FB_PRINTWSTR_EX( handle, s, len, 0 );

    fb_hFilePrintBufferWstrEx( handle, buff, bufflen );

    FB_UNLOCK( );
}
