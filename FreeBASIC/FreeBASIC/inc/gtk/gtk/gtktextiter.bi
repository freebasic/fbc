''
''
'' gtktextiter -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktextiter_bi__
#define __gtktextiter_bi__

#include once "gtktexttag.bi"
#include once "gtktextchild.bi"

#define GTK_TYPE_TEXT_ITER (gtk_text_iter_get_type ())

enum GtkTextSearchFlags
	GTK_TEXT_SEARCH_VISIBLE_ONLY = 1 shl 0
	GTK_TEXT_SEARCH_TEXT_ONLY = 1 shl 1
end enum

type GtkTextBuffer as _GtkTextBuffer

type _GtkTextIter
	dummy1 as gpointer
	dummy2 as gpointer
	dummy3 as gint
	dummy4 as gint
	dummy5 as gint
	dummy6 as gint
	dummy7 as gint
	dummy8 as gint
	dummy9 as gpointer
	dummy10 as gpointer
	dummy11 as gint
	dummy12 as gint
	dummy13 as gint
	dummy14 as gpointer
end type

declare function gtk_text_iter_get_buffer (byval iter as GtkTextIter ptr) as GtkTextBuffer ptr
declare function gtk_text_iter_copy (byval iter as GtkTextIter ptr) as GtkTextIter ptr
declare sub gtk_text_iter_free (byval iter as GtkTextIter ptr)
declare function gtk_text_iter_get_type () as GType
declare function gtk_text_iter_get_offset (byval iter as GtkTextIter ptr) as gint
declare function gtk_text_iter_get_line (byval iter as GtkTextIter ptr) as gint
declare function gtk_text_iter_get_line_offset (byval iter as GtkTextIter ptr) as gint
declare function gtk_text_iter_get_line_index (byval iter as GtkTextIter ptr) as gint
declare function gtk_text_iter_get_visible_line_offset (byval iter as GtkTextIter ptr) as gint
declare function gtk_text_iter_get_visible_line_index (byval iter as GtkTextIter ptr) as gint
declare function gtk_text_iter_get_char (byval iter as GtkTextIter ptr) as gunichar
declare function gtk_text_iter_get_slice (byval start as GtkTextIter ptr, byval end as GtkTextIter ptr) as zstring ptr
declare function gtk_text_iter_get_text (byval start as GtkTextIter ptr, byval end as GtkTextIter ptr) as zstring ptr
declare function gtk_text_iter_get_visible_slice (byval start as GtkTextIter ptr, byval end as GtkTextIter ptr) as zstring ptr
declare function gtk_text_iter_get_visible_text (byval start as GtkTextIter ptr, byval end as GtkTextIter ptr) as zstring ptr
declare function gtk_text_iter_get_pixbuf (byval iter as GtkTextIter ptr) as GdkPixbuf ptr
declare function gtk_text_iter_get_marks (byval iter as GtkTextIter ptr) as GSList ptr
declare function gtk_text_iter_get_child_anchor (byval iter as GtkTextIter ptr) as GtkTextChildAnchor ptr
declare function gtk_text_iter_get_toggled_tags (byval iter as GtkTextIter ptr, byval toggled_on as gboolean) as GSList ptr
declare function gtk_text_iter_begins_tag (byval iter as GtkTextIter ptr, byval tag as GtkTextTag ptr) as gboolean
declare function gtk_text_iter_ends_tag (byval iter as GtkTextIter ptr, byval tag as GtkTextTag ptr) as gboolean
declare function gtk_text_iter_toggles_tag (byval iter as GtkTextIter ptr, byval tag as GtkTextTag ptr) as gboolean
declare function gtk_text_iter_has_tag (byval iter as GtkTextIter ptr, byval tag as GtkTextTag ptr) as gboolean
declare function gtk_text_iter_get_tags (byval iter as GtkTextIter ptr) as GSList ptr
declare function gtk_text_iter_editable (byval iter as GtkTextIter ptr, byval default_setting as gboolean) as gboolean
declare function gtk_text_iter_can_insert (byval iter as GtkTextIter ptr, byval default_editability as gboolean) as gboolean
declare function gtk_text_iter_starts_word (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_ends_word (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_inside_word (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_starts_sentence (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_ends_sentence (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_inside_sentence (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_starts_line (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_ends_line (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_is_cursor_position (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_get_chars_in_line (byval iter as GtkTextIter ptr) as gint
declare function gtk_text_iter_get_bytes_in_line (byval iter as GtkTextIter ptr) as gint
declare function gtk_text_iter_get_attributes (byval iter as GtkTextIter ptr, byval values as GtkTextAttributes ptr) as gboolean
declare function gtk_text_iter_get_language (byval iter as GtkTextIter ptr) as PangoLanguage ptr
declare function gtk_text_iter_is_end (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_is_start (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_char (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_char (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_chars (byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_backward_chars (byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_forward_line (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_line (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_lines (byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_backward_lines (byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_forward_word_end (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_word_start (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_word_ends (byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_backward_word_starts (byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_forward_visible_word_end (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_visible_word_start (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_visible_word_ends (byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_backward_visible_word_starts (byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_forward_sentence_end (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_sentence_start (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_sentence_ends (byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_backward_sentence_starts (byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_forward_cursor_position (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_cursor_position (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_cursor_positions (byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_backward_cursor_positions (byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_forward_visible_cursor_position (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_visible_cursor_position (byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_visible_cursor_positions (byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_backward_visible_cursor_positions (byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare sub gtk_text_iter_set_offset (byval iter as GtkTextIter ptr, byval char_offset as gint)
declare sub gtk_text_iter_set_line (byval iter as GtkTextIter ptr, byval line_number as gint)
declare sub gtk_text_iter_set_line_offset (byval iter as GtkTextIter ptr, byval char_on_line as gint)
declare sub gtk_text_iter_set_line_index (byval iter as GtkTextIter ptr, byval byte_on_line as gint)
declare sub gtk_text_iter_forward_to_end (byval iter as GtkTextIter ptr)
declare function gtk_text_iter_forward_to_line_end (byval iter as GtkTextIter ptr) as gboolean
declare sub gtk_text_iter_set_visible_line_offset (byval iter as GtkTextIter ptr, byval char_on_line as gint)
declare sub gtk_text_iter_set_visible_line_index (byval iter as GtkTextIter ptr, byval byte_on_line as gint)
declare function gtk_text_iter_forward_to_tag_toggle (byval iter as GtkTextIter ptr, byval tag as GtkTextTag ptr) as gboolean
declare function gtk_text_iter_backward_to_tag_toggle (byval iter as GtkTextIter ptr, byval tag as GtkTextTag ptr) as gboolean

type GtkTextCharPredicate as function cdecl(byval as gunichar, byval as gpointer) as gboolean

declare function gtk_text_iter_forward_find_char (byval iter as GtkTextIter ptr, byval pred as GtkTextCharPredicate, byval user_data as gpointer, byval limit as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_find_char (byval iter as GtkTextIter ptr, byval pred as GtkTextCharPredicate, byval user_data as gpointer, byval limit as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_search (byval iter as GtkTextIter ptr, byval str as zstring ptr, byval flags as GtkTextSearchFlags, byval match_start as GtkTextIter ptr, byval match_end as GtkTextIter ptr, byval limit as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_search (byval iter as GtkTextIter ptr, byval str as zstring ptr, byval flags as GtkTextSearchFlags, byval match_start as GtkTextIter ptr, byval match_end as GtkTextIter ptr, byval limit as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_equal (byval lhs as GtkTextIter ptr, byval rhs as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_compare (byval lhs as GtkTextIter ptr, byval rhs as GtkTextIter ptr) as gint
declare function gtk_text_iter_in_range (byval iter as GtkTextIter ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr) as gboolean
declare sub gtk_text_iter_order (byval first as GtkTextIter ptr, byval second as GtkTextIter ptr)

#endif
