''
''
'' gtkvscrollbar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkvscrollbar_bi__
#define __gtkvscrollbar_bi__

#include once "gtk/gdk.bi"
#include once "gtkscrollbar.bi"

#define GTK_TYPE_VSCROLLBAR (gtk_vscrollbar_get_type ())
#define GTK_VSCROLLBAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_VSCROLLBAR, GtkVScrollbar))
#define GTK_VSCROLLBAR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_VSCROLLBAR, GtkVScrollbarClass))
#define GTK_IS_VSCROLLBAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_VSCROLLBAR))
#define GTK_IS_VSCROLLBAR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_VSCROLLBAR))
#define GTK_VSCROLLBAR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_VSCROLLBAR, GtkVScrollbarClass))

type GtkVScrollbar as _GtkVScrollbar
type GtkVScrollbarClass as _GtkVScrollbarClass

type _GtkVScrollbar
	scrollbar as GtkScrollbar
end type

type _GtkVScrollbarClass
	parent_class as GtkScrollbarClass
end type

declare function gtk_vscrollbar_get_type () as GType
declare function gtk_vscrollbar_new (byval adjustment as GtkAdjustment ptr) as GtkWidget ptr

#endif
