/*
 *  libgfx2 - FreeBASIC's alternative gfx library
 *	Copyright (C) 2005 Angelo Mottola (a.mottola@libero.it)
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
 * print_wstr.c -- graphical mode wstring text output
 *
 * chng: nov/2005 written [v1ctor]
 *
 */

#include "fb_gfx.h"
#include "../rtlib/fb_con.h"
#include <stdlib.h>

/*:::::*/
void fb_GfxPrintBufferWstrEx(const FB_WCHAR *buffer, size_t len, int mask)
{
	/* Unicode gfx font support is out of the scope of gfxlib, convert to ascii */
	
	char temp[len + 1];

	if( len > 0 )
		fb_wstr_ConvToA( temp, buffer, len );
	else
		*temp = '\0';

	fb_GfxPrintBufferEx( temp, len, mask );
}

/*:::::*/
void fb_GfxPrintBufferWstr(const FB_WCHAR *buffer, int mask)
{
	fb_GfxPrintBufferWstrEx( buffer, fb_wstr_Len(buffer), mask);
}

