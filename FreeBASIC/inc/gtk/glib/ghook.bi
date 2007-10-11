''
''
'' ghook -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ghook_bi__
#define __ghook_bi__

#include once "gmem.bi"

type GHook as _GHook
type GHookList as _GHookList
type GHookCompareFunc as function cdecl(byval as GHook ptr, byval as GHook ptr) as gint
type GHookFindFunc as function cdecl(byval as GHook ptr, byval as gpointer) as gboolean
type GHookMarshaller as sub cdecl(byval as GHook ptr, byval as gpointer)
type GHookCheckMarshaller as function cdecl(byval as GHook ptr, byval as gpointer) as gboolean
type GHookFunc as sub cdecl(byval as gpointer)
type GHookCheckFunc as function cdecl(byval as gpointer) as gboolean
type GHookFinalizeFunc as sub cdecl(byval as GHookList ptr, byval as GHook ptr)

enum GHookFlagMask
	G_HOOK_FLAG_ACTIVE = 1 shl 0
	G_HOOK_FLAG_IN_CALL = 1 shl 1
	G_HOOK_FLAG_MASK = &h0f
end enum


#define G_HOOK_FLAG_USER_SHIFT (4)

type _GHookList
	seq_id as gulong
	hook_size:16 as guint
	is_setup:1 as guint
	hooks as GHook ptr
	hook_memchunk as GMemChunk ptr
	finalize_hook as GHookFinalizeFunc
	dummy(0 to 2-1) as gpointer
end type

type _GHook
	data as gpointer
	next as GHook ptr
	prev as GHook ptr
	ref_count as guint
	hook_id as gulong
	flags as guint
	func as gpointer
	destroy as GDestroyNotify
end type

declare sub g_hook_list_init (byval hook_list as GHookList ptr, byval hook_size as guint)
declare sub g_hook_list_clear (byval hook_list as GHookList ptr)
declare function g_hook_alloc (byval hook_list as GHookList ptr) as GHook ptr
declare sub g_hook_free (byval hook_list as GHookList ptr, byval hook as GHook ptr)
declare function g_hook_ref (byval hook_list as GHookList ptr, byval hook as GHook ptr) as GHook ptr
declare sub g_hook_unref (byval hook_list as GHookList ptr, byval hook as GHook ptr)
declare function g_hook_destroy (byval hook_list as GHookList ptr, byval hook_id as gulong) as gboolean
declare sub g_hook_destroy_link (byval hook_list as GHookList ptr, byval hook as GHook ptr)
declare sub g_hook_prepend (byval hook_list as GHookList ptr, byval hook as GHook ptr)
declare sub g_hook_insert_before (byval hook_list as GHookList ptr, byval sibling as GHook ptr, byval hook as GHook ptr)
declare sub g_hook_insert_sorted (byval hook_list as GHookList ptr, byval hook as GHook ptr, byval func as GHookCompareFunc)
declare function g_hook_get (byval hook_list as GHookList ptr, byval hook_id as gulong) as GHook ptr
declare function g_hook_find (byval hook_list as GHookList ptr, byval need_valids as gboolean, byval func as GHookFindFunc, byval data as gpointer) as GHook ptr
declare function g_hook_find_data (byval hook_list as GHookList ptr, byval need_valids as gboolean, byval data as gpointer) as GHook ptr
declare function g_hook_find_func (byval hook_list as GHookList ptr, byval need_valids as gboolean, byval func as gpointer) as GHook ptr
declare function g_hook_find_func_data (byval hook_list as GHookList ptr, byval need_valids as gboolean, byval func as gpointer, byval data as gpointer) as GHook ptr
declare function g_hook_first_valid (byval hook_list as GHookList ptr, byval may_be_in_call as gboolean) as GHook ptr
declare function g_hook_next_valid (byval hook_list as GHookList ptr, byval hook as GHook ptr, byval may_be_in_call as gboolean) as GHook ptr
declare function g_hook_compare_ids (byval new_hook as GHook ptr, byval sibling as GHook ptr) as gint
declare sub g_hook_list_invoke (byval hook_list as GHookList ptr, byval may_recurse as gboolean)
declare sub g_hook_list_invoke_check (byval hook_list as GHookList ptr, byval may_recurse as gboolean)
declare sub g_hook_list_marshal (byval hook_list as GHookList ptr, byval may_recurse as gboolean, byval marshaller as GHookMarshaller, byval marshal_data as gpointer)
declare sub g_hook_list_marshal_check (byval hook_list as GHookList ptr, byval may_recurse as gboolean, byval marshaller as GHookCheckMarshaller, byval marshal_data as gpointer)

#endif
