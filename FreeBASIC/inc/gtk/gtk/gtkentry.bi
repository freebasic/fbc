''
''
'' gtkentry -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkentry_bi__
#define __gtkentry_bi__

#include once "gtk/gdk.bi"
#include once "gtkeditable.bi"
#include once "gtkimcontext.bi"
#include once "gtkmenu.bi"
#include once "gtkentrycompletion.bi"
#include once "gtk/pango.bi"

#define GTK_TYPE_ENTRY                  gtk_entry_get_type()
#define GTK_ENTRY(obj)                  G_TYPE_CHECK_INSTANCE_CAST(obj, GTK_TYPE_ENTRY, GtkEntry)
#define GTK_ENTRY_CLASS(klass)          G_TYPE_CHECK_CLASS_CAST(klass, GTK_TYPE_ENTRY, GtkEntryClass)
#define GTK_IS_ENTRY(obj)               G_TYPE_CHECK_INSTANCE_TYPE(obj, GTK_TYPE_ENTRY)
#define GTK_IS_ENTRY_CLASS(klass)       G_TYPE_CHECK_CLASS_TYPE(klass, GTK_TYPE_ENTRY)
#define GTK_ENTRY_GET_CLASS(obj)        G_TYPE_INSTANCE_GET_CLASS(obj, GTK_TYPE_ENTRY, GtkEntryClass)

type GtkEntry as _GtkEntry
type GtkEntryClass as _GtkEntryClass

type _GtkEntry
	widget as GtkWidget
	text as zstring ptr
	editable:1 as guint
	visible:1 as guint
	overwrite_mode:1 as guint
	in_drag:1 as guint
	text_length as guint16
	text_max_length as guint16
	text_area as GdkWindow ptr
	im_context as GtkIMContext ptr
	popup_menu as GtkWidget ptr
	current_pos as gint
	selection_bound as gint
	cached_layout as PangoLayout ptr
	cache_includes_preedit:1 as guint
	need_im_reset:1 as guint
	has_frame:1 as guint
	activates_default:1 as guint
	cursor_visible:1 as guint
	in_click:1 as guint
	is_cell_renderer:1 as guint
	editing_canceled:1 as guint
	mouse_cursor_obscured:1 as guint
	select_words:1 as guint
	select_lines:1 as guint
	resolved_dir:4 as guint
	button as guint
	blink_timeout as guint
	recompute_idle as guint
	scroll_offset as gint
	ascent as gint
	descent as gint
	text_size as guint16
	n_bytes as guint16
	preedit_length as guint16
	preedit_cursor as guint16
	dnd_position as gint
	drag_start_x as gint
	drag_start_y as gint
	invisible_char as gunichar
	width_chars as gint
end type

type _GtkEntryClass
	parent_class as GtkWidgetClass
	populate_popup as sub cdecl(byval as GtkEntry ptr, byval as GtkMenu ptr)
	activate as sub cdecl(byval as GtkEntry ptr)
	move_cursor as sub cdecl(byval as GtkEntry ptr, byval as GtkMovementStep, byval as gint, byval as gboolean)
	insert_at_cursor as sub cdecl(byval as GtkEntry ptr, byval as zstring ptr)
	delete_from_cursor as sub cdecl(byval as GtkEntry ptr, byval as GtkDeleteType, byval as gint)
	backspace as sub cdecl(byval as GtkEntry ptr)
	cut_clipboard as sub cdecl(byval as GtkEntry ptr)
	copy_clipboard as sub cdecl(byval as GtkEntry ptr)
	paste_clipboard as sub cdecl(byval as GtkEntry ptr)
	toggle_overwrite as sub cdecl(byval as GtkEntry ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
end type

declare function gtk_entry_get_type () as GType
declare function gtk_entry_new () as GtkWidget ptr
declare sub gtk_entry_set_visibility (byval entry as GtkEntry ptr, byval visible as gboolean)
declare function gtk_entry_get_visibility (byval entry as GtkEntry ptr) as gboolean
declare sub gtk_entry_set_invisible_char (byval entry as GtkEntry ptr, byval ch as gunichar)
declare function gtk_entry_get_invisible_char (byval entry as GtkEntry ptr) as gunichar
declare sub gtk_entry_set_has_frame (byval entry as GtkEntry ptr, byval setting as gboolean)
declare function gtk_entry_get_has_frame (byval entry as GtkEntry ptr) as gboolean
declare sub gtk_entry_set_max_length (byval entry as GtkEntry ptr, byval max as gint)
declare function gtk_entry_get_max_length (byval entry as GtkEntry ptr) as gint
declare sub gtk_entry_set_activates_default (byval entry as GtkEntry ptr, byval setting as gboolean)
declare function gtk_entry_get_activates_default (byval entry as GtkEntry ptr) as gboolean
declare sub gtk_entry_set_width_chars (byval entry as GtkEntry ptr, byval n_chars as gint)
declare function gtk_entry_get_width_chars (byval entry as GtkEntry ptr) as gint
declare sub gtk_entry_set_text (byval entry as GtkEntry ptr, byval text as zstring ptr)
declare function gtk_entry_get_text (byval entry as GtkEntry ptr) as zstring ptr
declare function gtk_entry_get_layout (byval entry as GtkEntry ptr) as PangoLayout ptr
declare sub gtk_entry_get_layout_offsets (byval entry as GtkEntry ptr, byval x as gint ptr, byval y as gint ptr)
declare sub gtk_entry_set_alignment (byval entry as GtkEntry ptr, byval xalign as gfloat)
declare function gtk_entry_get_alignment (byval entry as GtkEntry ptr) as gfloat
declare sub gtk_entry_set_completion (byval entry as GtkEntry ptr, byval completion as GtkEntryCompletion ptr)
declare function gtk_entry_get_completion (byval entry as GtkEntry ptr) as GtkEntryCompletion ptr
declare function gtk_entry_layout_index_to_text_index (byval entry as GtkEntry ptr, byval layout_index as gint) as gint
declare function gtk_entry_text_index_to_layout_index (byval entry as GtkEntry ptr, byval text_index as gint) as gint
declare function gtk_entry_new_with_max_length (byval max as gint) as GtkWidget ptr
declare sub gtk_entry_append_text (byval entry as GtkEntry ptr, byval text as zstring ptr)
declare sub gtk_entry_prepend_text (byval entry as GtkEntry ptr, byval text as zstring ptr)
declare sub gtk_entry_set_position (byval entry as GtkEntry ptr, byval position as gint)
declare sub gtk_entry_select_region (byval entry as GtkEntry ptr, byval start as gint, byval end as gint)
declare sub gtk_entry_set_editable (byval entry as GtkEntry ptr, byval editable as gboolean)
declare sub _gtk_entry_get_borders (byval entry as GtkEntry ptr, byval xborder as gint ptr, byval yborder as gint ptr)

#endif
