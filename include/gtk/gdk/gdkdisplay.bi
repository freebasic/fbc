''
''
'' gdkdisplay -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkdisplay_bi__
#define __gdkdisplay_bi__

#include once "gdktypes.bi"
#include once "gdkevents.bi"
#include once "gtk/glib-object.bi"

#define GDK_TYPE_DISPLAY (gdk_display_get_type ())
#define GDK_DISPLAY_OBJECT(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_DISPLAY, GdkDisplay))
#define GDK_DISPLAY_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_DISPLAY, GdkDisplayClass))
#define GDK_IS_DISPLAY(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_DISPLAY))
#define GDK_IS_DISPLAY_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_DISPLAY))
#define GDK_DISPLAY_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_DISPLAY, GdkDisplayClass))

type GdkDisplayClass as _GdkDisplayClass
type GdkDisplayPointerHooks as _GdkDisplayPointerHooks

type _GdkDisplay
	parent_instance as GObject
	queued_events as GList ptr
	queued_tail as GList ptr
	button_click_time(0 to 2-1) as guint32
	button_window(0 to 2-1) as GdkWindow ptr
	button_number(0 to 2-1) as gint
	double_click_time as guint
	core_pointer as GdkDevice ptr
	pointer_hooks as GdkDisplayPointerHooks ptr
	closed as guint
	double_click_distance as guint
	button_x(0 to 2-1) as gint
	button_y(0 to 2-1) as gint
end type

type _GdkDisplayClass
	parent_class as GObjectClass
	get_display_name as function cdecl(byval as GdkDisplay ptr) as gchar
	get_n_screens as function cdecl(byval as GdkDisplay ptr) as gint
	get_screen as function cdecl(byval as GdkDisplay ptr, byval as gint) as GdkScreen ptr
	get_default_screen as function cdecl(byval as GdkDisplay ptr) as GdkScreen ptr
	closed as sub cdecl(byval as GdkDisplay ptr, byval as gboolean)
end type

type _GdkDisplayPointerHooks
	get_pointer as sub cdecl(byval as GdkDisplay ptr, byval as GdkScreen ptr ptr, byval as gint ptr, byval as gint ptr, byval as GdkModifierType ptr)
	window_get_pointer as function cdecl(byval as GdkDisplay ptr, byval as GdkWindow ptr, byval as gint ptr, byval as gint ptr, byval as GdkModifierType ptr) as GdkWindow ptr
	window_at_pointer as function cdecl(byval as GdkDisplay ptr, byval as gint ptr, byval as gint ptr) as GdkWindow ptr
end type

declare function gdk_display_get_type () as GType
declare function gdk_display_open (byval display_name as zstring ptr) as GdkDisplay ptr
declare function gdk_display_get_name (byval display as GdkDisplay ptr) as zstring ptr
declare function gdk_display_get_n_screens (byval display as GdkDisplay ptr) as gint
declare function gdk_display_get_screen (byval display as GdkDisplay ptr, byval screen_num as gint) as GdkScreen ptr
declare function gdk_display_get_default_screen (byval display as GdkDisplay ptr) as GdkScreen ptr
declare sub gdk_display_pointer_ungrab (byval display as GdkDisplay ptr, byval time_ as guint32)
declare sub gdk_display_keyboard_ungrab (byval display as GdkDisplay ptr, byval time_ as guint32)
declare function gdk_display_pointer_is_grabbed (byval display as GdkDisplay ptr) as gboolean
declare sub gdk_display_beep (byval display as GdkDisplay ptr)
declare sub gdk_display_sync (byval display as GdkDisplay ptr)
declare sub gdk_display_flush (byval display as GdkDisplay ptr)
declare sub gdk_display_close (byval display as GdkDisplay ptr)
declare function gdk_display_list_devices (byval display as GdkDisplay ptr) as GList ptr
declare function gdk_display_get_event (byval display as GdkDisplay ptr) as GdkEvent ptr
declare function gdk_display_peek_event (byval display as GdkDisplay ptr) as GdkEvent ptr
declare sub gdk_display_put_event (byval display as GdkDisplay ptr, byval event as GdkEvent ptr)
declare sub gdk_display_add_client_message_filter (byval display as GdkDisplay ptr, byval message_type as GdkAtom, byval func as GdkFilterFunc, byval data as gpointer)
declare sub gdk_display_add_client_message_filter_full (byval display as GdkDisplay ptr, byval message_type as GdkAtom, byval func as GdkFilterFunc, byval data as gpointer, byval destroy as GDestroyNotify)
declare sub gdk_display_set_double_click_time (byval display as GdkDisplay ptr, byval msec as guint)
declare sub gdk_display_set_double_click_distance (byval display as GdkDisplay ptr, byval distance as guint)
declare function gdk_display_get_default () as GdkDisplay ptr
declare function gdk_display_get_core_pointer (byval display as GdkDisplay ptr) as GdkDevice ptr
declare sub gdk_display_get_pointer (byval display as GdkDisplay ptr, byval screen as GdkScreen ptr ptr, byval x as gint ptr, byval y as gint ptr, byval mask as GdkModifierType ptr)
declare function gdk_display_get_window_at_pointer (byval display as GdkDisplay ptr, byval win_x as gint ptr, byval win_y as gint ptr) as GdkWindow ptr
declare function gdk_display_set_pointer_hooks (byval display as GdkDisplay ptr, byval new_hooks as GdkDisplayPointerHooks ptr) as GdkDisplayPointerHooks ptr
declare function gdk_display_open_default_libgtk_only () as GdkDisplay ptr
declare function gdk_display_supports_cursor_alpha (byval display as GdkDisplay ptr) as gboolean
declare function gdk_display_supports_cursor_color (byval display as GdkDisplay ptr) as gboolean
declare function gdk_display_get_default_cursor_size (byval display as GdkDisplay ptr) as guint
declare sub gdk_display_get_maximal_cursor_size (byval display as GdkDisplay ptr, byval width as guint ptr, byval height as guint ptr)
declare function gdk_display_get_default_group (byval display as GdkDisplay ptr) as GdkWindow ptr
declare function gdk_display_supports_selection_notification (byval display as GdkDisplay ptr) as gboolean
declare function gdk_display_request_selection_notification (byval display as GdkDisplay ptr, byval selection as GdkAtom) as gboolean
declare function gdk_display_supports_clipboard_persistence (byval display as GdkDisplay ptr) as gboolean
declare sub gdk_display_store_clipboard (byval display as GdkDisplay ptr, byval clipboard_window as GdkWindow ptr, byval time_ as guint32, byval targets as GdkAtom ptr, byval n_targets as gint)

#endif
