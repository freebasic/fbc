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
 * thread_core.c -- Windows thread creation and destruction
 *
 * chng: feb/2005 written [lillo]
 *
 */

#include <process.h>
#include "fb.h"

/* thread proxy to user's thread proc */
#ifdef TARGET_WIN32
static void threadproc( void *param )
#else
static DWORD WINAPI threadproc( LPVOID param )
#endif
{
	FBTHREAD *thread = param;

	/* call the user thread */
	thread->proc( thread->param );

#ifdef TARGET_WIN32
    /* Never forget to close the threads handle ... otherwise we'll
     * have "zombie" threads in the system ... */
    CloseHandle( thread->id );
#endif

	/* free mem */
	fb_TlsFreeCtxTb( );

	free( thread );

#ifndef TARGET_WIN32
	return 1;
#endif
}

/*:::::*/
FBCALL FBTHREAD *fb_ThreadCreate( FB_THREADPROC proc, int param )
{
	FBTHREAD *thread;

	thread = (FBTHREAD *)malloc( sizeof(FBTHREAD) );
	if( !thread )
		return NULL;

    thread->proc	= proc;
    thread->param 	= param;

#ifdef TARGET_WIN32
    thread->id = (HANDLE)_beginthread( threadproc, 0, (void *)thread );
    if( thread->id == (void *)-1L )
    {
    	free( thread );
    	return NULL;
    }

#else
    {
        DWORD dwThreadId;
        thread->id = CreateThread( NULL,
                                   0,
                                   threadproc,
                                   (void*)thread,
                                   0,
                                   &dwThreadId );
    }

    if( thread->id == NULL )
    {
    	free( thread );
    	return NULL;
    }
#endif

	return thread;
}

/*:::::*/
FBCALL void fb_ThreadWait( FBTHREAD *thread )
{
	if( thread == NULL )
		return;

	/* race-condition can happen because the pointer could
	   be deallocated if user thread returned already */
	if( IsBadReadPtr( thread, sizeof(FBTHREAD) ) )
		return;

	WaitForSingleObject( thread->id, INFINITE );
}
