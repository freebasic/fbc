/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 * thread_core.c -- Linux (pthreads) thread creation and destruction
 *
 * chng: feb/2005 written [lillo]
 *
 */


#include <pthread.h>
#include "fb.h"


/* thread proxy to user's thread proc */
static void *threadproc( void *param )
{
	FBTHREAD *thread = param;

	/* call the user thread */
	thread->proc( thread->param );

	/* free mem */
	fb_TlsFreeCtxTb( );

	/* don't return NULL or exit() will be called */
	return (void *)1;
}

/*:::::*/
FBCALL FBTHREAD *fb_ThreadCreate( FB_THREADPROC proc, void *param, int stack_size )
{
	FBTHREAD *thread;
	pthread_attr_t tattr;

	thread = (FBTHREAD *)malloc( sizeof(FBTHREAD) );
	if( !thread )
		return NULL;

	thread->proc	= proc;
	thread->param 	= param;

	if( pthread_attr_init( &tattr ) ) {
		free( thread );
		return NULL;
	}

	/* Solaris pthread.h does not define PTHREAD_STACK_MIN */
#ifdef PTHREAD_STACK_MIN
	stack_size = stack_size >= PTHREAD_STACK_MIN ? stack_size : PTHREAD_STACK_MIN;
#endif
	
	pthread_attr_setstacksize( &tattr, stack_size );

	if( pthread_create( &thread->id, &tattr, threadproc, (void *)thread ) ) {
		free( (void *)thread );
		return NULL;
	}

	return thread;
}

/*:::::*/
FBCALL void fb_ThreadWait( FBTHREAD *thread )
{
	if( thread == NULL )
		return;

	pthread_join( thread->id, NULL );

	free( thread );
}
