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
#include once "gtkadjustment.bi"
#include once "gtkbin.bi"

#define GTK_TYPE_VIEWPORT (gtk_viewport_get_type ())
#define GTK_VIEWPORT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_VIEWPORT, GtkViewport))
#define GTK_VIEWPORT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_VIEWPORT, GtkViewportClass))
#define GTK_IS_VIEWPORT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_VIEWPORT))
#define GTK_IS_VIEWPORT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_VIEWPORT))
#define GTK_VIEWPORT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_VIEWPORT, GtkViewportClass))

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

declare function gtk_viewport_get_type () as GType
declare function gtk_viewport_new (byval hadjustment as GtkAdjustment ptr, byval vadjustment as GtkAdjustment ptr) as GtkWidget ptr
declare function gtk_viewport_get_hadjustment (byval viewport as GtkViewport ptr) as GtkAdjustment ptr
declare function gtk_viewport_get_vadjustment (byval viewport as GtkViewport ptr) as GtkAdjustment ptr
declare sub gtk_viewport_set_hadjustment (byval viewport as GtkViewport ptr, byval adjustment as GtkAdjustment ptr)
declare sub gtk_viewport_set_vadjustment (byval viewport as GtkViewport ptr, byval adjustment as GtkAdjustment ptr)
declare sub gtk_viewport_set_shadow_type (byval viewport as GtkViewport ptr, byval type as GtkShadowType)
declare function gtk_viewport_get_shadow_type (byval viewport as GtkViewport ptr) as GtkShadowType

#endif
