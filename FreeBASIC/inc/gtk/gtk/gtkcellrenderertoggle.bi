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

#include once "gtk/gtk/gtkcellrenderer.bi"

type GtkCellRendererToggle as _GtkCellRendererToggle
type GtkCellRendererToggleClass as _GtkCellRendererToggleClass

type _GtkCellRendererToggle
	parent as GtkCellRenderer
	active as guint
	activatable as guint
	radio as guint
end type

type _GtkCellRendererToggleClass
	parent_class as GtkCellRendererClass
	toggled as sub cdecl(byval as GtkCellRendererToggle ptr, byval as string)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_cell_renderer_toggle_get_type cdecl alias "gtk_cell_renderer_toggle_get_type" () as GType
declare function gtk_cell_renderer_toggle_new cdecl alias "gtk_cell_renderer_toggle_new" () as GtkCellRenderer ptr
declare function gtk_cell_renderer_toggle_get_radio cdecl alias "gtk_cell_renderer_toggle_get_radio" (byval toggle as GtkCellRendererToggle ptr) as gboolean
declare sub gtk_cell_renderer_toggle_set_radio cdecl alias "gtk_cell_renderer_toggle_set_radio" (byval toggle as GtkCellRendererToggle ptr, byval radio as gboolean)
declare function gtk_cell_renderer_toggle_get_active cdecl alias "gtk_cell_renderer_toggle_get_active" (byval toggle as GtkCellRendererToggle ptr) as gboolean
declare sub gtk_cell_renderer_toggle_set_active cdecl alias "gtk_cell_renderer_toggle_set_active" (byval toggle as GtkCellRendererToggle ptr, byval setting as gboolean)

#endif
