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
 * thread_cond.c -- Linux (pthreads) condition variables handling routines
 *
 * chng: feb/2005 written [lillo]
 *
 */


#include <pthread.h>
#include "fb.h"

typedef struct _FBCOND
{
	pthread_cond_t id;
	pthread_mutex_t lock;
} FBCOND;


/*:::::*/
FBCALL FBCOND *fb_CondCreate( void )
{
	FBCOND *cond;

	cond = (FBCOND *)malloc( sizeof( FBCOND ) );
	if( !cond )
		return NULL;

	pthread_mutex_init( &cond->lock, NULL );
	pthread_cond_init( &cond->id, NULL );

	return cond;
}

/*:::::*/
FBCALL void fb_CondDestroy( FBCOND *cond )
{
	if( cond == NULL )
		return;

	pthread_cond_destroy( &cond->id );
	pthread_mutex_destroy( &cond->lock );

	free( (void *)cond );
}

/*:::::*/
FBCALL void fb_CondSignal( FBCOND *cond )
{
	if( cond == NULL )
		return;

	pthread_mutex_lock( &cond->lock );
	pthread_cond_signal( &cond->id );
	pthread_mutex_unlock( &cond->lock );
}

/*:::::*/
FBCALL void fb_CondBroadcast( FBCOND *cond )
{
	if( cond == NULL )
		return;

	pthread_mutex_lock( &cond->lock );
	pthread_cond_broadcast( &cond->id );
	pthread_mutex_unlock( &cond->lock );
}

/*:::::*/
FBCALL void fb_CondWait( FBCOND *cond )
{
	if( cond == NULL )
		return;

	pthread_mutex_lock( &cond->lock );
	pthread_cond_wait( &cond->id, &cond->lock );
	pthread_mutex_unlock( &cond->lock );
}
