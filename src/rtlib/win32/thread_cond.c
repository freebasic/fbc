/**
 * Windows condition variables handling routines,
 * based on paper by Douglas C. Schmidt and Irfan Pyarali.
 *
 * The code can choose between two implementations at runtime:
 * one for Windows 9x, one for Windows NT.
 */

#include "../fb.h"
#include "../fb_private_thread.h"

#define SIGNAL		0
#define BROADCAST	1

struct _FBCOND {
	/* data common to both implementations */
	int waiters_count;
	CRITICAL_SECTION waiters_count_lock;
	union {
		struct {
			HANDLE event[2];
		} w9x;
		struct {
			HANDLE sema; /* semaphore for waiters */
			HANDLE waiters_done; /* event */
			BOOL was_broadcast;
		} nt;
	};
};

typedef struct _FBCONDOPS
{
	FBCALL void (*create)    ( FBCOND *cond );
	FBCALL void (*destroy)   ( FBCOND *cond );
	FBCALL void (*signal)    ( FBCOND *cond );
	FBCALL void (*broadcast) ( FBCOND *cond );
	FBCALL void (*wait)      ( FBCOND *cond, FBMUTEX *mutex );
} FBCONDOPS;

/* SignalObjectAndWait version */
static FBCALL void fb_CondCreate_nt    ( FBCOND *cond );
static FBCALL void fb_CondDestroy_nt   ( FBCOND *cond );
static FBCALL void fb_CondSignal_nt    ( FBCOND *cond );
static FBCALL void fb_CondBroadcast_nt ( FBCOND *cond );
static FBCALL void fb_CondWait_nt      ( FBCOND *cond, FBMUTEX *mutex );

/* non-SignalObjectAndWait version */
static FBCALL void fb_CondCreate_9x    ( FBCOND *cond );
static FBCALL void fb_CondDestroy_9x   ( FBCOND *cond );
static FBCALL void fb_CondSignal_9x    ( FBCOND *cond );
static FBCALL void fb_CondBroadcast_9x ( FBCOND *cond );
static FBCALL void fb_CondWait_9x      ( FBCOND *cond, FBMUTEX *mutex );

typedef DWORD (WINAPI * SIGNALOBJECTANDWAIT) (HANDLE, HANDLE, DWORD, BOOL );

static SIGNALOBJECTANDWAIT pSignalObjectAndWait = NULL;
static LONG __inited = FALSE;
static FBCONDOPS __condops;

static inline void fb_CondInit( void )
{
	/* If two threads get here at the same time, make sure only one of
	   them does the initialization while the other one waits. */
	FB_MTLOCK();

	if( __inited ) {
		FB_MTUNLOCK();
		return;
	}

	/* win95: pSignalObjectAndWait==NULL
	   win98: pSignalObjectAndWait() returns ERROR_INVALID_FUNCTION
	   winnt: pSignalObjectAndWait() returns WAIT_FAILED */

	pSignalObjectAndWait = (SIGNALOBJECTANDWAIT)(void*)GetProcAddress( GetModuleHandle( "KERNEL32" ), "SignalObjectAndWait" );
	if( (pSignalObjectAndWait != NULL)
	    && (pSignalObjectAndWait(NULL, NULL, 0, 0) == WAIT_FAILED) ) {
		__condops.create    = fb_CondCreate_nt;
		__condops.destroy   = fb_CondDestroy_nt;
		__condops.signal    = fb_CondSignal_nt;
		__condops.broadcast = fb_CondBroadcast_nt;
		__condops.wait      = fb_CondWait_nt;
	} else {
		__condops.create    = fb_CondCreate_9x;
		__condops.destroy   = fb_CondDestroy_9x;
		__condops.signal    = fb_CondSignal_9x;
		__condops.broadcast = fb_CondBroadcast_9x;
		__condops.wait      = fb_CondWait_9x;
	}

	__inited = TRUE;

	FB_MTUNLOCK();
}

FBCALL FBCOND *fb_CondCreate( void )
{
	FBCOND *cond;

	fb_CondInit( );

	cond = malloc( sizeof( FBCOND ) );
	if( !cond )
		return NULL;

	cond->waiters_count = 0;
	InitializeCriticalSection( &cond->waiters_count_lock );
	__condops.create( cond );

	return cond;
}

FBCALL void fb_CondDestroy( FBCOND *cond )
{
	if( !cond )
		return;
	DeleteCriticalSection( &cond->waiters_count_lock );
	__condops.destroy( cond );
	free( cond );
}

FBCALL void fb_CondSignal( FBCOND *cond )
{
	int has_waiters;

	if( !cond )
		return;

	EnterCriticalSection( &cond->waiters_count_lock );
	has_waiters = cond->waiters_count > 0;
	LeaveCriticalSection( &cond->waiters_count_lock );

	if( has_waiters ) {
		__condops.signal( cond );
	}
}

FBCALL void fb_CondBroadcast( FBCOND *cond )
{
	if( cond ) {
		__condops.broadcast( cond );
	}
}

FBCALL void fb_CondWait( FBCOND *cond, FBMUTEX *mutex )
{
	if( cond && mutex ) {
		__condops.wait( cond, mutex );
	}
}

/* SignalObjectAndWait version */

static FBCALL void fb_CondCreate_nt( FBCOND *cond )
{
	cond->nt.was_broadcast = FALSE;
	cond->nt.sema = CreateSemaphore( NULL, 0, 0x7fffffff, NULL );
	cond->nt.waiters_done = CreateEvent( NULL, FALSE, FALSE, NULL );
}

static FBCALL void fb_CondDestroy_nt( FBCOND *cond )
{
	CloseHandle( cond->nt.sema );
	CloseHandle( cond->nt.waiters_done );
}

static FBCALL void fb_CondSignal_nt( FBCOND *cond )
{
	ReleaseSemaphore( cond->nt.sema, 1, 0 );
}

static FBCALL void fb_CondBroadcast_nt( FBCOND *cond )
{
	EnterCriticalSection( &cond->waiters_count_lock );

	if( cond->waiters_count > 0 ) {
		cond->nt.was_broadcast = TRUE;

		ReleaseSemaphore( cond->nt.sema, cond->waiters_count, 0 );
		LeaveCriticalSection( &cond->waiters_count_lock );

		WaitForSingleObject( cond->nt.waiters_done, INFINITE );
		cond->nt.was_broadcast = FALSE;
	} else {
		LeaveCriticalSection( &cond->waiters_count_lock );
	}
}

static FBCALL void fb_CondWait_nt( FBCOND *cond, FBMUTEX *mutex )
{
	int last_waiter;

	EnterCriticalSection( &cond->waiters_count_lock );
	cond->waiters_count++;
	LeaveCriticalSection( &cond->waiters_count_lock );

	/* unlock mutex and wait for waiters semaphore */
	pSignalObjectAndWait( mutex->id, cond->nt.sema, INFINITE, FALSE );

	EnterCriticalSection( &cond->waiters_count_lock );
	cond->waiters_count--;
	last_waiter = cond->nt.was_broadcast && cond->waiters_count == 0;
	LeaveCriticalSection( &cond->waiters_count_lock );

	/* relock mutex */
	if( last_waiter ) {
		pSignalObjectAndWait( cond->nt.waiters_done, mutex->id, INFINITE, FALSE );
	} else {
		WaitForSingleObject( mutex->id, INFINITE );
	}
}

/* non-SignalObjectAndWait version */

static FBCALL void fb_CondCreate_9x( FBCOND *cond )
{
	cond->w9x.event[SIGNAL]    = CreateEvent( NULL, FALSE, FALSE, NULL );
	cond->w9x.event[BROADCAST] = CreateEvent( NULL, TRUE, FALSE, NULL );
}

static FBCALL void fb_CondDestroy_9x( FBCOND *cond )
{
	CloseHandle( cond->w9x.event[SIGNAL] );
	CloseHandle( cond->w9x.event[BROADCAST] );
}

static FBCALL void fb_CondSignal_9x( FBCOND *cond )
{
	SetEvent( cond->w9x.event[SIGNAL] );
}

static FBCALL void fb_CondBroadcast_9x( FBCOND *cond )
{
	int has_waiters;

	EnterCriticalSection( &cond->waiters_count_lock );
	has_waiters = cond->waiters_count > 0;
	LeaveCriticalSection( &cond->waiters_count_lock );

	if( has_waiters )
		SetEvent( cond->w9x.event[BROADCAST] );
}

static FBCALL void fb_CondWait_9x( FBCOND *cond, FBMUTEX *mutex )
{
	int result, last_waiter;

	EnterCriticalSection( &cond->waiters_count_lock );
	cond->waiters_count++;
	LeaveCriticalSection( &cond->waiters_count_lock );

	/* unlock mutex - WARNING: this is not atomic with the wait */
	ReleaseSemaphore( mutex->id, 1, NULL );

	result = WaitForMultipleObjects( 2, cond->w9x.event, FALSE, INFINITE );

	EnterCriticalSection( &cond->waiters_count_lock );
	cond->waiters_count--;
	last_waiter = (result == WAIT_OBJECT_0 + BROADCAST) && (cond->waiters_count == 0);
	LeaveCriticalSection( &cond->waiters_count_lock );

	if( last_waiter ) {
		ResetEvent( cond->w9x.event[BROADCAST] );
	}

	/* relock mutex */
	WaitForSingleObject( mutex->id, INFINITE );
}
