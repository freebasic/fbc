''
''
'' gtktreestore -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktreestore_bi__
#define __gtktreestore_bi__

#include once "gtk/gtk/gtktreemodel.bi"
#include once "gtk/gtk/gtktreesortable.bi"

type GtkTreeStore as _GtkTreeStore
type GtkTreeStoreClass as _GtkTreeStoreClass

type _GtkTreeStore
	parent as GObject
	stamp as gint
	root as gpointer
	last as gpointer
	n_columns as gint
	sort_column_id as gint
	sort_list as GList ptr
	order as GtkSortType
	column_headers as GType ptr
	default_sort_func as GtkTreeIterCompareFunc
	default_sort_data as gpointer
	default_sort_destroy as GtkDestroyNotify
	columns_dirty as guint
end type

type _GtkTreeStoreClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_tree_store_get_type cdecl alias "gtk_tree_store_get_type" () as GType
declare function gtk_tree_store_new cdecl alias "gtk_tree_store_new" (byval n_columns as gint, ...) as GtkTreeStore ptr
declare function gtk_tree_store_newv cdecl alias "gtk_tree_store_newv" (byval n_columns as gint, byval types as GType ptr) as GtkTreeStore ptr
declare sub gtk_tree_store_set_column_types cdecl alias "gtk_tree_store_set_column_types" (byval tree_store as GtkTreeStore ptr, byval n_columns as gint, byval types as GType ptr)
declare sub gtk_tree_store_set_value cdecl alias "gtk_tree_store_set_value" (byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval column as gint, byval value as GValue ptr)
declare sub gtk_tree_store_set cdecl alias "gtk_tree_store_set" (byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, ...)
''''''' declare sub gtk_tree_store_set_valist cdecl alias "gtk_tree_store_set_valist" (byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval var_args as va_list)
declare function gtk_tree_store_remove cdecl alias "gtk_tree_store_remove" (byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr) as gboolean
declare sub gtk_tree_store_insert cdecl alias "gtk_tree_store_insert" (byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval parent as GtkTreeIter ptr, byval position as gint)
declare sub gtk_tree_store_insert_before cdecl alias "gtk_tree_store_insert_before" (byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval parent as GtkTreeIter ptr, byval sibling as GtkTreeIter ptr)
declare sub gtk_tree_store_insert_after cdecl alias "gtk_tree_store_insert_after" (byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval parent as GtkTreeIter ptr, byval sibling as GtkTreeIter ptr)
declare sub gtk_tree_store_prepend cdecl alias "gtk_tree_store_prepend" (byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval parent as GtkTreeIter ptr)
declare sub gtk_tree_store_append cdecl alias "gtk_tree_store_append" (byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval parent as GtkTreeIter ptr)
declare function gtk_tree_store_is_ancestor cdecl alias "gtk_tree_store_is_ancestor" (byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval descendant as GtkTreeIter ptr) as gboolean
declare function gtk_tree_store_iter_depth cdecl alias "gtk_tree_store_iter_depth" (byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr) as gint
declare sub gtk_tree_store_clear cdecl alias "gtk_tree_store_clear" (byval tree_store as GtkTreeStore ptr)
declare function gtk_tree_store_iter_is_valid cdecl alias "gtk_tree_store_iter_is_valid" (byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr) as gboolean
declare sub gtk_tree_store_reorder cdecl alias "gtk_tree_store_reorder" (byval tree_store as GtkTreeStore ptr, byval parent as GtkTreeIter ptr, byval new_order as gint ptr)
declare sub gtk_tree_store_swap cdecl alias "gtk_tree_store_swap" (byval tree_store as GtkTreeStore ptr, byval a as GtkTreeIter ptr, byval b as GtkTreeIter ptr)
declare sub gtk_tree_store_move_before cdecl alias "gtk_tree_store_move_before" (byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval position as GtkTreeIter ptr)
declare sub gtk_tree_store_move_after cdecl alias "gtk_tree_store_move_after" (byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval position as GtkTreeIter ptr)

#endif
