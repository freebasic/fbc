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
 * hook_inkey.c -- inkey$ entrypoint, default to console mode
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

static FB_INKEYPROC fb_inkeyhook = &fb_ConsoleInkey;

static FB_GETKEYPROC fb_getkeyhook = &fb_ConsoleGetkey;

static FB_KEYHITPROC fb_keyhithook = &fb_ConsoleKeyHit;


/*:::::*/
FBCALL FBSTRING *fb_Inkey( void )
{

	return fb_inkeyhook( );

}

/*:::::*/
FBCALL FB_INKEYPROC fb_SetInkeyProc( FB_INKEYPROC newproc )
{
    FB_INKEYPROC oldproc = fb_inkeyhook;

    fb_inkeyhook = newproc;

	return oldproc;
}

/*:::::*/
FBCALL int fb_Getkey( void )
{

	return fb_getkeyhook( );

}

/*:::::*/
FBCALL FB_GETKEYPROC fb_SetGetkeyProc( FB_GETKEYPROC newproc )
{
    FB_GETKEYPROC oldproc = fb_getkeyhook;

    fb_getkeyhook = newproc;

	return oldproc;
}

/*:::::*/
FBCALL int fb_KeyHit( void )
{

	return fb_keyhithook( );

}

/*:::::*/
FBCALL FB_KEYHITPROC fb_SetKeyHitProc( FB_KEYHITPROC newproc )
{
    FB_KEYHITPROC oldproc = fb_keyhithook;

    fb_keyhithook = newproc;

	return oldproc;
}

