#if defined HOST_UNIX
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
   thread (freed by threadwait/threaddetach) */
struct _FBTHREAD {
#if defined HOST_DOS
	int id;
#elif defined HOST_UNIX
	pthread_t id;
#elif defined HOST_WIN32
	HANDLE id;
#elif defined HOST_XBOX
	HANDLE id;
#else
#error Unexpected target
#endif
	void         *opaque;
};
