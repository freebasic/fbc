''
''
'' gtkseparator -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkseparator_bi__
#define __gtkseparator_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkwidget.bi"

type GtkSeparator as _GtkSeparator
type GtkSeparatorClass as _GtkSeparatorClass

type _GtkSeparator
	widget as GtkWidget
end type

type _GtkSeparatorClass
	parent_class as GtkWidgetClass
end type

declare function gtk_separator_get_type cdecl alias "gtk_separator_get_type" () as GType

#endif
