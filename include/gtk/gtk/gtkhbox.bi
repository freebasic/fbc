''
''
'' gtkhbox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkhbox_bi__
#define __gtkhbox_bi__

#include once "gtk/gdk.bi"
#include once "gtkbox.bi"

#define GTK_TYPE_HBOX (gtk_hbox_get_type ())
#define GTK_HBOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_HBOX, GtkHBox))
#define GTK_HBOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_HBOX, GtkHBoxClass))
#define GTK_IS_HBOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_HBOX))
#define GTK_IS_HBOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_HBOX))
#define GTK_HBOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_HBOX, GtkHBoxClass))

type GtkHBox as _GtkHBox
type GtkHBoxClass as _GtkHBoxClass

type _GtkHBox
	box as GtkBox
end type

type _GtkHBoxClass
	parent_class as GtkBoxClass
end type

declare function gtk_hbox_get_type () as GType
declare function gtk_hbox_new (byval homogeneous as gboolean, byval spacing as gint) as GtkWidget ptr

#endif
