''
''
'' gdkwindow -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkwindow_bi__
#define __gdkwindow_bi__

#include once "gdkdrawable.bi"
#include once "gdktypes.bi"
#include once "gdkevents.bi"

#define GDK_TYPE_WINDOW (gdk_window_object_get_type ())
#define GDK_WINDOW(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_WINDOW, GdkWindow))
#define GDK_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_WINDOW, GdkWindowObjectClass))
#define GDK_IS_WINDOW(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_WINDOW))
#define GDK_IS_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_WINDOW))
#define GDK_WINDOW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_WINDOW, GdkWindowObjectClass))
#define GDK_WINDOW_OBJECT(object) (cast(GdkWindowObject ptr, GDK_WINDOW (object)))

type GdkGeometry as _GdkGeometry
type GdkWindowAttr as _GdkWindowAttr
type GdkPointerHooks as _GdkPointerHooks

enum GdkWindowClass
	GDK_INPUT_OUTPUT
	GDK_INPUT_ONLY
end enum


enum GdkWindowType
	GDK_WINDOW_ROOT
	GDK_WINDOW_TOPLEVEL
	GDK_WINDOW_CHILD
	GDK_WINDOW_DIALOG
	GDK_WINDOW_TEMP
	GDK_WINDOW_FOREIGN
end enum


enum GdkWindowAttributesType
	GDK_WA_TITLE = 1 shl 1
	GDK_WA_X = 1 shl 2
	GDK_WA_Y = 1 shl 3
	GDK_WA_CURSOR = 1 shl 4
	GDK_WA_COLORMAP = 1 shl 5
	GDK_WA_VISUAL = 1 shl 6
	GDK_WA_WMCLASS = 1 shl 7
	GDK_WA_NOREDIR = 1 shl 8
end enum


enum GdkWindowHints
	GDK_HINT_POS = 1 shl 0
	GDK_HINT_MIN_SIZE = 1 shl 1
	GDK_HINT_MAX_SIZE = 1 shl 2
	GDK_HINT_BASE_SIZE = 1 shl 3
	GDK_HINT_ASPECT = 1 shl 4
	GDK_HINT_RESIZE_INC = 1 shl 5
	GDK_HINT_WIN_GRAVITY = 1 shl 6
	GDK_HINT_USER_POS = 1 shl 7
	GDK_HINT_USER_SIZE = 1 shl 8
end enum


enum GdkWindowTypeHint
	GDK_WINDOW_TYPE_HINT_NORMAL
	GDK_WINDOW_TYPE_HINT_DIALOG
	GDK_WINDOW_TYPE_HINT_MENU
	GDK_WINDOW_TYPE_HINT_TOOLBAR
	GDK_WINDOW_TYPE_HINT_SPLASHSCREEN
	GDK_WINDOW_TYPE_HINT_UTILITY
	GDK_WINDOW_TYPE_HINT_DOCK
	GDK_WINDOW_TYPE_HINT_DESKTOP
end enum


enum GdkWMDecoration
	GDK_DECOR_ALL = 1 shl 0
	GDK_DECOR_BORDER = 1 shl 1
	GDK_DECOR_RESIZEH = 1 shl 2
	GDK_DECOR_TITLE = 1 shl 3
	GDK_DECOR_MENU = 1 shl 4
	GDK_DECOR_MINIMIZE = 1 shl 5
	GDK_DECOR_MAXIMIZE = 1 shl 6
end enum


enum GdkWMFunction
	GDK_FUNC_ALL = 1 shl 0
	GDK_FUNC_RESIZE = 1 shl 1
	GDK_FUNC_MOVE = 1 shl 2
	GDK_FUNC_MINIMIZE = 1 shl 3
	GDK_FUNC_MAXIMIZE = 1 shl 4
	GDK_FUNC_CLOSE = 1 shl 5
end enum


enum GdkGravity
	GDK_GRAVITY_NORTH_WEST = 1
	GDK_GRAVITY_NORTH
	GDK_GRAVITY_NORTH_EAST
	GDK_GRAVITY_WEST
	GDK_GRAVITY_CENTER
	GDK_GRAVITY_EAST
	GDK_GRAVITY_SOUTH_WEST
	GDK_GRAVITY_SOUTH
	GDK_GRAVITY_SOUTH_EAST
	GDK_GRAVITY_STATIC
end enum


enum GdkWindowEdge
	GDK_WINDOW_EDGE_NORTH_WEST
	GDK_WINDOW_EDGE_NORTH
	GDK_WINDOW_EDGE_NORTH_EAST
	GDK_WINDOW_EDGE_WEST
	GDK_WINDOW_EDGE_EAST
	GDK_WINDOW_EDGE_SOUTH_WEST
	GDK_WINDOW_EDGE_SOUTH
	GDK_WINDOW_EDGE_SOUTH_EAST
end enum


type _GdkWindowAttr
	title as zstring ptr
	event_mask as gint
	x as gint
	y as gint
	width as gint
	height as gint
	wclass as GdkWindowClass
	visual as GdkVisual ptr
	colormap as GdkColormap ptr
	window_type as GdkWindowType
	cursor as GdkCursor ptr
	wmclass_name as zstring ptr
	wmclass_class as zstring ptr
	override_redirect as gboolean
end type

type _GdkGeometry
	min_width as gint
	min_height as gint
	max_width as gint
	max_height as gint
	base_width as gint
	base_height as gint
	width_inc as gint
	height_inc as gint
	min_aspect as gdouble
	max_aspect as gdouble
	win_gravity as GdkGravity
end type

type _GdkPointerHooks
	get_pointer as function cdecl(byval as GdkWindow ptr, byval as gint ptr, byval as gint ptr, byval as GdkModifierType ptr) as GdkWindow
	window_at_pointer as function cdecl(byval as GdkScreen ptr, byval as gint ptr, byval as gint ptr) as GdkWindow
end type

type GdkWindowObject as _GdkWindowObject
type GdkWindowObjectClass as _GdkWindowObjectClass

type _GdkWindowObject
	parent_instance as GdkDrawable
	impl as GdkDrawable ptr
	parent as GdkWindowObject ptr
	user_data as gpointer
	x as gint
	y as gint
	extension_events as gint
	filters as GList ptr
	children as GList ptr
	bg_color as GdkColor
	bg_pixmap as GdkPixmap ptr
	paint_stack as GSList ptr
	update_area as GdkRegion ptr
	update_freeze_count as guint
	window_type as guint8
	depth as guint8
	resize_count as guint8
	state as GdkWindowState
	guffaw_gravity:1 as guint
	input_only:1 as guint
	modal_hint:1 as guint
	destroyed:2 as guint
	accept_focus:1 as guint
	focus_on_map:1 as guint
	event_mask as GdkEventMask
end type

type _GdkWindowObjectClass
	parent_class as GdkDrawableClass
end type

declare function gdk_window_object_get_type () as GType
declare function gdk_window_new (byval parent as GdkWindow ptr, byval attributes as GdkWindowAttr ptr, byval attributes_mask as gint) as GdkWindow ptr
declare sub gdk_window_destroy (byval window as GdkWindow ptr)
declare function gdk_window_get_window_type (byval window as GdkWindow ptr) as GdkWindowType
declare function gdk_window_at_pointer (byval win_x as gint ptr, byval win_y as gint ptr) as GdkWindow ptr
declare sub gdk_window_show (byval window as GdkWindow ptr)
declare sub gdk_window_hide (byval window as GdkWindow ptr)
declare sub gdk_window_withdraw (byval window as GdkWindow ptr)
declare sub gdk_window_show_unraised (byval window as GdkWindow ptr)
declare sub gdk_window_move (byval window as GdkWindow ptr, byval x as gint, byval y as gint)
declare sub gdk_window_resize (byval window as GdkWindow ptr, byval width as gint, byval height as gint)
declare sub gdk_window_move_resize (byval window as GdkWindow ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gdk_window_reparent (byval window as GdkWindow ptr, byval new_parent as GdkWindow ptr, byval x as gint, byval y as gint)
declare sub gdk_window_clear (byval window as GdkWindow ptr)
declare sub gdk_window_clear_area (byval window as GdkWindow ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gdk_window_clear_area_e (byval window as GdkWindow ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gdk_window_raise (byval window as GdkWindow ptr)
declare sub gdk_window_lower (byval window as GdkWindow ptr)
declare sub gdk_window_focus (byval window as GdkWindow ptr, byval timestamp as guint32)
declare sub gdk_window_set_user_data (byval window as GdkWindow ptr, byval user_data as gpointer)
declare sub gdk_window_set_override_redirect (byval window as GdkWindow ptr, byval override_redirect as gboolean)
declare sub gdk_window_set_accept_focus (byval window as GdkWindow ptr, byval accept_focus as gboolean)
declare sub gdk_window_set_focus_on_map (byval window as GdkWindow ptr, byval focus_on_map as gboolean)
declare sub gdk_window_add_filter (byval window as GdkWindow ptr, byval function as GdkFilterFunc, byval data as gpointer)
declare sub gdk_window_remove_filter (byval window as GdkWindow ptr, byval function as GdkFilterFunc, byval data as gpointer)
declare sub gdk_window_scroll (byval window as GdkWindow ptr, byval dx as gint, byval dy as gint)
declare sub gdk_window_shape_combine_mask (byval window as GdkWindow ptr, byval mask as GdkBitmap ptr, byval x as gint, byval y as gint)
declare sub gdk_window_shape_combine_region (byval window as GdkWindow ptr, byval shape_region as GdkRegion ptr, byval offset_x as gint, byval offset_y as gint)
declare sub gdk_window_set_child_shapes (byval window as GdkWindow ptr)
declare sub gdk_window_merge_child_shapes (byval window as GdkWindow ptr)
declare function gdk_window_is_visible (byval window as GdkWindow ptr) as gboolean
declare function gdk_window_is_viewable (byval window as GdkWindow ptr) as gboolean
declare function gdk_window_get_state (byval window as GdkWindow ptr) as GdkWindowState
declare function gdk_window_set_static_gravities (byval window as GdkWindow ptr, byval use_static as gboolean) as gboolean
declare function gdk_window_foreign_new (byval anid as GdkNativeWindow) as GdkWindow ptr
declare function gdk_window_lookup (byval anid as GdkNativeWindow) as GdkWindow ptr
declare function gdk_window_foreign_new_for_display (byval display as GdkDisplay ptr, byval anid as GdkNativeWindow) as GdkWindow ptr
declare function gdk_window_lookup_for_display (byval display as GdkDisplay ptr, byval anid as GdkNativeWindow) as GdkWindow ptr
declare sub gdk_window_set_hints (byval window as GdkWindow ptr, byval x as gint, byval y as gint, byval min_width as gint, byval min_height as gint, byval max_width as gint, byval max_height as gint, byval flags as gint)
declare sub gdk_window_set_type_hint (byval window as GdkWindow ptr, byval hint as GdkWindowTypeHint)
declare sub gdk_window_set_modal_hint (byval window as GdkWindow ptr, byval modal as gboolean)
declare sub gdk_window_set_skip_taskbar_hint (byval window as GdkWindow ptr, byval skips_taskbar as gboolean)
declare sub gdk_window_set_skip_pager_hint (byval window as GdkWindow ptr, byval skips_pager as gboolean)
declare sub gdk_window_set_geometry_hints (byval window as GdkWindow ptr, byval geometry as GdkGeometry ptr, byval geom_mask as GdkWindowHints)
declare sub gdk_set_sm_client_id (byval sm_client_id as zstring ptr)
declare sub gdk_window_begin_paint_rect (byval window as GdkWindow ptr, byval rectangle as GdkRectangle ptr)
declare sub gdk_window_begin_paint_region (byval window as GdkWindow ptr, byval region as GdkRegion ptr)
declare sub gdk_window_end_paint (byval window as GdkWindow ptr)
declare sub gdk_window_set_title (byval window as GdkWindow ptr, byval title as zstring ptr)
declare sub gdk_window_set_role (byval window as GdkWindow ptr, byval role as zstring ptr)
declare sub gdk_window_set_transient_for (byval window as GdkWindow ptr, byval parent as GdkWindow ptr)
declare sub gdk_window_set_background (byval window as GdkWindow ptr, byval color as GdkColor ptr)
declare sub gdk_window_set_back_pixmap (byval window as GdkWindow ptr, byval pixmap as GdkPixmap ptr, byval parent_relative as gboolean)
declare sub gdk_window_set_cursor (byval window as GdkWindow ptr, byval cursor as GdkCursor ptr)
declare sub gdk_window_get_user_data (byval window as GdkWindow ptr, byval data as gpointer ptr)
declare sub gdk_window_get_geometry (byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr, byval width as gint ptr, byval height as gint ptr, byval depth as gint ptr)
declare sub gdk_window_get_position (byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr)
declare function gdk_window_get_origin (byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr) as gint
declare function gdk_window_get_deskrelative_origin (byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr) as gboolean
declare sub gdk_window_get_root_origin (byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr)
declare sub gdk_window_get_frame_extents (byval window as GdkWindow ptr, byval rect as GdkRectangle ptr)
declare function gdk_window_get_pointer (byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr, byval mask as GdkModifierType ptr) as GdkWindow ptr
declare function gdk_window_get_parent (byval window as GdkWindow ptr) as GdkWindow ptr
declare function gdk_window_get_toplevel (byval window as GdkWindow ptr) as GdkWindow ptr
declare function gdk_window_get_children (byval window as GdkWindow ptr) as GList ptr
declare function gdk_window_peek_children (byval window as GdkWindow ptr) as GList ptr
declare function gdk_window_get_events (byval window as GdkWindow ptr) as GdkEventMask
declare sub gdk_window_set_events (byval window as GdkWindow ptr, byval event_mask as GdkEventMask)
declare sub gdk_window_set_icon_list (byval window as GdkWindow ptr, byval pixbufs as GList ptr)
declare sub gdk_window_set_icon (byval window as GdkWindow ptr, byval icon_window as GdkWindow ptr, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr)
declare sub gdk_window_set_icon_name (byval window as GdkWindow ptr, byval name as zstring ptr)
declare sub gdk_window_set_group (byval window as GdkWindow ptr, byval leader as GdkWindow ptr)
declare function gdk_window_get_group (byval window as GdkWindow ptr) as GdkWindow ptr
declare sub gdk_window_set_decorations (byval window as GdkWindow ptr, byval decorations as GdkWMDecoration)
declare function gdk_window_get_decorations (byval window as GdkWindow ptr, byval decorations as GdkWMDecoration ptr) as gboolean
declare sub gdk_window_set_functions (byval window as GdkWindow ptr, byval functions as GdkWMFunction)
declare function gdk_window_get_toplevels () as GList ptr
declare sub gdk_window_iconify (byval window as GdkWindow ptr)
declare sub gdk_window_deiconify (byval window as GdkWindow ptr)
declare sub gdk_window_stick (byval window as GdkWindow ptr)
declare sub gdk_window_unstick (byval window as GdkWindow ptr)
declare sub gdk_window_maximize (byval window as GdkWindow ptr)
declare sub gdk_window_unmaximize (byval window as GdkWindow ptr)
declare sub gdk_window_fullscreen (byval window as GdkWindow ptr)
declare sub gdk_window_unfullscreen (byval window as GdkWindow ptr)
declare sub gdk_window_set_keep_above (byval window as GdkWindow ptr, byval setting as gboolean)
declare sub gdk_window_set_keep_below (byval window as GdkWindow ptr, byval setting as gboolean)
declare sub gdk_window_register_dnd (byval window as GdkWindow ptr)
declare sub gdk_window_begin_resize_drag (byval window as GdkWindow ptr, byval edge as GdkWindowEdge, byval button as gint, byval root_x as gint, byval root_y as gint, byval timestamp as guint32)
declare sub gdk_window_begin_move_drag (byval window as GdkWindow ptr, byval button as gint, byval root_x as gint, byval root_y as gint, byval timestamp as guint32)
declare sub gdk_window_invalidate_rect (byval window as GdkWindow ptr, byval rect as GdkRectangle ptr, byval invalidate_children as gboolean)
declare sub gdk_window_invalidate_region (byval window as GdkWindow ptr, byval region as GdkRegion ptr, byval invalidate_children as gboolean)
declare sub gdk_window_invalidate_maybe_recurse (byval window as GdkWindow ptr, byval region as GdkRegion ptr, byval child_func as function cdecl(byval as GdkWindow ptr, byval as gpointer) as gboolean, byval user_data as gpointer)
declare function gdk_window_get_update_area (byval window as GdkWindow ptr) as GdkRegion ptr
declare sub gdk_window_freeze_updates (byval window as GdkWindow ptr)
declare sub gdk_window_thaw_updates (byval window as GdkWindow ptr)
declare sub gdk_window_process_all_updates ()
declare sub gdk_window_process_updates (byval window as GdkWindow ptr, byval update_children as gboolean)
declare sub gdk_window_set_debug_updates (byval setting as gboolean)
declare sub gdk_window_constrain_size (byval geometry as GdkGeometry ptr, byval flags as guint, byval width as gint, byval height as gint, byval new_width as gint ptr, byval new_height as gint ptr)
declare sub gdk_window_get_internal_paint_info (byval window as GdkWindow ptr, byval real_drawable as GdkDrawable ptr ptr, byval x_offset as gint ptr, byval y_offset as gint ptr)
declare sub gdk_window_enable_synchronized_configure (byval window as GdkWindow ptr)
declare sub gdk_window_configure_finished (byval window as GdkWindow ptr)
declare function gdk_set_pointer_hooks (byval new_hooks as GdkPointerHooks ptr) as GdkPointerHooks ptr
declare function gdk_get_default_root_window () as GdkWindow ptr

#define GDK_ROOT_PARENT() (gdk_get_default_root_window ())
#define gdk_window_get_size gdk_drawable_get_size
#define gdk_window_get_type gdk_window_get_window_type
#define gdk_window_get_colormap gdk_drawable_get_colormap
#define gdk_window_set_colormap gdk_drawable_set_colormap
#define gdk_window_get_visual gdk_drawable_get_visual
#define gdk_window_ref gdk_drawable_ref
#define gdk_window_unref gdk_drawable_unref

#define gdk_window_copy_area(drawable,gc,x,y,source_drawable,source_x,source_y,width_,height) _
   gdk_draw_pixmap(drawable,gc,source_drawable,source_x,source_y,x,y,width_,height)

#endif
