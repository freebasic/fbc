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
 * hook_getxy.c -- getx|y entrypoint, default to console mode
 *
 * chng: dec/2004 written [v1ctor]
 *
 */

#include "fb.h"

static FB_GETXPROC fb_getxhook = &fb_ConsoleGetX;
static FB_GETYPROC fb_getyhook = &fb_ConsoleGetY;


/*:::::*/
FBCALL int fb_GetX( void )
{
	int res;

	FB_LOCK();

	res = fb_getxhook( );
	
	FB_UNLOCK();
	
	return res;
}

/*:::::*/
FBCALL FB_GETXPROC fb_SetGetXProc( FB_GETXPROC newproc )
{
    FB_GETXPROC oldproc = fb_getxhook;

    fb_getxhook = newproc;

	return oldproc;
}

/*:::::*/
FBCALL int fb_GetY( void )
{
	int res;
	
	FB_LOCK();
	
	res = fb_getyhook( );
	
	FB_UNLOCK();
	
	return res;
}

/*:::::*/
FBCALL FB_GETYPROC fb_SetGetYProc( FB_GETYPROC newproc )
{
    FB_GETYPROC oldproc = fb_getyhook;

    fb_getyhook = newproc;
	
	return oldproc;
}
