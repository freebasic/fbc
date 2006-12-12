''
''
'' gtkvseparator -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkvseparator_bi__
#define __gtkvseparator_bi__

#include once "gtk/gdk.bi"
#include once "gtkseparator.bi"

#define GTK_TYPE_VSEPARATOR (gtk_vseparator_get_type ())
#define GTK_VSEPARATOR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_VSEPARATOR, GtkVSeparator))
#define GTK_VSEPARATOR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_VSEPARATOR, GtkVSeparatorClass))
#define GTK_IS_VSEPARATOR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_VSEPARATOR))
#define GTK_IS_VSEPARATOR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_VSEPARATOR))
#define GTK_VSEPARATOR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_VSEPARATOR, GtkVSeparatorClass))

type GtkVSeparator as _GtkVSeparator
type GtkVSeparatorClass as _GtkVSeparatorClass

type _GtkVSeparator
	separator as GtkSeparator
end type

type _GtkVSeparatorClass
	parent_class as GtkSeparatorClass
end type

declare function gtk_vseparator_get_type () as GType
declare function gtk_vseparator_new () as GtkWidget ptr

#endif
