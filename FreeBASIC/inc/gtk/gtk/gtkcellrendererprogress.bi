''
''
'' gtkcellrendererprogress -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcellrendererprogress_bi__
#define __gtkcellrendererprogress_bi__

#include once "gtk/gtk/gtkcellrenderer.bi"

type GtkCellRendererProgress as _GtkCellRendererProgress
type GtkCellRendererProgressClass as _GtkCellRendererProgressClass
type GtkCellRendererProgressPrivate as _GtkCellRendererProgressPrivate

type _GtkCellRendererProgress
	parent_instance as GtkCellRenderer
	priv as GtkCellRendererProgressPrivate ptr
end type

type _GtkCellRendererProgressClass
	parent_class as GtkCellRendererClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_cell_renderer_progress_get_type cdecl alias "gtk_cell_renderer_progress_get_type" () as GType
declare function gtk_cell_renderer_progress_new cdecl alias "gtk_cell_renderer_progress_new" () as GtkCellRenderer ptr

#endif
