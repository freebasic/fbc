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

#include once "gtk/gtk/gtkpaned.bi"

type GtkHPaned as _GtkHPaned
type GtkHPanedClass as _GtkHPanedClass

type _GtkHPaned
	paned as GtkPaned
end type

type _GtkHPanedClass
	parent_class as GtkPanedClass
end type

declare function gtk_hpaned_get_type cdecl alias "gtk_hpaned_get_type" () as GType
declare function gtk_hpaned_new cdecl alias "gtk_hpaned_new" () as GtkWidget ptr

#endif
