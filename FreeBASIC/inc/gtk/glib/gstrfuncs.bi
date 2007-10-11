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

#include once "gtypes.bi"

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


declare function g_ascii_tolower (byval c as gchar) as gchar
declare function g_ascii_toupper (byval c as gchar) as gchar
declare function g_ascii_digit_value (byval c as gchar) as gint
declare function g_ascii_xdigit_value (byval c as gchar) as gint

#define G_STR_DELIMITERS "_-|> <."

declare function g_strdelimit (byval string as zstring ptr, byval delimiters as zstring ptr, byval new_delimiter as gchar) as zstring ptr
declare function g_strcanon (byval string as zstring ptr, byval valid_chars as zstring ptr, byval substitutor as gchar) as zstring ptr
declare function g_strerror (byval errnum as gint) as zstring ptr
declare function g_strsignal (byval signum as gint) as zstring ptr
declare function g_strreverse (byval string as zstring ptr) as zstring ptr
declare function g_strlcpy (byval dest as zstring ptr, byval src as zstring ptr, byval dest_size as gsize) as gsize
declare function g_strlcat (byval dest as zstring ptr, byval src as zstring ptr, byval dest_size as gsize) as gsize
declare function g_strstr_len (byval haystack as zstring ptr, byval haystack_len as gssize, byval needle as zstring ptr) as zstring ptr
declare function g_strrstr (byval haystack as zstring ptr, byval needle as zstring ptr) as zstring ptr
declare function g_strrstr_len (byval haystack as zstring ptr, byval haystack_len as gssize, byval needle as zstring ptr) as zstring ptr
declare function g_str_has_suffix (byval str as zstring ptr, byval suffix as zstring ptr) as gboolean
declare function g_str_has_prefix (byval str as zstring ptr, byval prefix as zstring ptr) as gboolean
declare function g_strtod (byval nptr as zstring ptr, byval endptr as zstring ptr ptr) as gdouble
declare function g_ascii_strtod (byval nptr as zstring ptr, byval endptr as zstring ptr ptr) as gdouble
declare function g_ascii_strtoull (byval nptr as zstring ptr, byval endptr as zstring ptr ptr, byval base as guint) as guint64

#define G_ASCII_DTOSTR_BUF_SIZE (29+10)

declare function g_ascii_dtostr (byval buffer as zstring ptr, byval buf_len as gint, byval d as gdouble) as zstring ptr
declare function g_ascii_formatd (byval buffer as zstring ptr, byval buf_len as gint, byval format as zstring ptr, byval d as gdouble) as zstring ptr
declare function g_strchug (byval string as zstring ptr) as zstring ptr
declare function g_strchomp (byval string as zstring ptr) as zstring ptr
declare function g_ascii_strcasecmp (byval s1 as zstring ptr, byval s2 as zstring ptr) as gint
declare function g_ascii_strncasecmp (byval s1 as zstring ptr, byval s2 as zstring ptr, byval n as gsize) as gint
declare function g_ascii_strdown (byval str as zstring ptr, byval len as gssize) as zstring ptr
declare function g_ascii_strup (byval str as zstring ptr, byval len as gssize) as zstring ptr
declare function g_strcasecmp (byval s1 as zstring ptr, byval s2 as zstring ptr) as gint
declare function g_strncasecmp (byval s1 as zstring ptr, byval s2 as zstring ptr, byval n as guint) as gint
declare function g_strdown (byval string as zstring ptr) as zstring ptr
declare function g_strup (byval string as zstring ptr) as zstring ptr
declare function g_strdup (byval str as zstring ptr) as zstring ptr
declare function g_strdup_printf (byval format as zstring ptr, ...) as zstring ptr
''''''' declare function g_strdup_vprintf (byval format as zstring ptr, byval args as va_list) as zstring ptr
declare function g_strndup (byval str as zstring ptr, byval n as gsize) as zstring ptr
declare function g_strnfill (byval length as gsize, byval fill_char as gchar) as zstring ptr
declare function g_strconcat (byval string1 as zstring ptr, ...) as zstring ptr
declare function g_strjoin (byval separator as zstring ptr, ...) as zstring ptr
declare function g_strcompress (byval source as zstring ptr) as zstring ptr
declare function g_strescape (byval source as zstring ptr, byval exceptions as zstring ptr) as zstring ptr
declare function g_memdup (byval mem as gconstpointer, byval byte_size as guint) as gpointer
declare function g_strsplit (byval string as zstring ptr, byval delimiter as zstring ptr, byval max_tokens as gint) as zstring ptr ptr
declare function g_strsplit_set (byval string as zstring ptr, byval delimiters as zstring ptr, byval max_tokens as gint) as zstring ptr ptr
declare function g_strjoinv (byval separator as zstring ptr, byval str_array as zstring ptr ptr) as zstring ptr
declare sub g_strfreev (byval str_array as zstring ptr ptr)
declare function g_strdupv (byval str_array as zstring ptr ptr) as zstring ptr ptr
declare function g_strv_length (byval str_array as zstring ptr ptr) as guint
declare function g_stpcpy (byval dest as zstring ptr, byval src as zstring ptr) as zstring ptr
declare function g_strip_context (byval msgid as zstring ptr, byval msgval as zstring ptr) as zstring ptr

#endif
