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

#include once "gtkcellrenderer.bi"

#define GTK_TYPE_CELL_RENDERER_PIXBUF (gtk_cell_renderer_pixbuf_get_type ())
#define GTK_CELL_RENDERER_PIXBUF(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_RENDERER_PIXBUF, GtkCellRendererPixbuf))
#define GTK_CELL_RENDERER_PIXBUF_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CELL_RENDERER_PIXBUF, GtkCellRendererPixbufClass))
#define GTK_IS_CELL_RENDERER_PIXBUF(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_RENDERER_PIXBUF))
#define GTK_IS_CELL_RENDERER_PIXBUF_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CELL_RENDERER_PIXBUF))
#define GTK_CELL_RENDERER_PIXBUF_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CELL_RENDERER_PIXBUF, GtkCellRendererPixbufClass))

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

declare function gtk_cell_renderer_pixbuf_get_type () as GType
declare function gtk_cell_renderer_pixbuf_new () as GtkCellRenderer ptr

#endif
