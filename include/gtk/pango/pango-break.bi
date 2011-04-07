''
''
'' pango-break -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pango_break_bi__
#define __pango_break_bi__

#include once "gtk/glib.bi"
#include once "pango-item.bi"

type _PangoLogAttr
	is_line_break:1 as guint
	is_mandatory_break:1 as guint
	is_char_break:1 as guint
	is_white:1 as guint
	is_cursor_position:1 as guint
	is_word_start:1 as guint
	is_word_end:1 as guint
	is_sentence_boundary:1 as guint
	is_sentence_start:1 as guint
	is_sentence_end:1 as guint
	backspace_deletes_character:1 as guint
end type

declare sub pango_break (byval text as zstring ptr, byval length as integer, byval analysis as PangoAnalysis ptr, byval attrs as PangoLogAttr ptr, byval attrs_len as integer)
declare sub pango_find_paragraph_boundary (byval text as zstring ptr, byval length as gint, byval paragraph_delimiter_index as gint ptr, byval next_paragraph_start as gint ptr)
declare sub pango_get_log_attrs (byval text as zstring ptr, byval length as integer, byval level as integer, byval language as PangoLanguage ptr, byval log_attrs as PangoLogAttr ptr, byval attrs_len as integer)

#endif
