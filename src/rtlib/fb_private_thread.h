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

/* Info structure passed to our internal threadproc()s, so it can call the
   user's threadproc (freed at the end of our threadproc()s) */
typedef struct {
	FB_THREADPROC proc;
	void         *param;
} FBTHREADINFO;

/* Thread handle returned by threadcreate(), so the caller is able to track the
   thread (freed by threadwait/threaddetach).

   At least on Win32 we probably don't really need this - it would be enough to
   just use the HANDLE directly instead of wrapping it in an dynamically
   allocated FBTHREAD structure. (we're already assuming that NULL is an invalid
   handle in the win32 fb_ThreadCreate(), so that'd be nothing new)

   With pthreads though, it's not clear whether we could store a pthread_t into
   a void*, because pthread_t doesn't have to be an integer or pointer, and
   furthermore, zero may be a valid value for it. */
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
};
