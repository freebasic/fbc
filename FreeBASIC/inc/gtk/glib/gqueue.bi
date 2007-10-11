''
''
'' gqueue -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gqueue_bi__
#define __gqueue_bi__

#include once "glist.bi"

type GQueue as _GQueue

type _GQueue
	head as GList ptr
	tail as GList ptr
	length as guint
end type

declare function g_queue_new () as GQueue ptr
declare sub g_queue_free (byval queue as GQueue ptr)
declare function g_queue_is_empty (byval queue as GQueue ptr) as gboolean
declare function g_queue_get_length (byval queue as GQueue ptr) as guint
declare sub g_queue_reverse (byval queue as GQueue ptr)
declare function g_queue_copy (byval queue as GQueue ptr) as GQueue ptr
declare sub g_queue_foreach (byval queue as GQueue ptr, byval func as GFunc, byval user_data as gpointer)
declare function g_queue_find (byval queue as GQueue ptr, byval data as gconstpointer) as GList ptr
declare function g_queue_find_custom (byval queue as GQueue ptr, byval data as gconstpointer, byval func as GCompareFunc) as GList ptr
declare sub g_queue_sort (byval queue as GQueue ptr, byval compare_func as GCompareDataFunc, byval user_data as gpointer)
declare sub g_queue_push_head (byval queue as GQueue ptr, byval data as gpointer)
declare sub g_queue_push_tail (byval queue as GQueue ptr, byval data as gpointer)
declare sub g_queue_push_nth (byval queue as GQueue ptr, byval data as gpointer, byval n as gint)
declare function g_queue_pop_head (byval queue as GQueue ptr) as gpointer
declare function g_queue_pop_tail (byval queue as GQueue ptr) as gpointer
declare function g_queue_pop_nth (byval queue as GQueue ptr, byval n as guint) as gpointer
declare function g_queue_peek_head (byval queue as GQueue ptr) as gpointer
declare function g_queue_peek_tail (byval queue as GQueue ptr) as gpointer
declare function g_queue_peek_nth (byval queue as GQueue ptr, byval n as guint) as gpointer
declare function g_queue_index (byval queue as GQueue ptr, byval data as gconstpointer) as gint
declare sub g_queue_remove (byval queue as GQueue ptr, byval data as gconstpointer)
declare sub g_queue_remove_all (byval queue as GQueue ptr, byval data as gconstpointer)
declare sub g_queue_insert_before (byval queue as GQueue ptr, byval sibling as GList ptr, byval data as gpointer)
declare sub g_queue_insert_after (byval queue as GQueue ptr, byval sibling as GList ptr, byval data as gpointer)
declare sub g_queue_insert_sorted (byval queue as GQueue ptr, byval data as gpointer, byval func as GCompareDataFunc, byval user_data as gpointer)
declare sub g_queue_push_head_link (byval queue as GQueue ptr, byval link_ as GList ptr)
declare sub g_queue_push_tail_link (byval queue as GQueue ptr, byval link_ as GList ptr)
declare sub g_queue_push_nth_link (byval queue as GQueue ptr, byval n as gint, byval link_ as GList ptr)
declare function g_queue_pop_head_link (byval queue as GQueue ptr) as GList ptr
declare function g_queue_pop_tail_link (byval queue as GQueue ptr) as GList ptr
declare function g_queue_pop_nth_link (byval queue as GQueue ptr, byval n as guint) as GList ptr
declare function g_queue_peek_head_link (byval queue as GQueue ptr) as GList ptr
declare function g_queue_peek_tail_link (byval queue as GQueue ptr) as GList ptr
declare function g_queue_peek_nth_link (byval queue as GQueue ptr, byval n as guint) as GList ptr
declare function g_queue_link_index (byval queue as GQueue ptr, byval link_ as GList ptr) as gint
declare sub g_queue_unlink (byval queue as GQueue ptr, byval link_ as GList ptr)
declare sub g_queue_delete_link (byval queue as GQueue ptr, byval link_ as GList ptr)

#endif
