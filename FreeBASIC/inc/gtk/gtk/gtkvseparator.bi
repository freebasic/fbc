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
#include once "gtk/gtk/gtkseparator.bi"

type GtkVSeparator as _GtkVSeparator
type GtkVSeparatorClass as _GtkVSeparatorClass

type _GtkVSeparator
	separator as GtkSeparator
end type

type _GtkVSeparatorClass
	parent_class as GtkSeparatorClass
end type

declare function gtk_vseparator_get_type cdecl alias "gtk_vseparator_get_type" () as GType
declare function gtk_vseparator_new cdecl alias "gtk_vseparator_new" () as GtkWidget ptr

#endif
