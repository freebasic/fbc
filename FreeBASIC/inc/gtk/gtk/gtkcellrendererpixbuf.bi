''
''
'' gtkcellrendererpixbuf -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcellrendererpixbuf_bi__
#define __gtkcellrendererpixbuf_bi__

#include once "gtk/gtk/gtkcellrenderer.bi"

type GtkCellRendererPixbuf as _GtkCellRendererPixbuf
type GtkCellRendererPixbufClass as _GtkCellRendererPixbufClass

type _GtkCellRendererPixbuf
	parent as GtkCellRenderer
	pixbuf as GdkPixbuf ptr
	pixbuf_expander_open as GdkPixbuf ptr
	pixbuf_expander_closed as GdkPixbuf ptr
end type

type _GtkCellRendererPixbufClass
	parent_class as GtkCellRendererClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_cell_renderer_pixbuf_get_type cdecl alias "gtk_cell_renderer_pixbuf_get_type" () as GType
declare function gtk_cell_renderer_pixbuf_new cdecl alias "gtk_cell_renderer_pixbuf_new" () as GtkCellRenderer ptr

#endif
