#if defined HOST_UNIX
	#include <pthread.h>
	struct _FBMUTEX {
		pthread_mutex_t id;
	};
#elif defined HOST_DOS && defined ENABLE_MT
	#include <pthread.h>
	struct _FBMUTEX {
		pthread_mutex_t id;
	};
#elif defined HOST_WIN32
	#include <windows.h>
	struct _FBMUTEX {
		HANDLE id;
	};
#endif

/* Solaris pthread.h does not define PTHREAD_STACK_MIN */
#ifndef PTHREAD_STACK_MIN
	#define PTHREAD_STACK_MIN 8192
#endif

/* phtreads will crash freebsd when stack size is too small
// The default of 2048 KiB is too small.as tested on freebsd-13.0-i386
// 8192 KiB seems about alright (jeffm) 
// see https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=234775
*/
#ifdef HOST_FREEBSD
	#define FBTHREAD_STACK_MIN 8192
#else
	#define FBTHREAD_STACK_MIN PTHREAD_STACK_MIN
#endif

/* Thread handle returned by threadcreate(), so the caller is able to track the
   thread (freed by threadwait/threaddetach).

   At least on Win32 we probably don't really need this - it would be enough to
   just use the HANDLE directly instead of wrapping it in an dynamically
   allocated FBTHREAD structure. (we're already assuming that NULL is an invalid
   handle in the win32 fb_ThreadCreate(), so that'd be nothing new)

   With pthreads though, it's not clear whether we could store a pthread_t into
   a void*, because pthread_t doesn't have to be an integer or pointer, and
   furthermore, zero may be a valid value for it. */

typedef enum _FBTHREADFLAGS
{
	FBTHREAD_MAIN = 1,
	FBTHREAD_EXITED = 2,
	FBTHREAD_DETACHED = 4
} FBTHREADFLAGS;

struct _FBTHREAD {
#if defined HOST_DOS && defined ENABLE_MT
	pthread_t id;
#elif defined HOST_DOS && !defined ENABLE_MT
	int id;
	void *opaque;
#elif defined HOST_UNIX
	pthread_t id;
#elif defined HOST_WIN32
	HANDLE id;
#elif defined HOST_XBOX
	HANDLE id;
#else
#error Unexpected target
#endif
	volatile FBTHREADFLAGS flags;
};

/* Info structure passed to our internal threadproc()s, so it can call the
   user's threadproc (freed at the end of our threadproc()s) */
typedef struct {
	FB_THREADPROC     proc;
	void             *param;
	FBTHREAD         *thread;
} FBTHREADINFO;

typedef struct _FB_FBTHREADCTX
{
	FBTHREAD	*self;
} FB_FBTHREADCTX;

#define fb_FBTHREADCTX_Destructor NULL

void          fb_AllocateMainFBThread( void );
FBTHREADFLAGS fb_AtomicSetThreadFlags( volatile FBTHREADFLAGS *flags, FBTHREADFLAGS newFlag );

#ifdef ENABLE_MT
void          fb_CloseAtomicFBThreadFlagMutex( void );
#endif

