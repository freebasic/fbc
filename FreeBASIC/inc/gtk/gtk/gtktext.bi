''
''
'' gtktext -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktext_bi__
#define __gtktext_bi__

#include once "gtk/gdk.bi"
#include once "gtkadjustment.bi"
#include once "gtkoldeditable.bi"

#define GTK_TYPE_TEXT (gtk_text_get_type ())
#define GTK_TEXT(obj) (GTK_CHECK_CAST ((obj), GTK_TYPE_TEXT, GtkText))
#define GTK_TEXT_CLASS(klass) (GTK_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEXT, GtkTextClass))
#define GTK_IS_TEXT(obj) (GTK_CHECK_TYPE ((obj), GTK_TYPE_TEXT))
#define GTK_IS_TEXT_CLASS(klass) (GTK_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEXT))
#define GTK_TEXT_GET_CLASS(obj) (GTK_CHECK_GET_CLASS ((obj), GTK_TYPE_TEXT, GtkTextClass))

type GtkTextFont as _GtkTextFont
type GtkPropertyMark as _GtkPropertyMark
type GtkText as _GtkText
type GtkTextClass as _GtkTextClass

type _GtkPropertyMark
	property as GList ptr
	offset as guint
	index as guint
end type

union _GtkText_scratch_buffer
	wc as GdkWChar ptr
	ch as guchar ptr
end union

union _GtkText_text
	wc as GdkWChar ptr
	ch as guchar ptr
end union

type _GtkText
	old_editable as GtkOldEditable
	text_area as GdkWindow ptr
	hadj as GtkAdjustment ptr
	vadj as GtkAdjustment ptr
	gc as GdkGC ptr
	line_wrap_bitmap as GdkPixmap ptr
	line_arrow_bitmap as GdkPixmap ptr
	text_len as guint
	gap_position as guint
	gap_size as guint
	text_end as guint
	line_start_cache as GList ptr
	first_line_start_index as guint
	first_cut_pixels as guint
	first_onscreen_hor_pixel as guint
	first_onscreen_ver_pixel as guint
	line_wrap:1 as guint
	word_wrap:1 as guint
	use_wchar:1 as guint
	freeze_count as guint
	text_properties as GList ptr
	text_properties_end as GList ptr
	point as GtkPropertyMark
	scratch_buffer_len as guint
	last_ver_value as gint
	cursor_pos_x as gint
	cursor_pos_y as gint
	cursor_mark as GtkPropertyMark
	cursor_char as GdkWChar
	cursor_char_offset as gchar
	cursor_virtual_x as gint
	cursor_drawn_level as gint
	current_line as GList ptr
	tab_stops as GList ptr
	default_tab_width as gint
	current_font as GtkTextFont ptr
	timer as gint
	button as guint
	bg_gc as GdkGC ptr
	scratch_buffer as _GtkText_scratch_buffer
	text as _GtkText_text
end type

type _GtkTextClass
	parent_class as GtkOldEditableClass
	set_scroll_adjustments as sub cdecl(byval as GtkText ptr, byval as GtkAdjustment ptr, byval as GtkAdjustment ptr)
end type

declare function gtk_text_get_type () as GtkType
declare function gtk_text_new (byval hadj as GtkAdjustment ptr, byval vadj as GtkAdjustment ptr) as GtkWidget ptr
declare sub gtk_text_set_editable (byval text as GtkText ptr, byval editable as gboolean)
declare sub gtk_text_set_word_wrap (byval text as GtkText ptr, byval word_wrap as gboolean)
declare sub gtk_text_set_line_wrap (byval text as GtkText ptr, byval line_wrap as gboolean)
declare sub gtk_text_set_adjustments (byval text as GtkText ptr, byval hadj as GtkAdjustment ptr, byval vadj as GtkAdjustment ptr)
declare sub gtk_text_set_point (byval text as GtkText ptr, byval index as guint)
declare function gtk_text_get_point (byval text as GtkText ptr) as guint
declare function gtk_text_get_length (byval text as GtkText ptr) as guint
declare sub gtk_text_freeze (byval text as GtkText ptr)
declare sub gtk_text_thaw (byval text as GtkText ptr)
declare sub gtk_text_insert (byval text as GtkText ptr, byval font as GdkFont ptr, byval fore as GdkColor ptr, byval back as GdkColor ptr, byval chars as zstring ptr, byval length as gint)
declare function gtk_text_backward_delete (byval text as GtkText ptr, byval nchars as guint) as gboolean
declare function gtk_text_forward_delete (byval text as GtkText ptr, byval nchars as guint) as gboolean

#define GTK_TEXT_INDEX(t, index) iif( (t)->use_wchar, _
									  iif( (index) < (t)->gap_position, (t)->text.wc[index], (t)->text.wc[(index)+(t)->gap_size] ), _
									  iif( (index) < (t)->gap_position, (t)->text.ch[index], (t)->text.ch[(index)+(t)->gap_size] ) )

#endif
