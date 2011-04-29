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
 * io_color.c -- color (console, no gfx) function for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_colors.h"

static int colorlut[16] = { FB_COLOR_BLACK, FB_COLOR_BLUE,
					 		FB_COLOR_GREEN, FB_COLOR_CYAN,
					 		FB_COLOR_RED, FB_COLOR_MAGENTA,
					 		FB_COLOR_BROWN, FB_COLOR_WHITE,
					 		FB_COLOR_GREY, FB_COLOR_LBLUE,
					 		FB_COLOR_LGREEN, FB_COLOR_LCYAN,
					 		FB_COLOR_LRED, FB_COLOR_LMAGENTA,
					 		FB_COLOR_YELLOW, FB_COLOR_BWHITE };

static int last_bc = FB_COLOR_BLACK,
		   last_fc = FB_COLOR_WHITE;

/*:::::*/
void fb_ConsoleColorEx( HANDLE hConsole, int fc, int bc )
{
    int last_attr = fb_ConsoleGetColorAttEx( hConsole );
    int last_bc = (last_attr >> 4) & 0xF, last_fc = (last_attr & 0xF);

    if( fc >= 0 ) {
        fc = colorlut[fc & 15];
    } else {
        fc = last_fc;
    }

    if( bc >= 0 ) {
        bc = colorlut[bc & 15];
    } else {
        bc = last_bc;
    }

    SetConsoleTextAttribute( hConsole, fc + (bc << 4) );
}

/*:::::*/
int fb_ConsoleColor( int fc, int bc, int flags )
{
    int cur = last_fc | (last_bc << 16);

    if( !( flags & FB_COLOR_FG_DEFAULT ) ) {
        last_fc = (fc & 0xF);
        fc = colorlut[last_fc];
    } else {
        fc = last_fc;
    }

    if( !( flags & FB_COLOR_BG_DEFAULT ) ) {
        last_bc = (bc & 0xF);
        bc = colorlut[last_bc];
    } else {
        bc = last_bc;
    }

    SetConsoleTextAttribute( __fb_out_handle, fc + (bc << 4) );

	return cur;
}

