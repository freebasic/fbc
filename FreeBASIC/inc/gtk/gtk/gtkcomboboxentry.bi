''
''
'' gtkcomboboxentry -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcomboboxentry_bi__
#define __gtkcomboboxentry_bi__

#include once "gtkcombobox.bi"
#include once "gtktreemodel.bi"

#define GTK_TYPE_COMBO_BOX_ENTRY (gtk_combo_box_entry_get_type ())
#define GTK_COMBO_BOX_ENTRY(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_COMBO_BOX_ENTRY, GtkComboBoxEntry))
#define GTK_COMBO_BOX_ENTRY_CLASS(vtable) (G_TYPE_CHECK_CLASS_CAST ((vtable), GTK_TYPE_COMBO_BOX_ENTRY, GtkComboBoxEntryClass))
#define GTK_IS_COMBO_BOX_ENTRY(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_COMBO_BOX_ENTRY))
#define GTK_IS_COMBO_BOX_ENTRY_CLASS(vtable) (G_TYPE_CHECK_CLASS_TYPE ((vtable), GTK_TYPE_COMBO_BOX_ENTRY))
#define GTK_COMBO_BOX_ENTRY_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), GTK_TYPE_COMBO_BOX_ENTRY, GtkComboBoxEntryClass))

type GtkComboBoxEntry as _GtkComboBoxEntry
type GtkComboBoxEntryClass as _GtkComboBoxEntryClass
type GtkComboBoxEntryPrivate as _GtkComboBoxEntryPrivate

type _GtkComboBoxEntry
	parent_instance as GtkComboBox
	priv as GtkComboBoxEntryPrivate ptr
end type

type _GtkComboBoxEntryClass
	parent_class as GtkComboBoxClass
	_gtk_reserved0 as sub cdecl()
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
end type

declare function gtk_combo_box_entry_get_type () as GType
declare function gtk_combo_box_entry_new () as GtkWidget ptr
declare function gtk_combo_box_entry_new_with_model (byval model as GtkTreeModel ptr, byval text_column as gint) as GtkWidget ptr
declare sub gtk_combo_box_entry_set_text_column (byval entry_box as GtkComboBoxEntry ptr, byval text_column as gint)
declare function gtk_combo_box_entry_get_text_column (byval entry_box as GtkComboBoxEntry ptr) as gint
declare function gtk_combo_box_entry_new_text () as GtkWidget ptr

#endif
