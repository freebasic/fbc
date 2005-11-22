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
 * io_printbuff_wstr.c -- low-level print to console function for wstrings
 *
 * chng: nov/2005 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_con.h"

/*:::::*/
void fb_ConsolePrintBufferWstrEx( const FB_WCHAR *buffer, size_t len, int mask )
{
    /* !!!FIXME!!! no support for unicode output */

    char *temp = alloca( len + 1 );

    if( len > 0 )
    	fb_wstr_ConvToA( temp, buffer, len );
    else
    	*temp = '\0';

    fb_ConsolePrintBufferEx( temp, len, mask );
}

/*:::::*/
void fb_ConsolePrintBufferWstr( const FB_WCHAR *buffer, int mask )
{
	fb_ConsolePrintBufferWstrEx( buffer, fb_wstr_Len( buffer ), mask );
}
