/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
FBCALL FBTHREAD *fb_ThreadCreate( FB_THREADPROC proc, void *param, int stack_size )
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
    									 stack_size, 
    									 threadproc, 
    									 (void *)thread, 
    									 0, 
    									 &dwThreadId );
#else
    {
        thread->id = CreateThread( NULL,
                                   stack_size,
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
