''
''
'' gtkinvisible -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkinvisible_bi__
#define __gtkinvisible_bi__

#include once "gtkwidget.bi"

#define GTK_TYPE_INVISIBLE (gtk_invisible_get_type ())
#define GTK_INVISIBLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_INVISIBLE, GtkInvisible))
#define GTK_INVISIBLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_INVISIBLE, GtkInvisibleClass))
#define GTK_IS_INVISIBLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_INVISIBLE))
#define GTK_IS_INVISIBLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_INVISIBLE))
#define GTK_INVISIBLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_INVISIBLE, GtkInvisibleClass))

type GtkInvisible as _GtkInvisible
type GtkInvisibleClass as _GtkInvisibleClass

type _GtkInvisible
	widget as GtkWidget
	has_user_ref_count as gboolean
	screen as GdkScreen ptr
end type

type _GtkInvisibleClass
	parent_class as GtkWidgetClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_invisible_get_type () as GType
declare function gtk_invisible_new () as GtkWidget ptr
declare function gtk_invisible_new_for_screen (byval screen as GdkScreen ptr) as GtkWidget ptr
declare sub gtk_invisible_set_screen (byval invisible as GtkInvisible ptr, byval screen as GdkScreen ptr)
declare function gtk_invisible_get_screen (byval invisible as GtkInvisible ptr) as GdkScreen ptr

#endif
