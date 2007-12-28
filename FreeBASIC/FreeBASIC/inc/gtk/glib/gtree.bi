''
''
'' gtree -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtree_bi__
#define __gtree_bi__

#include once "gnode.bi"

type GTree as _GTree
type GTraverseFunc as function cdecl(byval as gpointer, byval as gpointer, byval as gpointer) as gboolean

declare function g_tree_new (byval key_compare_func as GCompareFunc) as GTree ptr
declare function g_tree_new_with_data (byval key_compare_func as GCompareDataFunc, byval key_compare_data as gpointer) as GTree ptr
declare function g_tree_new_full (byval key_compare_func as GCompareDataFunc, byval key_compare_data as gpointer, byval key_destroy_func as GDestroyNotify, byval value_destroy_func as GDestroyNotify) as GTree ptr
declare sub g_tree_destroy (byval tree as GTree ptr)
declare sub g_tree_insert (byval tree as GTree ptr, byval key as gpointer, byval value as gpointer)
declare sub g_tree_replace (byval tree as GTree ptr, byval key as gpointer, byval value as gpointer)
declare sub g_tree_remove (byval tree as GTree ptr, byval key as gconstpointer)
declare sub g_tree_steal (byval tree as GTree ptr, byval key as gconstpointer)
declare function g_tree_lookup (byval tree as GTree ptr, byval key as gconstpointer) as gpointer
declare function g_tree_lookup_extended (byval tree as GTree ptr, byval lookup_key as gconstpointer, byval orig_key as gpointer ptr, byval value as gpointer ptr) as gboolean
declare sub g_tree_foreach (byval tree as GTree ptr, byval func as GTraverseFunc, byval user_data as gpointer)
declare sub g_tree_traverse (byval tree as GTree ptr, byval traverse_func as GTraverseFunc, byval traverse_type as GTraverseType, byval user_data as gpointer)
declare function g_tree_search (byval tree as GTree ptr, byval search_func as GCompareFunc, byval user_data as gconstpointer) as gpointer
declare function g_tree_height (byval tree as GTree ptr) as gint
declare function g_tree_nnodes (byval tree as GTree ptr) as gint

#endif
