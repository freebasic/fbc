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

void __main(void);


/*:::::*/
void fb_hInit ( int argc, char **argv )
{
#ifdef TARGET_WIN32
    /* set FPU precision to 64-bit and round to nearest (as in QB) */
    _controlfp( _PC_64|_RC_NEAR, _MCW_PC|_MCW_RC );
#elif defined(__GNUC__) && defined(__i386__)
    {
        unsigned int control_word;
        /* Get FPU control word */
        __asm__ __volatile__( "fstcw %0" : "=m" (control_word) : );
        /* Set 64-bit and round to nearest */
        control_word = (control_word & 0xF0FF) | 0x300;
        /* Write back FPU control word */
        __asm__ __volatile__( "fldcw %0" : : "m" (control_word) );
    }
#endif


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

}
