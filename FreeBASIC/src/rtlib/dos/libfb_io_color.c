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
 * io_color.c -- color (console, no gfx) function for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include "fb.h"
#include "fb_colors.h"
#include <pc.h>

/* globals */
int fb_last_bc = FB_COLOR_BLACK,
	fb_last_fc = FB_COLOR_WHITE;

/*:::::*/
void fb_ConsoleColor( int fc, int bc )
{
	if( fc >= 0 )
		fb_last_fc = fc & 15;

	if( bc >= 0 )
		fb_last_bc = bc & 15;

	ScreenAttrib = fb_last_fc | (fb_last_bc << 4);

}

/*:::::*/
int fb_ConsoleGetColorAtt( void )
{
	return ScreenAttrib;

}
