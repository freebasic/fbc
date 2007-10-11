''
''
'' gtkoldeditable -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkoldeditable_bi__
#define __gtkoldeditable_bi__

#include once "gtk/gdk.bi"
#include once "gtkeditable.bi"
#include once "gtkwidget.bi"

#define GTK_TYPE_OLD_EDITABLE (gtk_old_editable_get_type ())
#define GTK_OLD_EDITABLE(obj) (GTK_CHECK_CAST ((obj), GTK_TYPE_OLD_EDITABLE, GtkOldEditable))
#define GTK_OLD_EDITABLE_CLASS(klass) (GTK_CHECK_CLASS_CAST ((klass), GTK_TYPE_OLD_EDITABLE, GtkOldEditableClass))
#define GTK_IS_OLD_EDITABLE(obj) (GTK_CHECK_TYPE ((obj), GTK_TYPE_OLD_EDITABLE))
#define GTK_IS_OLD_EDITABLE_CLASS(klass) (GTK_CHECK_CLASS_TYPE ((klass), GTK_TYPE_OLD_EDITABLE))
#define GTK_OLD_EDITABLE_GET_CLASS(obj) (GTK_CHECK_GET_CLASS ((obj), GTK_TYPE_OLD_EDITABLE, GtkOldEditableClass))

type GtkOldEditable as _GtkOldEditable
type GtkOldEditableClass as _GtkOldEditableClass
type GtkTextFunction as sub cdecl(byval as GtkOldEditable ptr, byval as guint32)

type _GtkOldEditable
	widget as GtkWidget
	current_pos as guint
	selection_start_pos as guint
	selection_end_pos as guint
	has_selection:1 as guint
	editable:1 as guint
	visible:1 as guint
	clipboard_text as zstring ptr
end type

type _GtkOldEditableClass
	parent_class as GtkWidgetClass
	activate as sub cdecl(byval as GtkOldEditable ptr)
	set_editable as sub cdecl(byval as GtkOldEditable ptr, byval as gboolean)
	move_cursor as sub cdecl(byval as GtkOldEditable ptr, byval as gint, byval as gint)
	move_word as sub cdecl(byval as GtkOldEditable ptr, byval as gint)
	move_page as sub cdecl(byval as GtkOldEditable ptr, byval as gint, byval as gint)
	move_to_row as sub cdecl(byval as GtkOldEditable ptr, byval as gint)
	move_to_column as sub cdecl(byval as GtkOldEditable ptr, byval as gint)
	kill_char as sub cdecl(byval as GtkOldEditable ptr, byval as gint)
	kill_word as sub cdecl(byval as GtkOldEditable ptr, byval as gint)
	kill_line as sub cdecl(byval as GtkOldEditable ptr, byval as gint)
	cut_clipboard as sub cdecl(byval as GtkOldEditable ptr)
	copy_clipboard as sub cdecl(byval as GtkOldEditable ptr)
	paste_clipboard as sub cdecl(byval as GtkOldEditable ptr)
	update_text as sub cdecl(byval as GtkOldEditable ptr, byval as gint, byval as gint)
	get_chars as function cdecl(byval as GtkOldEditable ptr, byval as gint, byval as gint) as gchar
	set_selection as sub cdecl(byval as GtkOldEditable ptr, byval as gint, byval as gint)
	set_position as sub cdecl(byval as GtkOldEditable ptr, byval as gint)
end type

declare function gtk_old_editable_get_type () as GtkType
declare sub gtk_old_editable_claim_selection (byval old_editable as GtkOldEditable ptr, byval claim as gboolean, byval time_ as guint32)
declare sub gtk_old_editable_changed (byval old_editable as GtkOldEditable ptr)

#endif
