''
''
'' gtkcellrenderercombo -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcellrenderercombo_bi__
#define __gtkcellrenderercombo_bi__

#include once "gtk/gtk/gtktreemodel.bi"
#include once "gtk/gtk/gtkcellrenderertext.bi"

type GtkCellRendererCombo as _GtkCellRendererCombo
type GtkCellRendererComboClass as _GtkCellRendererComboClass

type _GtkCellRendererCombo
	parent as GtkCellRendererText
	model as GtkTreeModel ptr
	text_column as gint
	has_entry as gboolean
	focus_out_id as guint
end type

type _GtkCellRendererComboClass
	parent as GtkCellRendererTextClass
end type

declare function gtk_cell_renderer_combo_get_type cdecl alias "gtk_cell_renderer_combo_get_type" () as GType
declare function gtk_cell_renderer_combo_new cdecl alias "gtk_cell_renderer_combo_new" () as GtkCellRenderer ptr

#endif
