''
''
'' gtkcelleditable -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcelleditable_bi__
#define __gtkcelleditable_bi__

#include once "gtkwidget.bi"

#define GTK_TYPE_CELL_EDITABLE (gtk_cell_editable_get_type ())
#define GTK_CELL_EDITABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_EDITABLE, GtkCellEditable))
#define GTK_CELL_EDITABLE_CLASS(obj) (G_TYPE_CHECK_CLASS_CAST ((obj), GTK_TYPE_CELL_EDITABLE, GtkCellEditableIface))
#define GTK_IS_CELL_EDITABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_EDITABLE))
#define GTK_CELL_EDITABLE_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GTK_TYPE_CELL_EDITABLE, GtkCellEditableIface))

type GtkCellEditable as _GtkCellEditable
type GtkCellEditableIface as _GtkCellEditableIface

type _GtkCellEditableIface
	g_iface as GTypeInterface
	editing_done as sub cdecl(byval as GtkCellEditable ptr)
	remove_widget as sub cdecl(byval as GtkCellEditable ptr)
	start_editing as sub cdecl(byval as GtkCellEditable ptr, byval as GdkEvent ptr)
end type

declare function gtk_cell_editable_get_type () as GType
declare sub gtk_cell_editable_start_editing (byval cell_editable as GtkCellEditable ptr, byval event as GdkEvent ptr)
declare sub gtk_cell_editable_editing_done (byval cell_editable as GtkCellEditable ptr)
declare sub gtk_cell_editable_remove_widget (byval cell_editable as GtkCellEditable ptr)

#endif
