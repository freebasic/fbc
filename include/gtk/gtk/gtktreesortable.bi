''
''
'' gtktreesortable -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktreesortable_bi__
#define __gtktreesortable_bi__

#include once "gtkenums.bi"
#include once "gtktreemodel.bi"
#include once "gtktypeutils.bi"

#define GTK_TYPE_TREE_SORTABLE (gtk_tree_sortable_get_type ())
#define GTK_TREE_SORTABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TREE_SORTABLE, GtkTreeSortable))
#define GTK_TREE_SORTABLE_CLASS(obj) (G_TYPE_CHECK_CLASS_CAST ((obj), GTK_TYPE_TREE_SORTABLE, GtkTreeSortableIface))
#define GTK_IS_TREE_SORTABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TREE_SORTABLE))
#define GTK_TREE_SORTABLE_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GTK_TYPE_TREE_SORTABLE, GtkTreeSortableIface))

enum 
	GTK_TREE_SORTABLE_DEFAULT_SORT_COLUMN_ID = -1
	GTK_TREE_SORTABLE_UNSORTED_SORT_COLUMN_ID = -2
end enum

type GtkTreeSortable as _GtkTreeSortable
type GtkTreeSortableIface as _GtkTreeSortableIface
type GtkTreeIterCompareFunc as function cdecl(byval as GtkTreeModel ptr, byval as GtkTreeIter ptr, byval as GtkTreeIter ptr, byval as gpointer) as gint

type _GtkTreeSortableIface
	g_iface as GTypeInterface
	sort_column_changed as sub cdecl(byval as GtkTreeSortable ptr)
	get_sort_column_id as function cdecl(byval as GtkTreeSortable ptr, byval as gint ptr, byval as GtkSortType ptr) as gboolean
	set_sort_column_id as sub cdecl(byval as GtkTreeSortable ptr, byval as gint, byval as GtkSortType)
	set_sort_func as sub cdecl(byval as GtkTreeSortable ptr, byval as gint, byval as GtkTreeIterCompareFunc, byval as gpointer, byval as GtkDestroyNotify)
	set_default_sort_func as sub cdecl(byval as GtkTreeSortable ptr, byval as GtkTreeIterCompareFunc, byval as gpointer, byval as GtkDestroyNotify)
	has_default_sort_func as function cdecl(byval as GtkTreeSortable ptr) as gboolean
end type

declare function gtk_tree_sortable_get_type () as GType
declare sub gtk_tree_sortable_sort_column_changed (byval sortable as GtkTreeSortable ptr)
declare function gtk_tree_sortable_get_sort_column_id (byval sortable as GtkTreeSortable ptr, byval sort_column_id as gint ptr, byval order as GtkSortType ptr) as gboolean
declare sub gtk_tree_sortable_set_sort_column_id (byval sortable as GtkTreeSortable ptr, byval sort_column_id as gint, byval order as GtkSortType)
declare sub gtk_tree_sortable_set_sort_func (byval sortable as GtkTreeSortable ptr, byval sort_column_id as gint, byval sort_func as GtkTreeIterCompareFunc, byval user_data as gpointer, byval destroy as GtkDestroyNotify)
declare sub gtk_tree_sortable_set_default_sort_func (byval sortable as GtkTreeSortable ptr, byval sort_func as GtkTreeIterCompareFunc, byval user_data as gpointer, byval destroy as GtkDestroyNotify)
declare function gtk_tree_sortable_has_default_sort_func (byval sortable as GtkTreeSortable ptr) as gboolean

#endif
