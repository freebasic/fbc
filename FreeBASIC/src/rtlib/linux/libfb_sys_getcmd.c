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
 * sys_getcmd.c -- get command line for Linux
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"

#ifdef __CYGWIN__
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#else
#include <unistd.h>

/* global */
char fb_commandline[1024];
#endif


/*:::::*/
char *fb_hGetCommandLine( void )
{

#ifdef __CYGWIN__
	return GetCommandLine( );
#else
    return fb_commandline;
#endif

}
