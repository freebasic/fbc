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
 * io_locate.c -- locate (console, no gfx) function for DOS
 *
 * chng: jan/2005 written [DrV]
 *       sep/2005 heavily rewritten to use BIOS instead [mjs]
 *
 */

#include "fb.h"
#include <go32.h>
#include <pc.h>
#include <dpmi.h>
#include <sys/farptr.h>

/*:::::*/
int fb_ConsoleLocate_BIOS( int row, int col, int cursor )
{
    __dpmi_regs regs;
    int x, y;
    int shape_start, shape_end, shape_visible;

    regs.x.ax = 0x0300;
    regs.x.bx = 0x0000;
    __dpmi_int(0x10, &regs);
    shape_start = regs.h.ch & 0x1F;
    shape_end   = regs.h.cl & 0x1F;
    shape_visible = (regs.h.ch & 0x60)==0;

    if( col >= 0 ) {
        x = col;
    } else {
        x = regs.h.dl;
    }

    if( row >= 0 ) {
        y = row;
    } else {
        y = regs.h.dh;
    }

    regs.x.ax = 0x0200;
    regs.x.bx = 0x0000;
    regs.h.dh = (unsigned char) y;
    regs.h.dl = (unsigned char) x;
    __dpmi_int(0x10, &regs);

    if( cursor >= 0) {
        shape_visible = cursor!=0;
        regs.x.ax = 0x0100;
        regs.h.ch = (unsigned char) (shape_start + (shape_visible ? 0x00 : 0x20));
        regs.h.cl = (unsigned char) shape_end;
        __dpmi_int(0x10, &regs);
    }

    return ( (x & 0xFF) | ((y & 0xFF) << 8) | (shape_visible ? 0x10000 : 0) );
}

/*:::::*/
int fb_ConsoleLocate( int row, int col, int cursor )
{
    int result = fb_ConsoleLocate_BIOS( row-1, col-1, cursor );
    ScrollWasOff = FALSE;
    return result + 0x0101;
}

/*:::::*/
int fb_ConsoleGetX( void )
{
    int x;
    fb_ConsoleGetXY( &x, NULL );
	return x;
}

/*:::::*/
int fb_ConsoleGetY( void )
{
    int y;
    fb_ConsoleGetXY( NULL, &y );
	return y;
}

/*:::::*/
void fb_ConsoleGetXY_BIOS( int *col, int *row )
{
    __dpmi_regs regs;
    regs.x.ax = 0x0300;
    regs.x.bx = 0x0000;
    __dpmi_int(0x10, &regs);
    if( col!=NULL )
        *col = regs.h.dl;
    if( row!=NULL )
        *row = regs.h.dh;
}

/*:::::*/
FBCALL void fb_ConsoleGetXY( int *col, int *row )
{
    fb_ConsoleGetXY_BIOS( col, row );
    if( col )
        ++*col;
    if( row )
        ++*row;
}

/*:::::*/
int fb_ConsoleReadXY_BIOS( int col, int row, int colorflag )
{
    unsigned short usPosOld;
    unsigned short usPos = (unsigned short) ((row << 8) + col);
    __dpmi_regs regs;

    _movedataw( _dos_ds, 0x450, _my_ds(), (int) &usPosOld, 1 );
    _movedataw( _my_ds(), (int) &usPos, _dos_ds, 0x450, 1 );
    regs.x.ax = 0x0800;
    regs.x.bx = 0x0000;
    __dpmi_int(0x10, &regs);
    _movedataw( _my_ds(), (int) &usPosOld, _dos_ds, 0x450, 1 );

    if( colorflag )
        return regs.h.ah;
    return regs.h.al;
}

/*:::::*/
FBCALL int fb_ConsoleReadXY( int col, int row, int colorflag )
{
    return fb_ConsoleReadXY_BIOS( col - 1, row - 1, colorflag );
}
