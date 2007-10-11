''
''
'' gtkvbox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkvbox_bi__
#define __gtkvbox_bi__

#include once "gtk/gdk.bi"
#include once "gtkbox.bi"

#define GTK_TYPE_VBOX (gtk_vbox_get_type ())
#define GTK_VBOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_VBOX, GtkVBox))
#define GTK_VBOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_VBOX, GtkVBoxClass))
#define GTK_IS_VBOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_VBOX))
#define GTK_IS_VBOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_VBOX))
#define GTK_VBOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_VBOX, GtkVBoxClass))

type GtkVBox as _GtkVBox
type GtkVBoxClass as _GtkVBoxClass

type _GtkVBox
	box as GtkBox
end type

type _GtkVBoxClass
	parent_class as GtkBoxClass
end type

declare function gtk_vbox_get_type () as GType
declare function gtk_vbox_new (byval homogeneous as gboolean, byval spacing as gint) as GtkWidget ptr

#endif
