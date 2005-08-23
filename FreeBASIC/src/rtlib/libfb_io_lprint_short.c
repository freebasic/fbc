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
 * io_print_byte.c -- print [#] function (short)
 *
 * chng: oct/2004 written [v1ctor]
 *       nov/2004 fixed scrolling problem if printing at bottom/right w/o a newline [v1ctor]
 *
 */

#include <stdio.h>
#include "fb.h"


int LPrintInit(void);

/*:::::*/
FBCALL void fb_LPrintShort ( int fnum, short val, int mask )
{
    LPrintInit();
    mask = FB_PRINT_CONVERT_BIN_NEWLINE(mask);
    FB_PRINTNUM( fnum, val, mask, "% ", "hd" );
}

/*:::::*/
FBCALL void fb_LPrintUShort ( int fnum, unsigned short val, int mask )
{
    LPrintInit();
    mask = FB_PRINT_CONVERT_BIN_NEWLINE(mask);
    FB_PRINTNUM( fnum, val, mask, "%", "hu" );
}
