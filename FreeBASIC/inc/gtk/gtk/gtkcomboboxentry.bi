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

#include once "gtk/gtk/gtkcombobox.bi"
#include once "gtk/gtk/gtktreemodel.bi"

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

declare function gtk_combo_box_entry_get_type cdecl alias "gtk_combo_box_entry_get_type" () as GType
declare function gtk_combo_box_entry_new cdecl alias "gtk_combo_box_entry_new" () as GtkWidget ptr
declare function gtk_combo_box_entry_new_with_model cdecl alias "gtk_combo_box_entry_new_with_model" (byval model as GtkTreeModel ptr, byval text_column as gint) as GtkWidget ptr
declare sub gtk_combo_box_entry_set_text_column cdecl alias "gtk_combo_box_entry_set_text_column" (byval entry_box as GtkComboBoxEntry ptr, byval text_column as gint)
declare function gtk_combo_box_entry_get_text_column cdecl alias "gtk_combo_box_entry_get_text_column" (byval entry_box as GtkComboBoxEntry ptr) as gint
declare function gtk_combo_box_entry_new_text cdecl alias "gtk_combo_box_entry_new_text" () as GtkWidget ptr

#endif
