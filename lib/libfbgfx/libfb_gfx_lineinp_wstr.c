/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
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
 */

/*
 * lineinp_wstr - console line input function for wstrings
 *
 * chng: nov/2005 written [v1ctor]
 *
 */

#include "fb_gfx.h"

/*:::::*/
int fb_GfxLineInputWstr( const FB_WCHAR *text, FB_WCHAR *dst, int max_chars,
						 int addquestion, int addnewline )
{
    FBSTRING *tmp_result;

    /* !!!FIXME!!! no support for unicode input */

    FB_LOCK();

    fb_PrintBufferEx( NULL, 0, FB_PRINT_FORCE_ADJUST );

    if( text != NULL )
    {
        fb_PrintWstr( 0, text, 0 );

        if( addquestion != FB_FALSE )
            fb_PrintFixString( 0, "? ", 0 );
    }

    FB_UNLOCK();

    tmp_result = fb_ConReadLine( TRUE );

    if( addnewline )
				fb_PrintVoid( 0, FB_PRINT_NEWLINE );

    if( tmp_result == NULL )
    	return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );

	fb_WstrAssignFromA( dst, max_chars, tmp_result, -1 );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}


