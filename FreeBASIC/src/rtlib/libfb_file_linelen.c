/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
 * file_linelen.c -- PRINT oddities
 *
 * chng: jun/2005 written [mjs]
 *
 */

#include "fb.h"

static FB_FILE fb_stdoutTB;

/*:::::*/
static void stdout_init( void )
{
    static int inited = 0;

    if( inited )
    	return;

    FB_LOCK();

    /* initialize handle for STDOUT */
    memset( &fb_stdoutTB, 0, sizeof(fb_stdoutTB) );
    fb_stdoutTB.f 		= stdout;
    fb_stdoutTB.mode 	= FB_FILE_MODE_OUTPUT;
    fb_stdoutTB.len 	= 128;
    fb_stdoutTB.type 	= FB_FILE_TYPE_CONSOLE;
    fb_stdoutTB.access 	= FB_FILE_ACCESS_WRITE;

    /* change line length to current cursor position - 1 to ensure that
     * the "," for a PRINT statement works correctly */
    fb_stdoutTB.line_length = fb_GetX() - 1;

    inited = 1;

    FB_UNLOCK();
}

/*:::::*/
FBCALL void fb_FileSetLineLen( int fnum, int len )
{
    if( fnum == 0 )
    {
    	stdout_init( );
	    fb_stdoutTB.line_length = len;
	}
	else
	{
        fb_fileTB[fnum-1].line_length = len;
	}
}

/*:::::*/
FBCALL int fb_FileGetLineLen( int fnum )
{
    if( fnum == 0 )
    {
    	stdout_init( );
    	return fb_stdoutTB.line_length;
    }
    else
    {
    	return fb_fileTB[fnum-1].line_length;
    }
}
