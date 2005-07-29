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
 * fb_win32.h -- common Win32 definitions.
 *
 * chng: jun/2005 written [lillo]
 *
 */

#ifndef __FB_WIN32_H__
#define __FB_WIN32_H__

#if defined(NOSTDCALL)
# define FBCALL __cdecl
#else
# define FBCALL __stdcall
#endif

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <io.h>

typedef struct _FB_DIRCTX
{
	int in_use;
	int attrib;
	struct _finddata_t data;
	long handle;
} FB_DIRCTX;

#ifdef MULTITHREADED
extern CRITICAL_SECTION fb_global_mutex;
extern CRITICAL_SECTION fb_string_mutex;
# define FB_LOCK()					EnterCriticalSection(&fb_global_mutex)
# define FB_UNLOCK()				LeaveCriticalSection(&fb_global_mutex)
# define FB_STRLOCK()				EnterCriticalSection(&fb_string_mutex)
# define FB_STRUNLOCK()				LeaveCriticalSection(&fb_string_mutex)
# define FB_TLSENTRY				DWORD
# define FB_TLSSET(key,value)		TlsSetValue((key), (LPVOID)(value))
# define FB_TLSGET(key)				TlsGetValue((key))
#endif

extern HANDLE fb_in_handle, fb_out_handle;
extern const unsigned char fb_keytable[][3];


#endif
