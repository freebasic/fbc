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
 * thread_cond.c -- Linux (pthreads) condition variables handling routines
 *
 * chng: feb/2005 written [lillo]
 *
 */


#include <pthread.h>
#include "fb.h"

typedef struct _FBCOND
{
	FB_LISTELEM elem;
	pthread_cond_t id;
	pthread_mutex_t lock;
} FBCOND;

static FBCOND condTB[FB_MAXCONDS];
static FB_LIST condList = { 0 };


/*:::::*/
FBCALL FBCOND *fb_CondCreate( void )
{
	FBCOND *cond;
	
	if( (condList.fhead == NULL) && (condList.head == NULL) )
		fb_hListInit( &condList, (void *)condTB, sizeof(FBCOND), FB_MAXCONDS );
	
	cond = (FBCOND *)fb_hListAllocElem( &condList );
	if( !cond )
		return NULL;
	
	pthread_mutex_init( &cond->lock, NULL );
	pthread_cond_init( &cond->id, NULL );
	
	return cond;
}

/*:::::*/
FBCALL void fb_CondDestroy( FBCOND *cond )
{
	/* dumb address checking */
	if( (cond < condTB) || (cond >= &condTB[FB_MAXCONDS]) )
		return;
	
	pthread_cond_destroy( &cond->id );
	pthread_mutex_destroy( &cond->lock );
	
	fb_hListFreeElem( &condList, (FB_LISTELEM *)cond );
}

/*:::::*/
FBCALL void fb_CondSignal( FBCOND *cond )
{
	/* dumb address checking */
	if( (cond < condTB) || (cond >= &condTB[FB_MAXCONDS]) )
		return;
	
	pthread_mutex_lock( &cond->lock );
	pthread_cond_signal( &cond->id );
	pthread_mutex_unlock( &cond->lock );
}

/*:::::*/
FBCALL void fb_CondBroadcast( FBCOND *cond )
{
	/* dumb address checking */
	if( (cond < condTB) || (cond >= &condTB[FB_MAXCONDS]) )
		return;
	
	pthread_mutex_lock( &cond->lock );
	pthread_cond_broadcast( &cond->id );
	pthread_mutex_unlock( &cond->lock );
}

/*:::::*/
FBCALL void fb_CondWait( FBCOND *cond )
{
	/* dumb address checking */
	if( (cond < condTB) || (cond >= &condTB[FB_MAXCONDS]) )
		return;
	
	pthread_mutex_lock( &cond->lock );
	pthread_cond_wait( &cond->id, &cond->lock );
	pthread_mutex_unlock( &cond->lock );
}
