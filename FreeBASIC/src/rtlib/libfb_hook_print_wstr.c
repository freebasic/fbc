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
 * hook_print_wstr.c -- print wstring entrypoint, default to console mode
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL void fb_PrintBufferWstrEx( const FB_WCHAR *buffer, size_t len, int mask )
{
	FB_LOCK();

    if( fb_hooks.printbuffwproc )
        fb_hooks.printbuffwproc( buffer, len, mask );
    else
        fb_ConsolePrintBufferWstrEx( buffer, len, mask );

	FB_UNLOCK();

}

/*:::::*/
FBCALL void fb_PrintBufferWstr( const FB_WCHAR *buffer, int mask )
{

    return fb_PrintBufferWstrEx( buffer, fb_wstr_Len( buffer ), mask );

}
