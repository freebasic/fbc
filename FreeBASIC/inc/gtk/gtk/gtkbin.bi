''
''
'' gtkbin -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkbin_bi__
#define __gtkbin_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkcontainer.bi"

type GtkBin as _GtkBin
type GtkBinClass as _GtkBinClass

type _GtkBin
	container as GtkContainer
	child as GtkWidget ptr
end type

type _GtkBinClass
	parent_class as GtkContainerClass
end type

declare function gtk_bin_get_type cdecl alias "gtk_bin_get_type" () as GType
declare function gtk_bin_get_child cdecl alias "gtk_bin_get_child" (byval bin as GtkBin ptr) as GtkWidget ptr

#endif
