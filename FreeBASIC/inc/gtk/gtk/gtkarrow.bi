''
''
'' gtkarrow -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkarrow_bi__
#define __gtkarrow_bi__

#include once "gtk/gdk.bi"
#include once "gtkmisc.bi"

#define GTK_TYPE_ARROW (gtk_arrow_get_type ())
#define GTK_ARROW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ARROW, GtkArrow))
#define GTK_ARROW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ARROW, GtkArrowClass))
#define GTK_IS_ARROW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ARROW))
#define GTK_IS_ARROW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ARROW))
#define GTK_ARROW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ARROW, GtkArrowClass))

type GtkArrow as _GtkArrow
type GtkArrowClass as _GtkArrowClass

type _GtkArrow
	misc as GtkMisc
	arrow_type as gint16
	shadow_type as gint16
end type

type _GtkArrowClass
	parent_class as GtkMiscClass
end type

declare function gtk_arrow_get_type () as GType
declare function gtk_arrow_new (byval arrow_type as GtkArrowType, byval shadow_type as GtkShadowType) as GtkWidget ptr
declare sub gtk_arrow_set (byval arrow as GtkArrow ptr, byval arrow_type as GtkArrowType, byval shadow_type as GtkShadowType)

#endif
