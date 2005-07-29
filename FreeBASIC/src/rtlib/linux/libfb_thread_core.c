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
 * thread_core.c -- Linux (pthreads) thread creation and destruction
 *
 * chng: feb/2005 written [lillo]
 *
 */


#include <pthread.h>
#include "fb.h"


typedef struct _FBTHREAD
{
	FB_LISTELEM elem;
	pthread_t id;
} FBTHREAD;

static FBTHREAD thdTB[FB_MAXTHREADS];
static FB_LIST thdList = { 0 };


/*:::::*/
FBCALL FBTHREAD *fb_ThreadCreate( void *proc, int param )
{
	FBTHREAD *thread;
	
	if( (thdList.fhead == NULL) && (thdList.head == NULL) )
		fb_hListInit( &thdList, (void *)thdTB, sizeof(FBTHREAD), FB_MAXTHREADS );
	
	thread = (FBTHREAD *)fb_hListAllocElem( &thdList );
	if( !thread )
		return NULL;
	
	if( pthread_create( &thread->id, NULL, (void *(*)(void *))proc, (void *)param ) ) {
		fb_hListFreeElem( &thdList, (FB_LISTELEM *)thread );
		return NULL;
	}
	
	return thread;
}

/*:::::*/
FBCALL void fb_ThreadWait( FBTHREAD *thread )
{
	/* dumb address checking */
	if( (thread < thdTB) || (thread >= &thdTB[FB_MAXTHREADS]) )
		return;
	
	pthread_join( thread->id, NULL );
	fb_hListFreeElem( &thdList, (FB_LISTELEM *)thread );
}
