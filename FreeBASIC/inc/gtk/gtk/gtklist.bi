''
''
'' gtklist -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtklist_bi__
#define __gtklist_bi__

#include once "gtk/gdk.bi"
#include once "gtkenums.bi"
#include once "gtkcontainer.bi"
#include once "gtklistitem.bi"

#define GTK_TYPE_LIST (gtk_list_get_type ())
#define GTK_LIST(obj) (GTK_CHECK_CAST ((obj), GTK_TYPE_LIST, GtkList))
#define GTK_LIST_CLASS(klass) (GTK_CHECK_CLASS_CAST ((klass), GTK_TYPE_LIST, GtkListClass))
#define GTK_IS_LIST(obj) (GTK_CHECK_TYPE ((obj), GTK_TYPE_LIST))
#define GTK_IS_LIST_CLASS(klass) (GTK_CHECK_CLASS_TYPE ((klass), GTK_TYPE_LIST))
#define GTK_LIST_GET_CLASS(obj) (GTK_CHECK_GET_CLASS ((obj), GTK_TYPE_LIST, GtkListClass))

type GtkList as _GtkList
type GtkListClass as _GtkListClass

type _GtkList
	container as GtkContainer
	children as GList ptr
	selection as GList ptr
	undo_selection as GList ptr
	undo_unselection as GList ptr
	last_focus_child as GtkWidget ptr
	undo_focus_child as GtkWidget ptr
	htimer as guint
	vtimer as guint
	anchor as gint
	drag_pos as gint
	anchor_state as GtkStateType
	selection_mode:2 as guint
	drag_selection:1 as guint
	add_mode:1 as guint
end type

type _GtkListClass
	parent_class as GtkContainerClass
	selection_changed as sub cdecl(byval as GtkList ptr)
	select_child as sub cdecl(byval as GtkList ptr, byval as GtkWidget ptr)
	unselect_child as sub cdecl(byval as GtkList ptr, byval as GtkWidget ptr)
end type

declare function gtk_list_get_type () as GtkType
declare function gtk_list_new () as GtkWidget ptr
declare sub gtk_list_insert_items (byval list as GtkList ptr, byval items as GList ptr, byval position as gint)
declare sub gtk_list_append_items (byval list as GtkList ptr, byval items as GList ptr)
declare sub gtk_list_prepend_items (byval list as GtkList ptr, byval items as GList ptr)
declare sub gtk_list_remove_items (byval list as GtkList ptr, byval items as GList ptr)
declare sub gtk_list_remove_items_no_unref (byval list as GtkList ptr, byval items as GList ptr)
declare sub gtk_list_clear_items (byval list as GtkList ptr, byval start as gint, byval end as gint)
declare sub gtk_list_select_item (byval list as GtkList ptr, byval item as gint)
declare sub gtk_list_unselect_item (byval list as GtkList ptr, byval item as gint)
declare sub gtk_list_select_child (byval list as GtkList ptr, byval child as GtkWidget ptr)
declare sub gtk_list_unselect_child (byval list as GtkList ptr, byval child as GtkWidget ptr)
declare function gtk_list_child_position (byval list as GtkList ptr, byval child as GtkWidget ptr) as gint
declare sub gtk_list_set_selection_mode (byval list as GtkList ptr, byval mode as GtkSelectionMode)
declare sub gtk_list_extend_selection (byval list as GtkList ptr, byval scroll_type as GtkScrollType, byval position as gfloat, byval auto_start_selection as gboolean)
declare sub gtk_list_start_selection (byval list as GtkList ptr)
declare sub gtk_list_end_selection (byval list as GtkList ptr)
declare sub gtk_list_select_all (byval list as GtkList ptr)
declare sub gtk_list_unselect_all (byval list as GtkList ptr)
declare sub gtk_list_scroll_horizontal (byval list as GtkList ptr, byval scroll_type as GtkScrollType, byval position as gfloat)
declare sub gtk_list_scroll_vertical (byval list as GtkList ptr, byval scroll_type as GtkScrollType, byval position as gfloat)
declare sub gtk_list_toggle_add_mode (byval list as GtkList ptr)
declare sub gtk_list_toggle_focus_row (byval list as GtkList ptr)
declare sub gtk_list_toggle_row (byval list as GtkList ptr, byval item as GtkWidget ptr)
declare sub gtk_list_undo_selection (byval list as GtkList ptr)
declare sub gtk_list_end_drag_selection (byval list as GtkList ptr)

#endif
