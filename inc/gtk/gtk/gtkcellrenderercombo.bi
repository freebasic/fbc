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

#include once "gtktreemodel.bi"
#include once "gtkcellrenderertext.bi"

#define GTK_TYPE_CELL_RENDERER_COMBO (gtk_cell_renderer_combo_get_type ())
#define GTK_CELL_RENDERER_COMBO(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_RENDERER_COMBO, GtkCellRendererCombo))
#define GTK_CELL_RENDERER_COMBO_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CELL_RENDERER_COMBO, GtkCellRendererComboClass))
#define GTK_IS_CELL_RENDERER_COMBO(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_RENDERER_COMBO))
#define GTK_IS_CELL_RENDERER_COMBO_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CELL_RENDERER_COMBO))
#define GTK_CELL_RENDERER_COMBO_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CELL_RENDERER_COMBO, GtkCellRendererTextClass))

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

declare function gtk_cell_renderer_combo_get_type () as GType
declare function gtk_cell_renderer_combo_new () as GtkCellRenderer ptr

#endif
