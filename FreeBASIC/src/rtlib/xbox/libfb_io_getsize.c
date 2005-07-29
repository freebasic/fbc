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
 * io_getsize.c -- get size (console, no gfx) function for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#ifndef fbhandlesdefined
#include "fb_xbox.h"
HANDLE fb_in_handle, fb_out_handle;
#define fbhandlesdefined
#endif

#include "../fb.h"
#include <stdio.h>



/*:::::*/
FBCALL void fb_ConsoleGetSize( int *cols, int *rows )
{
	//Console routines? For what? The herc mono video card I put in my x-box?
}
