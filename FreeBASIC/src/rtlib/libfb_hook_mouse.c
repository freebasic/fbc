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
 * hook_mouse.c -- mouse entrypoints, default to console mode
 *
 * chng: jun/2005 written [lillo]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL int fb_GetMouse( int *x, int *y, int *z, int *buttons )
{
	int res;
	
	FB_LOCK();
	
	if( fb_hooks.getmouseproc )
		res = fb_hooks.getmouseproc( x, y, z, buttons );
	else
		res = fb_ConsoleGetMouse( x, y, z, buttons );

	FB_UNLOCK();
	
	return res;
}


/*:::::*/
FBCALL int fb_SetMouse( int x, int y, int cursor )
{
	int res;
	
	FB_LOCK();
	
	if( fb_hooks.getmouseproc )
		res = fb_hooks.setmouseproc( x, y, cursor );
	else
		res = fb_ConsoleSetMouse( x, y, cursor );

	FB_UNLOCK();
	
	return res;
}
