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
 * sys_run.c -- run function for Windows
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <process.h>
#include "fb.h"

#ifdef TARGET_CYGWIN
#define _execl execl
#endif

/*:::::*/
FBCALL int fb_Run ( FBSTRING *program )
{
	if( (program != NULL) && (program->data != NULL) )
	{
        if( fb_hExec ( program, NULL, FALSE )!=-1 ) {
            fb_End( 0 );
        }
    } else {
        return 0;
    }
    return -1;
}
