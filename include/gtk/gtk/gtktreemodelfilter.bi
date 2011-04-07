''
''
'' gtktreemodelfilter -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktreemodelfilter_bi__
#define __gtktreemodelfilter_bi__

#include once "gtktreemodel.bi"

#define GTK_TYPE_TREE_MODEL_FILTER (gtk_tree_model_filter_get_type ())
#define GTK_TREE_MODEL_FILTER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TREE_MODEL_FILTER, GtkTreeModelFilter))
#define GTK_TREE_MODEL_FILTER_CLASS(vtable) (G_TYPE_CHECK_CLASS_CAST ((vtable), GTK_TYPE_TREE_MODEL_FILTER, GtkTreeModelFilterClass))
#define GTK_IS_TREE_MODEL_FILTER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TREE_MODEL_FILTER))
#define GTK_IS_TREE_MODEL_FILTER_CLASS(vtable) (G_TYPE_CHECK_CLASS_TYPE ((vtable), GTK_TYPE_TREE_MODEL_FILTER))
#define GTK_TREE_MODEL_FILTER_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TREE_MODEL_FILTER, GtkTreeModelFilterClass))

type GtkTreeModelFilterVisibleFunc as function cdecl(byval as GtkTreeModel ptr, byval as GtkTreeIter ptr, byval as gpointer) as gboolean
type GtkTreeModelFilterModifyFunc as sub cdecl(byval as GtkTreeModel ptr, byval as GtkTreeIter ptr, byval as GValue ptr, byval as gint, byval as gpointer)
type GtkTreeModelFilter as _GtkTreeModelFilter
type GtkTreeModelFilterClass as _GtkTreeModelFilterClass
type GtkTreeModelFilterPrivate as _GtkTreeModelFilterPrivate

type _GtkTreeModelFilter
	parent as GObject
	priv as GtkTreeModelFilterPrivate ptr
end type

type _GtkTreeModelFilterClass
	parent_class as GObjectClass
	_gtk_reserved0 as sub cdecl()
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
end type

declare function gtk_tree_model_filter_get_type () as GType
declare function gtk_tree_model_filter_new (byval child_model as GtkTreeModel ptr, byval root as GtkTreePath ptr) as GtkTreeModel ptr
declare sub gtk_tree_model_filter_set_visible_func (byval filter as GtkTreeModelFilter ptr, byval func as GtkTreeModelFilterVisibleFunc, byval data as gpointer, byval destroy as GtkDestroyNotify)
declare sub gtk_tree_model_filter_set_modify_func (byval filter as GtkTreeModelFilter ptr, byval n_columns as gint, byval types as GType ptr, byval func as GtkTreeModelFilterModifyFunc, byval data as gpointer, byval destroy as GtkDestroyNotify)
declare sub gtk_tree_model_filter_set_visible_column (byval filter as GtkTreeModelFilter ptr, byval column as gint)
declare function gtk_tree_model_filter_get_model (byval filter as GtkTreeModelFilter ptr) as GtkTreeModel ptr
declare sub gtk_tree_model_filter_convert_child_iter_to_iter (byval filter as GtkTreeModelFilter ptr, byval filter_iter as GtkTreeIter ptr, byval child_iter as GtkTreeIter ptr)
declare sub gtk_tree_model_filter_convert_iter_to_child_iter (byval filter as GtkTreeModelFilter ptr, byval child_iter as GtkTreeIter ptr, byval filter_iter as GtkTreeIter ptr)
declare function gtk_tree_model_filter_convert_child_path_to_path (byval filter as GtkTreeModelFilter ptr, byval child_path as GtkTreePath ptr) as GtkTreePath ptr
declare function gtk_tree_model_filter_convert_path_to_child_path (byval filter as GtkTreeModelFilter ptr, byval filter_path as GtkTreePath ptr) as GtkTreePath ptr
declare sub gtk_tree_model_filter_refilter (byval filter as GtkTreeModelFilter ptr)
declare sub gtk_tree_model_filter_clear_cache (byval filter as GtkTreeModelFilter ptr)

#endif
