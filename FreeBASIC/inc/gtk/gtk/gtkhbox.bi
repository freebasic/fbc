''
''
'' gtkhbox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkhbox_bi__
#define __gtkhbox_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkbox.bi"

type GtkHBox as _GtkHBox
type GtkHBoxClass as _GtkHBoxClass

type _GtkHBox
	box as GtkBox
end type

type _GtkHBoxClass
	parent_class as GtkBoxClass
end type

declare function gtk_hbox_get_type cdecl alias "gtk_hbox_get_type" () as GType
declare function gtk_hbox_new cdecl alias "gtk_hbox_new" (byval homogeneous as gboolean, byval spacing as gint) as GtkWidget ptr

#endif
