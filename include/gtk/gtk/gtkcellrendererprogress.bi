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

#include once "gtkcellrenderer.bi"

#define GTK_TYPE_CELL_RENDERER_PROGRESS (gtk_cell_renderer_progress_get_type ())
#define GTK_CELL_RENDERER_PROGRESS(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_RENDERER_PROGRESS, GtkCellRendererProgress))
#define GTK_CELL_RENDERER_PROGRESS_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CELL_RENDERER_PROGRESS, GtkCellRendererProgressClass))
#define GTK_IS_CELL_RENDERER_PROGRESS(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_RENDERER_PROGRESS))
#define GTK_IS_CELL_RENDERER_PROGRESS_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CELL_RENDERER_PROGRESS))
#define GTK_CELL_RENDERER_PROGRESS_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CELL_RENDERER_PROGRESS, GtkCellRendererProgressClass))

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

declare function gtk_cell_renderer_progress_get_type () as GType
declare function gtk_cell_renderer_progress_new () as GtkCellRenderer ptr

#endif
