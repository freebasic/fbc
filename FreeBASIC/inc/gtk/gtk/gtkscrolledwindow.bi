''
''
'' gtkscrolledwindow -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkscrolledwindow_bi__
#define __gtkscrolledwindow_bi__

#include once "gtk/gdk.bi"
#include once "gtkhscrollbar.bi"
#include once "gtkvscrollbar.bi"
#include once "gtkviewport.bi"

#define GTK_TYPE_SCROLLED_WINDOW (gtk_scrolled_window_get_type ())
#define GTK_SCROLLED_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SCROLLED_WINDOW, GtkScrolledWindow))
#define GTK_SCROLLED_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SCROLLED_WINDOW, GtkScrolledWindowClass))
#define GTK_IS_SCROLLED_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SCROLLED_WINDOW))
#define GTK_IS_SCROLLED_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SCROLLED_WINDOW))
#define GTK_SCROLLED_WINDOW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SCROLLED_WINDOW, GtkScrolledWindowClass))

type GtkScrolledWindow as _GtkScrolledWindow
type GtkScrolledWindowClass as _GtkScrolledWindowClass

type _GtkScrolledWindow
	container as GtkBin
	hscrollbar as GtkWidget ptr
	vscrollbar as GtkWidget ptr
	hscrollbar_policy:2 as guint
	vscrollbar_policy:2 as guint
	hscrollbar_visible:1 as guint
	vscrollbar_visible:1 as guint
	window_placement:2 as guint
	focus_out:1 as guint
	shadow_type as guint16
end type

type _GtkScrolledWindowClass
	parent_class as GtkBinClass
	scrollbar_spacing as gint
	scroll_child as sub cdecl(byval as GtkScrolledWindow ptr, byval as GtkScrollType, byval as gboolean)
	move_focus_out as sub cdecl(byval as GtkScrolledWindow ptr, byval as GtkDirectionType)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_scrolled_window_get_type () as GType
declare function gtk_scrolled_window_new (byval hadjustment as GtkAdjustment ptr, byval vadjustment as GtkAdjustment ptr) as GtkWidget ptr
declare sub gtk_scrolled_window_set_hadjustment (byval scrolled_window as GtkScrolledWindow ptr, byval hadjustment as GtkAdjustment ptr)
declare sub gtk_scrolled_window_set_vadjustment (byval scrolled_window as GtkScrolledWindow ptr, byval hadjustment as GtkAdjustment ptr)
declare function gtk_scrolled_window_get_hadjustment (byval scrolled_window as GtkScrolledWindow ptr) as GtkAdjustment ptr
declare function gtk_scrolled_window_get_vadjustment (byval scrolled_window as GtkScrolledWindow ptr) as GtkAdjustment ptr
declare sub gtk_scrolled_window_set_policy (byval scrolled_window as GtkScrolledWindow ptr, byval hscrollbar_policy as GtkPolicyType, byval vscrollbar_policy as GtkPolicyType)
declare sub gtk_scrolled_window_get_policy (byval scrolled_window as GtkScrolledWindow ptr, byval hscrollbar_policy as GtkPolicyType ptr, byval vscrollbar_policy as GtkPolicyType ptr)
declare sub gtk_scrolled_window_set_placement (byval scrolled_window as GtkScrolledWindow ptr, byval window_placement as GtkCornerType)
declare function gtk_scrolled_window_get_placement (byval scrolled_window as GtkScrolledWindow ptr) as GtkCornerType
declare sub gtk_scrolled_window_set_shadow_type (byval scrolled_window as GtkScrolledWindow ptr, byval type as GtkShadowType)
declare function gtk_scrolled_window_get_shadow_type (byval scrolled_window as GtkScrolledWindow ptr) as GtkShadowType
declare sub gtk_scrolled_window_add_with_viewport (byval scrolled_window as GtkScrolledWindow ptr, byval child as GtkWidget ptr)
declare function _gtk_scrolled_window_get_scrollbar_spacing (byval scrolled_window as GtkScrolledWindow ptr) as gint

#endif
