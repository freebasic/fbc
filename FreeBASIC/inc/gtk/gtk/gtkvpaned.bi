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

#include once "gtk/gtk/gtkpaned.bi"

type GtkVPaned as _GtkVPaned
type GtkVPanedClass as _GtkVPanedClass

type _GtkVPaned
	paned as GtkPaned
end type

type _GtkVPanedClass
	parent_class as GtkPanedClass
end type

declare function gtk_vpaned_get_type cdecl alias "gtk_vpaned_get_type" () as GType
declare function gtk_vpaned_new cdecl alias "gtk_vpaned_new" () as GtkWidget ptr

#endif
