''
''
'' gunicode -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gunicode_bi__
#define __gunicode_bi__

#include once "gtk/glib/gerror.bi"
#include once "gtk/glib/gtypes.bi"

type gunichar as guint32
type gunichar2 as guint16

enum GUnicodeType
	G_UNICODE_CONTROL
	G_UNICODE_FORMAT
	G_UNICODE_UNASSIGNED
	G_UNICODE_PRIVATE_USE
	G_UNICODE_SURROGATE
	G_UNICODE_LOWERCASE_LETTER
	G_UNICODE_MODIFIER_LETTER
	G_UNICODE_OTHER_LETTER
	G_UNICODE_TITLECASE_LETTER
	G_UNICODE_UPPERCASE_LETTER
	G_UNICODE_COMBINING_MARK
	G_UNICODE_ENCLOSING_MARK
	G_UNICODE_NON_SPACING_MARK
	G_UNICODE_DECIMAL_NUMBER
	G_UNICODE_LETTER_NUMBER
	G_UNICODE_OTHER_NUMBER
	G_UNICODE_CONNECT_PUNCTUATION
	G_UNICODE_DASH_PUNCTUATION
	G_UNICODE_CLOSE_PUNCTUATION
	G_UNICODE_FINAL_PUNCTUATION
	G_UNICODE_INITIAL_PUNCTUATION
	G_UNICODE_OTHER_PUNCTUATION
	G_UNICODE_OPEN_PUNCTUATION
	G_UNICODE_CURRENCY_SYMBOL
	G_UNICODE_MODIFIER_SYMBOL
	G_UNICODE_MATH_SYMBOL
	G_UNICODE_OTHER_SYMBOL
	G_UNICODE_LINE_SEPARATOR
	G_UNICODE_PARAGRAPH_SEPARATOR
	G_UNICODE_SPACE_SEPARATOR
end enum


enum GUnicodeBreakType
	G_UNICODE_BREAK_MANDATORY
	G_UNICODE_BREAK_CARRIAGE_RETURN
	G_UNICODE_BREAK_LINE_FEED
	G_UNICODE_BREAK_COMBINING_MARK
	G_UNICODE_BREAK_SURROGATE
	G_UNICODE_BREAK_ZERO_WIDTH_SPACE
	G_UNICODE_BREAK_INSEPARABLE
	G_UNICODE_BREAK_NON_BREAKING_GLUE
	G_UNICODE_BREAK_CONTINGENT
	G_UNICODE_BREAK_SPACE
	G_UNICODE_BREAK_AFTER
	G_UNICODE_BREAK_BEFORE
	G_UNICODE_BREAK_BEFORE_AND_AFTER
	G_UNICODE_BREAK_HYPHEN
	G_UNICODE_BREAK_NON_STARTER
	G_UNICODE_BREAK_OPEN_PUNCTUATION
	G_UNICODE_BREAK_CLOSE_PUNCTUATION
	G_UNICODE_BREAK_QUOTATION
	G_UNICODE_BREAK_EXCLAMATION
	G_UNICODE_BREAK_IDEOGRAPHIC
	G_UNICODE_BREAK_NUMERIC
	G_UNICODE_BREAK_INFIX_SEPARATOR
	G_UNICODE_BREAK_SYMBOL
	G_UNICODE_BREAK_ALPHABETIC
	G_UNICODE_BREAK_PREFIX
	G_UNICODE_BREAK_POSTFIX
	G_UNICODE_BREAK_COMPLEX_CONTEXT
	G_UNICODE_BREAK_AMBIGUOUS
	G_UNICODE_BREAK_UNKNOWN
	G_UNICODE_BREAK_NEXT_LINE
	G_UNICODE_BREAK_WORD_JOINER
end enum


declare function g_get_charset cdecl alias "g_get_charset" (byval charset as byte ptr ptr) as gboolean
declare function g_unichar_isalnum cdecl alias "g_unichar_isalnum" (byval c as gunichar) as gboolean
declare function g_unichar_isalpha cdecl alias "g_unichar_isalpha" (byval c as gunichar) as gboolean
declare function g_unichar_iscntrl cdecl alias "g_unichar_iscntrl" (byval c as gunichar) as gboolean
declare function g_unichar_isdigit cdecl alias "g_unichar_isdigit" (byval c as gunichar) as gboolean
declare function g_unichar_isgraph cdecl alias "g_unichar_isgraph" (byval c as gunichar) as gboolean
declare function g_unichar_islower cdecl alias "g_unichar_islower" (byval c as gunichar) as gboolean
declare function g_unichar_isprint cdecl alias "g_unichar_isprint" (byval c as gunichar) as gboolean
declare function g_unichar_ispunct cdecl alias "g_unichar_ispunct" (byval c as gunichar) as gboolean
declare function g_unichar_isspace cdecl alias "g_unichar_isspace" (byval c as gunichar) as gboolean
declare function g_unichar_isupper cdecl alias "g_unichar_isupper" (byval c as gunichar) as gboolean
declare function g_unichar_isxdigit cdecl alias "g_unichar_isxdigit" (byval c as gunichar) as gboolean
declare function g_unichar_istitle cdecl alias "g_unichar_istitle" (byval c as gunichar) as gboolean
declare function g_unichar_isdefined cdecl alias "g_unichar_isdefined" (byval c as gunichar) as gboolean
declare function g_unichar_iswide cdecl alias "g_unichar_iswide" (byval c as gunichar) as gboolean
declare function g_unichar_toupper cdecl alias "g_unichar_toupper" (byval c as gunichar) as gunichar
declare function g_unichar_tolower cdecl alias "g_unichar_tolower" (byval c as gunichar) as gunichar
declare function g_unichar_totitle cdecl alias "g_unichar_totitle" (byval c as gunichar) as gunichar
declare function g_unichar_digit_value cdecl alias "g_unichar_digit_value" (byval c as gunichar) as gint
declare function g_unichar_xdigit_value cdecl alias "g_unichar_xdigit_value" (byval c as gunichar) as gint
declare function g_unichar_type cdecl alias "g_unichar_type" (byval c as gunichar) as GUnicodeType
declare function g_unichar_break_type cdecl alias "g_unichar_break_type" (byval c as gunichar) as GUnicodeBreakType
declare sub g_unicode_canonical_ordering cdecl alias "g_unicode_canonical_ordering" (byval string as gunichar ptr, byval len as gsize)
declare function g_unicode_canonical_decomposition cdecl alias "g_unicode_canonical_decomposition" (byval ch as gunichar, byval result_len as gsize ptr) as gunichar ptr
declare function g_utf8_get_char cdecl alias "g_utf8_get_char" (byval p as gchar ptr) as gunichar
declare function g_utf8_get_char_validated cdecl alias "g_utf8_get_char_validated" (byval p as gchar ptr, byval max_len as gssize) as gunichar
declare function g_utf8_offset_to_pointer cdecl alias "g_utf8_offset_to_pointer" (byval str as gchar ptr, byval offset as glong) as gchar ptr
declare function g_utf8_pointer_to_offset cdecl alias "g_utf8_pointer_to_offset" (byval str as gchar ptr, byval pos as gchar ptr) as glong
declare function g_utf8_prev_char cdecl alias "g_utf8_prev_char" (byval p as gchar ptr) as gchar ptr
declare function g_utf8_find_next_char cdecl alias "g_utf8_find_next_char" (byval p as gchar ptr, byval end as gchar ptr) as gchar ptr
declare function g_utf8_find_prev_char cdecl alias "g_utf8_find_prev_char" (byval str as gchar ptr, byval p as gchar ptr) as gchar ptr
declare function g_utf8_strlen cdecl alias "g_utf8_strlen" (byval p as gchar ptr, byval max as gssize) as glong
declare function g_utf8_strncpy cdecl alias "g_utf8_strncpy" (byval dest as gchar ptr, byval src as gchar ptr, byval n as gsize) as gchar ptr
declare function g_utf8_strchr cdecl alias "g_utf8_strchr" (byval p as gchar ptr, byval len as gssize, byval c as gunichar) as gchar ptr
declare function g_utf8_strrchr cdecl alias "g_utf8_strrchr" (byval p as gchar ptr, byval len as gssize, byval c as gunichar) as gchar ptr
declare function g_utf8_strreverse cdecl alias "g_utf8_strreverse" (byval str as gchar ptr, byval len as gssize) as gchar ptr
declare function g_utf8_to_utf16 cdecl alias "g_utf8_to_utf16" (byval str as gchar ptr, byval len as glong, byval items_read as glong ptr, byval items_written as glong ptr, byval error as GError ptr ptr) as gunichar2 ptr
declare function g_utf8_to_ucs4 cdecl alias "g_utf8_to_ucs4" (byval str as gchar ptr, byval len as glong, byval items_read as glong ptr, byval items_written as glong ptr, byval error as GError ptr ptr) as gunichar ptr
declare function g_utf8_to_ucs4_fast cdecl alias "g_utf8_to_ucs4_fast" (byval str as gchar ptr, byval len as glong, byval items_written as glong ptr) as gunichar ptr
declare function g_utf16_to_ucs4 cdecl alias "g_utf16_to_ucs4" (byval str as gunichar2 ptr, byval len as glong, byval items_read as glong ptr, byval items_written as glong ptr, byval error as GError ptr ptr) as gunichar ptr
declare function g_utf16_to_utf8 cdecl alias "g_utf16_to_utf8" (byval str as gunichar2 ptr, byval len as glong, byval items_read as glong ptr, byval items_written as glong ptr, byval error as GError ptr ptr) as gchar ptr
declare function g_ucs4_to_utf16 cdecl alias "g_ucs4_to_utf16" (byval str as gunichar ptr, byval len as glong, byval items_read as glong ptr, byval items_written as glong ptr, byval error as GError ptr ptr) as gunichar2 ptr
declare function g_ucs4_to_utf8 cdecl alias "g_ucs4_to_utf8" (byval str as gunichar ptr, byval len as glong, byval items_read as glong ptr, byval items_written as glong ptr, byval error as GError ptr ptr) as gchar ptr
declare function g_unichar_to_utf8 cdecl alias "g_unichar_to_utf8" (byval c as gunichar, byval outbuf as gchar ptr) as gint
declare function g_utf8_validate cdecl alias "g_utf8_validate" (byval str as gchar ptr, byval max_len as gssize, byval end as gchar ptr ptr) as gboolean
declare function g_unichar_validate cdecl alias "g_unichar_validate" (byval ch as gunichar) as gboolean
declare function g_utf8_strup cdecl alias "g_utf8_strup" (byval str as gchar ptr, byval len as gssize) as gchar ptr
declare function g_utf8_strdown cdecl alias "g_utf8_strdown" (byval str as gchar ptr, byval len as gssize) as gchar ptr
declare function g_utf8_casefold cdecl alias "g_utf8_casefold" (byval str as gchar ptr, byval len as gssize) as gchar ptr

enum GNormalizeMode
	G_NORMALIZE_DEFAULT
	G_NORMALIZE_NFD = G_NORMALIZE_DEFAULT
	G_NORMALIZE_DEFAULT_COMPOSE
	G_NORMALIZE_NFC = G_NORMALIZE_DEFAULT_COMPOSE
	G_NORMALIZE_ALL
	G_NORMALIZE_NFKD = G_NORMALIZE_ALL
	G_NORMALIZE_ALL_COMPOSE
	G_NORMALIZE_NFKC = G_NORMALIZE_ALL_COMPOSE
end enum


declare function g_utf8_normalize cdecl alias "g_utf8_normalize" (byval str as gchar ptr, byval len as gssize, byval mode as GNormalizeMode) as gchar ptr
declare function g_utf8_collate cdecl alias "g_utf8_collate" (byval str1 as gchar ptr, byval str2 as gchar ptr) as gint
declare function g_utf8_collate_key cdecl alias "g_utf8_collate_key" (byval str as gchar ptr, byval len as gssize) as gchar ptr
declare function g_unichar_get_mirror_char cdecl alias "g_unichar_get_mirror_char" (byval ch as gunichar, byval mirrored_ch as gunichar ptr) as gboolean

#endif
