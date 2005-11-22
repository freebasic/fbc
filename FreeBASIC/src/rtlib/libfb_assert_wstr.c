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
 * assert.c -- assertion functions
 *
 * chng: jul/2005 written [v1ctor]
 *
 */

#include "fb.h"
#include <stdlib.h>
#include <stdio.h>

FBCALL void fb_PrintWstr ( int fnum, const FB_WCHAR *s, int mask );

/*:::::*/
static void printmsg( char *filename, int linenum, char *funcname, FB_WCHAR *expression )
{
	FB_WCHAR buffer[1024];

	swprintf( buffer, _LC("%S(%d): assertion failed at %S: %s"),
			  filename, linenum, funcname, expression );

	fb_PrintWstr( 0, buffer, FB_PRINT_NEWLINE );
}

/*:::::*/
FBCALL void fb_AssertW( char *filename, int linenum, char *funcname, FB_WCHAR *expression )
{
	printmsg( filename, linenum, funcname, expression );

	fb_End( 1 );
}

/*:::::*/
FBCALL void fb_AssertWarnW( char *filename, int linenum, char *funcname, FB_WCHAR *expression )
{
	printmsg( filename, linenum, funcname, expression );
}
