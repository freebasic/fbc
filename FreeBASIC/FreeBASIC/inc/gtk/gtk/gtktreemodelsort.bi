''
''
'' gtktreemodelsort -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktreemodelsort_bi__
#define __gtktreemodelsort_bi__

#include once "gtktreemodel.bi"
#include once "gtktreesortable.bi"

#define GTK_TYPE_TREE_MODEL_SORT (gtk_tree_model_sort_get_type ())
#define GTK_TREE_MODEL_SORT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TREE_MODEL_SORT, GtkTreeModelSort))
#define GTK_TREE_MODEL_SORT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TREE_MODEL_SORT, GtkTreeModelSortClass))
#define GTK_IS_TREE_MODEL_SORT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TREE_MODEL_SORT))
#define GTK_IS_TREE_MODEL_SORT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TREE_MODEL_SORT))
#define GTK_TREE_MODEL_SORT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TREE_MODEL_SORT, GtkTreeModelSortClass))

type GtkTreeModelSort as _GtkTreeModelSort
type GtkTreeModelSortClass as _GtkTreeModelSortClass

type _GtkTreeModelSort
	parent as GObject
	root as gpointer
	stamp as gint
	child_flags as guint
	child_model as GtkTreeModel ptr
	zero_ref_count as gint
	sort_list as GList ptr
	sort_column_id as gint
	order as GtkSortType
	default_sort_func as GtkTreeIterCompareFunc
	default_sort_data as gpointer
	default_sort_destroy as GtkDestroyNotify
	changed_id as guint
	inserted_id as guint
	has_child_toggled_id as guint
	deleted_id as guint
	reordered_id as guint
end type

type _GtkTreeModelSortClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_tree_model_sort_get_type () as GType
declare function gtk_tree_model_sort_new_with_model (byval child_model as GtkTreeModel ptr) as GtkTreeModel ptr
declare function gtk_tree_model_sort_get_model (byval tree_model as GtkTreeModelSort ptr) as GtkTreeModel ptr
declare function gtk_tree_model_sort_convert_child_path_to_path (byval tree_model_sort as GtkTreeModelSort ptr, byval child_path as GtkTreePath ptr) as GtkTreePath ptr
declare sub gtk_tree_model_sort_convert_child_iter_to_iter (byval tree_model_sort as GtkTreeModelSort ptr, byval sort_iter as GtkTreeIter ptr, byval child_iter as GtkTreeIter ptr)
declare function gtk_tree_model_sort_convert_path_to_child_path (byval tree_model_sort as GtkTreeModelSort ptr, byval sorted_path as GtkTreePath ptr) as GtkTreePath ptr
declare sub gtk_tree_model_sort_convert_iter_to_child_iter (byval tree_model_sort as GtkTreeModelSort ptr, byval child_iter as GtkTreeIter ptr, byval sorted_iter as GtkTreeIter ptr)
declare sub gtk_tree_model_sort_reset_default_sort_func (byval tree_model_sort as GtkTreeModelSort ptr)
declare sub gtk_tree_model_sort_clear_cache (byval tree_model_sort as GtkTreeModelSort ptr)
declare function gtk_tree_model_sort_iter_is_valid (byval tree_model_sort as GtkTreeModelSort ptr, byval iter as GtkTreeIter ptr) as gboolean

#endif
