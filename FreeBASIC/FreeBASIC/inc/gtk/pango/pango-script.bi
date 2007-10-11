''
''
'' pango-script -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pango_script_bi__
#define __pango_script_bi__

#include once "gtk/glib.bi"
#include once "pango-types.bi"

type PangoScriptIter as _PangoScriptIter

enum PangoScript
	PANGO_SCRIPT_INVALID_CODE = -1
	PANGO_SCRIPT_COMMON = 0
	PANGO_SCRIPT_INHERITED
	PANGO_SCRIPT_ARABIC
	PANGO_SCRIPT_ARMENIAN
	PANGO_SCRIPT_BENGALI
	PANGO_SCRIPT_BOPOMOFO
	PANGO_SCRIPT_CHEROKEE
	PANGO_SCRIPT_COPTIC
	PANGO_SCRIPT_CYRILLIC
	PANGO_SCRIPT_DESERET
	PANGO_SCRIPT_DEVANAGARI
	PANGO_SCRIPT_ETHIOPIC
	PANGO_SCRIPT_GEORGIAN
	PANGO_SCRIPT_GOTHIC
	PANGO_SCRIPT_GREEK
	PANGO_SCRIPT_GUJARATI
	PANGO_SCRIPT_GURMUKHI
	PANGO_SCRIPT_HAN
	PANGO_SCRIPT_HANGUL
	PANGO_SCRIPT_HEBREW
	PANGO_SCRIPT_HIRAGANA
	PANGO_SCRIPT_KANNADA
	PANGO_SCRIPT_KATAKANA
	PANGO_SCRIPT_KHMER
	PANGO_SCRIPT_LAO
	PANGO_SCRIPT_LATIN
	PANGO_SCRIPT_MALAYALAM
	PANGO_SCRIPT_MONGOLIAN
	PANGO_SCRIPT_MYANMAR
	PANGO_SCRIPT_OGHAM
	PANGO_SCRIPT_OLD_ITALIC
	PANGO_SCRIPT_ORIYA
	PANGO_SCRIPT_RUNIC
	PANGO_SCRIPT_SINHALA
	PANGO_SCRIPT_SYRIAC
	PANGO_SCRIPT_TAMIL
	PANGO_SCRIPT_TELUGU
	PANGO_SCRIPT_THAANA
	PANGO_SCRIPT_THAI
	PANGO_SCRIPT_TIBETAN
	PANGO_SCRIPT_CANADIAN_ABORIGINAL
	PANGO_SCRIPT_YI
	PANGO_SCRIPT_TAGALOG
	PANGO_SCRIPT_HANUNOO
	PANGO_SCRIPT_BUHID
	PANGO_SCRIPT_TAGBANWA
	PANGO_SCRIPT_BRAILLE
	PANGO_SCRIPT_CYPRIOT
	PANGO_SCRIPT_LIMBU
	PANGO_SCRIPT_OSMANYA
	PANGO_SCRIPT_SHAVIAN
	PANGO_SCRIPT_LINEAR_B
	PANGO_SCRIPT_TAI_LE
	PANGO_SCRIPT_UGARITIC
end enum


declare function pango_script_for_unichar (byval ch as gunichar) as PangoScript
declare function pango_script_iter_new (byval text as zstring ptr, byval length as integer) as PangoScriptIter ptr
declare sub pango_script_iter_get_range (byval iter as PangoScriptIter ptr, byval start as byte ptr ptr, byval end as byte ptr ptr, byval script as PangoScript ptr)
declare function pango_script_iter_next (byval iter as PangoScriptIter ptr) as gboolean
declare sub pango_script_iter_free (byval iter as PangoScriptIter ptr)
declare function pango_script_get_sample_language (byval script as PangoScript) as PangoLanguage ptr
declare function pango_language_includes_script (byval language as PangoLanguage ptr, byval script as PangoScript) as gboolean

#endif
