''
''
'' gtkvpaned -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkvpaned_bi__
#define __gtkvpaned_bi__

#include once "gtkpaned.bi"

#define GTK_TYPE_VPANED (gtk_vpaned_get_type ())
#define GTK_VPANED(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_VPANED, GtkVPaned))
#define GTK_VPANED_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_VPANED, GtkVPanedClass))
#define GTK_IS_VPANED(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_VPANED))
#define GTK_IS_VPANED_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_VPANED))
#define GTK_VPANED_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_VPANED, GtkVPanedClass))

type GtkVPaned as _GtkVPaned
type GtkVPanedClass as _GtkVPanedClass

type _GtkVPaned
	paned as GtkPaned
end type

type _GtkVPanedClass
	parent_class as GtkPanedClass
end type

declare function gtk_vpaned_get_type () as GType
declare function gtk_vpaned_new () as GtkWidget ptr

#endif
