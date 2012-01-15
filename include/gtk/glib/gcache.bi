''
''
'' gcache -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gcache_bi__
#define __gcache_bi__

#include once "glist.bi"

type GCache as _GCache
type GCacheNewFunc as function cdecl(byval as gpointer) as gpointer
type GCacheDupFunc as function cdecl(byval as gpointer) as gpointer
type GCacheDestroyFunc as sub cdecl(byval as gpointer)

declare function g_cache_new (byval value_new_func as GCacheNewFunc, byval value_destroy_func as GCacheDestroyFunc, byval key_dup_func as GCacheDupFunc, byval key_destroy_func as GCacheDestroyFunc, byval hash_key_func as GHashFunc, byval hash_value_func as GHashFunc, byval key_equal_func as GEqualFunc) as GCache ptr
declare sub g_cache_destroy (byval cache as GCache ptr)
declare function g_cache_insert (byval cache as GCache ptr, byval key as gpointer) as gpointer
declare sub g_cache_remove (byval cache as GCache ptr, byval value as gconstpointer)
declare sub g_cache_key_foreach (byval cache as GCache ptr, byval func as GHFunc, byval user_data as gpointer)
declare sub g_cache_value_foreach (byval cache as GCache ptr, byval func as GHFunc, byval user_data as gpointer)

#endif
