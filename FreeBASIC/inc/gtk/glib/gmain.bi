''
''
'' gmain -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gmain_bi__
#define __gmain_bi__

#include once "gslist.bi"
#include once "gthread.bi"

type GMainContext as _GMainContext
type GMainLoop as _GMainLoop
type GSource as _GSource
type GSourceCallbackFuncs as _GSourceCallbackFuncs
type GSourceFuncs as _GSourceFuncs
type GSourceFunc as function cdecl(byval as gpointer) as gboolean
type GChildWatchFunc as sub cdecl(byval as GPid, byval as gint, byval as gpointer)

type _GSource
	callback_data as gpointer
	callback_funcs as GSourceCallbackFuncs ptr
	source_funcs as GSourceFuncs ptr
	ref_count as guint
	context as GMainContext ptr
	priority as gint
	flags as guint
	source_id as guint
	poll_fds as GSList ptr
	prev as GSource ptr
	next as GSource ptr
	reserved1 as gpointer
	reserved2 as gpointer
end type

type _GSourceCallbackFuncs
	ref as sub cdecl(byval as gpointer)
	unref as sub cdecl(byval as gpointer)
	get as sub cdecl(byval as gpointer, byval as GSource ptr, byval as GSourceFunc ptr, byval as gpointer ptr)
end type

type GSourceDummyMarshal as sub cdecl()

type _GSourceFuncs
	prepare as function cdecl(byval as GSource ptr, byval as gint ptr) as gboolean
	check as function cdecl(byval as GSource ptr) as gboolean
	dispatch as function cdecl(byval as GSource ptr, byval as GSourceFunc, byval as gpointer) as gboolean
	finalize as sub cdecl(byval as GSource ptr)
	closure_callback as GSourceFunc
	closure_marshal as GSourceDummyMarshal
end type

type GPollFD as _GPollFD
type GPollFunc as function cdecl(byval as GPollFD ptr, byval as guint, byval as gint) as gint

type _GPollFD
	fd as gint
	events as gushort
	revents as gushort
end type

#define G_PRIORITY_HIGH -100
#define G_PRIORITY_DEFAULT 0
#define G_PRIORITY_HIGH_IDLE 100
#define G_PRIORITY_DEFAULT_IDLE 200
#define G_PRIORITY_LOW 300

declare function g_main_context_new () as GMainContext ptr
declare function g_main_context_ref (byval context as GMainContext ptr) as GMainContext ptr
declare sub g_main_context_unref (byval context as GMainContext ptr)
declare function g_main_context_default () as GMainContext ptr
declare function g_main_context_iteration (byval context as GMainContext ptr, byval may_block as gboolean) as gboolean
declare function g_main_context_pending (byval context as GMainContext ptr) as gboolean
declare function g_main_context_find_source_by_id (byval context as GMainContext ptr, byval source_id as guint) as GSource ptr
declare function g_main_context_find_source_by_user_data (byval context as GMainContext ptr, byval user_data as gpointer) as GSource ptr
declare function g_main_context_find_source_by_funcs_user_data (byval context as GMainContext ptr, byval funcs as GSourceFuncs ptr, byval user_data as gpointer) as GSource ptr
declare sub g_main_context_wakeup (byval context as GMainContext ptr)
declare function g_main_context_acquire (byval context as GMainContext ptr) as gboolean
declare sub g_main_context_release (byval context as GMainContext ptr)
declare function g_main_context_wait (byval context as GMainContext ptr, byval cond as GCond ptr, byval mutex as GMutex ptr) as gboolean
declare function g_main_context_prepare (byval context as GMainContext ptr, byval priority as gint ptr) as gboolean
declare function g_main_context_query (byval context as GMainContext ptr, byval max_priority as gint, byval timeout_ as gint ptr, byval fds as GPollFD ptr, byval n_fds as gint) as gint
declare function g_main_context_check (byval context as GMainContext ptr, byval max_priority as gint, byval fds as GPollFD ptr, byval n_fds as gint) as gint
declare sub g_main_context_dispatch (byval context as GMainContext ptr)
declare sub g_main_context_set_poll_func (byval context as GMainContext ptr, byval func as GPollFunc)
declare function g_main_context_get_poll_func (byval context as GMainContext ptr) as GPollFunc
declare sub g_main_context_add_poll (byval context as GMainContext ptr, byval fd as GPollFD ptr, byval priority as gint)
declare sub g_main_context_remove_poll (byval context as GMainContext ptr, byval fd as GPollFD ptr)
declare function g_main_depth () as integer
declare function g_main_loop_new (byval context as GMainContext ptr, byval is_running as gboolean) as GMainLoop ptr
declare sub g_main_loop_run (byval loop as GMainLoop ptr)
declare sub g_main_loop_quit (byval loop as GMainLoop ptr)
declare function g_main_loop_ref (byval loop as GMainLoop ptr) as GMainLoop ptr
declare sub g_main_loop_unref (byval loop as GMainLoop ptr)
declare function g_main_loop_is_running (byval loop as GMainLoop ptr) as gboolean
declare function g_main_loop_get_context (byval loop as GMainLoop ptr) as GMainContext ptr
declare function g_source_new (byval source_funcs as GSourceFuncs ptr, byval struct_size as guint) as GSource ptr
declare function g_source_ref (byval source as GSource ptr) as GSource ptr
declare sub g_source_unref (byval source as GSource ptr)
declare function g_source_attach (byval source as GSource ptr, byval context as GMainContext ptr) as guint
declare sub g_source_destroy (byval source as GSource ptr)
declare sub g_source_set_priority (byval source as GSource ptr, byval priority as gint)
declare function g_source_get_priority (byval source as GSource ptr) as gint
declare sub g_source_set_can_recurse (byval source as GSource ptr, byval can_recurse as gboolean)
declare function g_source_get_can_recurse (byval source as GSource ptr) as gboolean
declare function g_source_get_id (byval source as GSource ptr) as guint
declare function g_source_get_context (byval source as GSource ptr) as GMainContext ptr
declare sub g_source_set_callback (byval source as GSource ptr, byval func as GSourceFunc, byval data as gpointer, byval notify as GDestroyNotify)
declare sub g_source_set_callback_indirect (byval source as GSource ptr, byval callback_data as gpointer, byval callback_funcs as GSourceCallbackFuncs ptr)
declare sub g_source_add_poll (byval source as GSource ptr, byval fd as GPollFD ptr)
declare sub g_source_remove_poll (byval source as GSource ptr, byval fd as GPollFD ptr)
declare sub g_source_get_current_time (byval source as GSource ptr, byval timeval as GTimeVal ptr)
declare function g_idle_source_new () as GSource ptr
declare function g_child_watch_source_new (byval pid as GPid) as GSource ptr
declare function g_timeout_source_new (byval interval as guint) as GSource ptr
declare sub g_get_current_time (byval result as GTimeVal ptr)
declare function g_source_remove (byval tag as guint) as gboolean
declare function g_source_remove_by_user_data (byval user_data as gpointer) as gboolean
declare function g_source_remove_by_funcs_user_data (byval funcs as GSourceFuncs ptr, byval user_data as gpointer) as gboolean
declare function g_timeout_add_full (byval priority as gint, byval interval as guint, byval function as GSourceFunc, byval data as gpointer, byval notify as GDestroyNotify) as guint
declare function g_timeout_add (byval interval as guint, byval function as GSourceFunc, byval data as gpointer) as guint
declare function g_child_watch_add_full (byval priority as gint, byval pid as GPid, byval function as GChildWatchFunc, byval data as gpointer, byval notify as GDestroyNotify) as guint
declare function g_child_watch_add (byval pid as GPid, byval function as GChildWatchFunc, byval data as gpointer) as guint
declare function g_idle_add (byval function as GSourceFunc, byval data as gpointer) as guint
declare function g_idle_add_full (byval priority as gint, byval function as GSourceFunc, byval data as gpointer, byval notify as GDestroyNotify) as guint
declare function g_idle_remove_by_data (byval data as gpointer) as gboolean

#define	g_main_new(is_running) g_main_loop_new (NULL, is_running)
#define g_main_run(loop_) g_main_loop_run(loop_)
#define g_main_quit(loop_) g_main_loop_quit(loop_)
#define g_main_destroy(loop_) g_main_loop_unref(loop_)
#define g_main_is_running(loop_) g_main_loop_is_running(loop_)

#define	g_main_iteration(may_block) g_main_context_iteration(NULL, may_block)
#define g_main_pending() g_main_context_pending(NULL)

#define g_main_set_poll_func(func) g_main_context_set_poll_func(NULL, func)

#endif
