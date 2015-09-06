'' FreeBASIC binding for pango-1.36.8
''
'' based on the C header files:
''   Copyright (C) 1999 Red Hat Software
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Library General Public
''   License as published by the Free Software Foundation; either
''   version 2 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
''   Library General Public License for more details.
''
''   You should have received a copy of the GNU Library General Public
''   License along with this library; if not, write to the
''   Free Software Foundation, Inc., 51 Franklin Street - Fifth Floor,
''   Boston, MA 02111-1301, USA.
''
'' translated to FreeBASIC by:
''   (C) 2011, 2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "pango-1.0"

#include once "glib.bi"
#include once "glib-object.bi"
#include once "crt/stdio.bi"

'' The following symbols have been renamed:
''     procedure pango_language_to_string => pango_language_to_string_
''     procedure pango_version => pango_version_
''     procedure pango_version_string => pango_version_string_
''     procedure pango_version_check => pango_version_check_

#ifdef __FB_WIN32__
#pragma push(msbitfields)
#endif

extern "C"

#define __PANGO_H__
#define __PANGO_ATTRIBUTES_H__
#define __PANGO_FONT_H__
#define __PANGO_COVERAGE_H__
type PangoCoverage as _PangoCoverage

type PangoCoverageLevel as long
enum
	PANGO_COVERAGE_NONE
	PANGO_COVERAGE_FALLBACK
	PANGO_COVERAGE_APPROXIMATE
	PANGO_COVERAGE_EXACT
end enum

declare function pango_coverage_new() as PangoCoverage ptr
declare function pango_coverage_ref(byval coverage as PangoCoverage ptr) as PangoCoverage ptr
declare sub pango_coverage_unref(byval coverage as PangoCoverage ptr)
declare function pango_coverage_copy(byval coverage as PangoCoverage ptr) as PangoCoverage ptr
declare function pango_coverage_get(byval coverage as PangoCoverage ptr, byval index_ as long) as PangoCoverageLevel
declare sub pango_coverage_set(byval coverage as PangoCoverage ptr, byval index_ as long, byval level as PangoCoverageLevel)
declare sub pango_coverage_max(byval coverage as PangoCoverage ptr, byval other as PangoCoverage ptr)
declare sub pango_coverage_to_bytes(byval coverage as PangoCoverage ptr, byval bytes as guchar ptr ptr, byval n_bytes as long ptr)
declare function pango_coverage_from_bytes(byval bytes as guchar ptr, byval n_bytes as long) as PangoCoverage ptr
#define __PANGO_TYPES_H__

type PangoLogAttr as _PangoLogAttr
type PangoEngineLang as _PangoEngineLang
type PangoEngineShape as _PangoEngineShape
type PangoFont as _PangoFont
type PangoFontMap as _PangoFontMap
type PangoRectangle as _PangoRectangle
type PangoGlyph as guint32

const PANGO_SCALE = 1024
#define PANGO_PIXELS(d) ((clng(d) + 512) shr 10)
#define PANGO_PIXELS_FLOOR(d) (clng(d) shr 10)
#define PANGO_PIXELS_CEIL(d) ((clng(d) + 1023) shr 10)
#define PANGO_UNITS_ROUND(d) (((d) + (PANGO_SCALE shr 1)) and (not (PANGO_SCALE - 1)))
declare function pango_units_from_double(byval d as double) as long
declare function pango_units_to_double(byval i as long) as double

type _PangoRectangle
	x as long
	y as long
	width as long
	height as long
end type

#define PANGO_ASCENT(rect) (-(rect).y)
#define PANGO_DESCENT(rect) ((rect).y + (rect).height)
#define PANGO_LBEARING(rect) (rect).x
#define PANGO_RBEARING(rect) ((rect).x + (rect).width)
declare sub pango_extents_to_pixels(byval inclusive as PangoRectangle ptr, byval nearest as PangoRectangle ptr)
#define __PANGO_GRAVITY_H__

type PangoGravity as long
enum
	PANGO_GRAVITY_SOUTH
	PANGO_GRAVITY_EAST
	PANGO_GRAVITY_NORTH
	PANGO_GRAVITY_WEST
	PANGO_GRAVITY_AUTO
end enum

type PangoGravityHint as long
enum
	PANGO_GRAVITY_HINT_NATURAL
	PANGO_GRAVITY_HINT_STRONG
	PANGO_GRAVITY_HINT_LINE
end enum

#define PANGO_GRAVITY_IS_VERTICAL(gravity) (((gravity) = PANGO_GRAVITY_EAST) orelse ((gravity) = PANGO_GRAVITY_WEST))
#define PANGO_GRAVITY_IS_IMPROPER(gravity) (((gravity) = PANGO_GRAVITY_WEST) orelse ((gravity) = PANGO_GRAVITY_NORTH))
#define __PANGO_MATRIX_H__
type PangoMatrix as _PangoMatrix

type _PangoMatrix
	xx as double
	xy as double
	yx as double
	yy as double
	x0 as double
	y0 as double
end type

#define PANGO_TYPE_MATRIX pango_matrix_get_type()
#define PANGO_MATRIX_INIT (1., 0., 0., 1., 0., 0.)
declare function pango_matrix_get_type() as GType
declare function pango_matrix_copy(byval matrix as const PangoMatrix ptr) as PangoMatrix ptr
declare sub pango_matrix_free(byval matrix as PangoMatrix ptr)
declare sub pango_matrix_translate(byval matrix as PangoMatrix ptr, byval tx as double, byval ty as double)
declare sub pango_matrix_scale(byval matrix as PangoMatrix ptr, byval scale_x as double, byval scale_y as double)
declare sub pango_matrix_rotate(byval matrix as PangoMatrix ptr, byval degrees as double)
declare sub pango_matrix_concat(byval matrix as PangoMatrix ptr, byval new_matrix as const PangoMatrix ptr)
declare sub pango_matrix_transform_point(byval matrix as const PangoMatrix ptr, byval x as double ptr, byval y as double ptr)
declare sub pango_matrix_transform_distance(byval matrix as const PangoMatrix ptr, byval dx as double ptr, byval dy as double ptr)
declare sub pango_matrix_transform_rectangle(byval matrix as const PangoMatrix ptr, byval rect as PangoRectangle ptr)
declare sub pango_matrix_transform_pixel_rectangle(byval matrix as const PangoMatrix ptr, byval rect as PangoRectangle ptr)
declare function pango_matrix_get_font_scale_factor(byval matrix as const PangoMatrix ptr) as double
#define __PANGO_SCRIPT_H__
type PangoScriptIter as _PangoScriptIter

type PangoScript as long
enum
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
	PANGO_SCRIPT_NEW_TAI_LUE
	PANGO_SCRIPT_BUGINESE
	PANGO_SCRIPT_GLAGOLITIC
	PANGO_SCRIPT_TIFINAGH
	PANGO_SCRIPT_SYLOTI_NAGRI
	PANGO_SCRIPT_OLD_PERSIAN
	PANGO_SCRIPT_KHAROSHTHI
	PANGO_SCRIPT_UNKNOWN
	PANGO_SCRIPT_BALINESE
	PANGO_SCRIPT_CUNEIFORM
	PANGO_SCRIPT_PHOENICIAN
	PANGO_SCRIPT_PHAGS_PA
	PANGO_SCRIPT_NKO
	PANGO_SCRIPT_KAYAH_LI
	PANGO_SCRIPT_LEPCHA
	PANGO_SCRIPT_REJANG
	PANGO_SCRIPT_SUNDANESE
	PANGO_SCRIPT_SAURASHTRA
	PANGO_SCRIPT_CHAM
	PANGO_SCRIPT_OL_CHIKI
	PANGO_SCRIPT_VAI
	PANGO_SCRIPT_CARIAN
	PANGO_SCRIPT_LYCIAN
	PANGO_SCRIPT_LYDIAN
	PANGO_SCRIPT_BATAK
	PANGO_SCRIPT_BRAHMI
	PANGO_SCRIPT_MANDAIC
	PANGO_SCRIPT_CHAKMA
	PANGO_SCRIPT_MEROITIC_CURSIVE
	PANGO_SCRIPT_MEROITIC_HIEROGLYPHS
	PANGO_SCRIPT_MIAO
	PANGO_SCRIPT_SHARADA
	PANGO_SCRIPT_SORA_SOMPENG
	PANGO_SCRIPT_TAKRI
end enum

declare function pango_script_for_unichar(byval ch as gunichar) as PangoScript
declare function pango_script_iter_new(byval text as const zstring ptr, byval length as long) as PangoScriptIter ptr
declare sub pango_script_iter_get_range(byval iter as PangoScriptIter ptr, byval start as const zstring ptr ptr, byval end as const zstring ptr ptr, byval script as PangoScript ptr)
declare function pango_script_iter_next(byval iter as PangoScriptIter ptr) as gboolean
declare sub pango_script_iter_free(byval iter as PangoScriptIter ptr)
#define __PANGO_LANGUAGE_H__
type PangoLanguage as _PangoLanguage
#define PANGO_TYPE_LANGUAGE pango_language_get_type()
declare function pango_language_get_type() as GType
declare function pango_language_from_string(byval language as const zstring ptr) as PangoLanguage ptr
declare function pango_language_to_string_ alias "pango_language_to_string"(byval language as PangoLanguage ptr) as const zstring ptr
#define pango_language_to_string(language) cptr(const zstring ptr, language)
declare function pango_language_get_sample_string(byval language as PangoLanguage ptr) as const zstring ptr
declare function pango_language_get_default() as PangoLanguage ptr
declare function pango_language_matches(byval language as PangoLanguage ptr, byval range_list as const zstring ptr) as gboolean
declare function pango_language_includes_script(byval language as PangoLanguage ptr, byval script as PangoScript) as gboolean
declare function pango_language_get_scripts(byval language as PangoLanguage ptr, byval num_scripts as long ptr) as const PangoScript ptr
declare function pango_script_get_sample_language(byval script as PangoScript) as PangoLanguage ptr
declare function pango_gravity_to_rotation(byval gravity as PangoGravity) as double
declare function pango_gravity_get_for_matrix(byval matrix as const PangoMatrix ptr) as PangoGravity
declare function pango_gravity_get_for_script(byval script as PangoScript, byval base_gravity as PangoGravity, byval hint as PangoGravityHint) as PangoGravity
declare function pango_gravity_get_for_script_and_width(byval script as PangoScript, byval wide as gboolean, byval base_gravity as PangoGravity, byval hint as PangoGravityHint) as PangoGravity
#define __PANGO_BIDI_TYPE_H__

type PangoBidiType as long
enum
	PANGO_BIDI_TYPE_L
	PANGO_BIDI_TYPE_LRE
	PANGO_BIDI_TYPE_LRO
	PANGO_BIDI_TYPE_R
	PANGO_BIDI_TYPE_AL
	PANGO_BIDI_TYPE_RLE
	PANGO_BIDI_TYPE_RLO
	PANGO_BIDI_TYPE_PDF
	PANGO_BIDI_TYPE_EN
	PANGO_BIDI_TYPE_ES
	PANGO_BIDI_TYPE_ET
	PANGO_BIDI_TYPE_AN
	PANGO_BIDI_TYPE_CS
	PANGO_BIDI_TYPE_NSM
	PANGO_BIDI_TYPE_BN
	PANGO_BIDI_TYPE_B
	PANGO_BIDI_TYPE_S
	PANGO_BIDI_TYPE_WS
	PANGO_BIDI_TYPE_ON
end enum

declare function pango_bidi_type_for_unichar(byval ch as gunichar) as PangoBidiType

type PangoDirection as long
enum
	PANGO_DIRECTION_LTR
	PANGO_DIRECTION_RTL
	PANGO_DIRECTION_TTB_LTR
	PANGO_DIRECTION_TTB_RTL
	PANGO_DIRECTION_WEAK_LTR
	PANGO_DIRECTION_WEAK_RTL
	PANGO_DIRECTION_NEUTRAL
end enum

declare function pango_unichar_direction(byval ch as gunichar) as PangoDirection
declare function pango_find_base_dir(byval text as const gchar ptr, byval length as gint) as PangoDirection
declare function pango_get_mirror_char(byval ch as gunichar, byval mirrored_ch as gunichar ptr) as gboolean
type PangoFontDescription as _PangoFontDescription
type PangoFontMetrics as _PangoFontMetrics

type PangoStyle as long
enum
	PANGO_STYLE_NORMAL
	PANGO_STYLE_OBLIQUE
	PANGO_STYLE_ITALIC
end enum

type PangoVariant as long
enum
	PANGO_VARIANT_NORMAL
	PANGO_VARIANT_SMALL_CAPS
end enum

type PangoWeight as long
enum
	PANGO_WEIGHT_THIN = 100
	PANGO_WEIGHT_ULTRALIGHT = 200
	PANGO_WEIGHT_LIGHT = 300
	PANGO_WEIGHT_SEMILIGHT = 350
	PANGO_WEIGHT_BOOK = 380
	PANGO_WEIGHT_NORMAL = 400
	PANGO_WEIGHT_MEDIUM = 500
	PANGO_WEIGHT_SEMIBOLD = 600
	PANGO_WEIGHT_BOLD = 700
	PANGO_WEIGHT_ULTRABOLD = 800
	PANGO_WEIGHT_HEAVY = 900
	PANGO_WEIGHT_ULTRAHEAVY = 1000
end enum

type PangoStretch as long
enum
	PANGO_STRETCH_ULTRA_CONDENSED
	PANGO_STRETCH_EXTRA_CONDENSED
	PANGO_STRETCH_CONDENSED
	PANGO_STRETCH_SEMI_CONDENSED
	PANGO_STRETCH_NORMAL
	PANGO_STRETCH_SEMI_EXPANDED
	PANGO_STRETCH_EXPANDED
	PANGO_STRETCH_EXTRA_EXPANDED
	PANGO_STRETCH_ULTRA_EXPANDED
end enum

type PangoFontMask as long
enum
	PANGO_FONT_MASK_FAMILY = 1 shl 0
	PANGO_FONT_MASK_STYLE = 1 shl 1
	PANGO_FONT_MASK_VARIANT = 1 shl 2
	PANGO_FONT_MASK_WEIGHT = 1 shl 3
	PANGO_FONT_MASK_STRETCH = 1 shl 4
	PANGO_FONT_MASK_SIZE = 1 shl 5
	PANGO_FONT_MASK_GRAVITY = 1 shl 6
end enum

const PANGO_SCALE_XX_SMALL = cdbl(0.5787037037037)
const PANGO_SCALE_X_SMALL = cdbl(0.6444444444444)
const PANGO_SCALE_SMALL = cdbl(0.8333333333333)
const PANGO_SCALE_MEDIUM = cdbl(1.0)
const PANGO_SCALE_LARGE = cdbl(1.2)
const PANGO_SCALE_X_LARGE = cdbl(1.4399999999999)
const PANGO_SCALE_XX_LARGE = cdbl(1.728)
#define PANGO_TYPE_FONT_DESCRIPTION pango_font_description_get_type()

declare function pango_font_description_get_type() as GType
declare function pango_font_description_new() as PangoFontDescription ptr
declare function pango_font_description_copy(byval desc as const PangoFontDescription ptr) as PangoFontDescription ptr
declare function pango_font_description_copy_static(byval desc as const PangoFontDescription ptr) as PangoFontDescription ptr
declare function pango_font_description_hash(byval desc as const PangoFontDescription ptr) as guint
declare function pango_font_description_equal(byval desc1 as const PangoFontDescription ptr, byval desc2 as const PangoFontDescription ptr) as gboolean
declare sub pango_font_description_free(byval desc as PangoFontDescription ptr)
declare sub pango_font_descriptions_free(byval descs as PangoFontDescription ptr ptr, byval n_descs as long)
declare sub pango_font_description_set_family(byval desc as PangoFontDescription ptr, byval family as const zstring ptr)
declare sub pango_font_description_set_family_static(byval desc as PangoFontDescription ptr, byval family as const zstring ptr)
declare function pango_font_description_get_family(byval desc as const PangoFontDescription ptr) as const zstring ptr
declare sub pango_font_description_set_style(byval desc as PangoFontDescription ptr, byval style as PangoStyle)
declare function pango_font_description_get_style(byval desc as const PangoFontDescription ptr) as PangoStyle
declare sub pango_font_description_set_variant(byval desc as PangoFontDescription ptr, byval variant as PangoVariant)
declare function pango_font_description_get_variant(byval desc as const PangoFontDescription ptr) as PangoVariant
declare sub pango_font_description_set_weight(byval desc as PangoFontDescription ptr, byval weight as PangoWeight)
declare function pango_font_description_get_weight(byval desc as const PangoFontDescription ptr) as PangoWeight
declare sub pango_font_description_set_stretch(byval desc as PangoFontDescription ptr, byval stretch as PangoStretch)
declare function pango_font_description_get_stretch(byval desc as const PangoFontDescription ptr) as PangoStretch
declare sub pango_font_description_set_size(byval desc as PangoFontDescription ptr, byval size as gint)
declare function pango_font_description_get_size(byval desc as const PangoFontDescription ptr) as gint
declare sub pango_font_description_set_absolute_size(byval desc as PangoFontDescription ptr, byval size as double)
declare function pango_font_description_get_size_is_absolute(byval desc as const PangoFontDescription ptr) as gboolean
declare sub pango_font_description_set_gravity(byval desc as PangoFontDescription ptr, byval gravity as PangoGravity)
declare function pango_font_description_get_gravity(byval desc as const PangoFontDescription ptr) as PangoGravity
declare function pango_font_description_get_set_fields(byval desc as const PangoFontDescription ptr) as PangoFontMask
declare sub pango_font_description_unset_fields(byval desc as PangoFontDescription ptr, byval to_unset as PangoFontMask)
declare sub pango_font_description_merge(byval desc as PangoFontDescription ptr, byval desc_to_merge as const PangoFontDescription ptr, byval replace_existing as gboolean)
declare sub pango_font_description_merge_static(byval desc as PangoFontDescription ptr, byval desc_to_merge as const PangoFontDescription ptr, byval replace_existing as gboolean)
declare function pango_font_description_better_match(byval desc as const PangoFontDescription ptr, byval old_match as const PangoFontDescription ptr, byval new_match as const PangoFontDescription ptr) as gboolean
declare function pango_font_description_from_string(byval str as const zstring ptr) as PangoFontDescription ptr
declare function pango_font_description_to_string(byval desc as const PangoFontDescription ptr) as zstring ptr
declare function pango_font_description_to_filename(byval desc as const PangoFontDescription ptr) as zstring ptr
#define PANGO_TYPE_FONT_METRICS pango_font_metrics_get_type()
declare function pango_font_metrics_get_type() as GType
declare function pango_font_metrics_ref(byval metrics as PangoFontMetrics ptr) as PangoFontMetrics ptr
declare sub pango_font_metrics_unref(byval metrics as PangoFontMetrics ptr)
declare function pango_font_metrics_get_ascent(byval metrics as PangoFontMetrics ptr) as long
declare function pango_font_metrics_get_descent(byval metrics as PangoFontMetrics ptr) as long
declare function pango_font_metrics_get_approximate_char_width(byval metrics as PangoFontMetrics ptr) as long
declare function pango_font_metrics_get_approximate_digit_width(byval metrics as PangoFontMetrics ptr) as long
declare function pango_font_metrics_get_underline_position(byval metrics as PangoFontMetrics ptr) as long
declare function pango_font_metrics_get_underline_thickness(byval metrics as PangoFontMetrics ptr) as long
declare function pango_font_metrics_get_strikethrough_position(byval metrics as PangoFontMetrics ptr) as long
declare function pango_font_metrics_get_strikethrough_thickness(byval metrics as PangoFontMetrics ptr) as long

#define PANGO_TYPE_FONT_FAMILY pango_font_family_get_type()
#define PANGO_FONT_FAMILY(object) G_TYPE_CHECK_INSTANCE_CAST((object), PANGO_TYPE_FONT_FAMILY, PangoFontFamily)
#define PANGO_IS_FONT_FAMILY(object) G_TYPE_CHECK_INSTANCE_TYPE((object), PANGO_TYPE_FONT_FAMILY)
type PangoFontFamily as _PangoFontFamily
type PangoFontFace as _PangoFontFace

declare function pango_font_family_get_type() as GType
declare sub pango_font_family_list_faces(byval family as PangoFontFamily ptr, byval faces as PangoFontFace ptr ptr ptr, byval n_faces as long ptr)
declare function pango_font_family_get_name(byval family as PangoFontFamily ptr) as const zstring ptr
declare function pango_font_family_is_monospace(byval family as PangoFontFamily ptr) as gboolean

#define PANGO_TYPE_FONT_FACE pango_font_face_get_type()
#define PANGO_FONT_FACE(object) G_TYPE_CHECK_INSTANCE_CAST((object), PANGO_TYPE_FONT_FACE, PangoFontFace)
#define PANGO_IS_FONT_FACE(object) G_TYPE_CHECK_INSTANCE_TYPE((object), PANGO_TYPE_FONT_FACE)

declare function pango_font_face_get_type() as GType
declare function pango_font_face_describe(byval face as PangoFontFace ptr) as PangoFontDescription ptr
declare function pango_font_face_get_face_name(byval face as PangoFontFace ptr) as const zstring ptr
declare sub pango_font_face_list_sizes(byval face as PangoFontFace ptr, byval sizes as long ptr ptr, byval n_sizes as long ptr)
declare function pango_font_face_is_synthesized(byval face as PangoFontFace ptr) as gboolean

#define PANGO_TYPE_FONT pango_font_get_type()
#define PANGO_FONT(object) G_TYPE_CHECK_INSTANCE_CAST((object), PANGO_TYPE_FONT, PangoFont)
#define PANGO_IS_FONT(object) G_TYPE_CHECK_INSTANCE_TYPE((object), PANGO_TYPE_FONT)

declare function pango_font_get_type() as GType
declare function pango_font_describe(byval font as PangoFont ptr) as PangoFontDescription ptr
declare function pango_font_describe_with_absolute_size(byval font as PangoFont ptr) as PangoFontDescription ptr
declare function pango_font_get_coverage(byval font as PangoFont ptr, byval language as PangoLanguage ptr) as PangoCoverage ptr
declare function pango_font_find_shaper(byval font as PangoFont ptr, byval language as PangoLanguage ptr, byval ch as guint32) as PangoEngineShape ptr
declare function pango_font_get_metrics(byval font as PangoFont ptr, byval language as PangoLanguage ptr) as PangoFontMetrics ptr
declare sub pango_font_get_glyph_extents(byval font as PangoFont ptr, byval glyph as PangoGlyph, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare function pango_font_get_font_map(byval font as PangoFont ptr) as PangoFontMap ptr

const PANGO_GLYPH_EMPTY = cast(PangoGlyph, &h0FFFFFFF)
const PANGO_GLYPH_INVALID_INPUT = cast(PangoGlyph, &hFFFFFFFF)
const PANGO_GLYPH_UNKNOWN_FLAG = cast(PangoGlyph, &h10000000)
#define PANGO_GET_UNKNOWN_GLYPH(wc) (cast(PangoGlyph, (wc)) or PANGO_GLYPH_UNKNOWN_FLAG)
type PangoColor as _PangoColor

type _PangoColor
	red as guint16
	green as guint16
	blue as guint16
end type

#define PANGO_TYPE_COLOR pango_color_get_type()
declare function pango_color_get_type() as GType
declare function pango_color_copy(byval src as const PangoColor ptr) as PangoColor ptr
declare sub pango_color_free(byval color as PangoColor ptr)
declare function pango_color_parse(byval color as PangoColor ptr, byval spec as const zstring ptr) as gboolean
declare function pango_color_to_string(byval color as const PangoColor ptr) as gchar ptr

type PangoAttribute as _PangoAttribute
type PangoAttrClass as _PangoAttrClass
type PangoAttrString as _PangoAttrString
type PangoAttrLanguage as _PangoAttrLanguage
type PangoAttrInt as _PangoAttrInt
type PangoAttrSize as _PangoAttrSize
type PangoAttrFloat as _PangoAttrFloat
type PangoAttrColor as _PangoAttrColor
type PangoAttrFontDesc as _PangoAttrFontDesc
type PangoAttrShape as _PangoAttrShape
#define PANGO_TYPE_ATTR_LIST pango_attr_list_get_type()
type PangoAttrList as _PangoAttrList
type PangoAttrIterator as _PangoAttrIterator

type PangoAttrType as long
enum
	PANGO_ATTR_INVALID
	PANGO_ATTR_LANGUAGE
	PANGO_ATTR_FAMILY
	PANGO_ATTR_STYLE
	PANGO_ATTR_WEIGHT
	PANGO_ATTR_VARIANT
	PANGO_ATTR_STRETCH
	PANGO_ATTR_SIZE
	PANGO_ATTR_FONT_DESC
	PANGO_ATTR_FOREGROUND
	PANGO_ATTR_BACKGROUND
	PANGO_ATTR_UNDERLINE
	PANGO_ATTR_STRIKETHROUGH
	PANGO_ATTR_RISE
	PANGO_ATTR_SHAPE
	PANGO_ATTR_SCALE
	PANGO_ATTR_FALLBACK
	PANGO_ATTR_LETTER_SPACING
	PANGO_ATTR_UNDERLINE_COLOR
	PANGO_ATTR_STRIKETHROUGH_COLOR
	PANGO_ATTR_ABSOLUTE_SIZE
	PANGO_ATTR_GRAVITY
	PANGO_ATTR_GRAVITY_HINT
end enum

type PangoUnderline as long
enum
	PANGO_UNDERLINE_NONE
	PANGO_UNDERLINE_SINGLE
	PANGO_UNDERLINE_DOUBLE
	PANGO_UNDERLINE_LOW
	PANGO_UNDERLINE_ERROR
end enum

const PANGO_ATTR_INDEX_FROM_TEXT_BEGINNING = 0
#define PANGO_ATTR_INDEX_TO_TEXT_END G_MAXUINT

type _PangoAttribute
	klass as const PangoAttrClass ptr
	start_index as guint
	end_index as guint
end type

type PangoAttrFilterFunc as function(byval attribute as PangoAttribute ptr, byval user_data as gpointer) as gboolean
type PangoAttrDataCopyFunc as function(byval user_data as gconstpointer) as gpointer

type _PangoAttrClass
	as PangoAttrType type
	copy as function(byval attr as const PangoAttribute ptr) as PangoAttribute ptr
	destroy as sub(byval attr as PangoAttribute ptr)
	equal as function(byval attr1 as const PangoAttribute ptr, byval attr2 as const PangoAttribute ptr) as gboolean
end type

type _PangoAttrString
	attr as PangoAttribute
	value as zstring ptr
end type

type _PangoAttrLanguage
	attr as PangoAttribute
	value as PangoLanguage ptr
end type

type _PangoAttrInt
	attr as PangoAttribute
	value as long
end type

type _PangoAttrFloat
	attr as PangoAttribute
	value as double
end type

type _PangoAttrColor
	attr as PangoAttribute
	color as PangoColor
end type

type _PangoAttrSize
	attr as PangoAttribute
	size as long
	absolute : 1 as guint
end type

type _PangoAttrShape
	attr as PangoAttribute
	ink_rect as PangoRectangle
	logical_rect as PangoRectangle
	data as gpointer
	copy_func as PangoAttrDataCopyFunc
	destroy_func as GDestroyNotify
end type

type _PangoAttrFontDesc
	attr as PangoAttribute
	desc as PangoFontDescription ptr
end type

declare function pango_attr_type_register(byval name as const gchar ptr) as PangoAttrType
declare function pango_attr_type_get_name(byval type as PangoAttrType) as const zstring ptr
declare sub pango_attribute_init(byval attr as PangoAttribute ptr, byval klass as const PangoAttrClass ptr)
declare function pango_attribute_copy(byval attr as const PangoAttribute ptr) as PangoAttribute ptr
declare sub pango_attribute_destroy(byval attr as PangoAttribute ptr)
declare function pango_attribute_equal(byval attr1 as const PangoAttribute ptr, byval attr2 as const PangoAttribute ptr) as gboolean
declare function pango_attr_language_new(byval language as PangoLanguage ptr) as PangoAttribute ptr
declare function pango_attr_family_new(byval family as const zstring ptr) as PangoAttribute ptr
declare function pango_attr_foreground_new(byval red as guint16, byval green as guint16, byval blue as guint16) as PangoAttribute ptr
declare function pango_attr_background_new(byval red as guint16, byval green as guint16, byval blue as guint16) as PangoAttribute ptr
declare function pango_attr_size_new(byval size as long) as PangoAttribute ptr
declare function pango_attr_size_new_absolute(byval size as long) as PangoAttribute ptr
declare function pango_attr_style_new(byval style as PangoStyle) as PangoAttribute ptr
declare function pango_attr_weight_new(byval weight as PangoWeight) as PangoAttribute ptr
declare function pango_attr_variant_new(byval variant as PangoVariant) as PangoAttribute ptr
declare function pango_attr_stretch_new(byval stretch as PangoStretch) as PangoAttribute ptr
declare function pango_attr_font_desc_new(byval desc as const PangoFontDescription ptr) as PangoAttribute ptr
declare function pango_attr_underline_new(byval underline as PangoUnderline) as PangoAttribute ptr
declare function pango_attr_underline_color_new(byval red as guint16, byval green as guint16, byval blue as guint16) as PangoAttribute ptr
declare function pango_attr_strikethrough_new(byval strikethrough as gboolean) as PangoAttribute ptr
declare function pango_attr_strikethrough_color_new(byval red as guint16, byval green as guint16, byval blue as guint16) as PangoAttribute ptr
declare function pango_attr_rise_new(byval rise as long) as PangoAttribute ptr
declare function pango_attr_scale_new(byval scale_factor as double) as PangoAttribute ptr
declare function pango_attr_fallback_new(byval enable_fallback as gboolean) as PangoAttribute ptr
declare function pango_attr_letter_spacing_new(byval letter_spacing as long) as PangoAttribute ptr
declare function pango_attr_shape_new(byval ink_rect as const PangoRectangle ptr, byval logical_rect as const PangoRectangle ptr) as PangoAttribute ptr
declare function pango_attr_shape_new_with_data(byval ink_rect as const PangoRectangle ptr, byval logical_rect as const PangoRectangle ptr, byval data as gpointer, byval copy_func as PangoAttrDataCopyFunc, byval destroy_func as GDestroyNotify) as PangoAttribute ptr
declare function pango_attr_gravity_new(byval gravity as PangoGravity) as PangoAttribute ptr
declare function pango_attr_gravity_hint_new(byval hint as PangoGravityHint) as PangoAttribute ptr
declare function pango_attr_list_get_type() as GType
declare function pango_attr_list_new() as PangoAttrList ptr
declare function pango_attr_list_ref(byval list as PangoAttrList ptr) as PangoAttrList ptr
declare sub pango_attr_list_unref(byval list as PangoAttrList ptr)
declare function pango_attr_list_copy(byval list as PangoAttrList ptr) as PangoAttrList ptr
declare sub pango_attr_list_insert(byval list as PangoAttrList ptr, byval attr as PangoAttribute ptr)
declare sub pango_attr_list_insert_before(byval list as PangoAttrList ptr, byval attr as PangoAttribute ptr)
declare sub pango_attr_list_change(byval list as PangoAttrList ptr, byval attr as PangoAttribute ptr)
declare sub pango_attr_list_splice(byval list as PangoAttrList ptr, byval other as PangoAttrList ptr, byval pos as gint, byval len as gint)
declare function pango_attr_list_filter(byval list as PangoAttrList ptr, byval func as PangoAttrFilterFunc, byval data as gpointer) as PangoAttrList ptr
declare function pango_attr_list_get_iterator(byval list as PangoAttrList ptr) as PangoAttrIterator ptr
declare sub pango_attr_iterator_range(byval iterator as PangoAttrIterator ptr, byval start as gint ptr, byval end as gint ptr)
declare function pango_attr_iterator_next(byval iterator as PangoAttrIterator ptr) as gboolean
declare function pango_attr_iterator_copy(byval iterator as PangoAttrIterator ptr) as PangoAttrIterator ptr
declare sub pango_attr_iterator_destroy(byval iterator as PangoAttrIterator ptr)
declare function pango_attr_iterator_get(byval iterator as PangoAttrIterator ptr, byval type as PangoAttrType) as PangoAttribute ptr
declare sub pango_attr_iterator_get_font(byval iterator as PangoAttrIterator ptr, byval desc as PangoFontDescription ptr, byval language as PangoLanguage ptr ptr, byval extra_attrs as GSList ptr ptr)
declare function pango_attr_iterator_get_attrs(byval iterator as PangoAttrIterator ptr) as GSList ptr
declare function pango_parse_markup(byval markup_text as const zstring ptr, byval length as long, byval accel_marker as gunichar, byval attr_list as PangoAttrList ptr ptr, byval text as zstring ptr ptr, byval accel_char as gunichar ptr, byval error as GError ptr ptr) as gboolean
declare function pango_markup_parser_new(byval accel_marker as gunichar) as GMarkupParseContext ptr
declare function pango_markup_parser_finish(byval context as GMarkupParseContext ptr, byval attr_list as PangoAttrList ptr ptr, byval text as zstring ptr ptr, byval accel_char as gunichar ptr, byval error as GError ptr ptr) as gboolean
#define __PANGO_BREAK_H__
#define __PANGO_ITEM_H__
type PangoAnalysis as _PangoAnalysis
type PangoItem as _PangoItem
const PANGO_ANALYSIS_FLAG_CENTERED_BASELINE = 1 shl 0
const PANGO_ANALYSIS_FLAG_IS_ELLIPSIS = 1 shl 1

type _PangoAnalysis
	shape_engine as PangoEngineShape ptr
	lang_engine as PangoEngineLang ptr
	font as PangoFont ptr
	level as guint8
	gravity as guint8
	flags as guint8
	script as guint8
	language as PangoLanguage ptr
	extra_attrs as GSList ptr
end type

type _PangoItem
	offset as gint
	length as gint
	num_chars as gint
	analysis as PangoAnalysis
end type

#define PANGO_TYPE_ITEM pango_item_get_type()
declare function pango_item_get_type() as GType
declare function pango_item_new() as PangoItem ptr
declare function pango_item_copy(byval item as PangoItem ptr) as PangoItem ptr
declare sub pango_item_free(byval item as PangoItem ptr)
declare function pango_item_split(byval orig as PangoItem ptr, byval split_index as long, byval split_offset as long) as PangoItem ptr

type _PangoLogAttr
	is_line_break : 1 as guint
	is_mandatory_break : 1 as guint
	is_char_break : 1 as guint
	is_white : 1 as guint
	is_cursor_position : 1 as guint
	is_word_start : 1 as guint
	is_word_end : 1 as guint
	is_sentence_boundary : 1 as guint
	is_sentence_start : 1 as guint
	is_sentence_end : 1 as guint
	backspace_deletes_character : 1 as guint
	is_expandable_space : 1 as guint
	is_word_boundary : 1 as guint
end type

declare sub pango_break(byval text as const gchar ptr, byval length as long, byval analysis as PangoAnalysis ptr, byval attrs as PangoLogAttr ptr, byval attrs_len as long)
declare sub pango_find_paragraph_boundary(byval text as const gchar ptr, byval length as gint, byval paragraph_delimiter_index as gint ptr, byval next_paragraph_start as gint ptr)
declare sub pango_get_log_attrs(byval text as const zstring ptr, byval length as long, byval level as long, byval language as PangoLanguage ptr, byval log_attrs as PangoLogAttr ptr, byval attrs_len as long)

#define __PANGO_CONTEXT_H__
#define __PANGO_FONTMAP_H__
#define __PANGO_FONTSET_H__
#define PANGO_TYPE_FONTSET pango_fontset_get_type()
#define PANGO_FONTSET(object) G_TYPE_CHECK_INSTANCE_CAST((object), PANGO_TYPE_FONTSET, PangoFontset)
#define PANGO_IS_FONTSET(object) G_TYPE_CHECK_INSTANCE_TYPE((object), PANGO_TYPE_FONTSET)
declare function pango_fontset_get_type() as GType
type PangoFontset as _PangoFontset
type PangoFontsetForeachFunc as function(byval fontset as PangoFontset ptr, byval font as PangoFont ptr, byval user_data as gpointer) as gboolean

declare function pango_fontset_get_font(byval fontset as PangoFontset ptr, byval wc as guint) as PangoFont ptr
declare function pango_fontset_get_metrics(byval fontset as PangoFontset ptr) as PangoFontMetrics ptr
declare sub pango_fontset_foreach(byval fontset as PangoFontset ptr, byval func as PangoFontsetForeachFunc, byval data as gpointer)

#define PANGO_TYPE_FONT_MAP pango_font_map_get_type()
#define PANGO_FONT_MAP(object) G_TYPE_CHECK_INSTANCE_CAST((object), PANGO_TYPE_FONT_MAP, PangoFontMap)
#define PANGO_IS_FONT_MAP(object) G_TYPE_CHECK_INSTANCE_TYPE((object), PANGO_TYPE_FONT_MAP)
type PangoContext as _PangoContext

declare function pango_font_map_get_type() as GType
declare function pango_font_map_create_context(byval fontmap as PangoFontMap ptr) as PangoContext ptr
declare function pango_font_map_load_font(byval fontmap as PangoFontMap ptr, byval context as PangoContext ptr, byval desc as const PangoFontDescription ptr) as PangoFont ptr
declare function pango_font_map_load_fontset(byval fontmap as PangoFontMap ptr, byval context as PangoContext ptr, byval desc as const PangoFontDescription ptr, byval language as PangoLanguage ptr) as PangoFontset ptr
declare sub pango_font_map_list_families(byval fontmap as PangoFontMap ptr, byval families as PangoFontFamily ptr ptr ptr, byval n_families as long ptr)
declare function pango_font_map_get_serial(byval fontmap as PangoFontMap ptr) as guint
declare sub pango_font_map_changed(byval fontmap as PangoFontMap ptr)
type PangoContextClass as _PangoContextClass

#define PANGO_TYPE_CONTEXT pango_context_get_type()
#define PANGO_CONTEXT(object) G_TYPE_CHECK_INSTANCE_CAST((object), PANGO_TYPE_CONTEXT, PangoContext)
#define PANGO_CONTEXT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), PANGO_TYPE_CONTEXT, PangoContextClass)
#define PANGO_IS_CONTEXT(object) G_TYPE_CHECK_INSTANCE_TYPE((object), PANGO_TYPE_CONTEXT)
#define PANGO_IS_CONTEXT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), PANGO_TYPE_CONTEXT)
#define PANGO_CONTEXT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), PANGO_TYPE_CONTEXT, PangoContextClass)

declare function pango_context_get_type() as GType
declare function pango_context_new() as PangoContext ptr
declare sub pango_context_changed(byval context as PangoContext ptr)
declare sub pango_context_set_font_map(byval context as PangoContext ptr, byval font_map as PangoFontMap ptr)
declare function pango_context_get_font_map(byval context as PangoContext ptr) as PangoFontMap ptr
declare function pango_context_get_serial(byval context as PangoContext ptr) as guint
declare sub pango_context_list_families(byval context as PangoContext ptr, byval families as PangoFontFamily ptr ptr ptr, byval n_families as long ptr)
declare function pango_context_load_font(byval context as PangoContext ptr, byval desc as const PangoFontDescription ptr) as PangoFont ptr
declare function pango_context_load_fontset(byval context as PangoContext ptr, byval desc as const PangoFontDescription ptr, byval language as PangoLanguage ptr) as PangoFontset ptr
declare function pango_context_get_metrics(byval context as PangoContext ptr, byval desc as const PangoFontDescription ptr, byval language as PangoLanguage ptr) as PangoFontMetrics ptr
declare sub pango_context_set_font_description(byval context as PangoContext ptr, byval desc as const PangoFontDescription ptr)
declare function pango_context_get_font_description(byval context as PangoContext ptr) as PangoFontDescription ptr
declare function pango_context_get_language(byval context as PangoContext ptr) as PangoLanguage ptr
declare sub pango_context_set_language(byval context as PangoContext ptr, byval language as PangoLanguage ptr)
declare sub pango_context_set_base_dir(byval context as PangoContext ptr, byval direction as PangoDirection)
declare function pango_context_get_base_dir(byval context as PangoContext ptr) as PangoDirection
declare sub pango_context_set_base_gravity(byval context as PangoContext ptr, byval gravity as PangoGravity)
declare function pango_context_get_base_gravity(byval context as PangoContext ptr) as PangoGravity
declare function pango_context_get_gravity(byval context as PangoContext ptr) as PangoGravity
declare sub pango_context_set_gravity_hint(byval context as PangoContext ptr, byval hint as PangoGravityHint)
declare function pango_context_get_gravity_hint(byval context as PangoContext ptr) as PangoGravityHint
declare sub pango_context_set_matrix(byval context as PangoContext ptr, byval matrix as const PangoMatrix ptr)
declare function pango_context_get_matrix(byval context as PangoContext ptr) as const PangoMatrix ptr
declare function pango_itemize(byval context as PangoContext ptr, byval text as const zstring ptr, byval start_index as long, byval length as long, byval attrs as PangoAttrList ptr, byval cached_iter as PangoAttrIterator ptr) as GList ptr
declare function pango_itemize_with_base_dir(byval context as PangoContext ptr, byval base_dir as PangoDirection, byval text as const zstring ptr, byval start_index as long, byval length as long, byval attrs as PangoAttrList ptr, byval cached_iter as PangoAttrIterator ptr) as GList ptr
#define __PANGO_ENGINE_H__
#define __PANGO_GLYPH_H__

type PangoGlyphGeometry as _PangoGlyphGeometry
type PangoGlyphVisAttr as _PangoGlyphVisAttr
type PangoGlyphInfo as _PangoGlyphInfo
type PangoGlyphString as _PangoGlyphString
type PangoGlyphUnit as gint32

type _PangoGlyphGeometry
	width as PangoGlyphUnit
	x_offset as PangoGlyphUnit
	y_offset as PangoGlyphUnit
end type

type _PangoGlyphVisAttr
	is_cluster_start : 1 as guint
end type

type _PangoGlyphInfo
	glyph as PangoGlyph
	geometry as PangoGlyphGeometry
	attr as PangoGlyphVisAttr
end type

type _PangoGlyphString
	num_glyphs as gint
	glyphs as PangoGlyphInfo ptr
	log_clusters as gint ptr
	space as gint
end type

#define PANGO_TYPE_GLYPH_STRING pango_glyph_string_get_type()
declare function pango_glyph_string_new() as PangoGlyphString ptr
declare sub pango_glyph_string_set_size(byval string as PangoGlyphString ptr, byval new_len as gint)
declare function pango_glyph_string_get_type() as GType
declare function pango_glyph_string_copy(byval string as PangoGlyphString ptr) as PangoGlyphString ptr
declare sub pango_glyph_string_free(byval string as PangoGlyphString ptr)
declare sub pango_glyph_string_extents(byval glyphs as PangoGlyphString ptr, byval font as PangoFont ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare function pango_glyph_string_get_width(byval glyphs as PangoGlyphString ptr) as long
declare sub pango_glyph_string_extents_range(byval glyphs as PangoGlyphString ptr, byval start as long, byval end as long, byval font as PangoFont ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare sub pango_glyph_string_get_logical_widths(byval glyphs as PangoGlyphString ptr, byval text as const zstring ptr, byval length as long, byval embedding_level as long, byval logical_widths as long ptr)
declare sub pango_glyph_string_index_to_x(byval glyphs as PangoGlyphString ptr, byval text as zstring ptr, byval length as long, byval analysis as PangoAnalysis ptr, byval index_ as long, byval trailing as gboolean, byval x_pos as long ptr)
declare sub pango_glyph_string_x_to_index(byval glyphs as PangoGlyphString ptr, byval text as zstring ptr, byval length as long, byval analysis as PangoAnalysis ptr, byval x_pos as long, byval index_ as long ptr, byval trailing as long ptr)
declare sub pango_shape(byval text as const gchar ptr, byval length as gint, byval analysis as const PangoAnalysis ptr, byval glyphs as PangoGlyphString ptr)
declare sub pango_shape_full(byval item_text as const gchar ptr, byval item_length as gint, byval paragraph_text as const gchar ptr, byval paragraph_length as gint, byval analysis as const PangoAnalysis ptr, byval glyphs as PangoGlyphString ptr)
declare function pango_reorder_items(byval logical_items as GList ptr) as GList ptr
#define __PANGO_ENUM_TYPES_H__
declare function pango_attr_type_get_type() as GType
#define PANGO_TYPE_ATTR_TYPE pango_attr_type_get_type()
declare function pango_underline_get_type() as GType
#define PANGO_TYPE_UNDERLINE pango_underline_get_type()
declare function pango_bidi_type_get_type() as GType
#define PANGO_TYPE_BIDI_TYPE pango_bidi_type_get_type()
declare function pango_direction_get_type() as GType
#define PANGO_TYPE_DIRECTION pango_direction_get_type()
declare function pango_coverage_level_get_type() as GType
#define PANGO_TYPE_COVERAGE_LEVEL pango_coverage_level_get_type()
declare function pango_style_get_type() as GType
#define PANGO_TYPE_STYLE pango_style_get_type()
declare function pango_variant_get_type() as GType
#define PANGO_TYPE_VARIANT pango_variant_get_type()
declare function pango_weight_get_type() as GType
#define PANGO_TYPE_WEIGHT pango_weight_get_type()
declare function pango_stretch_get_type() as GType
#define PANGO_TYPE_STRETCH pango_stretch_get_type()
declare function pango_font_mask_get_type() as GType
#define PANGO_TYPE_FONT_MASK pango_font_mask_get_type()
declare function pango_gravity_get_type() as GType
#define PANGO_TYPE_GRAVITY pango_gravity_get_type()
declare function pango_gravity_hint_get_type() as GType
#define PANGO_TYPE_GRAVITY_HINT pango_gravity_hint_get_type()
declare function pango_alignment_get_type() as GType
#define PANGO_TYPE_ALIGNMENT pango_alignment_get_type()
declare function pango_wrap_mode_get_type() as GType
#define PANGO_TYPE_WRAP_MODE pango_wrap_mode_get_type()
declare function pango_ellipsize_mode_get_type() as GType
#define PANGO_TYPE_ELLIPSIZE_MODE pango_ellipsize_mode_get_type()
declare function pango_render_part_get_type() as GType
#define PANGO_TYPE_RENDER_PART pango_render_part_get_type()
declare function pango_script_get_type() as GType
#define PANGO_TYPE_SCRIPT pango_script_get_type()
declare function pango_tab_align_get_type() as GType

#define PANGO_TYPE_TAB_ALIGN pango_tab_align_get_type()
#define PANGO_FEATURES_H
const PANGO_VERSION_MAJOR = 1
const PANGO_VERSION_MINOR = 36
const PANGO_VERSION_MICRO = 8
#define PANGO_VERSION_STRING "1.36.8"
#define __PANGO_GLYPH_ITEM_H__
type PangoGlyphItem as _PangoGlyphItem

type _PangoGlyphItem
	item as PangoItem ptr
	glyphs as PangoGlyphString ptr
end type

#define PANGO_TYPE_GLYPH_ITEM pango_glyph_item_get_type()
declare function pango_glyph_item_get_type() as GType
declare function pango_glyph_item_split(byval orig as PangoGlyphItem ptr, byval text as const zstring ptr, byval split_index as long) as PangoGlyphItem ptr
declare function pango_glyph_item_copy(byval orig as PangoGlyphItem ptr) as PangoGlyphItem ptr
declare sub pango_glyph_item_free(byval glyph_item as PangoGlyphItem ptr)
declare function pango_glyph_item_apply_attrs(byval glyph_item as PangoGlyphItem ptr, byval text as const zstring ptr, byval list as PangoAttrList ptr) as GSList ptr
declare sub pango_glyph_item_letter_space(byval glyph_item as PangoGlyphItem ptr, byval text as const zstring ptr, byval log_attrs as PangoLogAttr ptr, byval letter_spacing as long)
declare sub pango_glyph_item_get_logical_widths(byval glyph_item as PangoGlyphItem ptr, byval text as const zstring ptr, byval logical_widths as long ptr)
type PangoGlyphItemIter as _PangoGlyphItemIter

type _PangoGlyphItemIter
	glyph_item as PangoGlyphItem ptr
	text as const gchar ptr
	start_glyph as long
	start_index as long
	start_char as long
	end_glyph as long
	end_index as long
	end_char as long
end type

#define PANGO_TYPE_GLYPH_ITEM_ITER pango_glyph_item_iter_get_type()
declare function pango_glyph_item_iter_get_type() as GType
declare function pango_glyph_item_iter_copy(byval orig as PangoGlyphItemIter ptr) as PangoGlyphItemIter ptr
declare sub pango_glyph_item_iter_free(byval iter as PangoGlyphItemIter ptr)
declare function pango_glyph_item_iter_init_start(byval iter as PangoGlyphItemIter ptr, byval glyph_item as PangoGlyphItem ptr, byval text as const zstring ptr) as gboolean
declare function pango_glyph_item_iter_init_end(byval iter as PangoGlyphItemIter ptr, byval glyph_item as PangoGlyphItem ptr, byval text as const zstring ptr) as gboolean
declare function pango_glyph_item_iter_next_cluster(byval iter as PangoGlyphItemIter ptr) as gboolean
declare function pango_glyph_item_iter_prev_cluster(byval iter as PangoGlyphItemIter ptr) as gboolean
#define __PANGO_LAYOUT_H__
#define __PANGO_TABS_H__
type PangoTabArray as _PangoTabArray

type PangoTabAlign as long
enum
	PANGO_TAB_LEFT
end enum

#define PANGO_TYPE_TAB_ARRAY pango_tab_array_get_type()
declare function pango_tab_array_new(byval initial_size as gint, byval positions_in_pixels as gboolean) as PangoTabArray ptr
declare function pango_tab_array_new_with_positions(byval size as gint, byval positions_in_pixels as gboolean, byval first_alignment as PangoTabAlign, byval first_position as gint, ...) as PangoTabArray ptr
declare function pango_tab_array_get_type() as GType
declare function pango_tab_array_copy(byval src as PangoTabArray ptr) as PangoTabArray ptr
declare sub pango_tab_array_free(byval tab_array as PangoTabArray ptr)
declare function pango_tab_array_get_size(byval tab_array as PangoTabArray ptr) as gint
declare sub pango_tab_array_resize(byval tab_array as PangoTabArray ptr, byval new_size as gint)
declare sub pango_tab_array_set_tab(byval tab_array as PangoTabArray ptr, byval tab_index as gint, byval alignment as PangoTabAlign, byval location as gint)
declare sub pango_tab_array_get_tab(byval tab_array as PangoTabArray ptr, byval tab_index as gint, byval alignment as PangoTabAlign ptr, byval location as gint ptr)
declare sub pango_tab_array_get_tabs(byval tab_array as PangoTabArray ptr, byval alignments as PangoTabAlign ptr ptr, byval locations as gint ptr ptr)
declare function pango_tab_array_get_positions_in_pixels(byval tab_array as PangoTabArray ptr) as gboolean

type PangoLayout as _PangoLayout
type PangoLayoutClass as _PangoLayoutClass
type PangoLayoutLine as _PangoLayoutLine
type PangoLayoutRun as PangoGlyphItem

type PangoAlignment as long
enum
	PANGO_ALIGN_LEFT
	PANGO_ALIGN_CENTER
	PANGO_ALIGN_RIGHT
end enum

type PangoWrapMode as long
enum
	PANGO_WRAP_WORD
	PANGO_WRAP_CHAR
	PANGO_WRAP_WORD_CHAR
end enum

type PangoEllipsizeMode as long
enum
	PANGO_ELLIPSIZE_NONE
	PANGO_ELLIPSIZE_START
	PANGO_ELLIPSIZE_MIDDLE
	PANGO_ELLIPSIZE_END
end enum

type _PangoLayoutLine
	layout as PangoLayout ptr
	start_index as gint
	length as gint
	runs as GSList ptr
	is_paragraph_start : 1 as guint
	resolved_dir : 3 as guint
end type

#define PANGO_TYPE_LAYOUT pango_layout_get_type()
#define PANGO_LAYOUT(object) G_TYPE_CHECK_INSTANCE_CAST((object), PANGO_TYPE_LAYOUT, PangoLayout)
#define PANGO_LAYOUT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), PANGO_TYPE_LAYOUT, PangoLayoutClass)
#define PANGO_IS_LAYOUT(object) G_TYPE_CHECK_INSTANCE_TYPE((object), PANGO_TYPE_LAYOUT)
#define PANGO_IS_LAYOUT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), PANGO_TYPE_LAYOUT)
#define PANGO_LAYOUT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), PANGO_TYPE_LAYOUT, PangoLayoutClass)

declare function pango_layout_get_type() as GType
declare function pango_layout_new(byval context as PangoContext ptr) as PangoLayout ptr
declare function pango_layout_copy(byval src as PangoLayout ptr) as PangoLayout ptr
declare function pango_layout_get_context(byval layout as PangoLayout ptr) as PangoContext ptr
declare sub pango_layout_set_attributes(byval layout as PangoLayout ptr, byval attrs as PangoAttrList ptr)
declare function pango_layout_get_attributes(byval layout as PangoLayout ptr) as PangoAttrList ptr
declare sub pango_layout_set_text(byval layout as PangoLayout ptr, byval text as const zstring ptr, byval length as long)
declare function pango_layout_get_text(byval layout as PangoLayout ptr) as const zstring ptr
declare function pango_layout_get_character_count(byval layout as PangoLayout ptr) as gint
declare sub pango_layout_set_markup(byval layout as PangoLayout ptr, byval markup as const zstring ptr, byval length as long)
declare sub pango_layout_set_markup_with_accel(byval layout as PangoLayout ptr, byval markup as const zstring ptr, byval length as long, byval accel_marker as gunichar, byval accel_char as gunichar ptr)
declare sub pango_layout_set_font_description(byval layout as PangoLayout ptr, byval desc as const PangoFontDescription ptr)
declare function pango_layout_get_font_description(byval layout as PangoLayout ptr) as const PangoFontDescription ptr
declare sub pango_layout_set_width(byval layout as PangoLayout ptr, byval width as long)
declare function pango_layout_get_width(byval layout as PangoLayout ptr) as long
declare sub pango_layout_set_height(byval layout as PangoLayout ptr, byval height as long)
declare function pango_layout_get_height(byval layout as PangoLayout ptr) as long
declare sub pango_layout_set_wrap(byval layout as PangoLayout ptr, byval wrap as PangoWrapMode)
declare function pango_layout_get_wrap(byval layout as PangoLayout ptr) as PangoWrapMode
declare function pango_layout_is_wrapped(byval layout as PangoLayout ptr) as gboolean
declare sub pango_layout_set_indent(byval layout as PangoLayout ptr, byval indent as long)
declare function pango_layout_get_indent(byval layout as PangoLayout ptr) as long
declare sub pango_layout_set_spacing(byval layout as PangoLayout ptr, byval spacing as long)
declare function pango_layout_get_spacing(byval layout as PangoLayout ptr) as long
declare sub pango_layout_set_justify(byval layout as PangoLayout ptr, byval justify as gboolean)
declare function pango_layout_get_justify(byval layout as PangoLayout ptr) as gboolean
declare sub pango_layout_set_auto_dir(byval layout as PangoLayout ptr, byval auto_dir as gboolean)
declare function pango_layout_get_auto_dir(byval layout as PangoLayout ptr) as gboolean
declare sub pango_layout_set_alignment(byval layout as PangoLayout ptr, byval alignment as PangoAlignment)
declare function pango_layout_get_alignment(byval layout as PangoLayout ptr) as PangoAlignment
declare sub pango_layout_set_tabs(byval layout as PangoLayout ptr, byval tabs as PangoTabArray ptr)
declare function pango_layout_get_tabs(byval layout as PangoLayout ptr) as PangoTabArray ptr
declare sub pango_layout_set_single_paragraph_mode(byval layout as PangoLayout ptr, byval setting as gboolean)
declare function pango_layout_get_single_paragraph_mode(byval layout as PangoLayout ptr) as gboolean
declare sub pango_layout_set_ellipsize(byval layout as PangoLayout ptr, byval ellipsize as PangoEllipsizeMode)
declare function pango_layout_get_ellipsize(byval layout as PangoLayout ptr) as PangoEllipsizeMode
declare function pango_layout_is_ellipsized(byval layout as PangoLayout ptr) as gboolean
declare function pango_layout_get_unknown_glyphs_count(byval layout as PangoLayout ptr) as long
declare sub pango_layout_context_changed(byval layout as PangoLayout ptr)
declare function pango_layout_get_serial(byval layout as PangoLayout ptr) as guint
declare sub pango_layout_get_log_attrs(byval layout as PangoLayout ptr, byval attrs as PangoLogAttr ptr ptr, byval n_attrs as gint ptr)
declare function pango_layout_get_log_attrs_readonly(byval layout as PangoLayout ptr, byval n_attrs as gint ptr) as const PangoLogAttr ptr
declare sub pango_layout_index_to_pos(byval layout as PangoLayout ptr, byval index_ as long, byval pos as PangoRectangle ptr)
declare sub pango_layout_index_to_line_x(byval layout as PangoLayout ptr, byval index_ as long, byval trailing as gboolean, byval line as long ptr, byval x_pos as long ptr)
declare sub pango_layout_get_cursor_pos(byval layout as PangoLayout ptr, byval index_ as long, byval strong_pos as PangoRectangle ptr, byval weak_pos as PangoRectangle ptr)
declare sub pango_layout_move_cursor_visually(byval layout as PangoLayout ptr, byval strong as gboolean, byval old_index as long, byval old_trailing as long, byval direction as long, byval new_index as long ptr, byval new_trailing as long ptr)
declare function pango_layout_xy_to_index(byval layout as PangoLayout ptr, byval x as long, byval y as long, byval index_ as long ptr, byval trailing as long ptr) as gboolean
declare sub pango_layout_get_extents(byval layout as PangoLayout ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare sub pango_layout_get_pixel_extents(byval layout as PangoLayout ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare sub pango_layout_get_size(byval layout as PangoLayout ptr, byval width as long ptr, byval height as long ptr)
declare sub pango_layout_get_pixel_size(byval layout as PangoLayout ptr, byval width as long ptr, byval height as long ptr)
declare function pango_layout_get_baseline(byval layout as PangoLayout ptr) as long
declare function pango_layout_get_line_count(byval layout as PangoLayout ptr) as long
declare function pango_layout_get_line(byval layout as PangoLayout ptr, byval line as long) as PangoLayoutLine ptr
declare function pango_layout_get_line_readonly(byval layout as PangoLayout ptr, byval line as long) as PangoLayoutLine ptr
declare function pango_layout_get_lines(byval layout as PangoLayout ptr) as GSList ptr
declare function pango_layout_get_lines_readonly(byval layout as PangoLayout ptr) as GSList ptr
#define PANGO_TYPE_LAYOUT_LINE pango_layout_line_get_type()
declare function pango_layout_line_get_type() as GType
declare function pango_layout_line_ref(byval line as PangoLayoutLine ptr) as PangoLayoutLine ptr
declare sub pango_layout_line_unref(byval line as PangoLayoutLine ptr)
declare function pango_layout_line_x_to_index(byval line as PangoLayoutLine ptr, byval x_pos as long, byval index_ as long ptr, byval trailing as long ptr) as gboolean
declare sub pango_layout_line_index_to_x(byval line as PangoLayoutLine ptr, byval index_ as long, byval trailing as gboolean, byval x_pos as long ptr)
declare sub pango_layout_line_get_x_ranges(byval line as PangoLayoutLine ptr, byval start_index as long, byval end_index as long, byval ranges as long ptr ptr, byval n_ranges as long ptr)
declare sub pango_layout_line_get_extents(byval line as PangoLayoutLine ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare sub pango_layout_line_get_pixel_extents(byval layout_line as PangoLayoutLine ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
type PangoLayoutIter as _PangoLayoutIter
#define PANGO_TYPE_LAYOUT_ITER pango_layout_iter_get_type()
declare function pango_layout_iter_get_type() as GType
declare function pango_layout_get_iter(byval layout as PangoLayout ptr) as PangoLayoutIter ptr
declare function pango_layout_iter_copy(byval iter as PangoLayoutIter ptr) as PangoLayoutIter ptr
declare sub pango_layout_iter_free(byval iter as PangoLayoutIter ptr)
declare function pango_layout_iter_get_index(byval iter as PangoLayoutIter ptr) as long
declare function pango_layout_iter_get_run(byval iter as PangoLayoutIter ptr) as PangoLayoutRun ptr
declare function pango_layout_iter_get_run_readonly(byval iter as PangoLayoutIter ptr) as PangoLayoutRun ptr
declare function pango_layout_iter_get_line(byval iter as PangoLayoutIter ptr) as PangoLayoutLine ptr
declare function pango_layout_iter_get_line_readonly(byval iter as PangoLayoutIter ptr) as PangoLayoutLine ptr
declare function pango_layout_iter_at_last_line(byval iter as PangoLayoutIter ptr) as gboolean
declare function pango_layout_iter_get_layout(byval iter as PangoLayoutIter ptr) as PangoLayout ptr
declare function pango_layout_iter_next_char(byval iter as PangoLayoutIter ptr) as gboolean
declare function pango_layout_iter_next_cluster(byval iter as PangoLayoutIter ptr) as gboolean
declare function pango_layout_iter_next_run(byval iter as PangoLayoutIter ptr) as gboolean
declare function pango_layout_iter_next_line(byval iter as PangoLayoutIter ptr) as gboolean
declare sub pango_layout_iter_get_char_extents(byval iter as PangoLayoutIter ptr, byval logical_rect as PangoRectangle ptr)
declare sub pango_layout_iter_get_cluster_extents(byval iter as PangoLayoutIter ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare sub pango_layout_iter_get_run_extents(byval iter as PangoLayoutIter ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare sub pango_layout_iter_get_line_extents(byval iter as PangoLayoutIter ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare sub pango_layout_iter_get_line_yrange(byval iter as PangoLayoutIter ptr, byval y0_ as long ptr, byval y1_ as long ptr)
declare sub pango_layout_iter_get_layout_extents(byval iter as PangoLayoutIter ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare function pango_layout_iter_get_baseline(byval iter as PangoLayoutIter ptr) as long

#define __PANGO_RENDERER_H_
#define PANGO_TYPE_RENDERER pango_renderer_get_type()
#define PANGO_RENDERER(object) G_TYPE_CHECK_INSTANCE_CAST((object), PANGO_TYPE_RENDERER, PangoRenderer)
#define PANGO_IS_RENDERER(object) G_TYPE_CHECK_INSTANCE_TYPE((object), PANGO_TYPE_RENDERER)
#define PANGO_RENDERER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), PANGO_TYPE_RENDERER, PangoRendererClass)
#define PANGO_IS_RENDERER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), PANGO_TYPE_RENDERER)
#define PANGO_RENDERER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), PANGO_TYPE_RENDERER, PangoRendererClass)

type PangoRenderer as _PangoRenderer
type PangoRendererClass as _PangoRendererClass
type PangoRendererPrivate as _PangoRendererPrivate

type PangoRenderPart as long
enum
	PANGO_RENDER_PART_FOREGROUND
	PANGO_RENDER_PART_BACKGROUND
	PANGO_RENDER_PART_UNDERLINE
	PANGO_RENDER_PART_STRIKETHROUGH
end enum

type _PangoRenderer
	parent_instance as GObject
	underline as PangoUnderline
	strikethrough as gboolean
	active_count as long
	matrix as PangoMatrix ptr
	priv as PangoRendererPrivate ptr
end type

type _PangoRendererClass
	parent_class as GObjectClass
	draw_glyphs as sub(byval renderer as PangoRenderer ptr, byval font as PangoFont ptr, byval glyphs as PangoGlyphString ptr, byval x as long, byval y as long)
	draw_rectangle as sub(byval renderer as PangoRenderer ptr, byval part as PangoRenderPart, byval x as long, byval y as long, byval width as long, byval height as long)
	draw_error_underline as sub(byval renderer as PangoRenderer ptr, byval x as long, byval y as long, byval width as long, byval height as long)
	draw_shape as sub(byval renderer as PangoRenderer ptr, byval attr as PangoAttrShape ptr, byval x as long, byval y as long)
	draw_trapezoid as sub(byval renderer as PangoRenderer ptr, byval part as PangoRenderPart, byval y1_ as double, byval x11 as double, byval x21 as double, byval y2 as double, byval x12 as double, byval x22 as double)
	draw_glyph as sub(byval renderer as PangoRenderer ptr, byval font as PangoFont ptr, byval glyph as PangoGlyph, byval x as double, byval y as double)
	part_changed as sub(byval renderer as PangoRenderer ptr, byval part as PangoRenderPart)
	begin as sub(byval renderer as PangoRenderer ptr)
	as sub(byval renderer as PangoRenderer ptr) end
	prepare_run as sub(byval renderer as PangoRenderer ptr, byval run as PangoLayoutRun ptr)
	draw_glyph_item as sub(byval renderer as PangoRenderer ptr, byval text as const zstring ptr, byval glyph_item as PangoGlyphItem ptr, byval x as long, byval y as long)
	_pango_reserved2 as sub()
	_pango_reserved3 as sub()
	_pango_reserved4 as sub()
end type

declare function pango_renderer_get_type() as GType
declare sub pango_renderer_draw_layout(byval renderer as PangoRenderer ptr, byval layout as PangoLayout ptr, byval x as long, byval y as long)
declare sub pango_renderer_draw_layout_line(byval renderer as PangoRenderer ptr, byval line as PangoLayoutLine ptr, byval x as long, byval y as long)
declare sub pango_renderer_draw_glyphs(byval renderer as PangoRenderer ptr, byval font as PangoFont ptr, byval glyphs as PangoGlyphString ptr, byval x as long, byval y as long)
declare sub pango_renderer_draw_glyph_item(byval renderer as PangoRenderer ptr, byval text as const zstring ptr, byval glyph_item as PangoGlyphItem ptr, byval x as long, byval y as long)
declare sub pango_renderer_draw_rectangle(byval renderer as PangoRenderer ptr, byval part as PangoRenderPart, byval x as long, byval y as long, byval width as long, byval height as long)
declare sub pango_renderer_draw_error_underline(byval renderer as PangoRenderer ptr, byval x as long, byval y as long, byval width as long, byval height as long)
declare sub pango_renderer_draw_trapezoid(byval renderer as PangoRenderer ptr, byval part as PangoRenderPart, byval y1_ as double, byval x11 as double, byval x21 as double, byval y2 as double, byval x12 as double, byval x22 as double)
declare sub pango_renderer_draw_glyph(byval renderer as PangoRenderer ptr, byval font as PangoFont ptr, byval glyph as PangoGlyph, byval x as double, byval y as double)
declare sub pango_renderer_activate(byval renderer as PangoRenderer ptr)
declare sub pango_renderer_deactivate(byval renderer as PangoRenderer ptr)
declare sub pango_renderer_part_changed(byval renderer as PangoRenderer ptr, byval part as PangoRenderPart)
declare sub pango_renderer_set_color(byval renderer as PangoRenderer ptr, byval part as PangoRenderPart, byval color as const PangoColor ptr)
declare function pango_renderer_get_color(byval renderer as PangoRenderer ptr, byval part as PangoRenderPart) as PangoColor ptr
declare sub pango_renderer_set_matrix(byval renderer as PangoRenderer ptr, byval matrix as const PangoMatrix ptr)
declare function pango_renderer_get_matrix(byval renderer as PangoRenderer ptr) as const PangoMatrix ptr
declare function pango_renderer_get_layout(byval renderer as PangoRenderer ptr) as PangoLayout ptr
declare function pango_renderer_get_layout_line(byval renderer as PangoRenderer ptr) as PangoLayoutLine ptr
#define __PANGO_UTILS_H__
declare function pango_split_file_list(byval str as const zstring ptr) as zstring ptr ptr
declare function pango_trim_string(byval str as const zstring ptr) as zstring ptr
declare function pango_read_line(byval stream as FILE ptr, byval str as GString ptr) as gint
declare function pango_skip_space(byval pos as const zstring ptr ptr) as gboolean
declare function pango_scan_word(byval pos as const zstring ptr ptr, byval out as GString ptr) as gboolean
declare function pango_scan_string(byval pos as const zstring ptr ptr, byval out as GString ptr) as gboolean
declare function pango_scan_int(byval pos as const zstring ptr ptr, byval out as long ptr) as gboolean
declare function pango_parse_enum(byval type as GType, byval str as const zstring ptr, byval value as long ptr, byval warn as gboolean, byval possible_values as zstring ptr ptr) as gboolean
declare function pango_parse_style(byval str as const zstring ptr, byval style as PangoStyle ptr, byval warn as gboolean) as gboolean
declare function pango_parse_variant(byval str as const zstring ptr, byval variant as PangoVariant ptr, byval warn as gboolean) as gboolean
declare function pango_parse_weight(byval str as const zstring ptr, byval weight as PangoWeight ptr, byval warn as gboolean) as gboolean
declare function pango_parse_stretch(byval str as const zstring ptr, byval stretch as PangoStretch ptr, byval warn as gboolean) as gboolean
declare sub pango_quantize_line_geometry(byval thickness as long ptr, byval position as long ptr)
declare function pango_log2vis_get_embedding_levels(byval text as const gchar ptr, byval length as long, byval pbase_dir as PangoDirection ptr) as guint8 ptr
declare function pango_is_zero_width(byval ch as gunichar) as gboolean

#define PANGO_VERSION_ENCODE(major, minor, micro) ((((major) * 10000) + ((minor) * 100)) + ((micro) * 1))
#define PANGO_VERSION PANGO_VERSION_ENCODE(PANGO_VERSION_MAJOR, PANGO_VERSION_MINOR, PANGO_VERSION_MICRO)
#define PANGO_VERSION_CHECK(major, minor, micro) (PANGO_VERSION >= PANGO_VERSION_ENCODE(major, minor, micro))

declare function pango_version_ alias "pango_version"() as long
declare function pango_version_string_ alias "pango_version_string"() as const zstring ptr
declare function pango_version_check_ alias "pango_version_check"(byval required_major as long, byval required_minor as long, byval required_micro as long) as const zstring ptr

end extern

#ifdef __FB_WIN32__
#pragma pop(msbitfields)
#endif
