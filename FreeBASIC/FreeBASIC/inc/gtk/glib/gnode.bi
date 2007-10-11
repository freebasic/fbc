''
''
'' gnode -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gnode_bi__
#define __gnode_bi__

#include once "gmem.bi"

type GNode as _GNode

enum GTraverseFlags
	G_TRAVERSE_LEAVES = 1 shl 0
	G_TRAVERSE_NON_LEAVES = 1 shl 1
	G_TRAVERSE_ALL = G_TRAVERSE_LEAVES or G_TRAVERSE_NON_LEAVES
	G_TRAVERSE_MASK = &h03
	G_TRAVERSE_LEAFS = G_TRAVERSE_LEAVES
	G_TRAVERSE_NON_LEAFS = G_TRAVERSE_NON_LEAVES
end enum


enum GTraverseType
	G_IN_ORDER
	G_PRE_ORDER
	G_POST_ORDER
	G_LEVEL_ORDER
end enum

type GNodeTraverseFunc as function cdecl(byval as GNode ptr, byval as gpointer) as gboolean
type GNodeForeachFunc as sub cdecl(byval as GNode ptr, byval as gpointer)
type GCopyFunc as function cdecl(byval as gconstpointer, byval as gpointer) as gpointer

type _GNode
	data as gpointer
	next as GNode ptr
	prev as GNode ptr
	parent as GNode ptr
	children as GNode ptr
end type

declare sub g_node_push_allocator (byval allocator as GAllocator ptr)
declare sub g_node_pop_allocator ()
declare function g_node_new (byval data as gpointer) as GNode ptr
declare sub g_node_destroy (byval root as GNode ptr)
declare sub g_node_unlink (byval node as GNode ptr)
declare function g_node_copy_deep (byval node as GNode ptr, byval copy_func as GCopyFunc, byval data as gpointer) as GNode ptr
declare function g_node_copy (byval node as GNode ptr) as GNode ptr
declare function g_node_insert (byval parent as GNode ptr, byval position as gint, byval node as GNode ptr) as GNode ptr
declare function g_node_insert_before (byval parent as GNode ptr, byval sibling as GNode ptr, byval node as GNode ptr) as GNode ptr
declare function g_node_insert_after (byval parent as GNode ptr, byval sibling as GNode ptr, byval node as GNode ptr) as GNode ptr
declare function g_node_prepend (byval parent as GNode ptr, byval node as GNode ptr) as GNode ptr
declare function g_node_n_nodes (byval root as GNode ptr, byval flags as GTraverseFlags) as guint
declare function g_node_get_root (byval node as GNode ptr) as GNode ptr
declare function g_node_is_ancestor (byval node as GNode ptr, byval descendant as GNode ptr) as gboolean
declare function g_node_depth (byval node as GNode ptr) as guint
declare function g_node_find (byval root as GNode ptr, byval order as GTraverseType, byval flags as GTraverseFlags, byval data as gpointer) as GNode ptr
declare sub g_node_traverse (byval root as GNode ptr, byval order as GTraverseType, byval flags as GTraverseFlags, byval max_depth as gint, byval func as GNodeTraverseFunc, byval data as gpointer)
declare function g_node_max_height (byval root as GNode ptr) as guint
declare sub g_node_children_foreach (byval node as GNode ptr, byval flags as GTraverseFlags, byval func as GNodeForeachFunc, byval data as gpointer)
declare sub g_node_reverse_children (byval node as GNode ptr)
declare function g_node_n_children (byval node as GNode ptr) as guint
declare function g_node_nth_child (byval node as GNode ptr, byval n as guint) as GNode ptr
declare function g_node_last_child (byval node as GNode ptr) as GNode ptr
declare function g_node_find_child (byval node as GNode ptr, byval flags as GTraverseFlags, byval data as gpointer) as GNode ptr
declare function g_node_child_position (byval node as GNode ptr, byval child as GNode ptr) as gint
declare function g_node_child_index (byval node as GNode ptr, byval data as gpointer) as gint
declare function g_node_first_sibling (byval node as GNode ptr) as GNode ptr
declare function g_node_last_sibling (byval node as GNode ptr) as GNode ptr

#endif
