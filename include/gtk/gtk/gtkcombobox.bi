''
''
'' gtkcombobox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcombobox_bi__
#define __gtkcombobox_bi__

#include once "gtkbin.bi"
#include once "gtktreemodel.bi"
#include once "gtktreeview.bi"

#define GTK_TYPE_COMBO_BOX (gtk_combo_box_get_type ())
#define GTK_COMBO_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_COMBO_BOX, GtkComboBox))
#define GTK_COMBO_BOX_CLASS(vtable) (G_TYPE_CHECK_CLASS_CAST ((vtable), GTK_TYPE_COMBO_BOX, GtkComboBoxClass))
#define GTK_IS_COMBO_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_COMBO_BOX))
#define GTK_IS_COMBO_BOX_CLASS(vtable) (G_TYPE_CHECK_CLASS_TYPE ((vtable), GTK_TYPE_COMBO_BOX))
#define GTK_COMBO_BOX_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), GTK_TYPE_COMBO_BOX, GtkComboBoxClass))

type GtkComboBox as _GtkComboBox
type GtkComboBoxClass as _GtkComboBoxClass
type GtkComboBoxPrivate as _GtkComboBoxPrivate

type _GtkComboBox
	parent_instance as GtkBin
	priv as GtkComboBoxPrivate ptr
end type

type _GtkComboBoxClass
	parent_class as GtkBinClass
	changed as sub cdecl(byval as GtkComboBox ptr)
	_gtk_reserved0 as sub cdecl()
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
end type

declare function gtk_combo_box_get_type () as GType
declare function gtk_combo_box_new () as GtkWidget ptr
declare function gtk_combo_box_new_with_model (byval model as GtkTreeModel ptr) as GtkWidget ptr
declare function gtk_combo_box_get_wrap_width (byval combo_box as GtkComboBox ptr) as gint
declare sub gtk_combo_box_set_wrap_width (byval combo_box as GtkComboBox ptr, byval width as gint)
declare function gtk_combo_box_get_row_span_column (byval combo_box as GtkComboBox ptr) as gint
declare sub gtk_combo_box_set_row_span_column (byval combo_box as GtkComboBox ptr, byval row_span as gint)
declare function gtk_combo_box_get_column_span_column (byval combo_box as GtkComboBox ptr) as gint
declare sub gtk_combo_box_set_column_span_column (byval combo_box as GtkComboBox ptr, byval column_span as gint)
declare function gtk_combo_box_get_add_tearoffs (byval combo_box as GtkComboBox ptr) as gboolean
declare sub gtk_combo_box_set_add_tearoffs (byval combo_box as GtkComboBox ptr, byval add_tearoffs as gboolean)
declare function gtk_combo_box_get_focus_on_click (byval combo as GtkComboBox ptr) as gboolean
declare sub gtk_combo_box_set_focus_on_click (byval combo as GtkComboBox ptr, byval focus_on_click as gboolean)
declare function gtk_combo_box_get_active (byval combo_box as GtkComboBox ptr) as gint
declare sub gtk_combo_box_set_active (byval combo_box as GtkComboBox ptr, byval index_ as gint)
declare function gtk_combo_box_get_active_iter (byval combo_box as GtkComboBox ptr, byval iter as GtkTreeIter ptr) as gboolean
declare sub gtk_combo_box_set_active_iter (byval combo_box as GtkComboBox ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_combo_box_set_model (byval combo_box as GtkComboBox ptr, byval model as GtkTreeModel ptr)
declare function gtk_combo_box_get_model (byval combo_box as GtkComboBox ptr) as GtkTreeModel ptr
declare function gtk_combo_box_get_row_separator_func (byval combo_box as GtkComboBox ptr) as GtkTreeViewRowSeparatorFunc
declare sub gtk_combo_box_set_row_separator_func (byval combo_box as GtkComboBox ptr, byval func as GtkTreeViewRowSeparatorFunc, byval data as gpointer, byval destroy as GtkDestroyNotify)
declare function gtk_combo_box_new_text () as GtkWidget ptr
declare sub gtk_combo_box_append_text (byval combo_box as GtkComboBox ptr, byval text as zstring ptr)
declare sub gtk_combo_box_insert_text (byval combo_box as GtkComboBox ptr, byval position as gint, byval text as zstring ptr)
declare sub gtk_combo_box_prepend_text (byval combo_box as GtkComboBox ptr, byval text as zstring ptr)
declare sub gtk_combo_box_remove_text (byval combo_box as GtkComboBox ptr, byval position as gint)
declare function gtk_combo_box_get_active_text (byval combo_box as GtkComboBox ptr) as zstring ptr
declare sub gtk_combo_box_popup (byval combo_box as GtkComboBox ptr)
declare sub gtk_combo_box_popdown (byval combo_box as GtkComboBox ptr)
declare function gtk_combo_box_get_popup_accessible (byval combo_box as GtkComboBox ptr) as AtkObject ptr
declare function _gtk_combo_box_editing_canceled (byval combo_box as GtkComboBox ptr) as gboolean

#endif
