''
''
'' gtkhpaned -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkhpaned_bi__
#define __gtkhpaned_bi__

#include once "gtkpaned.bi"

#define GTK_TYPE_HPANED (gtk_hpaned_get_type ())
#define GTK_HPANED(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_HPANED, GtkHPaned))
#define GTK_HPANED_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_HPANED, GtkHPanedClass))
#define GTK_IS_HPANED(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_HPANED))
#define GTK_IS_HPANED_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_HPANED))
#define GTK_HPANED_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_HPANED, GtkHPanedClass))

type GtkHPaned as _GtkHPaned
type GtkHPanedClass as _GtkHPanedClass

type _GtkHPaned
	paned as GtkPaned
end type

type _GtkHPanedClass
	parent_class as GtkPanedClass
end type

declare function gtk_hpaned_get_type () as GType
declare function gtk_hpaned_new () as GtkWidget ptr

#endif
