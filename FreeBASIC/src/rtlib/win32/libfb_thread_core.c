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
 * thread_core.c -- Windows thread creation and destruction
 *
 * chng: feb/2005 written [lillo]
 *
 */

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <process.h>
#include "fb.h"


typedef struct _FBTHREAD
{
	FB_LISTELEM elem;
	HANDLE id;
} FBTHREAD;

static FBTHREAD thdTB[FB_MAXTHREADS];
static FB_LIST thdList = { 0 };

typedef void( __cdecl *ThreadStartFn )( void * );


/*:::::*/
FBCALL FBTHREAD *fb_ThreadCreate( void *proc, int param )
{
	FBTHREAD *thread;

	if( (thdList.fhead == NULL) && (thdList.head == NULL) )
		fb_hListInit( &thdList, (void *)thdTB, sizeof(FBTHREAD), FB_MAXTHREADS );

	thread = (FBTHREAD *)fb_hListAllocElem( &thdList );
	if( !thread )
		return NULL;

	thread->id = (HANDLE)_beginthread( (ThreadStartFn) proc, 0, (void *)param );

	return thread;
}

/*:::::*/
FBCALL void fb_ThreadWait( FBTHREAD *thread )
{
	/* dumb address checking */
	if( (thread < thdTB) || (thread >= &thdTB[FB_MAXTHREADS]) )
		return;

	WaitForSingleObject( thread->id, INFINITE );
	fb_hListFreeElem( &thdList, (FB_LISTELEM *)thread );
}
