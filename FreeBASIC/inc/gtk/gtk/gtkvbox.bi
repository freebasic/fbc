''
''
'' gtkvbox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkvbox_bi__
#define __gtkvbox_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkbox.bi"

type GtkVBox as _GtkVBox
type GtkVBoxClass as _GtkVBoxClass

type _GtkVBox
	box as GtkBox
end type

type _GtkVBoxClass
	parent_class as GtkBoxClass
end type

declare function gtk_vbox_get_type cdecl alias "gtk_vbox_get_type" () as GType
declare function gtk_vbox_new cdecl alias "gtk_vbox_new" (byval homogeneous as gboolean, byval spacing as gint) as GtkWidget ptr

#endif
