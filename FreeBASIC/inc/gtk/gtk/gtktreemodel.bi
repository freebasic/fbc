''
''
'' gtktreemodel -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktreemodel_bi__
#define __gtktreemodel_bi__

#include once "gtk/glib-object.bi"
#include once "gtk/gtk/gtkobject.bi"

type GtkTreeIter as _GtkTreeIter
type GtkTreePath as _GtkTreePath
type GtkTreeRowReference as _GtkTreeRowReference
type GtkTreeModel as _GtkTreeModel
type GtkTreeModelIface as _GtkTreeModelIface
type GtkTreeModelForeachFunc as function cdecl(byval as GtkTreeModel ptr, byval as GtkTreePath ptr, byval as GtkTreeIter ptr, byval as gpointer) as gboolean

enum GtkTreeModelFlags
	GTK_TREE_MODEL_ITERS_PERSIST = 1 shl 0
	GTK_TREE_MODEL_LIST_ONLY = 1 shl 1
end enum


type _GtkTreeIter
	stamp as gint
	user_data as gpointer
	user_data2 as gpointer
	user_data3 as gpointer
end type

type _GtkTreeModelIface
	g_iface as GTypeInterface
	row_changed as sub cdecl(byval as GtkTreeModel ptr, byval as GtkTreePath ptr, byval as GtkTreeIter ptr)
	row_inserted as sub cdecl(byval as GtkTreeModel ptr, byval as GtkTreePath ptr, byval as GtkTreeIter ptr)
	row_has_child_toggled as sub cdecl(byval as GtkTreeModel ptr, byval as GtkTreePath ptr, byval as GtkTreeIter ptr)
	row_deleted as sub cdecl(byval as GtkTreeModel ptr, byval as GtkTreePath ptr)
	rows_reordered as sub cdecl(byval as GtkTreeModel ptr, byval as GtkTreePath ptr, byval as GtkTreeIter ptr, byval as gint ptr)
	get_flags as function cdecl(byval as GtkTreeModel ptr) as GtkTreeModelFlags
	get_n_columns as function cdecl(byval as GtkTreeModel ptr) as gint
	get_column_type as function cdecl(byval as GtkTreeModel ptr, byval as gint) as GType
	get_iter as function cdecl(byval as GtkTreeModel ptr, byval as GtkTreeIter ptr, byval as GtkTreePath ptr) as gboolean
	get_path as function cdecl(byval as GtkTreeModel ptr, byval as GtkTreeIter ptr) as GtkTreePath ptr
	get_value as sub cdecl(byval as GtkTreeModel ptr, byval as GtkTreeIter ptr, byval as gint, byval as GValue ptr)
	iter_next as function cdecl(byval as GtkTreeModel ptr, byval as GtkTreeIter ptr) as gboolean
	iter_children as function cdecl(byval as GtkTreeModel ptr, byval as GtkTreeIter ptr, byval as GtkTreeIter ptr) as gboolean
	iter_has_child as function cdecl(byval as GtkTreeModel ptr, byval as GtkTreeIter ptr) as gboolean
	iter_n_children as function cdecl(byval as GtkTreeModel ptr, byval as GtkTreeIter ptr) as gint
	iter_nth_child as function cdecl(byval as GtkTreeModel ptr, byval as GtkTreeIter ptr, byval as GtkTreeIter ptr, byval as gint) as gboolean
	iter_parent as function cdecl(byval as GtkTreeModel ptr, byval as GtkTreeIter ptr, byval as GtkTreeIter ptr) as gboolean
	ref_node as sub cdecl(byval as GtkTreeModel ptr, byval as GtkTreeIter ptr)
	unref_node as sub cdecl(byval as GtkTreeModel ptr, byval as GtkTreeIter ptr)
end type

declare function gtk_tree_path_new cdecl alias "gtk_tree_path_new" () as GtkTreePath ptr
declare function gtk_tree_path_new_from_string cdecl alias "gtk_tree_path_new_from_string" (byval path as zstring ptr) as GtkTreePath ptr
declare function gtk_tree_path_new_from_indices cdecl alias "gtk_tree_path_new_from_indices" (byval first_index as gint, ...) as GtkTreePath ptr
declare function gtk_tree_path_to_string cdecl alias "gtk_tree_path_to_string" (byval path as GtkTreePath ptr) as zstring ptr
declare function gtk_tree_path_new_first cdecl alias "gtk_tree_path_new_first" () as GtkTreePath ptr
declare sub gtk_tree_path_append_index cdecl alias "gtk_tree_path_append_index" (byval path as GtkTreePath ptr, byval index_ as gint)
declare sub gtk_tree_path_prepend_index cdecl alias "gtk_tree_path_prepend_index" (byval path as GtkTreePath ptr, byval index_ as gint)
declare function gtk_tree_path_get_depth cdecl alias "gtk_tree_path_get_depth" (byval path as GtkTreePath ptr) as gint
declare function gtk_tree_path_get_indices cdecl alias "gtk_tree_path_get_indices" (byval path as GtkTreePath ptr) as gint ptr
declare sub gtk_tree_path_free cdecl alias "gtk_tree_path_free" (byval path as GtkTreePath ptr)
declare function gtk_tree_path_copy cdecl alias "gtk_tree_path_copy" (byval path as GtkTreePath ptr) as GtkTreePath ptr
declare function gtk_tree_path_get_type cdecl alias "gtk_tree_path_get_type" () as GType
declare function gtk_tree_path_compare cdecl alias "gtk_tree_path_compare" (byval a as GtkTreePath ptr, byval b as GtkTreePath ptr) as gint
declare sub gtk_tree_path_next cdecl alias "gtk_tree_path_next" (byval path as GtkTreePath ptr)
declare function gtk_tree_path_prev cdecl alias "gtk_tree_path_prev" (byval path as GtkTreePath ptr) as gboolean
declare function gtk_tree_path_up cdecl alias "gtk_tree_path_up" (byval path as GtkTreePath ptr) as gboolean
declare sub gtk_tree_path_down cdecl alias "gtk_tree_path_down" (byval path as GtkTreePath ptr)
declare function gtk_tree_path_is_ancestor cdecl alias "gtk_tree_path_is_ancestor" (byval path as GtkTreePath ptr, byval descendant as GtkTreePath ptr) as gboolean
declare function gtk_tree_path_is_descendant cdecl alias "gtk_tree_path_is_descendant" (byval path as GtkTreePath ptr, byval ancestor as GtkTreePath ptr) as gboolean
declare function gtk_tree_row_reference_get_type cdecl alias "gtk_tree_row_reference_get_type" () as GType
declare function gtk_tree_row_reference_new cdecl alias "gtk_tree_row_reference_new" (byval model as GtkTreeModel ptr, byval path as GtkTreePath ptr) as GtkTreeRowReference ptr
declare function gtk_tree_row_reference_new_proxy cdecl alias "gtk_tree_row_reference_new_proxy" (byval proxy as GObject ptr, byval model as GtkTreeModel ptr, byval path as GtkTreePath ptr) as GtkTreeRowReference ptr
declare function gtk_tree_row_reference_get_path cdecl alias "gtk_tree_row_reference_get_path" (byval reference as GtkTreeRowReference ptr) as GtkTreePath ptr
declare function gtk_tree_row_reference_valid cdecl alias "gtk_tree_row_reference_valid" (byval reference as GtkTreeRowReference ptr) as gboolean
declare function gtk_tree_row_reference_copy cdecl alias "gtk_tree_row_reference_copy" (byval reference as GtkTreeRowReference ptr) as GtkTreeRowReference ptr
declare sub gtk_tree_row_reference_free cdecl alias "gtk_tree_row_reference_free" (byval reference as GtkTreeRowReference ptr)
declare sub gtk_tree_row_reference_inserted cdecl alias "gtk_tree_row_reference_inserted" (byval proxy as GObject ptr, byval path as GtkTreePath ptr)
declare sub gtk_tree_row_reference_deleted cdecl alias "gtk_tree_row_reference_deleted" (byval proxy as GObject ptr, byval path as GtkTreePath ptr)
declare sub gtk_tree_row_reference_reordered cdecl alias "gtk_tree_row_reference_reordered" (byval proxy as GObject ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr, byval new_order as gint ptr)
declare function gtk_tree_iter_copy cdecl alias "gtk_tree_iter_copy" (byval iter as GtkTreeIter ptr) as GtkTreeIter ptr
declare sub gtk_tree_iter_free cdecl alias "gtk_tree_iter_free" (byval iter as GtkTreeIter ptr)
declare function gtk_tree_iter_get_type cdecl alias "gtk_tree_iter_get_type" () as GType
declare function gtk_tree_model_get_type cdecl alias "gtk_tree_model_get_type" () as GType
declare function gtk_tree_model_get_flags cdecl alias "gtk_tree_model_get_flags" (byval tree_model as GtkTreeModel ptr) as GtkTreeModelFlags
declare function gtk_tree_model_get_n_columns cdecl alias "gtk_tree_model_get_n_columns" (byval tree_model as GtkTreeModel ptr) as gint
declare function gtk_tree_model_get_column_type cdecl alias "gtk_tree_model_get_column_type" (byval tree_model as GtkTreeModel ptr, byval index_ as gint) as GType
declare function gtk_tree_model_get_iter cdecl alias "gtk_tree_model_get_iter" (byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval path as GtkTreePath ptr) as gboolean
declare function gtk_tree_model_get_iter_from_string cdecl alias "gtk_tree_model_get_iter_from_string" (byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval path_string as zstring ptr) as gboolean
declare function gtk_tree_model_get_string_from_iter cdecl alias "gtk_tree_model_get_string_from_iter" (byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as zstring ptr
declare function gtk_tree_model_get_iter_first cdecl alias "gtk_tree_model_get_iter_first" (byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as gboolean
declare function gtk_tree_model_get_path cdecl alias "gtk_tree_model_get_path" (byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as GtkTreePath ptr
declare sub gtk_tree_model_get_value cdecl alias "gtk_tree_model_get_value" (byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval column as gint, byval value as GValue ptr)
declare function gtk_tree_model_iter_next cdecl alias "gtk_tree_model_iter_next" (byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as gboolean
declare function gtk_tree_model_iter_children cdecl alias "gtk_tree_model_iter_children" (byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval parent as GtkTreeIter ptr) as gboolean
declare function gtk_tree_model_iter_has_child cdecl alias "gtk_tree_model_iter_has_child" (byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as gboolean
declare function gtk_tree_model_iter_n_children cdecl alias "gtk_tree_model_iter_n_children" (byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as gint
declare function gtk_tree_model_iter_nth_child cdecl alias "gtk_tree_model_iter_nth_child" (byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval parent as GtkTreeIter ptr, byval n as gint) as gboolean
declare function gtk_tree_model_iter_parent cdecl alias "gtk_tree_model_iter_parent" (byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval child as GtkTreeIter ptr) as gboolean
declare sub gtk_tree_model_ref_node cdecl alias "gtk_tree_model_ref_node" (byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_tree_model_unref_node cdecl alias "gtk_tree_model_unref_node" (byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_tree_model_get cdecl alias "gtk_tree_model_get" (byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, ...)
''''''' declare sub gtk_tree_model_get_valist cdecl alias "gtk_tree_model_get_valist" (byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval var_args as va_list)
declare sub gtk_tree_model_foreach cdecl alias "gtk_tree_model_foreach" (byval model as GtkTreeModel ptr, byval func as GtkTreeModelForeachFunc, byval user_data as gpointer)
declare sub gtk_tree_model_row_changed cdecl alias "gtk_tree_model_row_changed" (byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_tree_model_row_inserted cdecl alias "gtk_tree_model_row_inserted" (byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_tree_model_row_has_child_toggled cdecl alias "gtk_tree_model_row_has_child_toggled" (byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_tree_model_row_deleted cdecl alias "gtk_tree_model_row_deleted" (byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr)
declare sub gtk_tree_model_rows_reordered cdecl alias "gtk_tree_model_rows_reordered" (byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr, byval new_order as gint ptr)

#define gtk_tree_path_new_root() gtk_tree_path_new_first()
#define gtk_tree_model_get_iter_root(tree_model, iter) gtk_tree_model_get_iter_first(tree_model, iter)

#endif
