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

#include once "gtk/gtk/gtkwidget.bi"

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

declare function gtk_invisible_get_type cdecl alias "gtk_invisible_get_type" () as GType
declare function gtk_invisible_new cdecl alias "gtk_invisible_new" () as GtkWidget ptr
declare function gtk_invisible_new_for_screen cdecl alias "gtk_invisible_new_for_screen" (byval screen as GdkScreen ptr) as GtkWidget ptr
declare sub gtk_invisible_set_screen cdecl alias "gtk_invisible_set_screen" (byval invisible as GtkInvisible ptr, byval screen as GdkScreen ptr)
declare function gtk_invisible_get_screen cdecl alias "gtk_invisible_get_screen" (byval invisible as GtkInvisible ptr) as GdkScreen ptr

#endif
