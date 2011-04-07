''
''
'' gtktreeviewcolumn -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktreeviewcolumn_bi__
#define __gtktreeviewcolumn_bi__

#include once "gtk/glib-object.bi"
#include once "gtkcellrenderer.bi"
#include once "gtktreemodel.bi"
#include once "gtktreesortable.bi"
#include once "gtkobject.bi"

#define GTK_TYPE_TREE_VIEW_COLUMN (gtk_tree_view_column_get_type ())
#define GTK_TREE_VIEW_COLUMN(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TREE_VIEW_COLUMN, GtkTreeViewColumn))
#define GTK_TREE_VIEW_COLUMN_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TREE_VIEW_COLUMN, GtkTreeViewColumnClass))
#define GTK_IS_TREE_VIEW_COLUMN(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TREE_VIEW_COLUMN))
#define GTK_IS_TREE_VIEW_COLUMN_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TREE_VIEW_COLUMN))
#define GTK_TREE_VIEW_COLUMN_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TREE_VIEW_COLUMN, GtkTreeViewColumnClass))

enum GtkTreeViewColumnSizing
	GTK_TREE_VIEW_COLUMN_GROW_ONLY
	GTK_TREE_VIEW_COLUMN_AUTOSIZE
	GTK_TREE_VIEW_COLUMN_FIXED
end enum

type GtkTreeViewColumn as _GtkTreeViewColumn
type GtkTreeViewColumnClass as _GtkTreeViewColumnClass
type GtkTreeCellDataFunc as sub cdecl(byval as GtkTreeViewColumn ptr, byval as GtkCellRenderer ptr, byval as GtkTreeModel ptr, byval as GtkTreeIter ptr, byval as gpointer)

type _GtkTreeViewColumn
	parent as GtkObject
	tree_view as GtkWidget ptr
	button as GtkWidget ptr
	child as GtkWidget ptr
	arrow as GtkWidget ptr
	alignment as GtkWidget ptr
	window as GdkWindow ptr
	editable_widget as GtkCellEditable ptr
	xalign as gfloat
	property_changed_signal as guint
	spacing as gint
	column_type as GtkTreeViewColumnSizing
	requested_width as gint
	button_request as gint
	resized_width as gint
	width as gint
	fixed_width as gint
	min_width as gint
	max_width as gint
	drag_x as gint
	drag_y as gint
	title as zstring ptr
	cell_list as GList ptr
	sort_clicked_signal as guint
	sort_column_changed_signal as guint
	sort_column_id as gint
	sort_order as GtkSortType
	visible:1 as guint
	resizable:1 as guint
	clickable:1 as guint
	dirty:1 as guint
	show_sort_indicator:1 as guint
	maybe_reordered:1 as guint
	reorderable:1 as guint
	use_resized_width:1 as guint
	expand:1 as guint
end type

type _GtkTreeViewColumnClass
	parent_class as GtkObjectClass
	clicked as sub cdecl(byval as GtkTreeViewColumn ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_tree_view_column_get_type () as GType
declare function gtk_tree_view_column_new () as GtkTreeViewColumn ptr
declare function gtk_tree_view_column_new_with_attributes (byval title as zstring ptr, byval cell as GtkCellRenderer ptr, ...) as GtkTreeViewColumn ptr
declare sub gtk_tree_view_column_pack_start (byval tree_column as GtkTreeViewColumn ptr, byval cell as GtkCellRenderer ptr, byval expand as gboolean)
declare sub gtk_tree_view_column_pack_end (byval tree_column as GtkTreeViewColumn ptr, byval cell as GtkCellRenderer ptr, byval expand as gboolean)
declare sub gtk_tree_view_column_clear (byval tree_column as GtkTreeViewColumn ptr)
declare function gtk_tree_view_column_get_cell_renderers (byval tree_column as GtkTreeViewColumn ptr) as GList ptr
declare sub gtk_tree_view_column_add_attribute (byval tree_column as GtkTreeViewColumn ptr, byval cell_renderer as GtkCellRenderer ptr, byval attribute as zstring ptr, byval column as gint)
declare sub gtk_tree_view_column_set_attributes (byval tree_column as GtkTreeViewColumn ptr, byval cell_renderer as GtkCellRenderer ptr, ...)
declare sub gtk_tree_view_column_set_cell_data_func (byval tree_column as GtkTreeViewColumn ptr, byval cell_renderer as GtkCellRenderer ptr, byval func as GtkTreeCellDataFunc, byval func_data as gpointer, byval destroy as GtkDestroyNotify)
declare sub gtk_tree_view_column_clear_attributes (byval tree_column as GtkTreeViewColumn ptr, byval cell_renderer as GtkCellRenderer ptr)
declare sub gtk_tree_view_column_set_spacing (byval tree_column as GtkTreeViewColumn ptr, byval spacing as gint)
declare function gtk_tree_view_column_get_spacing (byval tree_column as GtkTreeViewColumn ptr) as gint
declare sub gtk_tree_view_column_set_visible (byval tree_column as GtkTreeViewColumn ptr, byval visible as gboolean)
declare function gtk_tree_view_column_get_visible (byval tree_column as GtkTreeViewColumn ptr) as gboolean
declare sub gtk_tree_view_column_set_resizable (byval tree_column as GtkTreeViewColumn ptr, byval resizable as gboolean)
declare function gtk_tree_view_column_get_resizable (byval tree_column as GtkTreeViewColumn ptr) as gboolean
declare sub gtk_tree_view_column_set_sizing (byval tree_column as GtkTreeViewColumn ptr, byval type as GtkTreeViewColumnSizing)
declare function gtk_tree_view_column_get_sizing (byval tree_column as GtkTreeViewColumn ptr) as GtkTreeViewColumnSizing
declare function gtk_tree_view_column_get_width (byval tree_column as GtkTreeViewColumn ptr) as gint
declare function gtk_tree_view_column_get_fixed_width (byval tree_column as GtkTreeViewColumn ptr) as gint
declare sub gtk_tree_view_column_set_fixed_width (byval tree_column as GtkTreeViewColumn ptr, byval fixed_width as gint)
declare sub gtk_tree_view_column_set_min_width (byval tree_column as GtkTreeViewColumn ptr, byval min_width as gint)
declare function gtk_tree_view_column_get_min_width (byval tree_column as GtkTreeViewColumn ptr) as gint
declare sub gtk_tree_view_column_set_max_width (byval tree_column as GtkTreeViewColumn ptr, byval max_width as gint)
declare function gtk_tree_view_column_get_max_width (byval tree_column as GtkTreeViewColumn ptr) as gint
declare sub gtk_tree_view_column_clicked (byval tree_column as GtkTreeViewColumn ptr)
declare sub gtk_tree_view_column_set_title (byval tree_column as GtkTreeViewColumn ptr, byval title as zstring ptr)
declare function gtk_tree_view_column_get_title (byval tree_column as GtkTreeViewColumn ptr) as zstring ptr
declare sub gtk_tree_view_column_set_expand (byval tree_column as GtkTreeViewColumn ptr, byval expand as gboolean)
declare function gtk_tree_view_column_get_expand (byval tree_column as GtkTreeViewColumn ptr) as gboolean
declare sub gtk_tree_view_column_set_clickable (byval tree_column as GtkTreeViewColumn ptr, byval clickable as gboolean)
declare function gtk_tree_view_column_get_clickable (byval tree_column as GtkTreeViewColumn ptr) as gboolean
declare sub gtk_tree_view_column_set_widget (byval tree_column as GtkTreeViewColumn ptr, byval widget as GtkWidget ptr)
declare function gtk_tree_view_column_get_widget (byval tree_column as GtkTreeViewColumn ptr) as GtkWidget ptr
declare sub gtk_tree_view_column_set_alignment (byval tree_column as GtkTreeViewColumn ptr, byval xalign as gfloat)
declare function gtk_tree_view_column_get_alignment (byval tree_column as GtkTreeViewColumn ptr) as gfloat
declare sub gtk_tree_view_column_set_reorderable (byval tree_column as GtkTreeViewColumn ptr, byval reorderable as gboolean)
declare function gtk_tree_view_column_get_reorderable (byval tree_column as GtkTreeViewColumn ptr) as gboolean
declare sub gtk_tree_view_column_set_sort_column_id (byval tree_column as GtkTreeViewColumn ptr, byval sort_column_id as gint)
declare function gtk_tree_view_column_get_sort_column_id (byval tree_column as GtkTreeViewColumn ptr) as gint
declare sub gtk_tree_view_column_set_sort_indicator (byval tree_column as GtkTreeViewColumn ptr, byval setting as gboolean)
declare function gtk_tree_view_column_get_sort_indicator (byval tree_column as GtkTreeViewColumn ptr) as gboolean
declare sub gtk_tree_view_column_set_sort_order (byval tree_column as GtkTreeViewColumn ptr, byval order as GtkSortType)
declare function gtk_tree_view_column_get_sort_order (byval tree_column as GtkTreeViewColumn ptr) as GtkSortType
declare sub gtk_tree_view_column_cell_set_cell_data (byval tree_column as GtkTreeViewColumn ptr, byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval is_expander as gboolean, byval is_expanded as gboolean)
declare sub gtk_tree_view_column_cell_get_size (byval tree_column as GtkTreeViewColumn ptr, byval cell_area as GdkRectangle ptr, byval x_offset as gint ptr, byval y_offset as gint ptr, byval width as gint ptr, byval height as gint ptr)
declare function gtk_tree_view_column_cell_is_visible (byval tree_column as GtkTreeViewColumn ptr) as gboolean
declare sub gtk_tree_view_column_focus_cell (byval tree_column as GtkTreeViewColumn ptr, byval cell as GtkCellRenderer ptr)
declare function gtk_tree_view_column_cell_get_position (byval tree_column as GtkTreeViewColumn ptr, byval cell_renderer as GtkCellRenderer ptr, byval start_pos as gint ptr, byval width as gint ptr) as gboolean

#endif
