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
#include once "gtk/pango/pango-item.bi"

type _PangoLogAttr
	''!!!FIXME!!! bit-fields support is needed
	union
		is_line_break as guint
		is_mandatory_break as guint
		is_char_break as guint
		is_white as guint
		is_cursor_position as guint
		is_word_start as guint
		is_word_end as guint
		is_sentence_boundary as guint
		is_sentence_start as guint
		is_sentence_end as guint
		backspace_deletes_character as guint
	end union
end type

declare sub pango_break cdecl alias "pango_break" (byval text as string, byval length as integer, byval analysis as PangoAnalysis ptr, byval attrs as PangoLogAttr ptr, byval attrs_len as integer)
declare sub pango_find_paragraph_boundary cdecl alias "pango_find_paragraph_boundary" (byval text as string, byval length as gint, byval paragraph_delimiter_index as gint ptr, byval next_paragraph_start as gint ptr)
declare sub pango_get_log_attrs cdecl alias "pango_get_log_attrs" (byval text as string, byval length as integer, byval level as integer, byval language as PangoLanguage ptr, byval log_attrs as PangoLogAttr ptr, byval attrs_len as integer)

#endif
