''
''
'' gtkviewport -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkviewport_bi__
#define __gtkviewport_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkadjustment.bi"
#include once "gtk/gtk/gtkbin.bi"

type GtkViewport as _GtkViewport
type GtkViewportClass as _GtkViewportClass

type _GtkViewport
	bin as GtkBin
	shadow_type as GtkShadowType
	view_window as GdkWindow ptr
	bin_window as GdkWindow ptr
	hadjustment as GtkAdjustment ptr
	vadjustment as GtkAdjustment ptr
end type

type _GtkViewportClass
	parent_class as GtkBinClass
	set_scroll_adjustments as sub cdecl(byval as GtkViewport ptr, byval as GtkAdjustment ptr, byval as GtkAdjustment ptr)
end type

declare function gtk_viewport_get_type cdecl alias "gtk_viewport_get_type" () as GType
declare function gtk_viewport_new cdecl alias "gtk_viewport_new" (byval hadjustment as GtkAdjustment ptr, byval vadjustment as GtkAdjustment ptr) as GtkWidget ptr
declare function gtk_viewport_get_hadjustment cdecl alias "gtk_viewport_get_hadjustment" (byval viewport as GtkViewport ptr) as GtkAdjustment ptr
declare function gtk_viewport_get_vadjustment cdecl alias "gtk_viewport_get_vadjustment" (byval viewport as GtkViewport ptr) as GtkAdjustment ptr
declare sub gtk_viewport_set_hadjustment cdecl alias "gtk_viewport_set_hadjustment" (byval viewport as GtkViewport ptr, byval adjustment as GtkAdjustment ptr)
declare sub gtk_viewport_set_vadjustment cdecl alias "gtk_viewport_set_vadjustment" (byval viewport as GtkViewport ptr, byval adjustment as GtkAdjustment ptr)
declare sub gtk_viewport_set_shadow_type cdecl alias "gtk_viewport_set_shadow_type" (byval viewport as GtkViewport ptr, byval type as GtkShadowType)
declare function gtk_viewport_get_shadow_type cdecl alias "gtk_viewport_get_shadow_type" (byval viewport as GtkViewport ptr) as GtkShadowType

#endif
