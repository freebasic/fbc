''
''
'' gtkiconview -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkiconview_bi__
#define __gtkiconview_bi__

#include once "gtkcontainer.bi"
#include once "gtktreemodel.bi"

#define GTK_TYPE_ICON_VIEW (gtk_icon_view_get_type ())
#define GTK_ICON_VIEW(obj) (GTK_CHECK_CAST ((obj), GTK_TYPE_ICON_VIEW, GtkIconView))
#define GTK_ICON_VIEW_CLASS(klass) (GTK_CHECK_CLASS_CAST ((klass), GTK_TYPE_ICON_VIEW, GtkIconViewClass))
#define GTK_IS_ICON_VIEW(obj) (GTK_CHECK_TYPE ((obj), GTK_TYPE_ICON_VIEW))
#define GTK_IS_ICON_VIEW_CLASS(klass) (GTK_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ICON_VIEW))
#define GTK_ICON_VIEW_GET_CLASS(obj) (GTK_CHECK_GET_CLASS ((obj), GTK_TYPE_ICON_VIEW, GtkIconViewClass))

type GtkIconView as _GtkIconView
type GtkIconViewClass as _GtkIconViewClass
type GtkIconViewPrivate as _GtkIconViewPrivate
type GtkIconViewForeachFunc as sub cdecl(byval as GtkIconView ptr, byval as GtkTreePath ptr, byval as gpointer)

type _GtkIconView
	parent as GtkContainer
	priv as GtkIconViewPrivate ptr
end type

type _GtkIconViewClass
	parent_class as GtkContainerClass
	set_scroll_adjustments as sub cdecl(byval as GtkIconView ptr, byval as GtkAdjustment ptr, byval as GtkAdjustment ptr)
	item_activated as sub cdecl(byval as GtkIconView ptr, byval as GtkTreePath ptr)
	selection_changed as sub cdecl(byval as GtkIconView ptr)
	select_all as sub cdecl(byval as GtkIconView ptr)
	unselect_all as sub cdecl(byval as GtkIconView ptr)
	select_cursor_item as sub cdecl(byval as GtkIconView ptr)
	toggle_cursor_item as sub cdecl(byval as GtkIconView ptr)
	move_cursor as function cdecl(byval as GtkIconView ptr, byval as GtkMovementStep, byval as gint) as gboolean
	activate_cursor_item as function cdecl(byval as GtkIconView ptr) as gboolean
end type

declare function gtk_icon_view_get_type () as GType
declare function gtk_icon_view_new () as GtkWidget ptr
declare function gtk_icon_view_new_with_model (byval model as GtkTreeModel ptr) as GtkWidget ptr
declare sub gtk_icon_view_set_model (byval icon_view as GtkIconView ptr, byval model as GtkTreeModel ptr)
declare function gtk_icon_view_get_model (byval icon_view as GtkIconView ptr) as GtkTreeModel ptr
declare sub gtk_icon_view_set_text_column (byval icon_view as GtkIconView ptr, byval column as gint)
declare function gtk_icon_view_get_text_column (byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_markup_column (byval icon_view as GtkIconView ptr, byval column as gint)
declare function gtk_icon_view_get_markup_column (byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_pixbuf_column (byval icon_view as GtkIconView ptr, byval column as gint)
declare function gtk_icon_view_get_pixbuf_column (byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_orientation (byval icon_view as GtkIconView ptr, byval orientation as GtkOrientation)
declare function gtk_icon_view_get_orientation (byval icon_view as GtkIconView ptr) as GtkOrientation
declare sub gtk_icon_view_set_columns (byval icon_view as GtkIconView ptr, byval columns as gint)
declare function gtk_icon_view_get_columns (byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_item_width (byval icon_view as GtkIconView ptr, byval item_width as gint)
declare function gtk_icon_view_get_item_width (byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_spacing (byval icon_view as GtkIconView ptr, byval spacing as gint)
declare function gtk_icon_view_get_spacing (byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_row_spacing (byval icon_view as GtkIconView ptr, byval row_spacing as gint)
declare function gtk_icon_view_get_row_spacing (byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_column_spacing (byval icon_view as GtkIconView ptr, byval column_spacing as gint)
declare function gtk_icon_view_get_column_spacing (byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_margin (byval icon_view as GtkIconView ptr, byval margin as gint)
declare function gtk_icon_view_get_margin (byval icon_view as GtkIconView ptr) as gint
declare function gtk_icon_view_get_path_at_pos (byval icon_view as GtkIconView ptr, byval x as gint, byval y as gint) as GtkTreePath ptr
declare sub gtk_icon_view_selected_foreach (byval icon_view as GtkIconView ptr, byval func as GtkIconViewForeachFunc, byval data as gpointer)
declare sub gtk_icon_view_set_selection_mode (byval icon_view as GtkIconView ptr, byval mode as GtkSelectionMode)
declare function gtk_icon_view_get_selection_mode (byval icon_view as GtkIconView ptr) as GtkSelectionMode
declare sub gtk_icon_view_select_path (byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr)
declare sub gtk_icon_view_unselect_path (byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr)
declare function gtk_icon_view_path_is_selected (byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr) as gboolean
declare function gtk_icon_view_get_selected_items (byval icon_view as GtkIconView ptr) as GList ptr
declare sub gtk_icon_view_select_all (byval icon_view as GtkIconView ptr)
declare sub gtk_icon_view_unselect_all (byval icon_view as GtkIconView ptr)
declare sub gtk_icon_view_item_activated (byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr)

#endif
