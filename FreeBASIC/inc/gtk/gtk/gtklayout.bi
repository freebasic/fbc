''
''
'' gtklayout -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtklayout_bi__
#define __gtklayout_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkcontainer.bi"
#include once "gtk/gtk/gtkadjustment.bi"

type GtkLayout as _GtkLayout
type GtkLayoutClass as _GtkLayoutClass

type _GtkLayout
	container as GtkContainer
	children as GList ptr
	width as guint
	height as guint
	hadjustment as GtkAdjustment ptr
	vadjustment as GtkAdjustment ptr
	bin_window as GdkWindow ptr
	visibility as GdkVisibilityState
	scroll_x as gint
	scroll_y as gint
	freeze_count as guint
end type

type _GtkLayoutClass
	parent_class as GtkContainerClass
	set_scroll_adjustments as sub cdecl(byval as GtkLayout ptr, byval as GtkAdjustment ptr, byval as GtkAdjustment ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_layout_get_type cdecl alias "gtk_layout_get_type" () as GType
declare function gtk_layout_new cdecl alias "gtk_layout_new" (byval hadjustment as GtkAdjustment ptr, byval vadjustment as GtkAdjustment ptr) as GtkWidget ptr
declare sub gtk_layout_put cdecl alias "gtk_layout_put" (byval layout as GtkLayout ptr, byval child_widget as GtkWidget ptr, byval x as gint, byval y as gint)
declare sub gtk_layout_move cdecl alias "gtk_layout_move" (byval layout as GtkLayout ptr, byval child_widget as GtkWidget ptr, byval x as gint, byval y as gint)
declare sub gtk_layout_set_size cdecl alias "gtk_layout_set_size" (byval layout as GtkLayout ptr, byval width as guint, byval height as guint)
declare sub gtk_layout_get_size cdecl alias "gtk_layout_get_size" (byval layout as GtkLayout ptr, byval width as guint ptr, byval height as guint ptr)
declare function gtk_layout_get_hadjustment cdecl alias "gtk_layout_get_hadjustment" (byval layout as GtkLayout ptr) as GtkAdjustment ptr
declare function gtk_layout_get_vadjustment cdecl alias "gtk_layout_get_vadjustment" (byval layout as GtkLayout ptr) as GtkAdjustment ptr
declare sub gtk_layout_set_hadjustment cdecl alias "gtk_layout_set_hadjustment" (byval layout as GtkLayout ptr, byval adjustment as GtkAdjustment ptr)
declare sub gtk_layout_set_vadjustment cdecl alias "gtk_layout_set_vadjustment" (byval layout as GtkLayout ptr, byval adjustment as GtkAdjustment ptr)
declare sub gtk_layout_freeze cdecl alias "gtk_layout_freeze" (byval layout as GtkLayout ptr)
declare sub gtk_layout_thaw cdecl alias "gtk_layout_thaw" (byval layout as GtkLayout ptr)

#endif
