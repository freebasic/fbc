''
''
'' gtkdnd -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkdnd_bi__
#define __gtkdnd_bi__

#include once "gtk/gdk.bi"
#include once "gtkenums.bi"
#include once "gtkwidget.bi"
#include once "gtkselection.bi"

enum GtkDestDefaults
	GTK_DEST_DEFAULT_MOTION = 1 shl 0
	GTK_DEST_DEFAULT_HIGHLIGHT = 1 shl 1
	GTK_DEST_DEFAULT_DROP = 1 shl 2
	GTK_DEST_DEFAULT_ALL = &h07
end enum


enum GtkTargetFlags
	GTK_TARGET_SAME_APP = 1 shl 0
	GTK_TARGET_SAME_WIDGET = 1 shl 1
end enum


declare sub gtk_drag_get_data (byval widget as GtkWidget ptr, byval context as GdkDragContext ptr, byval target as GdkAtom, byval time_ as guint32)
declare sub gtk_drag_finish (byval context as GdkDragContext ptr, byval success as gboolean, byval del as gboolean, byval time_ as guint32)
declare function gtk_drag_get_source_widget (byval context as GdkDragContext ptr) as GtkWidget ptr
declare sub gtk_drag_highlight (byval widget as GtkWidget ptr)
declare sub gtk_drag_unhighlight (byval widget as GtkWidget ptr)
declare sub gtk_drag_dest_set (byval widget as GtkWidget ptr, byval flags as GtkDestDefaults, byval targets as GtkTargetEntry ptr, byval n_targets as gint, byval actions as GdkDragAction)
declare sub gtk_drag_dest_set_proxy (byval widget as GtkWidget ptr, byval proxy_window as GdkWindow ptr, byval protocol as GdkDragProtocol, byval use_coordinates as gboolean)
declare sub gtk_drag_dest_unset (byval widget as GtkWidget ptr)
declare function gtk_drag_dest_find_target (byval widget as GtkWidget ptr, byval context as GdkDragContext ptr, byval target_list as GtkTargetList ptr) as GdkAtom
declare function gtk_drag_dest_get_target_list (byval widget as GtkWidget ptr) as GtkTargetList ptr
declare sub gtk_drag_dest_set_target_list (byval widget as GtkWidget ptr, byval target_list as GtkTargetList ptr)
declare sub gtk_drag_dest_add_text_targets (byval widget as GtkWidget ptr)
declare sub gtk_drag_dest_add_image_targets (byval widget as GtkWidget ptr)
declare sub gtk_drag_dest_add_uri_targets (byval widget as GtkWidget ptr)
declare sub gtk_drag_source_set (byval widget as GtkWidget ptr, byval start_button_mask as GdkModifierType, byval targets as GtkTargetEntry ptr, byval n_targets as gint, byval actions as GdkDragAction)
declare sub gtk_drag_source_unset (byval widget as GtkWidget ptr)
declare function gtk_drag_source_get_target_list (byval widget as GtkWidget ptr) as GtkTargetList ptr
declare sub gtk_drag_source_set_target_list (byval widget as GtkWidget ptr, byval target_list as GtkTargetList ptr)
declare sub gtk_drag_source_add_text_targets (byval widget as GtkWidget ptr)
declare sub gtk_drag_source_add_image_targets (byval widget as GtkWidget ptr)
declare sub gtk_drag_source_add_uri_targets (byval widget as GtkWidget ptr)
declare sub gtk_drag_source_set_icon (byval widget as GtkWidget ptr, byval colormap as GdkColormap ptr, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr)
declare sub gtk_drag_source_set_icon_pixbuf (byval widget as GtkWidget ptr, byval pixbuf as GdkPixbuf ptr)
declare sub gtk_drag_source_set_icon_stock (byval widget as GtkWidget ptr, byval stock_id as zstring ptr)
declare function gtk_drag_begin (byval widget as GtkWidget ptr, byval targets as GtkTargetList ptr, byval actions as GdkDragAction, byval button as gint, byval event as GdkEvent ptr) as GdkDragContext ptr
declare sub gtk_drag_set_icon_widget (byval context as GdkDragContext ptr, byval widget as GtkWidget ptr, byval hot_x as gint, byval hot_y as gint)
declare sub gtk_drag_set_icon_pixmap (byval context as GdkDragContext ptr, byval colormap as GdkColormap ptr, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr, byval hot_x as gint, byval hot_y as gint)
declare sub gtk_drag_set_icon_pixbuf (byval context as GdkDragContext ptr, byval pixbuf as GdkPixbuf ptr, byval hot_x as gint, byval hot_y as gint)
declare sub gtk_drag_set_icon_stock (byval context as GdkDragContext ptr, byval stock_id as zstring ptr, byval hot_x as gint, byval hot_y as gint)
declare sub gtk_drag_set_icon_default (byval context as GdkDragContext ptr)
declare function gtk_drag_check_threshold (byval widget as GtkWidget ptr, byval start_x as gint, byval start_y as gint, byval current_x as gint, byval current_y as gint) as gboolean
declare sub _gtk_drag_source_handle_event (byval widget as GtkWidget ptr, byval event as GdkEvent ptr)
declare sub _gtk_drag_dest_handle_event (byval toplevel as GtkWidget ptr, byval event as GdkEvent ptr)
declare sub gtk_drag_set_default_icon (byval colormap as GdkColormap ptr, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr, byval hot_x as gint, byval hot_y as gint)

#endif
