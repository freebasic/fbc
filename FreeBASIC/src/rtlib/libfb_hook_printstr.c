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
 * hook_printstr.c -- print string entrypoint, default to console mode
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

static FB_PRINTBUFFPROC fb_printbuffhook = &fb_ConsolePrintBuffer;


/*:::::*/
FBCALL void fb_PrintBuffer( char *buffer, int mask )
{

	return fb_printbuffhook( buffer, mask );

}

/*:::::*/
FBCALL FB_PRINTBUFFPROC fb_SetPrintBufferProc( FB_PRINTBUFFPROC newproc )
{
    FB_PRINTBUFFPROC oldproc = fb_printbuffhook;

    fb_printbuffhook = newproc;

	return oldproc;
}
