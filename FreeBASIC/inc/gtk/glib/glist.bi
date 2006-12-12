''
''
'' glist -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __glist_bi__
#define __glist_bi__

#include once "gmem.bi"

type GList as _GList

type _GList
	data as gpointer
	next as GList ptr
	prev as GList ptr
end type

declare sub g_list_push_allocator (byval allocator as GAllocator ptr)
declare sub g_list_pop_allocator ()
declare function g_list_alloc () as GList ptr
declare sub g_list_free (byval list as GList ptr)
declare sub g_list_free_1 (byval list as GList ptr)
declare function g_list_append (byval list as GList ptr, byval data as gpointer) as GList ptr
declare function g_list_prepend (byval list as GList ptr, byval data as gpointer) as GList ptr
declare function g_list_insert (byval list as GList ptr, byval data as gpointer, byval position as gint) as GList ptr
declare function g_list_insert_sorted (byval list as GList ptr, byval data as gpointer, byval func as GCompareFunc) as GList ptr
declare function g_list_insert_before (byval list as GList ptr, byval sibling as GList ptr, byval data as gpointer) as GList ptr
declare function g_list_concat (byval list1 as GList ptr, byval list2 as GList ptr) as GList ptr
declare function g_list_remove (byval list as GList ptr, byval data as gconstpointer) as GList ptr
declare function g_list_remove_all (byval list as GList ptr, byval data as gconstpointer) as GList ptr
declare function g_list_remove_link (byval list as GList ptr, byval llink as GList ptr) as GList ptr
declare function g_list_delete_link (byval list as GList ptr, byval link_ as GList ptr) as GList ptr
declare function g_list_reverse (byval list as GList ptr) as GList ptr
declare function g_list_copy (byval list as GList ptr) as GList ptr
declare function g_list_nth (byval list as GList ptr, byval n as guint) as GList ptr
declare function g_list_nth_prev (byval list as GList ptr, byval n as guint) as GList ptr
declare function g_list_find (byval list as GList ptr, byval data as gconstpointer) as GList ptr
declare function g_list_find_custom (byval list as GList ptr, byval data as gconstpointer, byval func as GCompareFunc) as GList ptr
declare function g_list_position (byval list as GList ptr, byval llink as GList ptr) as gint
declare function g_list_index (byval list as GList ptr, byval data as gconstpointer) as gint
declare function g_list_last (byval list as GList ptr) as GList ptr
declare function g_list_first (byval list as GList ptr) as GList ptr
declare function g_list_length (byval list as GList ptr) as guint
declare sub g_list_foreach (byval list as GList ptr, byval func as GFunc, byval user_data as gpointer)
declare function g_list_sort (byval list as GList ptr, byval compare_func as GCompareFunc) as GList ptr
declare function g_list_sort_with_data (byval list as GList ptr, byval compare_func as GCompareDataFunc, byval user_data as gpointer) as GList ptr
declare function g_list_nth_data (byval list as GList ptr, byval n as guint) as gpointer

#endif
