''
''
'' gtkfixed -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkfixed_bi__
#define __gtkfixed_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkcontainer.bi"

type GtkFixed as _GtkFixed
type GtkFixedClass as _GtkFixedClass
type GtkFixedChild as _GtkFixedChild

type _GtkFixed
	container as GtkContainer
	children as GList ptr
end type

type _GtkFixedClass
	parent_class as GtkContainerClass
end type

type _GtkFixedChild
	widget as GtkWidget ptr
	x as gint
	y as gint
end type

declare function gtk_fixed_get_type cdecl alias "gtk_fixed_get_type" () as GType
declare function gtk_fixed_new cdecl alias "gtk_fixed_new" () as GtkWidget ptr
declare sub gtk_fixed_put cdecl alias "gtk_fixed_put" (byval fixed as GtkFixed ptr, byval widget as GtkWidget ptr, byval x as gint, byval y as gint)
declare sub gtk_fixed_move cdecl alias "gtk_fixed_move" (byval fixed as GtkFixed ptr, byval widget as GtkWidget ptr, byval x as gint, byval y as gint)
declare sub gtk_fixed_set_has_window cdecl alias "gtk_fixed_set_has_window" (byval fixed as GtkFixed ptr, byval has_window as gboolean)
declare function gtk_fixed_get_has_window cdecl alias "gtk_fixed_get_has_window" (byval fixed as GtkFixed ptr) as gboolean

#endif
