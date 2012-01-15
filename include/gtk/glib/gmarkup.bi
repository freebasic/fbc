''
''
'' gmarkup -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gmarkup_bi__
#define __gmarkup_bi__

#include once "gerror.bi"

enum GMarkupError
	G_MARKUP_ERROR_BAD_UTF8
	G_MARKUP_ERROR_EMPTY
	G_MARKUP_ERROR_PARSE
	G_MARKUP_ERROR_UNKNOWN_ELEMENT
	G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE
	G_MARKUP_ERROR_INVALID_CONTENT
end enum


declare function g_markup_error_quark () as GQuark

enum GMarkupParseFlags
	G_MARKUP_DO_NOT_USE_THIS_UNSUPPORTED_FLAG = 1 shl 0
end enum

type GMarkupParseContext as _GMarkupParseContext
type GMarkupParser as _GMarkupParser

type _GMarkupParser
	start_element as sub cdecl(byval as GMarkupParseContext ptr, byval as zstring ptr, byval as zstring ptr ptr, byval as zstring ptr ptr, byval as gpointer, byval as GError ptr ptr)
	end_element as sub cdecl(byval as GMarkupParseContext ptr, byval as zstring ptr, byval as gpointer, byval as GError ptr ptr)
	text as sub cdecl(byval as GMarkupParseContext ptr, byval as zstring ptr, byval as gsize, byval as gpointer, byval as GError ptr ptr)
	passthrough as sub cdecl(byval as GMarkupParseContext ptr, byval as zstring ptr, byval as gsize, byval as gpointer, byval as GError ptr ptr)
	error as sub cdecl(byval as GMarkupParseContext ptr, byval as GError ptr, byval as gpointer)
end type

declare function g_markup_parse_context_new (byval parser as GMarkupParser ptr, byval flags as GMarkupParseFlags, byval user_data as gpointer, byval user_data_dnotify as GDestroyNotify) as GMarkupParseContext ptr
declare sub g_markup_parse_context_free (byval context as GMarkupParseContext ptr)
declare function g_markup_parse_context_parse (byval context as GMarkupParseContext ptr, byval text as zstring ptr, byval text_len as gssize, byval error as GError ptr ptr) as gboolean
declare function g_markup_parse_context_end_parse (byval context as GMarkupParseContext ptr, byval error as GError ptr ptr) as gboolean
declare function g_markup_parse_context_get_element (byval context as GMarkupParseContext ptr) as zstring ptr
declare sub g_markup_parse_context_get_position (byval context as GMarkupParseContext ptr, byval line_number as gint ptr, byval char_number as gint ptr)
declare function g_markup_escape_text (byval text as zstring ptr, byval length as gssize) as zstring ptr
declare function g_markup_printf_escaped (byval format as zstring ptr, ...) as zstring ptr
''''''' declare function g_markup_vprintf_escaped (byval format as zstring ptr, byval args as va_list) as zstring ptr

#endif
