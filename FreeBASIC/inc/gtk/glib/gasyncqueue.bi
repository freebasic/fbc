''
''
'' gasyncqueue -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gasyncqueue_bi__
#define __gasyncqueue_bi__

#include once "gtk/glib/gthread.bi"

type GAsyncQueue as _GAsyncQueue

declare function g_async_queue_new cdecl alias "g_async_queue_new" () as GAsyncQueue ptr
declare sub g_async_queue_lock cdecl alias "g_async_queue_lock" (byval queue as GAsyncQueue ptr)
declare sub g_async_queue_unlock cdecl alias "g_async_queue_unlock" (byval queue as GAsyncQueue ptr)
declare function g_async_queue_ref cdecl alias "g_async_queue_ref" (byval queue as GAsyncQueue ptr) as GAsyncQueue ptr
declare sub g_async_queue_unref cdecl alias "g_async_queue_unref" (byval queue as GAsyncQueue ptr)
declare sub g_async_queue_ref_unlocked cdecl alias "g_async_queue_ref_unlocked" (byval queue as GAsyncQueue ptr)
declare sub g_async_queue_unref_and_unlock cdecl alias "g_async_queue_unref_and_unlock" (byval queue as GAsyncQueue ptr)
declare sub g_async_queue_push cdecl alias "g_async_queue_push" (byval queue as GAsyncQueue ptr, byval data as gpointer)
declare sub g_async_queue_push_unlocked cdecl alias "g_async_queue_push_unlocked" (byval queue as GAsyncQueue ptr, byval data as gpointer)
declare function g_async_queue_pop cdecl alias "g_async_queue_pop" (byval queue as GAsyncQueue ptr) as gpointer
declare function g_async_queue_pop_unlocked cdecl alias "g_async_queue_pop_unlocked" (byval queue as GAsyncQueue ptr) as gpointer
declare function g_async_queue_try_pop cdecl alias "g_async_queue_try_pop" (byval queue as GAsyncQueue ptr) as gpointer
declare function g_async_queue_try_pop_unlocked cdecl alias "g_async_queue_try_pop_unlocked" (byval queue as GAsyncQueue ptr) as gpointer
declare function g_async_queue_timed_pop cdecl alias "g_async_queue_timed_pop" (byval queue as GAsyncQueue ptr, byval end_time as GTimeVal ptr) as gpointer
declare function g_async_queue_timed_pop_unlocked cdecl alias "g_async_queue_timed_pop_unlocked" (byval queue as GAsyncQueue ptr, byval end_time as GTimeVal ptr) as gpointer
declare function g_async_queue_length cdecl alias "g_async_queue_length" (byval queue as GAsyncQueue ptr) as gint
declare function g_async_queue_length_unlocked cdecl alias "g_async_queue_length_unlocked" (byval queue as GAsyncQueue ptr) as gint

#endif
