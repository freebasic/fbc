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
#include once "gtk/gtk/gtkwidget.bi"

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

declare function gtk_misc_get_type cdecl alias "gtk_misc_get_type" () as GType
declare sub gtk_misc_set_alignment cdecl alias "gtk_misc_set_alignment" (byval misc as GtkMisc ptr, byval xalign as gfloat, byval yalign as gfloat)
declare sub gtk_misc_get_alignment cdecl alias "gtk_misc_get_alignment" (byval misc as GtkMisc ptr, byval xalign as gfloat ptr, byval yalign as gfloat ptr)
declare sub gtk_misc_set_padding cdecl alias "gtk_misc_set_padding" (byval misc as GtkMisc ptr, byval xpad as gint, byval ypad as gint)
declare sub gtk_misc_get_padding cdecl alias "gtk_misc_get_padding" (byval misc as GtkMisc ptr, byval xpad as gint ptr, byval ypad as gint ptr)

#endif
