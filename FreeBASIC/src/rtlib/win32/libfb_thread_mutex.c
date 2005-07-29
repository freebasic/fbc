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
 * thread_mutex.c -- Windows mutex handling routines
 *
 * chng: feb/2005 written [lillo]
 *
 */

#include "fb.h"

typedef struct _FBMUTEX
{
	FB_LISTELEM elem;
	HANDLE id;
} FBMUTEX;

static FBMUTEX mtxTB[FB_MAXMUTEXES];
static FB_LIST mtxList = { 0 };


/*:::::*/
FBCALL FBMUTEX *fb_MutexCreate( void )
{
	FBMUTEX *mutex;

	if( (mtxList.fhead == NULL) && (mtxList.head == NULL) )
		fb_hListInit( &mtxList, (void *)mtxTB, sizeof(FBMUTEX), FB_MAXMUTEXES );

	mutex = (FBMUTEX *)fb_hListAllocElem( &mtxList );
	if( !mutex )
		return NULL;

	mutex->id = CreateSemaphore(NULL, 1, 1, NULL);

	return mutex;
}

/*:::::*/
FBCALL void fb_MutexDestroy( FBMUTEX *mutex )
{
	/* dumb address checking */
	if( (mutex < mtxTB) || (mutex >= &mtxTB[FB_MAXMUTEXES]) )
		return;

	CloseHandle( mutex->id );
	fb_hListFreeElem( &mtxList, (FB_LISTELEM *)mutex );
}

/*:::::*/
FBCALL void fb_MutexLock( FBMUTEX *mutex )
{
	/* dumb address checking */
	if( (mutex < mtxTB) || (mutex >= &mtxTB[FB_MAXMUTEXES]) )
		return;

	WaitForSingleObject( mutex->id, INFINITE );
}

/*:::::*/
FBCALL void fb_MutexUnlock( FBMUTEX *mutex )
{
	/* dumb address checking */
	if( (mutex < mtxTB) || (mutex >= &mtxTB[FB_MAXMUTEXES]) )
		return;

	ReleaseSemaphore( mutex->id, 1, NULL );
}
