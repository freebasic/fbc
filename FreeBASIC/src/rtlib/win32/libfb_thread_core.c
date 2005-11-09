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
static unsigned int WINAPI threadproc( void *param )
#else
static DWORD WINAPI threadproc( LPVOID param )
#endif
{
	FBTHREAD *thread = param;

	/* call the user thread */
	thread->proc( thread->param );

	/* free mem */
	fb_TlsFreeCtxTb( );

	return 1;
}

/*:::::*/
FBCALL FBTHREAD *fb_ThreadCreate( FB_THREADPROC proc, int param )
{
	FBTHREAD *thread;
#ifdef TARGET_WIN32
	unsigned int dwThreadId;
#else
    DWORD dwThreadId;
#endif

	thread = (FBTHREAD *)malloc( sizeof(FBTHREAD) );
	if( thread == NULL )
		return NULL;

    thread->proc	= proc;
    thread->param 	= param;

#ifdef TARGET_WIN32
    thread->id = (HANDLE)_beginthreadex( NULL, 
    									 0, 
    									 threadproc, 
    									 (void *)thread, 
    									 0, 
    									 &dwThreadId );
#else
    {
        thread->id = CreateThread( NULL,
                                   0,
                                   threadproc,
                                   (void*)thread,
                                   0,
                                   &dwThreadId );
    }
#endif

    if( thread->id == NULL )
    {
    	free( thread );
    	return NULL;
    }

	return thread;
}

/*:::::*/
FBCALL void fb_ThreadWait( FBTHREAD *thread )
{
	if( thread == NULL )
		return;

	WaitForSingleObject( thread->id, INFINITE );

    /* Never forget to close the threads handle ... otherwise we'll
     * have "zombie" threads in the system ... */
    CloseHandle( thread->id );

	free( thread );
}
