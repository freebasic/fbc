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
 * init.c -- libfb initialization for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"
#include <float.h>

#ifdef MULTITHREADED
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
CRITICAL_SECTION fb_global_mutex;

#endif

FB_ERRORCTX fb_errctx = { 0 };
FB_INPCTX fb_inpctx = { 0 };


/*:::::*/
void fb_hInit ( void )
{

    /* set FPU precision to 64-bit and round to nearest (as in QB) */
	_controlfp( _PC_64|_RC_NEAR, _MCW_PC|_MCW_RC );

#ifdef MULTITHREADED
	InitializeCriticalSection(&fb_global_mutex);
	
	/* allocate thread local storage vars for runtime error handling */
	fb_errctx.handler   = TlsAlloc();
	fb_errctx.num       = TlsAlloc();
	fb_errctx.reslbl    = TlsAlloc();
	fb_errctx.resnxtlbl = TlsAlloc();
	
	/* allocate thread local storage vars for input context */
	fb_inpctx.f         = TlsAlloc();
	fb_inpctx.i         = TlsAlloc();
	fb_inpctx.s.data    = TlsAlloc();
	fb_inpctx.s.len     = TlsAlloc();
	fb_inpctx.s.size    = TlsAlloc();
#endif

}
