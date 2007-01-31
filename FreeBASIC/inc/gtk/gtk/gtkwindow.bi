''
''
'' gtkwindow -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkwindow_bi__
#define __gtkwindow_bi__

#include once "gtk/gdk.bi"
#include once "gtkaccelgroup.bi"
#include once "gtkbin.bi"
#include once "gtkenums.bi"
#include once "gtkwidget.bi"

#define GTK_TYPE_WINDOW gtk_window_get_type()
#define GTK_WINDOW(obj) G_TYPE_CHECK_INSTANCE_CAST(obj, GTK_TYPE_WINDOW, GtkWindow)
#define GTK_WINDOW_CLASS(klass) G_TYPE_CHECK_CLASS_CAST(klass, GTK_TYPE_WINDOW, GtkWindowClass)
#define GTK_IS_WINDOW(obj) G_TYPE_CHECK_INSTANCE_TYPE(obj, GTK_TYPE_WINDOW)
#define GTK_IS_WINDOW_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE(klass, GTK_TYPE_WINDOW)
#define GTK_WINDOW_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS(obj, GTK_TYPE_WINDOW, GtkWindowClass)

#define GTK_TYPE_WINDOW_GROUP (gtk_window_group_get_type ())
#define GTK_WINDOW_GROUP(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_WINDOW_GROUP, GtkWindowGroup))
#define GTK_WINDOW_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_WINDOW_GROUP, GtkWindowGroupClass))
#define GTK_IS_WINDOW_GROUP(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_WINDOW_GROUP))
#define GTK_IS_WINDOW_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_WINDOW_GROUP))
#define GTK_WINDOW_GROUP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_WINDOW_GROUP, GtkWindowGroupClass))

type GtkWindow as _GtkWindow
type GtkWindowClass as _GtkWindowClass
type GtkWindowGeometryInfo as _GtkWindowGeometryInfo
type GtkWindowGroup as _GtkWindowGroup
type GtkWindowGroupClass as _GtkWindowGroupClass

type _GtkWindow
	bin as GtkBin
	title as zstring ptr
	wmclass_name as zstring ptr
	wmclass_class as zstring ptr
	wm_role as zstring ptr
	focus_widget as GtkWidget ptr
	default_widget as GtkWidget ptr
	transient_parent as GtkWindow ptr
	geometry_info as GtkWindowGeometryInfo ptr
	frame as GdkWindow ptr
	group as GtkWindowGroup ptr
	configure_request_count as guint16
	allow_shrink:1 as guint
	allow_grow:1 as guint
	configure_notify_received:1 as guint
	need_default_position:1 as guint
	need_default_size:1 as guint
	position:3 as guint
	type:4 as guint
	has_user_ref_count:1 as guint
	has_focus:1 as guint
	modal:1 as guint
	destroy_with_parent:1 as guint
	has_frame:1 as guint
	iconify_initially:1 as guint
	stick_initially:1 as guint
	maximize_initially:1 as guint
	decorated:1 as guint
	type_hint:3 as guint
	gravity:5 as guint
	is_active:1 as guint
	has_toplevel_focus:1 as guint
	frame_left as guint
	frame_top as guint
	frame_right as guint
	frame_bottom as guint
	keys_changed_handler as guint
	mnemonic_modifier as GdkModifierType
	screen as GdkScreen ptr
end type

type _GtkWindowClass
	parent_class as GtkBinClass
	set_focus as sub cdecl(byval as GtkWindow ptr, byval as GtkWidget ptr)
	frame_event as function cdecl(byval as GtkWindow ptr, byval as GdkEvent ptr) as gboolean
	activate_focus as sub cdecl(byval as GtkWindow ptr)
	activate_default as sub cdecl(byval as GtkWindow ptr)
	move_focus as sub cdecl(byval as GtkWindow ptr, byval as GtkDirectionType)
	keys_changed as sub cdecl(byval as GtkWindow ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

type _GtkWindowGroup
	parent_instance as GObject
	grabs as GSList ptr
end type

type _GtkWindowGroupClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

#ifdef __FB_Win32__
/' Reserve old names for DLL ABI backward compatibility '/
#define gtk_window_set_icon_from_file gtk_window_set_icon_from_file_utf8
#define gtk_window_set_default_icon_from_file gtk_window_set_default_icon_from_file_utf8
#endif

declare function gtk_window_get_type () as GType
declare function gtk_window_new (byval type as GtkWindowType) as GtkWidget ptr
declare sub gtk_window_set_title (byval window as GtkWindow ptr, byval title as zstring ptr)
declare function gtk_window_get_title (byval window as GtkWindow ptr) as zstring ptr
declare sub gtk_window_set_wmclass (byval window as GtkWindow ptr, byval wmclass_name as zstring ptr, byval wmclass_class as zstring ptr)
declare sub gtk_window_set_role (byval window as GtkWindow ptr, byval role as zstring ptr)
declare function gtk_window_get_role (byval window as GtkWindow ptr) as zstring ptr
declare sub gtk_window_add_accel_group (byval window as GtkWindow ptr, byval accel_group as GtkAccelGroup ptr)
declare sub gtk_window_remove_accel_group (byval window as GtkWindow ptr, byval accel_group as GtkAccelGroup ptr)
declare sub gtk_window_set_position (byval window as GtkWindow ptr, byval position as GtkWindowPosition)
declare function gtk_window_activate_focus (byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_focus (byval window as GtkWindow ptr, byval focus as GtkWidget ptr)
declare function gtk_window_get_focus (byval window as GtkWindow ptr) as GtkWidget ptr
declare sub gtk_window_set_default (byval window as GtkWindow ptr, byval default_widget as GtkWidget ptr)
declare function gtk_window_activate_default (byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_transient_for (byval window as GtkWindow ptr, byval parent as GtkWindow ptr)
declare function gtk_window_get_transient_for (byval window as GtkWindow ptr) as GtkWindow ptr
declare sub gtk_window_set_type_hint (byval window as GtkWindow ptr, byval hint as GdkWindowTypeHint)
declare function gtk_window_get_type_hint (byval window as GtkWindow ptr) as GdkWindowTypeHint
declare sub gtk_window_set_skip_taskbar_hint (byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_skip_taskbar_hint (byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_skip_pager_hint (byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_skip_pager_hint (byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_accept_focus (byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_accept_focus (byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_focus_on_map (byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_focus_on_map (byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_destroy_with_parent (byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_destroy_with_parent (byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_resizable (byval window as GtkWindow ptr, byval resizable as gboolean)
declare function gtk_window_get_resizable (byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_gravity (byval window as GtkWindow ptr, byval gravity as GdkGravity)
declare function gtk_window_get_gravity (byval window as GtkWindow ptr) as GdkGravity
declare sub gtk_window_set_geometry_hints (byval window as GtkWindow ptr, byval geometry_widget as GtkWidget ptr, byval geometry as GdkGeometry ptr, byval geom_mask as GdkWindowHints)
declare sub gtk_window_set_screen (byval window as GtkWindow ptr, byval screen as GdkScreen ptr)
declare function gtk_window_get_screen (byval window as GtkWindow ptr) as GdkScreen ptr
declare function gtk_window_is_active (byval window as GtkWindow ptr) as gboolean
declare function gtk_window_has_toplevel_focus (byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_has_frame (byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_has_frame (byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_frame_dimensions (byval window as GtkWindow ptr, byval left as gint, byval top as gint, byval right as gint, byval bottom as gint)
declare sub gtk_window_get_frame_dimensions (byval window as GtkWindow ptr, byval left as gint ptr, byval top as gint ptr, byval right as gint ptr, byval bottom as gint ptr)
declare sub gtk_window_set_decorated (byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_decorated (byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_icon_list (byval window as GtkWindow ptr, byval list as GList ptr)
declare function gtk_window_get_icon_list (byval window as GtkWindow ptr) as GList ptr
declare sub gtk_window_set_icon (byval window as GtkWindow ptr, byval icon as GdkPixbuf ptr)
declare sub gtk_window_set_icon_name (byval window as GtkWindow ptr, byval name as zstring ptr)
declare function gtk_window_set_icon_from_file (byval window as GtkWindow ptr, byval filename as zstring ptr, byval err as GError ptr ptr) as gboolean
declare function gtk_window_get_icon (byval window as GtkWindow ptr) as GdkPixbuf ptr
declare function gtk_window_get_icon_name (byval window as GtkWindow ptr) as zstring ptr
declare sub gtk_window_set_default_icon_list (byval list as GList ptr)
declare function gtk_window_get_default_icon_list () as GList ptr
declare sub gtk_window_set_default_icon (byval icon as GdkPixbuf ptr)
declare sub gtk_window_set_default_icon_name (byval name as zstring ptr)
declare function gtk_window_set_default_icon_from_file (byval filename as zstring ptr, byval err as GError ptr ptr) as gboolean
declare sub gtk_window_set_auto_startup_notification (byval setting as gboolean)
declare sub gtk_window_set_modal (byval window as GtkWindow ptr, byval modal as gboolean)
declare function gtk_window_get_modal (byval window as GtkWindow ptr) as gboolean
declare function gtk_window_list_toplevels () as GList ptr
declare sub gtk_window_add_mnemonic (byval window as GtkWindow ptr, byval keyval as guint, byval target as GtkWidget ptr)
declare sub gtk_window_remove_mnemonic (byval window as GtkWindow ptr, byval keyval as guint, byval target as GtkWidget ptr)
declare function gtk_window_mnemonic_activate (byval window as GtkWindow ptr, byval keyval as guint, byval modifier as GdkModifierType) as gboolean
declare sub gtk_window_set_mnemonic_modifier (byval window as GtkWindow ptr, byval modifier as GdkModifierType)
declare function gtk_window_get_mnemonic_modifier (byval window as GtkWindow ptr) as GdkModifierType
declare function gtk_window_activate_key (byval window as GtkWindow ptr, byval event as GdkEventKey ptr) as gboolean
declare function gtk_window_propagate_key_event (byval window as GtkWindow ptr, byval event as GdkEventKey ptr) as gboolean
declare sub gtk_window_present (byval window as GtkWindow ptr)
declare sub gtk_window_iconify (byval window as GtkWindow ptr)
declare sub gtk_window_deiconify (byval window as GtkWindow ptr)
declare sub gtk_window_stick (byval window as GtkWindow ptr)
declare sub gtk_window_unstick (byval window as GtkWindow ptr)
declare sub gtk_window_maximize (byval window as GtkWindow ptr)
declare sub gtk_window_unmaximize (byval window as GtkWindow ptr)
declare sub gtk_window_fullscreen (byval window as GtkWindow ptr)
declare sub gtk_window_unfullscreen (byval window as GtkWindow ptr)
declare sub gtk_window_set_keep_above (byval window as GtkWindow ptr, byval setting as gboolean)
declare sub gtk_window_set_keep_below (byval window as GtkWindow ptr, byval setting as gboolean)
declare sub gtk_window_begin_resize_drag (byval window as GtkWindow ptr, byval edge as GdkWindowEdge, byval button as gint, byval root_x as gint, byval root_y as gint, byval timestamp as guint32)
declare sub gtk_window_begin_move_drag (byval window as GtkWindow ptr, byval button as gint, byval root_x as gint, byval root_y as gint, byval timestamp as guint32)
declare sub gtk_window_set_policy (byval window as GtkWindow ptr, byval allow_shrink as gint, byval allow_grow as gint, byval auto_shrink as gint)
declare sub gtk_window_set_default_size (byval window as GtkWindow ptr, byval width as gint, byval height as gint)
declare sub gtk_window_get_default_size (byval window as GtkWindow ptr, byval width as gint ptr, byval height as gint ptr)
declare sub gtk_window_resize (byval window as GtkWindow ptr, byval width as gint, byval height as gint)
declare sub gtk_window_get_size (byval window as GtkWindow ptr, byval width as gint ptr, byval height as gint ptr)
declare sub gtk_window_move (byval window as GtkWindow ptr, byval x as gint, byval y as gint)
declare sub gtk_window_get_position (byval window as GtkWindow ptr, byval root_x as gint ptr, byval root_y as gint ptr)
declare function gtk_window_parse_geometry (byval window as GtkWindow ptr, byval geometry as zstring ptr) as gboolean
declare sub gtk_window_reshow_with_initial_size (byval window as GtkWindow ptr)
declare function gtk_window_group_get_type () as GType
declare function gtk_window_group_new () as GtkWindowGroup ptr
declare sub gtk_window_group_add_window (byval window_group as GtkWindowGroup ptr, byval window as GtkWindow ptr)
declare sub gtk_window_group_remove_window (byval window_group as GtkWindowGroup ptr, byval window as GtkWindow ptr)
declare sub _gtk_window_internal_set_focus (byval window as GtkWindow ptr, byval focus as GtkWidget ptr)
declare sub gtk_window_remove_embedded_xid (byval window as GtkWindow ptr, byval xid as guint)
declare sub gtk_window_add_embedded_xid (byval window as GtkWindow ptr, byval xid as guint)
declare sub _gtk_window_reposition (byval window as GtkWindow ptr, byval x as gint, byval y as gint)
declare sub _gtk_window_constrain_size (byval window as GtkWindow ptr, byval width as gint, byval height as gint, byval new_width as gint ptr, byval new_height as gint ptr)
declare function _gtk_window_get_group (byval window as GtkWindow ptr) as GtkWindowGroup ptr
declare sub _gtk_window_set_has_toplevel_focus (byval window as GtkWindow ptr, byval has_toplevel_focus as gboolean)
declare sub _gtk_window_unset_focus_and_default (byval window as GtkWindow ptr, byval widget as GtkWidget ptr)
declare sub _gtk_window_set_is_active (byval window as GtkWindow ptr, byval is_active as gboolean)

type GtkWindowKeysForeachFunc as sub cdecl(byval as GtkWindow ptr, byval as guint, byval as GdkModifierType, byval as gboolean, byval as gpointer)

declare sub _gtk_window_keys_foreach (byval window as GtkWindow ptr, byval func as GtkWindowKeysForeachFunc, byval func_data as gpointer)
declare function _gtk_window_query_nonaccels (byval window as GtkWindow ptr, byval accel_key as guint, byval accel_mods as GdkModifierType) as gboolean

#define	gtk_window_position	gtk_window_set_position

#endif
