/* Threading stubs for AmigaOS
 *
 * AmigaOS 3.x: No pthreads. Has exec.library CreateTask/CreateProcess
 *   but they're incompatible with FB's threading model.
 * AROS: Has pthreads (uses unix/thread_core.c when built with ENABLE_MT)
 * MorphOS: Has pthreads via ixemul
 * AmigaOS4: Has pthreads via newlib
 *
 * When ENABLE_MT is not defined (default for AmigaOS 3.x), these stubs
 * provide graceful no-op behavior so programs that reference threading
 * functions still link and run (single-threaded).
 */
#include "../fb.h"
#include "../fb_private_thread.h"

#ifndef ENABLE_MT

FBCALL FBTHREAD *fb_ThreadCreate(FB_THREADPROC proc, void *param, ssize_t stack_size) {
    (void)proc; (void)param; (void)stack_size;
    return NULL; /* Cannot create threads */
}

FBCALL void fb_ThreadWait(FBTHREAD *thread) { (void)thread; }
FBCALL void fb_ThreadDetach(FBTHREAD *thread) { (void)thread; }

FBCALL FBMUTEX *fb_MutexCreate(void) { return NULL; }
FBCALL void fb_MutexDestroy(FBMUTEX *mutex) { (void)mutex; }
FBCALL void fb_MutexLock(FBMUTEX *mutex) { (void)mutex; }
FBCALL void fb_MutexUnlock(FBMUTEX *mutex) { (void)mutex; }

FBCALL FBCOND *fb_CondCreate(void) { return NULL; }
FBCALL void fb_CondDestroy(FBCOND *cond) { (void)cond; }
FBCALL void fb_CondSignal(FBCOND *cond) { (void)cond; }
FBCALL void fb_CondBroadcast(FBCOND *cond) { (void)cond; }
FBCALL void fb_CondWait(FBCOND *cond, FBMUTEX *mutex) { (void)cond; (void)mutex; }

#endif /* !ENABLE_MT */
