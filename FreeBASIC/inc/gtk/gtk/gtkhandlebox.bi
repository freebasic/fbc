''
''
'' gtkhandlebox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkhandlebox_bi__
#define __gtkhandlebox_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkbin.bi"

type GtkHandleBox as _GtkHandleBox
type GtkHandleBoxClass as _GtkHandleBoxClass

type _GtkHandleBox
	bin as GtkBin
	bin_window as GdkWindow ptr
	float_window as GdkWindow ptr
	shadow_type as GtkShadowType
	handle_position:2 as guint
	float_window_mapped:1 as guint
	child_detached:1 as guint
	in_drag:1 as guint
	shrink_on_detach:1 as guint
	snap_edge:3 as integer
	deskoff_x as gint
	deskoff_y as gint
	attach_allocation as GtkAllocation
	float_allocation as GtkAllocation
end type

type _GtkHandleBoxClass
	parent_class as GtkBinClass
	child_attached as sub cdecl(byval as GtkHandleBox ptr, byval as GtkWidget ptr)
	child_detached as sub cdecl(byval as GtkHandleBox ptr, byval as GtkWidget ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_handle_box_get_type cdecl alias "gtk_handle_box_get_type" () as GType
declare function gtk_handle_box_new cdecl alias "gtk_handle_box_new" () as GtkWidget ptr
declare sub gtk_handle_box_set_shadow_type cdecl alias "gtk_handle_box_set_shadow_type" (byval handle_box as GtkHandleBox ptr, byval type as GtkShadowType)
declare function gtk_handle_box_get_shadow_type cdecl alias "gtk_handle_box_get_shadow_type" (byval handle_box as GtkHandleBox ptr) as GtkShadowType
declare sub gtk_handle_box_set_handle_position cdecl alias "gtk_handle_box_set_handle_position" (byval handle_box as GtkHandleBox ptr, byval position as GtkPositionType)
declare function gtk_handle_box_get_handle_position cdecl alias "gtk_handle_box_get_handle_position" (byval handle_box as GtkHandleBox ptr) as GtkPositionType
declare sub gtk_handle_box_set_snap_edge cdecl alias "gtk_handle_box_set_snap_edge" (byval handle_box as GtkHandleBox ptr, byval edge as GtkPositionType)
declare function gtk_handle_box_get_snap_edge cdecl alias "gtk_handle_box_get_snap_edge" (byval handle_box as GtkHandleBox ptr) as GtkPositionType

#endif
