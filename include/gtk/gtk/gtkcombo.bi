''
''
'' gtkcombo -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcombo_bi__
#define __gtkcombo_bi__

#include once "gtkhbox.bi"
#include once "gtkitem.bi"

#define GTK_TYPE_COMBO              gtk_combo_get_type()
#define GTK_COMBO(obj)              G_TYPE_CHECK_INSTANCE_CAST(obj, GTK_TYPE_COMBO, GtkCombo)
#define GTK_COMBO_CLASS(klass)      G_TYPE_CHECK_CLASS_CAST(klass, GTK_TYPE_COMBO, GtkComboClass)
#define GTK_IS_COMBO(obj)           G_TYPE_CHECK_INSTANCE_TYPE(obj, GTK_TYPE_COMBO)
#define GTK_IS_COMBO_CLASS(klass)   G_TYPE_CHECK_CLASS_TYPE(klass, GTK_TYPE_COMBO)
#define GTK_COMBO_GET_CLASS(obj)    G_TYPE_INSTANCE_GET_CLASS(obj, GTK_TYPE_COMBO, GtkComboClass)

type GtkCombo as _GtkCombo
type GtkComboClass as _GtkComboClass

type _GtkCombo
	hbox as GtkHBox
	entry as GtkWidget ptr
	button as GtkWidget ptr
	popup as GtkWidget ptr
	popwin as GtkWidget ptr
	list as GtkWidget ptr
	entry_change_id as guint
	list_change_id as guint
	value_in_list:1 as guint
	ok_if_empty:1 as guint
	case_sensitive:1 as guint
	use_arrows:1 as guint
	use_arrows_always:1 as guint
	current_button as guint16
	activate_id as guint
end type

type _GtkComboClass
	parent_class as GtkHBoxClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_combo_get_type () as GType
declare function gtk_combo_new () as GtkWidget ptr
declare sub gtk_combo_set_value_in_list (byval combo as GtkCombo ptr, byval val as gboolean, byval ok_if_empty as gboolean)
declare sub gtk_combo_set_use_arrows (byval combo as GtkCombo ptr, byval val as gboolean)
declare sub gtk_combo_set_use_arrows_always (byval combo as GtkCombo ptr, byval val as gboolean)
declare sub gtk_combo_set_case_sensitive (byval combo as GtkCombo ptr, byval val as gboolean)
declare sub gtk_combo_set_item_string (byval combo as GtkCombo ptr, byval item as GtkItem ptr, byval item_value as zstring ptr)
declare sub gtk_combo_set_popdown_strings (byval combo as GtkCombo ptr, byval strings as GList ptr)
declare sub gtk_combo_disable_activate (byval combo as GtkCombo ptr)

#endif
