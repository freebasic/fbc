''
''
'' gtktreeview -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktreeview_bi__
#define __gtktreeview_bi__

#include once "gtkwidget.bi"
#include once "gtkcontainer.bi"
#include once "gtktreemodel.bi"
#include once "gtktreeviewcolumn.bi"
#include once "gtkdnd.bi"

#define GTK_TYPE_TREE_VIEW (gtk_tree_view_get_type ())
#define GTK_TREE_VIEW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TREE_VIEW, GtkTreeView))
#define GTK_TREE_VIEW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TREE_VIEW, GtkTreeViewClass))
#define GTK_IS_TREE_VIEW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TREE_VIEW))
#define GTK_IS_TREE_VIEW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TREE_VIEW))
#define GTK_TREE_VIEW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TREE_VIEW, GtkTreeViewClass))

enum GtkTreeViewDropPosition
	GTK_TREE_VIEW_DROP_BEFORE
	GTK_TREE_VIEW_DROP_AFTER
	GTK_TREE_VIEW_DROP_INTO_OR_BEFORE
	GTK_TREE_VIEW_DROP_INTO_OR_AFTER
end enum

type GtkTreeView as _GtkTreeView
type GtkTreeViewClass as _GtkTreeViewClass
type GtkTreeViewPrivate as _GtkTreeViewPrivate
type GtkTreeSelection as _GtkTreeSelection
type GtkTreeSelectionClass as _GtkTreeSelectionClass

type _GtkTreeView
	parent as GtkContainer
	priv as GtkTreeViewPrivate ptr
end type

type _GtkTreeViewClass
	parent_class as GtkContainerClass
	set_scroll_adjustments as sub cdecl(byval as GtkTreeView ptr, byval as GtkAdjustment ptr, byval as GtkAdjustment ptr)
	row_activated as sub cdecl(byval as GtkTreeView ptr, byval as GtkTreePath ptr, byval as GtkTreeViewColumn ptr)
	test_expand_row as function cdecl(byval as GtkTreeView ptr, byval as GtkTreeIter ptr, byval as GtkTreePath ptr) as gboolean
	test_collapse_row as function cdecl(byval as GtkTreeView ptr, byval as GtkTreeIter ptr, byval as GtkTreePath ptr) as gboolean
	row_expanded as sub cdecl(byval as GtkTreeView ptr, byval as GtkTreeIter ptr, byval as GtkTreePath ptr)
	row_collapsed as sub cdecl(byval as GtkTreeView ptr, byval as GtkTreeIter ptr, byval as GtkTreePath ptr)
	columns_changed as sub cdecl(byval as GtkTreeView ptr)
	cursor_changed as sub cdecl(byval as GtkTreeView ptr)
	move_cursor as function cdecl(byval as GtkTreeView ptr, byval as GtkMovementStep, byval as gint) as gboolean
	select_all as function cdecl(byval as GtkTreeView ptr) as gboolean
	unselect_all as function cdecl(byval as GtkTreeView ptr) as gboolean
	select_cursor_row as function cdecl(byval as GtkTreeView ptr, byval as gboolean) as gboolean
	toggle_cursor_row as function cdecl(byval as GtkTreeView ptr) as gboolean
	expand_collapse_cursor_row as function cdecl(byval as GtkTreeView ptr, byval as gboolean, byval as gboolean, byval as gboolean) as gboolean
	select_cursor_parent as function cdecl(byval as GtkTreeView ptr) as gboolean
	start_interactive_search as function cdecl(byval as GtkTreeView ptr) as gboolean
	_gtk_reserved0 as sub cdecl()
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

type GtkTreeViewColumnDropFunc as function cdecl(byval as GtkTreeView ptr, byval as GtkTreeViewColumn ptr, byval as GtkTreeViewColumn ptr, byval as GtkTreeViewColumn ptr, byval as gpointer) as gboolean
type GtkTreeViewMappingFunc as sub cdecl(byval as GtkTreeView ptr, byval as GtkTreePath ptr, byval as gpointer)
type GtkTreeViewSearchEqualFunc as function cdecl(byval as GtkTreeModel ptr, byval as gint, byval as zstring ptr, byval as GtkTreeIter ptr, byval as gpointer) as gboolean
type GtkTreeViewRowSeparatorFunc as function cdecl(byval as GtkTreeModel ptr, byval as GtkTreeIter ptr, byval as gpointer) as gboolean

declare function gtk_tree_view_get_type () as GType
declare function gtk_tree_view_new () as GtkWidget ptr
declare function gtk_tree_view_new_with_model (byval model as GtkTreeModel ptr) as GtkWidget ptr
declare function gtk_tree_view_get_model (byval tree_view as GtkTreeView ptr) as GtkTreeModel ptr
declare sub gtk_tree_view_set_model (byval tree_view as GtkTreeView ptr, byval model as GtkTreeModel ptr)
declare function gtk_tree_view_get_selection (byval tree_view as GtkTreeView ptr) as GtkTreeSelection ptr
declare function gtk_tree_view_get_hadjustment (byval tree_view as GtkTreeView ptr) as GtkAdjustment ptr
declare sub gtk_tree_view_set_hadjustment (byval tree_view as GtkTreeView ptr, byval adjustment as GtkAdjustment ptr)
declare function gtk_tree_view_get_vadjustment (byval tree_view as GtkTreeView ptr) as GtkAdjustment ptr
declare sub gtk_tree_view_set_vadjustment (byval tree_view as GtkTreeView ptr, byval adjustment as GtkAdjustment ptr)
declare function gtk_tree_view_get_headers_visible (byval tree_view as GtkTreeView ptr) as gboolean
declare sub gtk_tree_view_set_headers_visible (byval tree_view as GtkTreeView ptr, byval headers_visible as gboolean)
declare sub gtk_tree_view_columns_autosize (byval tree_view as GtkTreeView ptr)
declare sub gtk_tree_view_set_headers_clickable (byval tree_view as GtkTreeView ptr, byval setting as gboolean)
declare sub gtk_tree_view_set_rules_hint (byval tree_view as GtkTreeView ptr, byval setting as gboolean)
declare function gtk_tree_view_get_rules_hint (byval tree_view as GtkTreeView ptr) as gboolean
declare function gtk_tree_view_append_column (byval tree_view as GtkTreeView ptr, byval column as GtkTreeViewColumn ptr) as gint
declare function gtk_tree_view_remove_column (byval tree_view as GtkTreeView ptr, byval column as GtkTreeViewColumn ptr) as gint
declare function gtk_tree_view_insert_column (byval tree_view as GtkTreeView ptr, byval column as GtkTreeViewColumn ptr, byval position as gint) as gint
declare function gtk_tree_view_insert_column_with_attributes (byval tree_view as GtkTreeView ptr, byval position as gint, byval title as zstring ptr, byval cell as GtkCellRenderer ptr, ...) as gint
declare function gtk_tree_view_insert_column_with_data_func (byval tree_view as GtkTreeView ptr, byval position as gint, byval title as zstring ptr, byval cell as GtkCellRenderer ptr, byval func as GtkTreeCellDataFunc, byval data as gpointer, byval dnotify as GDestroyNotify) as gint
declare function gtk_tree_view_get_column (byval tree_view as GtkTreeView ptr, byval n as gint) as GtkTreeViewColumn ptr
declare function gtk_tree_view_get_columns (byval tree_view as GtkTreeView ptr) as GList ptr
declare sub gtk_tree_view_move_column_after (byval tree_view as GtkTreeView ptr, byval column as GtkTreeViewColumn ptr, byval base_column as GtkTreeViewColumn ptr)
declare sub gtk_tree_view_set_expander_column (byval tree_view as GtkTreeView ptr, byval column as GtkTreeViewColumn ptr)
declare function gtk_tree_view_get_expander_column (byval tree_view as GtkTreeView ptr) as GtkTreeViewColumn ptr
declare sub gtk_tree_view_set_column_drag_function (byval tree_view as GtkTreeView ptr, byval func as GtkTreeViewColumnDropFunc, byval user_data as gpointer, byval destroy as GtkDestroyNotify)
declare sub gtk_tree_view_scroll_to_point (byval tree_view as GtkTreeView ptr, byval tree_x as gint, byval tree_y as gint)
declare sub gtk_tree_view_scroll_to_cell (byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval column as GtkTreeViewColumn ptr, byval use_align as gboolean, byval row_align as gfloat, byval col_align as gfloat)
declare sub gtk_tree_view_row_activated (byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval column as GtkTreeViewColumn ptr)
declare sub gtk_tree_view_expand_all (byval tree_view as GtkTreeView ptr)
declare sub gtk_tree_view_collapse_all (byval tree_view as GtkTreeView ptr)
declare sub gtk_tree_view_expand_to_path (byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr)
declare function gtk_tree_view_expand_row (byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval open_all as gboolean) as gboolean
declare function gtk_tree_view_collapse_row (byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr) as gboolean
declare sub gtk_tree_view_map_expanded_rows (byval tree_view as GtkTreeView ptr, byval func as GtkTreeViewMappingFunc, byval data as gpointer)
declare function gtk_tree_view_row_expanded (byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr) as gboolean
declare sub gtk_tree_view_set_reorderable (byval tree_view as GtkTreeView ptr, byval reorderable as gboolean)
declare function gtk_tree_view_get_reorderable (byval tree_view as GtkTreeView ptr) as gboolean
declare sub gtk_tree_view_set_cursor (byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval focus_column as GtkTreeViewColumn ptr, byval start_editing as gboolean)
declare sub gtk_tree_view_set_cursor_on_cell (byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval focus_column as GtkTreeViewColumn ptr, byval focus_cell as GtkCellRenderer ptr, byval start_editing as gboolean)
declare sub gtk_tree_view_get_cursor (byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr ptr, byval focus_column as GtkTreeViewColumn ptr ptr)
declare function gtk_tree_view_get_bin_window (byval tree_view as GtkTreeView ptr) as GdkWindow ptr
declare function gtk_tree_view_get_path_at_pos (byval tree_view as GtkTreeView ptr, byval x as gint, byval y as gint, byval path as GtkTreePath ptr ptr, byval column as GtkTreeViewColumn ptr ptr, byval cell_x as gint ptr, byval cell_y as gint ptr) as gboolean
declare sub gtk_tree_view_get_cell_area (byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval column as GtkTreeViewColumn ptr, byval rect as GdkRectangle ptr)
declare sub gtk_tree_view_get_background_area (byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval column as GtkTreeViewColumn ptr, byval rect as GdkRectangle ptr)
declare sub gtk_tree_view_get_visible_rect (byval tree_view as GtkTreeView ptr, byval visible_rect as GdkRectangle ptr)
declare sub gtk_tree_view_widget_to_tree_coords (byval tree_view as GtkTreeView ptr, byval wx as gint, byval wy as gint, byval tx as gint ptr, byval ty as gint ptr)
declare sub gtk_tree_view_tree_to_widget_coords (byval tree_view as GtkTreeView ptr, byval tx as gint, byval ty as gint, byval wx as gint ptr, byval wy as gint ptr)
declare sub gtk_tree_view_enable_model_drag_source (byval tree_view as GtkTreeView ptr, byval start_button_mask as GdkModifierType, byval targets as GtkTargetEntry ptr, byval n_targets as gint, byval actions as GdkDragAction)
declare sub gtk_tree_view_enable_model_drag_dest (byval tree_view as GtkTreeView ptr, byval targets as GtkTargetEntry ptr, byval n_targets as gint, byval actions as GdkDragAction)
declare sub gtk_tree_view_unset_rows_drag_source (byval tree_view as GtkTreeView ptr)
declare sub gtk_tree_view_unset_rows_drag_dest (byval tree_view as GtkTreeView ptr)
declare sub gtk_tree_view_set_drag_dest_row (byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval pos as GtkTreeViewDropPosition)
declare sub gtk_tree_view_get_drag_dest_row (byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr ptr, byval pos as GtkTreeViewDropPosition ptr)
declare function gtk_tree_view_get_dest_row_at_pos (byval tree_view as GtkTreeView ptr, byval drag_x as gint, byval drag_y as gint, byval path as GtkTreePath ptr ptr, byval pos as GtkTreeViewDropPosition ptr) as gboolean
declare function gtk_tree_view_create_row_drag_icon (byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr) as GdkPixmap ptr
declare sub gtk_tree_view_set_enable_search (byval tree_view as GtkTreeView ptr, byval enable_search as gboolean)
declare function gtk_tree_view_get_enable_search (byval tree_view as GtkTreeView ptr) as gboolean
declare function gtk_tree_view_get_search_column (byval tree_view as GtkTreeView ptr) as gint
declare sub gtk_tree_view_set_search_column (byval tree_view as GtkTreeView ptr, byval column as gint)
declare function gtk_tree_view_get_search_equal_func (byval tree_view as GtkTreeView ptr) as GtkTreeViewSearchEqualFunc
declare sub gtk_tree_view_set_search_equal_func (byval tree_view as GtkTreeView ptr, byval search_equal_func as GtkTreeViewSearchEqualFunc, byval search_user_data as gpointer, byval search_destroy as GtkDestroyNotify)

type GtkTreeDestroyCountFunc as sub cdecl(byval as GtkTreeView ptr, byval as GtkTreePath ptr, byval as gint, byval as gpointer)

declare sub gtk_tree_view_set_destroy_count_func (byval tree_view as GtkTreeView ptr, byval func as GtkTreeDestroyCountFunc, byval data as gpointer, byval destroy as GtkDestroyNotify)
declare sub gtk_tree_view_set_fixed_height_mode (byval tree_view as GtkTreeView ptr, byval enable as gboolean)
declare function gtk_tree_view_get_fixed_height_mode (byval tree_view as GtkTreeView ptr) as gboolean
declare sub gtk_tree_view_set_hover_selection (byval tree_view as GtkTreeView ptr, byval hover as gboolean)
declare function gtk_tree_view_get_hover_selection (byval tree_view as GtkTreeView ptr) as gboolean
declare sub gtk_tree_view_set_hover_expand (byval tree_view as GtkTreeView ptr, byval expand as gboolean)
declare function gtk_tree_view_get_hover_expand (byval tree_view as GtkTreeView ptr) as gboolean
declare function gtk_tree_view_get_row_separator_func (byval tree_view as GtkTreeView ptr) as GtkTreeViewRowSeparatorFunc
declare sub gtk_tree_view_set_row_separator_func (byval tree_view as GtkTreeView ptr, byval func as GtkTreeViewRowSeparatorFunc, byval data as gpointer, byval destroy as GtkDestroyNotify)

#endif
