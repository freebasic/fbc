''
''
'' gconvert -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gconvert_bi__
#define __gconvert_bi__

#include once "gtk/glib/gerror.bi"

enum GConvertError
	G_CONVERT_ERROR_NO_CONVERSION
	G_CONVERT_ERROR_ILLEGAL_SEQUENCE
	G_CONVERT_ERROR_FAILED
	G_CONVERT_ERROR_PARTIAL_INPUT
	G_CONVERT_ERROR_BAD_URI
	G_CONVERT_ERROR_NOT_ABSOLUTE_PATH
end enum


declare function g_convert_error_quark cdecl alias "g_convert_error_quark" () as GQuark

type GIConv as _GIConv ptr

declare function g_iconv_open cdecl alias "g_iconv_open" (byval to_codeset as string, byval from_codeset as string) as GIConv
declare function g_iconv cdecl alias "g_iconv" (byval converter as GIConv, byval inbuf as zstring ptr ptr, byval inbytes_left as gsize ptr, byval outbuf as zstring ptr ptr, byval outbytes_left as gsize ptr) as integer
declare function g_iconv_close cdecl alias "g_iconv_close" (byval converter as GIConv) as gint
declare function g_convert cdecl alias "g_convert" (byval str as string, byval len as gssize, byval to_codeset as string, byval from_codeset as string, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as zstring ptr
declare function g_convert_with_iconv cdecl alias "g_convert_with_iconv" (byval str as string, byval len as gssize, byval converter as GIConv, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as zstring ptr
declare function g_convert_with_fallback cdecl alias "g_convert_with_fallback" (byval str as string, byval len as gssize, byval to_codeset as string, byval from_codeset as string, byval fallback as string, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as zstring ptr
declare function g_locale_to_utf8 cdecl alias "g_locale_to_utf8" (byval opsysstring as string, byval len as gssize, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as zstring ptr
declare function g_locale_from_utf8 cdecl alias "g_locale_from_utf8" (byval utf8string as string, byval len as gssize, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as zstring ptr
declare function g_filename_to_utf8_utf8 cdecl alias "g_filename_to_utf8_utf8" (byval opsysstring as string, byval len as gssize, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as zstring ptr
declare function g_filename_from_utf8_utf8 cdecl alias "g_filename_from_utf8_utf8" (byval utf8string as string, byval len as gssize, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as zstring ptr
declare function g_filename_from_uri_utf8 cdecl alias "g_filename_from_uri_utf8" (byval uri as string, byval hostname as zstring ptr ptr, byval error as GError ptr ptr) as zstring ptr
declare function g_filename_to_uri_utf8 cdecl alias "g_filename_to_uri_utf8" (byval filename as string, byval hostname as string, byval error as GError ptr ptr) as zstring ptr
declare function g_filename_display_name cdecl alias "g_filename_display_name" (byval filename as string) as zstring ptr
declare function g_get_filename_charsets cdecl alias "g_get_filename_charsets" (byval charsets as zstring ptr ptr ptr) as gboolean
declare function g_filename_display_basename cdecl alias "g_filename_display_basename" (byval filename as string) as zstring ptr
declare function g_uri_list_extract_uris cdecl alias "g_uri_list_extract_uris" (byval uri_list as string) as zstring ptr ptr

#endif
