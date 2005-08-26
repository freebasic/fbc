''
''
'' gdkscreen -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkscreen_bi__
#define __gdkscreen_bi__

#include once "gtk/gdk/gdktypes.bi"
#include once "gtk/gdk/gdkdisplay.bi"

type GdkScreenClass as _GdkScreenClass

type _GdkScreen
	parent_instance as GObject
	closed as guint
	normal_gcs(0 to 32-1) as GdkGC ptr
	exposure_gcs(0 to 32-1) as GdkGC ptr
end type

type _GdkScreenClass
	parent_class as GObjectClass
	size_changed as sub cdecl(byval as GdkScreen ptr)
end type

declare function gdk_screen_get_type cdecl alias "gdk_screen_get_type" () as GType
declare function gdk_screen_get_default_colormap cdecl alias "gdk_screen_get_default_colormap" (byval screen as GdkScreen ptr) as GdkColormap ptr
declare sub gdk_screen_set_default_colormap cdecl alias "gdk_screen_set_default_colormap" (byval screen as GdkScreen ptr, byval colormap as GdkColormap ptr)
declare function gdk_screen_get_system_colormap cdecl alias "gdk_screen_get_system_colormap" (byval screen as GdkScreen ptr) as GdkColormap ptr
declare function gdk_screen_get_system_visual cdecl alias "gdk_screen_get_system_visual" (byval screen as GdkScreen ptr) as GdkVisual ptr
declare function gdk_screen_get_rgb_colormap cdecl alias "gdk_screen_get_rgb_colormap" (byval screen as GdkScreen ptr) as GdkColormap ptr
declare function gdk_screen_get_rgb_visual cdecl alias "gdk_screen_get_rgb_visual" (byval screen as GdkScreen ptr) as GdkVisual ptr
declare function gdk_screen_get_root_window cdecl alias "gdk_screen_get_root_window" (byval screen as GdkScreen ptr) as GdkWindow ptr
declare function gdk_screen_get_display cdecl alias "gdk_screen_get_display" (byval screen as GdkScreen ptr) as GdkDisplay ptr
declare function gdk_screen_get_number cdecl alias "gdk_screen_get_number" (byval screen as GdkScreen ptr) as gint
declare function gdk_screen_get_width cdecl alias "gdk_screen_get_width" (byval screen as GdkScreen ptr) as gint
declare function gdk_screen_get_height cdecl alias "gdk_screen_get_height" (byval screen as GdkScreen ptr) as gint
declare function gdk_screen_get_width_mm cdecl alias "gdk_screen_get_width_mm" (byval screen as GdkScreen ptr) as gint
declare function gdk_screen_get_height_mm cdecl alias "gdk_screen_get_height_mm" (byval screen as GdkScreen ptr) as gint
declare function gdk_screen_list_visuals cdecl alias "gdk_screen_list_visuals" (byval screen as GdkScreen ptr) as GList ptr
declare function gdk_screen_get_toplevel_windows cdecl alias "gdk_screen_get_toplevel_windows" (byval screen as GdkScreen ptr) as GList ptr
declare function gdk_screen_make_display_name cdecl alias "gdk_screen_make_display_name" (byval screen as GdkScreen ptr) as zstring ptr
declare function gdk_screen_get_n_monitors cdecl alias "gdk_screen_get_n_monitors" (byval screen as GdkScreen ptr) as gint
declare sub gdk_screen_get_monitor_geometry cdecl alias "gdk_screen_get_monitor_geometry" (byval screen as GdkScreen ptr, byval monitor_num as gint, byval dest as GdkRectangle ptr)
declare function gdk_screen_get_monitor_at_point cdecl alias "gdk_screen_get_monitor_at_point" (byval screen as GdkScreen ptr, byval x as gint, byval y as gint) as gint
declare function gdk_screen_get_monitor_at_window cdecl alias "gdk_screen_get_monitor_at_window" (byval screen as GdkScreen ptr, byval window as GdkWindow ptr) as gint
declare sub gdk_screen_broadcast_client_message cdecl alias "gdk_screen_broadcast_client_message" (byval screen as GdkScreen ptr, byval event as GdkEvent ptr)
declare function gdk_screen_get_default cdecl alias "gdk_screen_get_default" () as GdkScreen ptr
declare function gdk_screen_get_setting cdecl alias "gdk_screen_get_setting" (byval screen as GdkScreen ptr, byval name as zstring ptr, byval value as GValue ptr) as gboolean

#endif
