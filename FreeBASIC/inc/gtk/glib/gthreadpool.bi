''
''
'' gthreadpool -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gthreadpool_bi__
#define __gthreadpool_bi__

#include once "gthread.bi"

type GThreadPool as _GThreadPool

type _GThreadPool
	func as GFunc
	user_data as gpointer
	exclusive as gboolean
end type

declare function g_thread_pool_new (byval func as GFunc, byval user_data as gpointer, byval max_threads as gint, byval exclusive as gboolean, byval error as GError ptr ptr) as GThreadPool ptr
declare sub g_thread_pool_push (byval pool as GThreadPool ptr, byval data as gpointer, byval error as GError ptr ptr)
declare sub g_thread_pool_set_max_threads (byval pool as GThreadPool ptr, byval max_threads as gint, byval error as GError ptr ptr)
declare function g_thread_pool_get_max_threads (byval pool as GThreadPool ptr) as gint
declare function g_thread_pool_get_num_threads (byval pool as GThreadPool ptr) as guint
declare function g_thread_pool_unprocessed (byval pool as GThreadPool ptr) as guint
declare sub g_thread_pool_free (byval pool as GThreadPool ptr, byval immediate as gboolean, byval wait as gboolean)
declare sub g_thread_pool_set_max_unused_threads (byval max_threads as gint)
declare function g_thread_pool_get_max_unused_threads () as gint
declare function g_thread_pool_get_num_unused_threads () as guint
declare sub g_thread_pool_stop_unused_threads ()

#endif
