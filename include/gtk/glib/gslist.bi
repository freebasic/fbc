''
''
'' gslist -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gslist_bi__
#define __gslist_bi__

#include once "gmem.bi"

type GSList as _GSList

type _GSList
	data as gpointer
	next as GSList ptr
end type

declare sub g_slist_push_allocator (byval allocator as GAllocator ptr)
declare sub g_slist_pop_allocator ()
declare function g_slist_alloc () as GSList ptr
declare sub g_slist_free (byval list as GSList ptr)
declare sub g_slist_free_1 (byval list as GSList ptr)
declare function g_slist_append (byval list as GSList ptr, byval data as gpointer) as GSList ptr
declare function g_slist_prepend (byval list as GSList ptr, byval data as gpointer) as GSList ptr
declare function g_slist_insert (byval list as GSList ptr, byval data as gpointer, byval position as gint) as GSList ptr
declare function g_slist_insert_sorted (byval list as GSList ptr, byval data as gpointer, byval func as GCompareFunc) as GSList ptr
declare function g_slist_insert_before (byval slist as GSList ptr, byval sibling as GSList ptr, byval data as gpointer) as GSList ptr
declare function g_slist_concat (byval list1 as GSList ptr, byval list2 as GSList ptr) as GSList ptr
declare function g_slist_remove (byval list as GSList ptr, byval data as gconstpointer) as GSList ptr
declare function g_slist_remove_all (byval list as GSList ptr, byval data as gconstpointer) as GSList ptr
declare function g_slist_remove_link (byval list as GSList ptr, byval link_ as GSList ptr) as GSList ptr
declare function g_slist_delete_link (byval list as GSList ptr, byval link_ as GSList ptr) as GSList ptr
declare function g_slist_reverse (byval list as GSList ptr) as GSList ptr
declare function g_slist_copy (byval list as GSList ptr) as GSList ptr
declare function g_slist_nth (byval list as GSList ptr, byval n as guint) as GSList ptr
declare function g_slist_find (byval list as GSList ptr, byval data as gconstpointer) as GSList ptr
declare function g_slist_find_custom (byval list as GSList ptr, byval data as gconstpointer, byval func as GCompareFunc) as GSList ptr
declare function g_slist_position (byval list as GSList ptr, byval llink as GSList ptr) as gint
declare function g_slist_index (byval list as GSList ptr, byval data as gconstpointer) as gint
declare function g_slist_last (byval list as GSList ptr) as GSList ptr
declare function g_slist_length (byval list as GSList ptr) as guint
declare sub g_slist_foreach (byval list as GSList ptr, byval func as GFunc, byval user_data as gpointer)
declare function g_slist_sort (byval list as GSList ptr, byval compare_func as GCompareFunc) as GSList ptr
declare function g_slist_sort_with_data (byval list as GSList ptr, byval compare_func as GCompareDataFunc, byval user_data as gpointer) as GSList ptr
declare function g_slist_nth_data (byval list as GSList ptr, byval n as guint) as gpointer

#endif
