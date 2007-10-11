''
''
'' gtkcellrenderertoggle -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcellrenderertoggle_bi__
#define __gtkcellrenderertoggle_bi__

#include once "gtkcellrenderer.bi"

#define GTK_TYPE_CELL_RENDERER_TOGGLE (gtk_cell_renderer_toggle_get_type ())
#define GTK_CELL_RENDERER_TOGGLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_RENDERER_TOGGLE, GtkCellRendererToggle))
#define GTK_CELL_RENDERER_TOGGLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CELL_RENDERER_TOGGLE, GtkCellRendererToggleClass))
#define GTK_IS_CELL_RENDERER_TOGGLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_RENDERER_TOGGLE))
#define GTK_IS_CELL_RENDERER_TOGGLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CELL_RENDERER_TOGGLE))
#define GTK_CELL_RENDERER_TOGGLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CELL_RENDERER_TOGGLE, GtkCellRendererToggleClass))

type GtkCellRendererToggle as _GtkCellRendererToggle
type GtkCellRendererToggleClass as _GtkCellRendererToggleClass

type _GtkCellRendererToggle
	parent as GtkCellRenderer
	active:1 as guint
	activatable:1 as guint
	radio:1 as guint
end type

type _GtkCellRendererToggleClass
	parent_class as GtkCellRendererClass
	toggled as sub cdecl(byval as GtkCellRendererToggle ptr, byval as zstring ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_cell_renderer_toggle_get_type () as GType
declare function gtk_cell_renderer_toggle_new () as GtkCellRenderer ptr
declare function gtk_cell_renderer_toggle_get_radio (byval toggle as GtkCellRendererToggle ptr) as gboolean
declare sub gtk_cell_renderer_toggle_set_radio (byval toggle as GtkCellRendererToggle ptr, byval radio as gboolean)
declare function gtk_cell_renderer_toggle_get_active (byval toggle as GtkCellRendererToggle ptr) as gboolean
declare sub gtk_cell_renderer_toggle_set_active (byval toggle as GtkCellRendererToggle ptr, byval setting as gboolean)

#endif
