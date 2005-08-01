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
 * init.c -- libfb initialization for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include <stdlib.h>
#include <float.h>
#include "fb.h"
#include "fb_rterr.h"

#ifdef MULTITHREADED
CRITICAL_SECTION fb_global_mutex;
CRITICAL_SECTION fb_string_mutex;
#endif

HANDLE fb_in_handle, fb_out_handle;

SMALL_RECT srConsoleWindow;

void __main(void);

/** Remembers the current console window coordinates.
 *
 * This function remembers the current console window coordinates. This is
 * required because some applications showing using a SAA interface doesn't
 * use WIDTH first to reduce the console screen buffer size which means that
 * the scroll bar of the console window is always visible/accessible which
 * also implies that the user might scroll up and down while the application
 * is running.
 *
 * When this library would always use the current console window coordinates,
 * the application might show trash when the user scrolled up or down the
 * buffer. But this is not what we want so we're only updating the console
 * window coordinates under the following conditions:
 *
 * - Initialization
 * - After screen buffer size change (using WIDTH)
 * - After printing text
 */
FBCALL void fb_hUpdateConsoleWindow( void )
{
    CONSOLE_SCREEN_BUFFER_INFO info;
    if( GetConsoleScreenBufferInfo( fb_out_handle, &info )==0 ) {
        memset( &srConsoleWindow, 0, sizeof(SMALL_RECT) );
    } else {
#if 0
        memcpy( &srConsoleWindow, &info.srWindow, sizeof(SMALL_RECT) );
#else
        srConsoleWindow.Left = 0;
        srConsoleWindow.Top = info.srWindow.Top;
        srConsoleWindow.Right = info.dwSize.X - 1;
        srConsoleWindow.Bottom = info.srWindow.Bottom;
#endif
    }
}

FBCALL void fb_hRestoreConsoleWindow( void )
{
    SetConsoleWindowInfo( fb_out_handle, TRUE, &srConsoleWindow );
}

/*:::::*/
void fb_hInit ( int argc, char **argv )
{

    /* set FPU precision to 64-bit and round to nearest (as in QB) */
	_controlfp( _PC_64|_RC_NEAR, _MCW_PC|_MCW_RC );

	fb_in_handle = GetStdHandle( STD_INPUT_HANDLE );
	fb_out_handle = GetStdHandle( STD_OUTPUT_HANDLE );

#ifdef MULTITHREADED
	InitializeCriticalSection(&fb_global_mutex);
	InitializeCriticalSection(&fb_string_mutex);

	/* allocate thread local storage vars for runtime error handling */
	fb_errctx.handler   = TlsAlloc();
	fb_errctx.num       = TlsAlloc();
	fb_errctx.linenum   = TlsAlloc();
	fb_errctx.reslbl    = TlsAlloc();
	fb_errctx.resnxtlbl = TlsAlloc();

	/* allocate thread local storage vars for input context */
	fb_inpctx.handle    = TlsAlloc();
	fb_inpctx.i         = TlsAlloc();
	fb_inpctx.s.data    = TlsAlloc();
	fb_inpctx.s.len     = TlsAlloc();
	fb_inpctx.s.size    = TlsAlloc();

	/* allocate thread local storage vars for print using context */
	fb_printusgctx.chars       = TlsAlloc();
	fb_printusgctx.ptr         = TlsAlloc();
	fb_printusgctx.fmtstr.data = TlsAlloc();
	fb_printusgctx.fmtstr.len  = TlsAlloc();
	fb_printusgctx.fmtstr.size = TlsAlloc();

	/* allocate thread local storage var for dir context */
	fb_dirctx           = TlsAlloc();
#endif

    /* call default CRT0 constructors (only required for Win32) */
    __main();

    /* query the console window position/size only when needed */
    fb_hUpdateConsoleWindow( );
}
