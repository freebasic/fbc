''
''
'' ghash -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ghash_bi__
#define __ghash_bi__

#include once "gtypes.bi"

type GHashTable as _GHashTable
type GHRFunc as function cdecl(byval as gpointer, byval as gpointer, byval as gpointer) as gboolean

declare function g_hash_table_new (byval hash_func as GHashFunc, byval key_equal_func as GEqualFunc) as GHashTable ptr
declare function g_hash_table_new_full (byval hash_func as GHashFunc, byval key_equal_func as GEqualFunc, byval key_destroy_func as GDestroyNotify, byval value_destroy_func as GDestroyNotify) as GHashTable ptr
declare sub g_hash_table_destroy (byval hash_table as GHashTable ptr)
declare sub g_hash_table_insert (byval hash_table as GHashTable ptr, byval key as gpointer, byval value as gpointer)
declare sub g_hash_table_replace (byval hash_table as GHashTable ptr, byval key as gpointer, byval value as gpointer)
declare function g_hash_table_remove (byval hash_table as GHashTable ptr, byval key as gconstpointer) as gboolean
declare function g_hash_table_steal (byval hash_table as GHashTable ptr, byval key as gconstpointer) as gboolean
declare function g_hash_table_lookup (byval hash_table as GHashTable ptr, byval key as gconstpointer) as gpointer
declare function g_hash_table_lookup_extended (byval hash_table as GHashTable ptr, byval lookup_key as gconstpointer, byval orig_key as gpointer ptr, byval value as gpointer ptr) as gboolean
declare sub g_hash_table_foreach (byval hash_table as GHashTable ptr, byval func as GHFunc, byval user_data as gpointer)
declare function g_hash_table_find (byval hash_table as GHashTable ptr, byval predicate as GHRFunc, byval user_data as gpointer) as gpointer
declare function g_hash_table_foreach_remove (byval hash_table as GHashTable ptr, byval func as GHRFunc, byval user_data as gpointer) as guint
declare function g_hash_table_foreach_steal (byval hash_table as GHashTable ptr, byval func as GHRFunc, byval user_data as gpointer) as guint
declare function g_hash_table_size (byval hash_table as GHashTable ptr) as guint
declare function g_str_equal (byval v as gconstpointer, byval v2 as gconstpointer) as gboolean
declare function g_str_hash (byval v as gconstpointer) as guint
declare function g_int_equal (byval v as gconstpointer, byval v2 as gconstpointer) as gboolean
declare function g_int_hash (byval v as gconstpointer) as guint
declare function g_direct_hash (byval v as gconstpointer) as guint
declare function g_direct_equal (byval v as gconstpointer, byval v2 as gconstpointer) as gboolean


#define g_hash_table_freeze(hash_table) 
#define g_hash_table_thaw(hash_table) 

#endif
