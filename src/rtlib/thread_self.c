#include "fb.h"
#include "fb_private_thread.h"

#define GCC_VERSION (__GNUC__ * 10000 \
                     + __GNUC_MINOR__ * 100 \
                     + __GNUC_PATCHLEVEL__)

/* A mutex is massively overkill for atomic int updates, 
   but we have to support both ancient platforms and build tools
   so those can use the super slow mutex and everything not 20 years old
   can use the fast stuff

   GCC 4.1 is the first to implement the atomic builtins, 
   and InterlockedOr is a macro in the Windows headers for
   atomic or operations

   NeedsMutex = (EnableMT && (GCC <= 4.0 || !(Windows && InterlockedOr)))
 */
#if ( ( defined( ENABLE_MT ) ) && \
	( ( GCC_VERSION < 40100 ) || \
	  ( !( defined( HOST_WIN32 ) && defined( InterlockedOr ) ) ) \
	) \
)
#define NEEDS_MUTEX 1
static FBMUTEX *g_threadFlagMutex = NULL;
#endif


FBCALL FBTHREAD *fb_ThreadSelf( void )
{
	return FB_TLSGETCTX( FBTHREAD )->self;
}

void fb_AllocateMainFBThread( void )
{
	/* As TlsGetCtx will allocate a TLS structure and 
	   space to hold the context, and as the main thread doesn't have
           its own FBTHREAD* - to avoid making two allocations, 
           we tell it the context is big enough to cover both
           and make our own FBTHREAD
	*/
	FB_FBTHREADCTX* ctx = fb_TlsGetCtx(
		FB_TLSKEY_FBTHREAD, 
		sizeof( *ctx ) + sizeof( *( ctx->self ) ),
		fb_FBTHREADCTX_Destructor
	);
	ctx->self = ( FBTHREAD * )( ctx + 1 );
	memset( ctx->self, 0, sizeof( *( ctx->self ) ) );
	ctx->self->flags = FBTHREAD_MAIN;

#ifdef NEEDS_MUTEX
	g_threadFlagMutex = fb_MutexCreate( );
#endif
}

#ifdef ENABLE_MT
void fb_CloseAtomicFBThreadFlagMutex( void )
{
#ifdef NEEDS_MUTEX
	fb_MutexDestroy( g_threadFlagMutex );
#endif
}
#endif

/* 
** even if this is not the multithreaded version of the rtlib
** define fbAtomicSetThreadFlags() anyway as it will be called
** from thread_core.c:threadproc()
*/
FBTHREADFLAGS fb_AtomicSetThreadFlags( volatile FBTHREADFLAGS *threadFlags, FBTHREADFLAGS newFlag )
{
#ifdef ENABLE_MT
#ifdef NEEDS_MUTEX

	FBTHREADFLAGS before;
	fb_MutexLock( g_threadFlagMutex );
	before = *threadFlags;
	*threadFlags |= newFlag;
	fb_MutexUnlock( g_threadFlagMutex );
	return before;

#else

#if GCC_VERSION >= 40100
	return __sync_fetch_and_or( threadFlags, newFlag );
#elif defined ( InterlockedOr )
	return InterlockedOr( (volatile LONG *) threadFlags, newFlag );
#endif /* GCC_VERSION */

#endif /* NEEDS_MUTEX */

#else /* !define(ENABLE_MT) */
	FBTHREADFLAGS before;
	before = *threadFlags;
	*threadFlags |= newFlag;
	return before;

#endif /* ENABLE_MT */
}
