''
''
'' gstrfuncs -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gstrfuncs_bi__
#define __gstrfuncs_bi__

#include once "gtk/glib/gtypes.bi"

enum GAsciiType
	G_ASCII_ALNUM = 1 shl 0
	G_ASCII_ALPHA = 1 shl 1
	G_ASCII_CNTRL = 1 shl 2
	G_ASCII_DIGIT = 1 shl 3
	G_ASCII_GRAPH = 1 shl 4
	G_ASCII_LOWER = 1 shl 5
	G_ASCII_PRINT = 1 shl 6
	G_ASCII_PUNCT = 1 shl 7
	G_ASCII_SPACE = 1 shl 8
	G_ASCII_UPPER = 1 shl 9
	G_ASCII_XDIGIT = 1 shl 10
end enum


declare function g_ascii_tolower cdecl alias "g_ascii_tolower" (byval c as gchar) as gchar
declare function g_ascii_toupper cdecl alias "g_ascii_toupper" (byval c as gchar) as gchar
declare function g_ascii_digit_value cdecl alias "g_ascii_digit_value" (byval c as gchar) as gint
declare function g_ascii_xdigit_value cdecl alias "g_ascii_xdigit_value" (byval c as gchar) as gint

#define G_STR_DELIMITERS "_-|> <."

declare function g_strdelimit cdecl alias "g_strdelimit" (byval string as gchar ptr, byval delimiters as gchar ptr, byval new_delimiter as gchar) as gchar ptr
declare function g_strcanon cdecl alias "g_strcanon" (byval string as gchar ptr, byval valid_chars as gchar ptr, byval substitutor as gchar) as gchar ptr
declare function g_strerror cdecl alias "g_strerror" (byval errnum as gint) as gchar ptr
declare function g_strsignal cdecl alias "g_strsignal" (byval signum as gint) as gchar ptr
declare function g_strreverse cdecl alias "g_strreverse" (byval string as gchar ptr) as gchar ptr
declare function g_strlcpy cdecl alias "g_strlcpy" (byval dest as gchar ptr, byval src as gchar ptr, byval dest_size as gsize) as gsize
declare function g_strlcat cdecl alias "g_strlcat" (byval dest as gchar ptr, byval src as gchar ptr, byval dest_size as gsize) as gsize
declare function g_strstr_len cdecl alias "g_strstr_len" (byval haystack as gchar ptr, byval haystack_len as gssize, byval needle as gchar ptr) as gchar ptr
declare function g_strrstr cdecl alias "g_strrstr" (byval haystack as gchar ptr, byval needle as gchar ptr) as gchar ptr
declare function g_strrstr_len cdecl alias "g_strrstr_len" (byval haystack as gchar ptr, byval haystack_len as gssize, byval needle as gchar ptr) as gchar ptr
declare function g_str_has_suffix cdecl alias "g_str_has_suffix" (byval str as gchar ptr, byval suffix as gchar ptr) as gboolean
declare function g_str_has_prefix cdecl alias "g_str_has_prefix" (byval str as gchar ptr, byval prefix as gchar ptr) as gboolean
declare function g_strtod cdecl alias "g_strtod" (byval nptr as gchar ptr, byval endptr as gchar ptr ptr) as gdouble
declare function g_ascii_strtod cdecl alias "g_ascii_strtod" (byval nptr as gchar ptr, byval endptr as gchar ptr ptr) as gdouble
declare function g_ascii_strtoull cdecl alias "g_ascii_strtoull" (byval nptr as gchar ptr, byval endptr as gchar ptr ptr, byval base as guint) as guint64

#define G_ASCII_DTOSTR_BUF_SIZE (29+10)

declare function g_ascii_dtostr cdecl alias "g_ascii_dtostr" (byval buffer as gchar ptr, byval buf_len as gint, byval d as gdouble) as gchar ptr
declare function g_ascii_formatd cdecl alias "g_ascii_formatd" (byval buffer as gchar ptr, byval buf_len as gint, byval format as gchar ptr, byval d as gdouble) as gchar ptr
declare function g_strchug cdecl alias "g_strchug" (byval string as gchar ptr) as gchar ptr
declare function g_strchomp cdecl alias "g_strchomp" (byval string as gchar ptr) as gchar ptr
declare function g_ascii_strcasecmp cdecl alias "g_ascii_strcasecmp" (byval s1 as gchar ptr, byval s2 as gchar ptr) as gint
declare function g_ascii_strncasecmp cdecl alias "g_ascii_strncasecmp" (byval s1 as gchar ptr, byval s2 as gchar ptr, byval n as gsize) as gint
declare function g_ascii_strdown cdecl alias "g_ascii_strdown" (byval str as gchar ptr, byval len as gssize) as gchar ptr
declare function g_ascii_strup cdecl alias "g_ascii_strup" (byval str as gchar ptr, byval len as gssize) as gchar ptr
declare function g_strcasecmp cdecl alias "g_strcasecmp" (byval s1 as gchar ptr, byval s2 as gchar ptr) as gint
declare function g_strncasecmp cdecl alias "g_strncasecmp" (byval s1 as gchar ptr, byval s2 as gchar ptr, byval n as guint) as gint
declare function g_strdown cdecl alias "g_strdown" (byval string as gchar ptr) as gchar ptr
declare function g_strup cdecl alias "g_strup" (byval string as gchar ptr) as gchar ptr
declare function g_strdup cdecl alias "g_strdup" (byval str as gchar ptr) as gchar ptr
declare function g_strdup_printf cdecl alias "g_strdup_printf" (byval format as gchar ptr, ...) as gchar ptr
''''''' declare function g_strdup_vprintf cdecl alias "g_strdup_vprintf" (byval format as gchar ptr, byval args as va_list) as gchar ptr
declare function g_strndup cdecl alias "g_strndup" (byval str as gchar ptr, byval n as gsize) as gchar ptr
declare function g_strnfill cdecl alias "g_strnfill" (byval length as gsize, byval fill_char as gchar) as gchar ptr
declare function g_strconcat cdecl alias "g_strconcat" (byval string1 as gchar ptr, ...) as gchar ptr
declare function g_strjoin cdecl alias "g_strjoin" (byval separator as gchar ptr, ...) as gchar ptr
declare function g_strcompress cdecl alias "g_strcompress" (byval source as gchar ptr) as gchar ptr
declare function g_strescape cdecl alias "g_strescape" (byval source as gchar ptr, byval exceptions as gchar ptr) as gchar ptr
declare function g_memdup cdecl alias "g_memdup" (byval mem as gconstpointer, byval byte_size as guint) as gpointer
declare function g_strsplit cdecl alias "g_strsplit" (byval string as gchar ptr, byval delimiter as gchar ptr, byval max_tokens as gint) as gchar ptr ptr
declare function g_strsplit_set cdecl alias "g_strsplit_set" (byval string as gchar ptr, byval delimiters as gchar ptr, byval max_tokens as gint) as gchar ptr ptr
declare function g_strjoinv cdecl alias "g_strjoinv" (byval separator as gchar ptr, byval str_array as gchar ptr ptr) as gchar ptr
declare sub g_strfreev cdecl alias "g_strfreev" (byval str_array as gchar ptr ptr)
declare function g_strdupv cdecl alias "g_strdupv" (byval str_array as gchar ptr ptr) as gchar ptr ptr
declare function g_strv_length cdecl alias "g_strv_length" (byval str_array as gchar ptr ptr) as guint
declare function g_stpcpy cdecl alias "g_stpcpy" (byval dest as gchar ptr, byval src as string) as gchar ptr
declare function g_strip_context cdecl alias "g_strip_context" (byval msgid as gchar ptr, byval msgval as gchar ptr) as gchar ptr

#endif
