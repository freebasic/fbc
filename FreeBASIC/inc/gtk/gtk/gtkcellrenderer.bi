''
''
'' gtkcellrenderer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcellrenderer_bi__
#define __gtkcellrenderer_bi__

#include once "gtk/gtk/gtkobject.bi"
#include once "gtk/gtk/gtkwidget.bi"
#include once "gtk/gtk/gtkcelleditable.bi"

enum GtkCellRendererState
	GTK_CELL_RENDERER_SELECTED = 1 shl 0
	GTK_CELL_RENDERER_PRELIT = 1 shl 1
	GTK_CELL_RENDERER_INSENSITIVE = 1 shl 2
	GTK_CELL_RENDERER_SORTED = 1 shl 3
	GTK_CELL_RENDERER_FOCUSED = 1 shl 4
end enum


enum GtkCellRendererMode
	GTK_CELL_RENDERER_MODE_INERT
	GTK_CELL_RENDERER_MODE_ACTIVATABLE
	GTK_CELL_RENDERER_MODE_EDITABLE
end enum

type GtkCellRenderer as _GtkCellRenderer
type GtkCellRendererClass as _GtkCellRendererClass

type _GtkCellRenderer
	parent as GtkObject
	xalign as gfloat
	yalign as gfloat
	width as gint
	height as gint
	xpad as guint16
	ypad as guint16
	mode:2 as guint
	visible:1 as guint
	is_expander:1 as guint
	is_expanded:1 as guint
	cell_background_set:1 as guint
	sensitive:1 as guint
	editing:1 as guint
end type

type _GtkCellRendererClass
	parent_class as GtkObjectClass
	get_size as sub cdecl(byval as GtkCellRenderer ptr, byval as GtkWidget ptr, byval as GdkRectangle ptr, byval as gint ptr, byval as gint ptr, byval as gint ptr, byval as gint ptr)
	render as sub cdecl(byval as GtkCellRenderer ptr, byval as GdkDrawable ptr, byval as GtkWidget ptr, byval as GdkRectangle ptr, byval as GdkRectangle ptr, byval as GdkRectangle ptr, byval as GtkCellRendererState)
	activate as function cdecl(byval as GtkCellRenderer ptr, byval as GdkEvent ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as GdkRectangle ptr, byval as GdkRectangle ptr, byval as GtkCellRendererState) as gboolean
	start_editing as function cdecl(byval as GtkCellRenderer ptr, byval as GdkEvent ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as GdkRectangle ptr, byval as GdkRectangle ptr, byval as GtkCellRendererState) as GtkCellEditable ptr
	editing_canceled as sub cdecl(byval as GtkCellRenderer ptr)
	editing_started as sub cdecl(byval as GtkCellRenderer ptr, byval as GtkCellEditable ptr, byval as zstring ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
end type

declare function gtk_cell_renderer_get_type cdecl alias "gtk_cell_renderer_get_type" () as GType
declare sub gtk_cell_renderer_get_size cdecl alias "gtk_cell_renderer_get_size" (byval cell as GtkCellRenderer ptr, byval widget as GtkWidget ptr, byval cell_area as GdkRectangle ptr, byval x_offset as gint ptr, byval y_offset as gint ptr, byval width as gint ptr, byval height as gint ptr)
declare sub gtk_cell_renderer_render cdecl alias "gtk_cell_renderer_render" (byval cell as GtkCellRenderer ptr, byval window as GdkWindow ptr, byval widget as GtkWidget ptr, byval background_area as GdkRectangle ptr, byval cell_area as GdkRectangle ptr, byval expose_area as GdkRectangle ptr, byval flags as GtkCellRendererState)
declare function gtk_cell_renderer_activate cdecl alias "gtk_cell_renderer_activate" (byval cell as GtkCellRenderer ptr, byval event as GdkEvent ptr, byval widget as GtkWidget ptr, byval path as zstring ptr, byval background_area as GdkRectangle ptr, byval cell_area as GdkRectangle ptr, byval flags as GtkCellRendererState) as gboolean
declare function gtk_cell_renderer_start_editing cdecl alias "gtk_cell_renderer_start_editing" (byval cell as GtkCellRenderer ptr, byval event as GdkEvent ptr, byval widget as GtkWidget ptr, byval path as zstring ptr, byval background_area as GdkRectangle ptr, byval cell_area as GdkRectangle ptr, byval flags as GtkCellRendererState) as GtkCellEditable ptr
declare sub gtk_cell_renderer_set_fixed_size cdecl alias "gtk_cell_renderer_set_fixed_size" (byval cell as GtkCellRenderer ptr, byval width as gint, byval height as gint)
declare sub gtk_cell_renderer_get_fixed_size cdecl alias "gtk_cell_renderer_get_fixed_size" (byval cell as GtkCellRenderer ptr, byval width as gint ptr, byval height as gint ptr)
declare sub gtk_cell_renderer_editing_canceled cdecl alias "gtk_cell_renderer_editing_canceled" (byval cell as GtkCellRenderer ptr)
declare sub gtk_cell_renderer_stop_editing cdecl alias "gtk_cell_renderer_stop_editing" (byval cell as GtkCellRenderer ptr, byval canceled as gboolean)

#endif
