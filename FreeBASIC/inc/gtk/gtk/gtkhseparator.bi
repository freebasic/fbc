''
''
'' gtkhseparator -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkhseparator_bi__
#define __gtkhseparator_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkseparator.bi"

type GtkHSeparator as _GtkHSeparator
type GtkHSeparatorClass as _GtkHSeparatorClass

type _GtkHSeparator
	separator as GtkSeparator
end type

type _GtkHSeparatorClass
	parent_class as GtkSeparatorClass
end type

declare function gtk_hseparator_get_type cdecl alias "gtk_hseparator_get_type" () as GType
declare function gtk_hseparator_new cdecl alias "gtk_hseparator_new" () as GtkWidget ptr

#endif
