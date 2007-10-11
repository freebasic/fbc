''
''
'' gtkbin -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkbin_bi__
#define __gtkbin_bi__

#include once "gtk/gdk.bi"
#include once "gtkcontainer.bi"

#define GTK_TYPE_BIN (gtk_bin_get_type ())
#define GTK_BIN(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_BIN, GtkBin))
#define GTK_BIN_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_BIN, GtkBinClass))
#define GTK_IS_BIN(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_BIN))
#define GTK_IS_BIN_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_BIN))
#define GTK_BIN_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_BIN, GtkBinClass))

type GtkBin as _GtkBin
type GtkBinClass as _GtkBinClass

type _GtkBin
	container as GtkContainer
	child as GtkWidget ptr
end type

type _GtkBinClass
	parent_class as GtkContainerClass
end type

declare function gtk_bin_get_type () as GType
declare function gtk_bin_get_child (byval bin as GtkBin ptr) as GtkWidget ptr

#endif
