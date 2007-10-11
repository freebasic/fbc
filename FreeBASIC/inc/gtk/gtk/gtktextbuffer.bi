''
''
'' gtktextbuffer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktextbuffer_bi__
#define __gtktextbuffer_bi__

#include once "gtkwidget.bi"
#include once "gtkclipboard.bi"
#include once "gtktexttagtable.bi"
#include once "gtktextiter.bi"
#include once "gtktextmark.bi"
#include once "gtktextchild.bi"

#define GTK_TYPE_TEXT_BUFFER (gtk_text_buffer_get_type ())
#define GTK_TEXT_BUFFER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TEXT_BUFFER, GtkTextBuffer))
#define GTK_TEXT_BUFFER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEXT_BUFFER, GtkTextBufferClass))
#define GTK_IS_TEXT_BUFFER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TEXT_BUFFER))
#define GTK_IS_TEXT_BUFFER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEXT_BUFFER))
#define GTK_TEXT_BUFFER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEXT_BUFFER, GtkTextBufferClass))

type GtkTextBTree as _GtkTextBTree
type GtkTextLogAttrCache as _GtkTextLogAttrCache
type GtkTextBufferClass as _GtkTextBufferClass

type _GtkTextBuffer
	parent_instance as GObject
	tag_table as GtkTextTagTable ptr
	btree as GtkTextBTree ptr
	clipboard_contents_buffers as GSList ptr
	selection_clipboards as GSList ptr
	log_attr_cache as GtkTextLogAttrCache ptr
	user_action_count as guint
	modified as guint
end type

type _GtkTextBufferClass
	parent_class as GObjectClass
	insert_text as sub cdecl(byval as GtkTextBuffer ptr, byval as GtkTextIter ptr, byval as zstring ptr, byval as gint)
	insert_pixbuf as sub cdecl(byval as GtkTextBuffer ptr, byval as GtkTextIter ptr, byval as GdkPixbuf ptr)
	insert_child_anchor as sub cdecl(byval as GtkTextBuffer ptr, byval as GtkTextIter ptr, byval as GtkTextChildAnchor ptr)
	delete_range as sub cdecl(byval as GtkTextBuffer ptr, byval as GtkTextIter ptr, byval as GtkTextIter ptr)
	changed as sub cdecl(byval as GtkTextBuffer ptr)
	modified_changed as sub cdecl(byval as GtkTextBuffer ptr)
	mark_set as sub cdecl(byval as GtkTextBuffer ptr, byval as GtkTextIter ptr, byval as GtkTextMark ptr)
	mark_deleted as sub cdecl(byval as GtkTextBuffer ptr, byval as GtkTextMark ptr)
	apply_tag as sub cdecl(byval as GtkTextBuffer ptr, byval as GtkTextTag ptr, byval as GtkTextIter ptr, byval as GtkTextIter ptr)
	remove_tag as sub cdecl(byval as GtkTextBuffer ptr, byval as GtkTextTag ptr, byval as GtkTextIter ptr, byval as GtkTextIter ptr)
	begin_user_action as sub cdecl(byval as GtkTextBuffer ptr)
	end_user_action as sub cdecl(byval as GtkTextBuffer ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
	_gtk_reserved5 as sub cdecl()
	_gtk_reserved6 as sub cdecl()
end type

declare function gtk_text_buffer_get_type () as GType
declare function gtk_text_buffer_new (byval table as GtkTextTagTable ptr) as GtkTextBuffer ptr
declare function gtk_text_buffer_get_line_count (byval buffer as GtkTextBuffer ptr) as gint
declare function gtk_text_buffer_get_char_count (byval buffer as GtkTextBuffer ptr) as gint
declare function gtk_text_buffer_get_tag_table (byval buffer as GtkTextBuffer ptr) as GtkTextTagTable ptr
declare sub gtk_text_buffer_set_text (byval buffer as GtkTextBuffer ptr, byval text as zstring ptr, byval len as gint)
declare sub gtk_text_buffer_insert (byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval text as zstring ptr, byval len as gint)
declare sub gtk_text_buffer_insert_at_cursor (byval buffer as GtkTextBuffer ptr, byval text as zstring ptr, byval len as gint)
declare function gtk_text_buffer_insert_interactive (byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval text as zstring ptr, byval len as gint, byval default_editable as gboolean) as gboolean
declare function gtk_text_buffer_insert_interactive_at_cursor (byval buffer as GtkTextBuffer ptr, byval text as zstring ptr, byval len as gint, byval default_editable as gboolean) as gboolean
declare sub gtk_text_buffer_insert_range (byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr)
declare function gtk_text_buffer_insert_range_interactive (byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr, byval default_editable as gboolean) as gboolean
declare sub gtk_text_buffer_insert_with_tags (byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval text as zstring ptr, byval len as gint, byval first_tag as GtkTextTag ptr, ...)
declare sub gtk_text_buffer_insert_with_tags_by_name (byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval text as zstring ptr, byval len as gint, byval first_tag_name as zstring ptr, ...)
declare sub gtk_text_buffer_delete (byval buffer as GtkTextBuffer ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr)
declare function gtk_text_buffer_delete_interactive (byval buffer as GtkTextBuffer ptr, byval start_iter as GtkTextIter ptr, byval end_iter as GtkTextIter ptr, byval default_editable as gboolean) as gboolean
declare function gtk_text_buffer_backspace (byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval interactive as gboolean, byval default_editable as gboolean) as gboolean
declare function gtk_text_buffer_get_text (byval buffer as GtkTextBuffer ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr, byval include_hidden_chars as gboolean) as zstring ptr
declare function gtk_text_buffer_get_slice (byval buffer as GtkTextBuffer ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr, byval include_hidden_chars as gboolean) as zstring ptr
declare sub gtk_text_buffer_insert_pixbuf (byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval pixbuf as GdkPixbuf ptr)
declare sub gtk_text_buffer_insert_child_anchor (byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval anchor as GtkTextChildAnchor ptr)
declare function gtk_text_buffer_create_child_anchor (byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr) as GtkTextChildAnchor ptr
declare function gtk_text_buffer_create_mark (byval buffer as GtkTextBuffer ptr, byval mark_name as zstring ptr, byval where as GtkTextIter ptr, byval left_gravity as gboolean) as GtkTextMark ptr
declare sub gtk_text_buffer_move_mark (byval buffer as GtkTextBuffer ptr, byval mark as GtkTextMark ptr, byval where as GtkTextIter ptr)
declare sub gtk_text_buffer_delete_mark (byval buffer as GtkTextBuffer ptr, byval mark as GtkTextMark ptr)
declare function gtk_text_buffer_get_mark (byval buffer as GtkTextBuffer ptr, byval name as zstring ptr) as GtkTextMark ptr
declare sub gtk_text_buffer_move_mark_by_name (byval buffer as GtkTextBuffer ptr, byval name as zstring ptr, byval where as GtkTextIter ptr)
declare sub gtk_text_buffer_delete_mark_by_name (byval buffer as GtkTextBuffer ptr, byval name as zstring ptr)
declare function gtk_text_buffer_get_insert (byval buffer as GtkTextBuffer ptr) as GtkTextMark ptr
declare function gtk_text_buffer_get_selection_bound (byval buffer as GtkTextBuffer ptr) as GtkTextMark ptr
declare sub gtk_text_buffer_place_cursor (byval buffer as GtkTextBuffer ptr, byval where as GtkTextIter ptr)
declare sub gtk_text_buffer_select_range (byval buffer as GtkTextBuffer ptr, byval ins as GtkTextIter ptr, byval bound as GtkTextIter ptr)
declare sub gtk_text_buffer_apply_tag (byval buffer as GtkTextBuffer ptr, byval tag as GtkTextTag ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr)
declare sub gtk_text_buffer_remove_tag (byval buffer as GtkTextBuffer ptr, byval tag as GtkTextTag ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr)
declare sub gtk_text_buffer_apply_tag_by_name (byval buffer as GtkTextBuffer ptr, byval name as zstring ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr)
declare sub gtk_text_buffer_remove_tag_by_name (byval buffer as GtkTextBuffer ptr, byval name as zstring ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr)
declare sub gtk_text_buffer_remove_all_tags (byval buffer as GtkTextBuffer ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr)
declare function gtk_text_buffer_create_tag (byval buffer as GtkTextBuffer ptr, byval tag_name as zstring ptr, byval first_property_name as zstring ptr, ...) as GtkTextTag ptr
declare sub gtk_text_buffer_get_iter_at_line_offset (byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval line_number as gint, byval char_offset as gint)
declare sub gtk_text_buffer_get_iter_at_line_index (byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval line_number as gint, byval byte_index as gint)
declare sub gtk_text_buffer_get_iter_at_offset (byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval char_offset as gint)
declare sub gtk_text_buffer_get_iter_at_line (byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval line_number as gint)
declare sub gtk_text_buffer_get_start_iter (byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr)
declare sub gtk_text_buffer_get_end_iter (byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr)
declare sub gtk_text_buffer_get_bounds (byval buffer as GtkTextBuffer ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr)
declare sub gtk_text_buffer_get_iter_at_mark (byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval mark as GtkTextMark ptr)
declare sub gtk_text_buffer_get_iter_at_child_anchor (byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval anchor as GtkTextChildAnchor ptr)
declare function gtk_text_buffer_get_modified (byval buffer as GtkTextBuffer ptr) as gboolean
declare sub gtk_text_buffer_set_modified (byval buffer as GtkTextBuffer ptr, byval setting as gboolean)
declare sub gtk_text_buffer_add_selection_clipboard (byval buffer as GtkTextBuffer ptr, byval clipboard as GtkClipboard ptr)
declare sub gtk_text_buffer_remove_selection_clipboard (byval buffer as GtkTextBuffer ptr, byval clipboard as GtkClipboard ptr)
declare sub gtk_text_buffer_cut_clipboard (byval buffer as GtkTextBuffer ptr, byval clipboard as GtkClipboard ptr, byval default_editable as gboolean)
declare sub gtk_text_buffer_copy_clipboard (byval buffer as GtkTextBuffer ptr, byval clipboard as GtkClipboard ptr)
declare sub gtk_text_buffer_paste_clipboard (byval buffer as GtkTextBuffer ptr, byval clipboard as GtkClipboard ptr, byval override_location as GtkTextIter ptr, byval default_editable as gboolean)
declare function gtk_text_buffer_get_selection_bounds (byval buffer as GtkTextBuffer ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr) as gboolean
declare function gtk_text_buffer_delete_selection (byval buffer as GtkTextBuffer ptr, byval interactive as gboolean, byval default_editable as gboolean) as gboolean
declare sub gtk_text_buffer_begin_user_action (byval buffer as GtkTextBuffer ptr)
declare sub gtk_text_buffer_end_user_action (byval buffer as GtkTextBuffer ptr)
declare sub _gtk_text_buffer_spew (byval buffer as GtkTextBuffer ptr)
declare function _gtk_text_buffer_get_btree (byval buffer as GtkTextBuffer ptr) as GtkTextBTree ptr
declare function _gtk_text_buffer_get_line_log_attrs (byval buffer as GtkTextBuffer ptr, byval anywhere_in_line as GtkTextIter ptr, byval char_len as gint ptr) as PangoLogAttr ptr
declare sub _gtk_text_buffer_notify_will_remove_tag (byval buffer as GtkTextBuffer ptr, byval tag as GtkTextTag ptr)

#endif
