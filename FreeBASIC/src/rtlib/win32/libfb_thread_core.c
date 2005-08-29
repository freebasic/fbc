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

#ifdef DEBUG
static CRITICAL_SECTION fb_output_mutex;
static int mutex_inited = FALSE;

typedef struct _CS_INFO {
    CRITICAL_SECTION *pCS;
    DWORD             dwThreadId;
    DWORD             dwLockCount;
} CS_INFO;

static CS_INFO cs_infos[10] = { { 0 } };

void fb_hInitLock( void )
{
    if( mutex_inited )
        return;
    mutex_inited = TRUE;
	InitializeCriticalSection(&fb_output_mutex);
}

void fb_hDoLock(CRITICAL_SECTION *pLock)
{
    DWORD dwThreadId = GetCurrentThreadId();

    fb_hInitLock();

    EnterCriticalSection(&fb_output_mutex);
    printf("Try lock of %p from %lx\n", pLock, dwThreadId);
    LeaveCriticalSection(&fb_output_mutex);

    EnterCriticalSection(pLock);

    EnterCriticalSection(&fb_output_mutex);
    {
        size_t iCount = sizeof(cs_infos)/sizeof(cs_infos[0]);
        size_t i;
        for( i=0; i!=iCount; ++i ) {
            CS_INFO *cs_info = cs_infos + i;
            if( cs_info->pCS==pLock ) {
                cs_info->dwThreadId = dwThreadId;
                ++cs_info->dwLockCount;
                break;
            }
        }
        if( i==iCount ) {
            for( i=0; i!=iCount; ++i ) {
                CS_INFO *cs_info = cs_infos + i;
                if( cs_info->pCS==NULL ) {
                    cs_info->pCS = pLock;
                    cs_info->dwThreadId = GetCurrentThreadId();
                    cs_info->dwLockCount = 1;
                    break;
                }
            }
        }
        printf("Lock level (%p, %lx) = %lu\n", pLock, dwThreadId, cs_infos[i].dwLockCount );
    }
    LeaveCriticalSection(&fb_output_mutex);

}

void fb_hDoUnlock(CRITICAL_SECTION *pLock)
{
    DWORD dwThreadId = GetCurrentThreadId();

    fb_hInitLock();

    EnterCriticalSection(&fb_output_mutex);
    {
        size_t iCount = sizeof(cs_infos)/sizeof(cs_infos[0]);
        size_t i;
        for( i=0; i!=iCount; ++i ) {
            CS_INFO *cs_info = cs_infos + i;
            if( cs_info->pCS==pLock ) {
                if( cs_info->dwThreadId==dwThreadId ) {
                    if( --cs_info->dwLockCount==0 ) {
                        cs_info->dwThreadId = 0;
                    }
                    printf("Unlock level (%p, %lx) = %lu\n", pLock, dwThreadId, cs_info->dwLockCount );
                } else {
                    printf("Internal error 2\n");
                    abort();
                }
                break;
            }
        }
        if( i==iCount ) {
            printf("Internal error 1\n");
            abort();
        }
    }
    LeaveCriticalSection(&fb_output_mutex);

    LeaveCriticalSection(pLock);
}
#endif

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

#ifdef TARGET_WIN32
    thread->id = (HANDLE)_beginthread( (ThreadStartFn) proc, 0, (void *)param );
#else
    {
        DWORD dwThreadId;
        thread->id = CreateThread( NULL,
                                   0,
                                   (LPTHREAD_START_ROUTINE) proc,
                                   (void*) param,
                                   0,
                                   &dwThreadId );
    }
#endif

	return thread;
}

/*:::::*/
FBCALL void fb_ThreadWait( FBTHREAD *thread )
{
	/* dumb address checking */
	if( (thread < thdTB) || (thread >= &thdTB[FB_MAXTHREADS]) )
		return;

    WaitForSingleObject( thread->id, INFINITE );

#ifdef TARGET_WIN32
    /* Never forget to close the threads handle ... otherwise we'll
     * have "zombie" threads in the system ... */
    CloseHandle( thread->id );
#endif

	fb_hListFreeElem( &thdList, (FB_LISTELEM *)thread );
}
