/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2007 The FreeBASIC development team.
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
 * io_scroll.c -- console scrolling for when VIEW is used for DOS
 *
 * chng: jan/2005 written [DrV]
 *       sep/2005 heavily enhanced to do *real* scrolling [mjs]
 *
 */

#include "fb.h"
#include <dpmi.h>

/*:::::*/
void fb_ConsoleScroll_BIOS( int x1, int y1, int x2, int y2, int nrows )
{
    __dpmi_regs regs;
	
    regs.h.bl = 0;
    regs.h.bh = (unsigned char) fb_ConsoleGetColorAtt();
    regs.h.cl = (unsigned char) x1;
    regs.h.ch = (unsigned char) y1;
    regs.h.dl = (unsigned char) x2;
    regs.h.dh = (unsigned char) y2;

    if( nrows >= 0 ) {
        regs.x.ax = (unsigned short) (0x0600 + nrows);
    } else {
        regs.x.ax = (unsigned short) (0x0700 + -nrows);
    }
    __dpmi_int(0x10, &regs);
}

void fb_ConsoleScrollEx( int x1, int y1, int x2, int y2, int nrows )
{
    int rows;

	if( nrows == 0 )
        return;

	fb_ConsoleGetSize( NULL, &rows );

    if( nrows <= -rows || nrows >= rows )
        nrows = 0;
	
    fb_ConsoleScroll_BIOS( x1-1, y1-1, x2-1, y2-1, nrows );

#if 0
    if( nrows > 0 ) {
        fb_ConsoleLocate_BIOS( y2 - 1 - nrows, x1, -1 );
    } else if( nrows < 0 ) {
        fb_ConsoleLocate_BIOS( y1 - 1 - nrows, x1, -1 );
    } else {
        fb_ConsoleLocate_BIOS( y1 - 1, x1 - 1, -1 );
    }
#endif
}

void fb_ConsoleScroll( int nrows )
{
	int toprow, botrow;
    int cols;

	if( nrows == 0 )
        return;

	fb_ConsoleGetSize( &cols, NULL );
    fb_ConsoleGetView( &toprow, &botrow );

    return fb_ConsoleScrollEx( 1, toprow, cols, botrow, nrows );
}
