''
''
'' gtkmisc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkmisc_bi__
#define __gtkmisc_bi__

#include once "gtk/gdk.bi"
#include once "gtkwidget.bi"

#define GTK_TYPE_MISC (gtk_misc_get_type ())
#define GTK_MISC(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_MISC, GtkMisc))
#define GTK_MISC_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_MISC, GtkMiscClass))
#define GTK_IS_MISC(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_MISC))
#define GTK_IS_MISC_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_MISC))
#define GTK_MISC_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_MISC, GtkMiscClass))

type GtkMisc as _GtkMisc
type GtkMiscClass as _GtkMiscClass

type _GtkMisc
	widget as GtkWidget
	xalign as gfloat
	yalign as gfloat
	xpad as guint16
	ypad as guint16
end type

type _GtkMiscClass
	parent_class as GtkWidgetClass
end type

declare function gtk_misc_get_type () as GType
declare sub gtk_misc_set_alignment (byval misc as GtkMisc ptr, byval xalign as gfloat, byval yalign as gfloat)
declare sub gtk_misc_get_alignment (byval misc as GtkMisc ptr, byval xalign as gfloat ptr, byval yalign as gfloat ptr)
declare sub gtk_misc_set_padding (byval misc as GtkMisc ptr, byval xpad as gint, byval ypad as gint)
declare sub gtk_misc_get_padding (byval misc as GtkMisc ptr, byval xpad as gint ptr, byval ypad as gint ptr)

#endif
