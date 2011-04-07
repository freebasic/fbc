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

#include once "gerror.bi"
#include once "gtypes.bi"

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


declare function g_get_charset (byval charset as byte ptr ptr) as gboolean
declare function g_unichar_isalnum (byval c as gunichar) as gboolean
declare function g_unichar_isalpha (byval c as gunichar) as gboolean
declare function g_unichar_iscntrl (byval c as gunichar) as gboolean
declare function g_unichar_isdigit (byval c as gunichar) as gboolean
declare function g_unichar_isgraph (byval c as gunichar) as gboolean
declare function g_unichar_islower (byval c as gunichar) as gboolean
declare function g_unichar_isprint (byval c as gunichar) as gboolean
declare function g_unichar_ispunct (byval c as gunichar) as gboolean
declare function g_unichar_isspace (byval c as gunichar) as gboolean
declare function g_unichar_isupper (byval c as gunichar) as gboolean
declare function g_unichar_isxdigit (byval c as gunichar) as gboolean
declare function g_unichar_istitle (byval c as gunichar) as gboolean
declare function g_unichar_isdefined (byval c as gunichar) as gboolean
declare function g_unichar_iswide (byval c as gunichar) as gboolean
declare function g_unichar_toupper (byval c as gunichar) as gunichar
declare function g_unichar_tolower (byval c as gunichar) as gunichar
declare function g_unichar_totitle (byval c as gunichar) as gunichar
declare function g_unichar_digit_value (byval c as gunichar) as gint
declare function g_unichar_xdigit_value (byval c as gunichar) as gint
declare function g_unichar_type (byval c as gunichar) as GUnicodeType
declare function g_unichar_break_type (byval c as gunichar) as GUnicodeBreakType
declare sub g_unicode_canonical_ordering (byval string as gunichar ptr, byval len as gsize)
declare function g_unicode_canonical_decomposition (byval ch as gunichar, byval result_len as gsize ptr) as gunichar ptr
declare function g_utf8_get_char (byval p as zstring ptr) as gunichar
declare function g_utf8_get_char_validated (byval p as zstring ptr, byval max_len as gssize) as gunichar
declare function g_utf8_offset_to_pointer (byval str as zstring ptr, byval offset as glong) as zstring ptr
declare function g_utf8_pointer_to_offset (byval str as zstring ptr, byval pos as zstring ptr) as glong
declare function g_utf8_prev_char (byval p as zstring ptr) as zstring ptr
declare function g_utf8_find_next_char (byval p as zstring ptr, byval end as zstring ptr) as zstring ptr
declare function g_utf8_find_prev_char (byval str as zstring ptr, byval p as zstring ptr) as zstring ptr
declare function g_utf8_strlen (byval p as zstring ptr, byval max as gssize) as glong
declare function g_utf8_strncpy (byval dest as zstring ptr, byval src as zstring ptr, byval n as gsize) as zstring ptr
declare function g_utf8_strchr (byval p as zstring ptr, byval len as gssize, byval c as gunichar) as zstring ptr
declare function g_utf8_strrchr (byval p as zstring ptr, byval len as gssize, byval c as gunichar) as zstring ptr
declare function g_utf8_strreverse (byval str as zstring ptr, byval len as gssize) as zstring ptr
declare function g_utf8_to_utf16 (byval str as zstring ptr, byval len as glong, byval items_read as glong ptr, byval items_written as glong ptr, byval error as GError ptr ptr) as gunichar2 ptr
declare function g_utf8_to_ucs4 (byval str as zstring ptr, byval len as glong, byval items_read as glong ptr, byval items_written as glong ptr, byval error as GError ptr ptr) as gunichar ptr
declare function g_utf8_to_ucs4_fast (byval str as zstring ptr, byval len as glong, byval items_written as glong ptr) as gunichar ptr
declare function g_utf16_to_ucs4 (byval str as gunichar2 ptr, byval len as glong, byval items_read as glong ptr, byval items_written as glong ptr, byval error as GError ptr ptr) as gunichar ptr
declare function g_utf16_to_utf8 (byval str as gunichar2 ptr, byval len as glong, byval items_read as glong ptr, byval items_written as glong ptr, byval error as GError ptr ptr) as zstring ptr
declare function g_ucs4_to_utf16 (byval str as gunichar ptr, byval len as glong, byval items_read as glong ptr, byval items_written as glong ptr, byval error as GError ptr ptr) as gunichar2 ptr
declare function g_ucs4_to_utf8 (byval str as gunichar ptr, byval len as glong, byval items_read as glong ptr, byval items_written as glong ptr, byval error as GError ptr ptr) as zstring ptr
declare function g_unichar_to_utf8 (byval c as gunichar, byval outbuf as zstring ptr) as gint
declare function g_utf8_validate (byval str as zstring ptr, byval max_len as gssize, byval end as zstring ptr ptr) as gboolean
declare function g_unichar_validate (byval ch as gunichar) as gboolean
declare function g_utf8_strup (byval str as zstring ptr, byval len as gssize) as zstring ptr
declare function g_utf8_strdown (byval str as zstring ptr, byval len as gssize) as zstring ptr
declare function g_utf8_casefold (byval str as zstring ptr, byval len as gssize) as zstring ptr

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


declare function g_utf8_normalize (byval str as zstring ptr, byval len as gssize, byval mode as GNormalizeMode) as zstring ptr
declare function g_utf8_collate (byval str1 as zstring ptr, byval str2 as zstring ptr) as gint
declare function g_utf8_collate_key (byval str as zstring ptr, byval len as gssize) as zstring ptr
declare function g_unichar_get_mirror_char (byval ch as gunichar, byval mirrored_ch as gunichar ptr) as gboolean

#endif
