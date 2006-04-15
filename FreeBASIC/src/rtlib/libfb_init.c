/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2006 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and
 *  the FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * init.c -- libfb initialization
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/* globals */
int fb_argc = 0;
char **fb_argv = NULL;

FB_HOOKSTB fb_hooks = { NULL };
FB_FILE fb_fileTB[FB_MAX_FILES];
int __fb_file_handles_cleared = FALSE;
#ifdef MULTITHREADED
int __fb_io_is_exiting = FALSE;
#endif

FBSTRING fb_strNullDesc = { NULL, 0 };

FnDevOpenHook fb_pfnDevOpenHook = NULL;

/*:::::*/
FBCALL void fb_RtInit ( void )
{
#ifdef MULTITHREADED
	int i;
#endif

	static int inited = FALSE;

	/* already initialized? */
	if( inited )
		return;

	inited = TRUE;

	/* initialize files table */
    memset( fb_fileTB, 0, sizeof( fb_fileTB ) );
    __fb_file_handles_cleared = TRUE;

	/* os-dep initialization */
    fb_hInit( );

#ifdef MULTITHREADED
	/* allocate thread local storage keys */
	for( i = 0; i < FB_TLSKEYS; i++ )
		FB_TLSALLOC( fb_tls_ctxtb[i] );
#endif

	/* add rtlib's exit() to queue */
	atexit( &fb_RtExit );
}

/*:::::*/
FBCALL void fb_Init ( int argc, char **argv )
{
	fb_argc = argc;
	fb_argv = argv;

	fb_RtInit( );
}

