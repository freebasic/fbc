''
''
'' gthread -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gthread_bi__
#define __gthread_bi__

#include once "gerror.bi"
#include once "gtypes.bi"
#include once "gatomic.bi"

declare function g_thread_error_quark () as GQuark

enum GThreadError
	G_THREAD_ERROR_AGAIN
end enum

type GThreadFunc as function cdecl(byval as gpointer) as gpointer

enum GThreadPriority
	G_THREAD_PRIORITY_LOW
	G_THREAD_PRIORITY_NORMAL
	G_THREAD_PRIORITY_HIGH
	G_THREAD_PRIORITY_URGENT
end enum

type GThread as _GThread

type _GThread
	func as GThreadFunc
	data as gpointer
	joinable as gboolean
	priority as GThreadPriority
end type

type GMutex as _GMutex
type GCond as _GCond
type GPrivate as _GPrivate
type GStaticPrivate as _GStaticPrivate
type GThreadFunctions as _GThreadFunctions

type _GThreadFunctions
	mutex_new as function cdecl() as GMutex ptr
	mutex_lock as sub cdecl(byval as GMutex ptr)
	mutex_trylock as function cdecl(byval as GMutex ptr) as gboolean
	mutex_unlock as sub cdecl(byval as GMutex ptr)
	mutex_free as sub cdecl(byval as GMutex ptr)
	cond_new as function cdecl() as GCond ptr
	cond_signal as sub cdecl(byval as GCond ptr)
	cond_broadcast as sub cdecl(byval as GCond ptr)
	cond_wait as sub cdecl(byval as GCond ptr, byval as GMutex ptr)
	cond_timed_wait as function cdecl(byval as GCond ptr, byval as GMutex ptr, byval as GTimeVal ptr) as gboolean
	cond_free as sub cdecl(byval as GCond ptr)
	private_new as function cdecl(byval as GDestroyNotify) as GPrivate ptr
	private_get as function cdecl(byval as GPrivate ptr) as gpointer
	private_set as sub cdecl(byval as GPrivate ptr, byval as gpointer)
	thread_create as sub cdecl(byval as GThreadFunc, byval as gpointer, byval as gulong, byval as gboolean, byval as gboolean, byval as GThreadPriority, byval as gpointer, byval as GError ptr ptr)
	thread_yield as sub cdecl()
	thread_join as sub cdecl(byval as gpointer)
	thread_exit as sub cdecl()
	thread_set_priority as sub cdecl(byval as gpointer, byval as GThreadPriority)
	thread_self as sub cdecl(byval as gpointer)
	thread_equal as function cdecl(byval as gpointer, byval as gpointer) as gboolean
end type

declare sub g_thread_init (byval vtable as GThreadFunctions ptr)
declare sub g_thread_init_with_errorcheck_mutexes (byval vtable as GThreadFunctions ptr)

#define G_MUTEX_DEBUG_MAGIC &hf8e18ad7

declare function g_static_mutex_get_mutex_impl (byval mutex as GMutex ptr ptr) as GMutex ptr
declare function g_thread_create_full (byval func as GThreadFunc, byval data as gpointer, byval stack_size as gulong, byval joinable as gboolean, byval bound as gboolean, byval priority as GThreadPriority, byval error as GError ptr ptr) as GThread ptr
declare function g_thread_self () as GThread ptr
declare sub g_thread_exit (byval retval as gpointer)
declare function g_thread_join (byval thread as GThread ptr) as gpointer
declare sub g_thread_set_priority (byval thread as GThread ptr, byval priority as GThreadPriority)
declare sub g_static_mutex_init (byval mutex as GStaticMutex ptr)
declare sub g_static_mutex_free (byval mutex as GStaticMutex ptr)

type _GStaticPrivate
	index as guint
end type

declare sub g_static_private_init (byval private_key as GStaticPrivate ptr)
declare function g_static_private_get (byval private_key as GStaticPrivate ptr) as gpointer
declare sub g_static_private_set (byval private_key as GStaticPrivate ptr, byval data as gpointer, byval notify as GDestroyNotify)
declare sub g_static_private_free (byval private_key as GStaticPrivate ptr)

type GStaticRecMutex as _GStaticRecMutex

type _GStaticRecMutex
	mutex as GStaticMutex
	depth as guint
	owner as GSystemThread
end type

declare sub g_static_rec_mutex_init (byval mutex as GStaticRecMutex ptr)
declare sub g_static_rec_mutex_lock (byval mutex as GStaticRecMutex ptr)
declare function g_static_rec_mutex_trylock (byval mutex as GStaticRecMutex ptr) as gboolean
declare sub g_static_rec_mutex_unlock (byval mutex as GStaticRecMutex ptr)
declare sub g_static_rec_mutex_lock_full (byval mutex as GStaticRecMutex ptr, byval depth as guint)
declare function g_static_rec_mutex_unlock_full (byval mutex as GStaticRecMutex ptr) as guint
declare sub g_static_rec_mutex_free (byval mutex as GStaticRecMutex ptr)

type GStaticRWLock as _GStaticRWLock

type _GStaticRWLock
	mutex as GStaticMutex
	read_cond as GCond ptr
	write_cond as GCond ptr
	read_counter as guint
	have_writer as gboolean
	want_to_read as guint
	want_to_write as guint
end type

declare sub g_static_rw_lock_init (byval lock as GStaticRWLock ptr)
declare sub g_static_rw_lock_reader_lock (byval lock as GStaticRWLock ptr)
declare function g_static_rw_lock_reader_trylock (byval lock as GStaticRWLock ptr) as gboolean
declare sub g_static_rw_lock_reader_unlock (byval lock as GStaticRWLock ptr)
declare sub g_static_rw_lock_writer_lock (byval lock as GStaticRWLock ptr)
declare function g_static_rw_lock_writer_trylock (byval lock as GStaticRWLock ptr) as gboolean
declare sub g_static_rw_lock_writer_unlock (byval lock as GStaticRWLock ptr)
declare sub g_static_rw_lock_free (byval lock as GStaticRWLock ptr)

enum GOnceStatus
	G_ONCE_STATUS_NOTCALLED
	G_ONCE_STATUS_PROGRESS
	G_ONCE_STATUS_READY
end enum

type GOnce as _GOnce

type _GOnce
	status as GOnceStatus
	retval as gpointer
end type

declare function g_once_impl (byval once as GOnce ptr, byval func as GThreadFunc, byval arg as gpointer) as gpointer
declare sub glib_dummy_decl ()

#endif
