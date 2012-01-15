''
''
'' gtkeditable -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkeditable_bi__
#define __gtkeditable_bi__

#include once "gtk/gdk.bi"
#include once "gtkwidget.bi"

#define GTK_TYPE_EDITABLE (gtk_editable_get_type ())
#define GTK_EDITABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_EDITABLE, GtkEditable))
#define GTK_EDITABLE_CLASS(vtable) (G_TYPE_CHECK_CLASS_CAST ((vtable), GTK_TYPE_EDITABLE, GtkEditableClass))
#define GTK_IS_EDITABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_EDITABLE))
#define GTK_IS_EDITABLE_CLASS(vtable) (G_TYPE_CHECK_CLASS_TYPE ((vtable), GTK_TYPE_EDITABLE))
#define GTK_EDITABLE_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), GTK_TYPE_EDITABLE, GtkEditableClass))

type GtkEditable as _GtkEditable
type GtkEditableClass as _GtkEditableClass

type _GtkEditableClass
	base_iface as GTypeInterface
	insert_text as sub cdecl(byval as GtkEditable ptr, byval as zstring ptr, byval as gint, byval as gint ptr)
	delete_text as sub cdecl(byval as GtkEditable ptr, byval as gint, byval as gint)
	changed as sub cdecl(byval as GtkEditable ptr)
	do_insert_text as sub cdecl(byval as GtkEditable ptr, byval as zstring ptr, byval as gint, byval as gint ptr)
	do_delete_text as sub cdecl(byval as GtkEditable ptr, byval as gint, byval as gint)
	get_chars as function cdecl(byval as GtkEditable ptr, byval as gint, byval as gint) as gchar
	set_selection_bounds as sub cdecl(byval as GtkEditable ptr, byval as gint, byval as gint)
	get_selection_bounds as function cdecl(byval as GtkEditable ptr, byval as gint ptr, byval as gint ptr) as gboolean
	set_position as sub cdecl(byval as GtkEditable ptr, byval as gint)
	get_position as function cdecl(byval as GtkEditable ptr) as gint
end type

declare function gtk_editable_get_type () as GType
declare sub gtk_editable_select_region (byval editable as GtkEditable ptr, byval start as gint, byval end as gint)
declare function gtk_editable_get_selection_bounds (byval editable as GtkEditable ptr, byval start as gint ptr, byval end as gint ptr) as gboolean
declare sub gtk_editable_insert_text (byval editable as GtkEditable ptr, byval new_text as zstring ptr, byval new_text_length as gint, byval position as gint ptr)
declare sub gtk_editable_delete_text (byval editable as GtkEditable ptr, byval start_pos as gint, byval end_pos as gint)
declare function gtk_editable_get_chars (byval editable as GtkEditable ptr, byval start_pos as gint, byval end_pos as gint) as zstring ptr
declare sub gtk_editable_cut_clipboard (byval editable as GtkEditable ptr)
declare sub gtk_editable_copy_clipboard (byval editable as GtkEditable ptr)
declare sub gtk_editable_paste_clipboard (byval editable as GtkEditable ptr)
declare sub gtk_editable_delete_selection (byval editable as GtkEditable ptr)
declare sub gtk_editable_set_position (byval editable as GtkEditable ptr, byval position as gint)
declare function gtk_editable_get_position (byval editable as GtkEditable ptr) as gint
declare sub gtk_editable_set_editable (byval editable as GtkEditable ptr, byval is_editable as gboolean)
declare function gtk_editable_get_editable (byval editable as GtkEditable ptr) as gboolean

#endif
