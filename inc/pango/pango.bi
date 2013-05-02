' This is file glib.bi
' (FreeBasic binding for Pango library version 1.30.1)
'
' translated with help of h_2_bi.bas by
' Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net.
'
' Licence:
' (C) 2011-2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
'
' This library binding is free software; you can redistribute it
' and/or modify it under the terms of the GNU Lesser General Public
' License as published by the Free Software Foundation; either
' version 2 of the License, or (at your option) ANY later version.
'
' This binding is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
' Lesser General Public License for more details, refer to:
' http://www.gnu.org/licenses/lgpl.html
'
'
' Original license text:
'
'/* Pango
 '* pango.h:
 '*
 '* Copyright (C) 1999 Red Hat Software
 '*
 '* This library is free software; you can redistribute it and/or
 '* modify it under the terms of the GNU Library General Public
 '* License as published by the Free Software Foundation; either
 '* version 2 of the License, or (at your option) any later version.
 '*
 '* This library is distributed in the hope that it will be useful,
 '* but WITHOUT ANY WARRANTY; without even the implied warranty of
 '* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   See the GNU
 '* Library General Public License for more details.
 '*
 '* You should have received a copy of the GNU Library General Public
 '* License along with this library; if not, write to the
 '* Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 '* Boston, MA 02111-1307, USA.
 '*/

#IFDEF __FB_WIN32__
#PRAGMA push(msbitfields)
#ENDIF

#INCLIB "pango-1.0"

EXTERN "C" ' (h_2_bi -P_oCD option)

#IFNDEF __PANGO_H__
#DEFINE __PANGO_H__

#IFNDEF __PANGO_ATTRIBUTES_H__
#DEFINE __PANGO_ATTRIBUTES_H__

#IFNDEF __PANGO_FONT_H__
#DEFINE __PANGO_FONT_H__

#IFNDEF __PANGO_COVERAGE_H__
#DEFINE __PANGO_COVERAGE_H__
#INCLUDE ONCE "glib.bi" '__HEADERS__: glib.h

TYPE PangoCoverage AS _PangoCoverage

ENUM PangoCoverageLevel
  PANGO_COVERAGE_NONE
  PANGO_COVERAGE_FALLBACK
  PANGO_COVERAGE_APPROXIMATE
  PANGO_COVERAGE_EXACT
END ENUM

DECLARE FUNCTION pango_coverage_new() AS PangoCoverage PTR
DECLARE FUNCTION pango_coverage_ref(BYVAL AS PangoCoverage PTR) AS PangoCoverage PTR
DECLARE SUB pango_coverage_unref(BYVAL AS PangoCoverage PTR)
DECLARE FUNCTION pango_coverage_copy(BYVAL AS PangoCoverage PTR) AS PangoCoverage PTR
DECLARE FUNCTION pango_coverage_get(BYVAL AS PangoCoverage PTR, BYVAL AS INTEGER) AS PangoCoverageLevel
DECLARE SUB pango_coverage_set(BYVAL AS PangoCoverage PTR, BYVAL AS INTEGER, BYVAL AS PangoCoverageLevel)
DECLARE SUB pango_coverage_max(BYVAL AS PangoCoverage PTR, BYVAL AS PangoCoverage PTR)
DECLARE SUB pango_coverage_to_bytes(BYVAL AS PangoCoverage PTR, BYVAL AS guchar PTR PTR, BYVAL AS INTEGER PTR)
DECLARE FUNCTION pango_coverage_from_bytes(BYVAL AS guchar PTR, BYVAL AS INTEGER) AS PangoCoverage PTR

#ENDIF ' __PANGO_COVERAGE_H__

#IFNDEF __PANGO_TYPES_H__
#DEFINE __PANGO_TYPES_H__

#INCLUDE ONCE "glib-object.bi" '__HEADERS__: glib-object.h

TYPE PangoLogAttr AS _PangoLogAttr
TYPE PangoEngineLang AS _PangoEngineLang
TYPE PangoEngineShape AS _PangoEngineShape
TYPE PangoFont AS _PangoFont
TYPE PangoFontMap AS _PangoFontMap
TYPE PangoRectangle AS _PangoRectangle
TYPE PangoGlyph AS guint32

#DEFINE PANGO_SCALE 1024
#DEFINE PANGO_PIXELS(d) (CAST(INTEGER, (d, + 512)) SHR 10)
#DEFINE PANGO_PIXELS_FLOOR(d) (CAST(INTEGER, (d)) SHR 10)
#DEFINE PANGO_PIXELS_CEIL(d) (CAST(INTEGER, (d) + 1023) SHR 10)
#DEFINE PANGO_UNITS_ROUND(d) _
  ((d) + (PANGO_SCALE  SHR 1) AND NOT (PANGO_SCALE - 1))

DECLARE FUNCTION pango_units_from_double(BYVAL AS DOUBLE) AS INTEGER
DECLARE FUNCTION pango_units_to_double(BYVAL AS INTEGER) AS DOUBLE

TYPE _PangoRectangle
  AS INTEGER x
  AS INTEGER y
  AS INTEGER width
  AS INTEGER height
END TYPE

#DEFINE PANGO_ASCENT(rect) (-(rect).y)
#DEFINE PANGO_DESCENT(rect) ((rect).y + (rect).height)
#DEFINE PANGO_LBEARING(rect) ((rect).x)
#DEFINE PANGO_RBEARING(rect) ((rect).x + (rect).width)

DECLARE SUB pango_extents_to_pixels(BYVAL AS PangoRectangle PTR, BYVAL AS PangoRectangle PTR)

#IFNDEF __PANGO_GRAVITY_H__
#DEFINE __PANGO_GRAVITY_H__

ENUM PangoGravity
  PANGO_GRAVITY_SOUTH
  PANGO_GRAVITY_EAST
  PANGO_GRAVITY_NORTH
  PANGO_GRAVITY_WEST
  PANGO_GRAVITY_AUTO
END ENUM

ENUM PangoGravityHint
  PANGO_GRAVITY_HINT_NATURAL
  PANGO_GRAVITY_HINT_STRONG
  PANGO_GRAVITY_HINT_LINE
END ENUM

#DEFINE PANGO_GRAVITY_IS_VERTICAL(gravity) _
 ((gravity) = PANGO_GRAVITY_EAST  ORELSE (gravity) = PANGO_GRAVITY_WEST)

#IFNDEF __PANGO_MATRIX_H__
#DEFINE __PANGO_MATRIX_H__

TYPE PangoMatrix AS _PangoMatrix

TYPE _PangoMatrix
  AS DOUBLE xx
  AS DOUBLE xy
  AS DOUBLE yx
  AS DOUBLE yy
  AS DOUBLE x0
  AS DOUBLE y0
END TYPE

#DEFINE PANGO_TYPE_MATRIX (pango_matrix_get_type ())
#DEFINE PANGO_MATRIX_INIT TYPE<PangoMatrix>( 1., 0., 0., 1., 0., 0. )

DECLARE FUNCTION pango_matrix_get_type() AS GType
DECLARE FUNCTION pango_matrix_copy(BYVAL AS CONST PangoMatrix PTR) AS PangoMatrix PTR
DECLARE SUB pango_matrix_free(BYVAL AS PangoMatrix PTR)
DECLARE SUB pango_matrix_translate(BYVAL AS PangoMatrix PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB pango_matrix_scale(BYVAL AS PangoMatrix PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB pango_matrix_rotate(BYVAL AS PangoMatrix PTR, BYVAL AS DOUBLE)
DECLARE SUB pango_matrix_concat(BYVAL AS PangoMatrix PTR, BYVAL AS CONST PangoMatrix PTR)
DECLARE SUB pango_matrix_transform_point(BYVAL AS CONST PangoMatrix PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR)
DECLARE SUB pango_matrix_transform_distance(BYVAL AS CONST PangoMatrix PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR)
DECLARE SUB pango_matrix_transform_rectangle(BYVAL AS CONST PangoMatrix PTR, BYVAL AS PangoRectangle PTR)
DECLARE SUB pango_matrix_transform_pixel_rectangle(BYVAL AS CONST PangoMatrix PTR, BYVAL AS PangoRectangle PTR)
DECLARE FUNCTION pango_matrix_get_font_scale_factor(BYVAL AS CONST PangoMatrix PTR) AS DOUBLE

#ENDIF ' __PANGO_MATRIX_H__

#IFNDEF __PANGO_SCRIPT_H__
#DEFINE __PANGO_SCRIPT_H__

TYPE PangoScriptIter AS _PangoScriptIter

ENUM PangoScript
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
END ENUM

DECLARE FUNCTION pango_script_for_unichar(BYVAL AS gunichar) AS PangoScript
DECLARE FUNCTION pango_script_iter_new(BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER) AS PangoScriptIter PTR
DECLARE SUB pango_script_iter_get_range(BYVAL AS PangoScriptIter PTR, BYVAL AS CONST ZSTRING PTR PTR, BYVAL AS CONST ZSTRING PTR PTR, BYVAL AS PangoScript PTR)
DECLARE FUNCTION pango_script_iter_next(BYVAL AS PangoScriptIter PTR) AS gboolean
DECLARE SUB pango_script_iter_free(BYVAL AS PangoScriptIter PTR)

#IFNDEF __PANGO_LANGUAGE_H__
#DEFINE __PANGO_LANGUAGE_H__

TYPE PangoLanguage AS _PangoLanguage

#DEFINE PANGO_TYPE_LANGUAGE (pango_language_get_type ())

DECLARE FUNCTION pango_language_get_type() AS GType
DECLARE FUNCTION pango_language_from_string(BYVAL AS CONST ZSTRING PTR) AS PangoLanguage PTR
DECLARE FUNCTION pango_language_to_string_ ALIAS "pango_language_to_string"(BYVAL AS PangoLanguage PTR) AS CONST ZSTRING PTR

#DEFINE pango_language_to_string(language) (CAST(CONST ZSTRING PTR, language))

DECLARE FUNCTION pango_language_get_sample_string(BYVAL AS PangoLanguage PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION pango_language_get_default() AS PangoLanguage PTR
DECLARE FUNCTION pango_language_matches(BYVAL AS PangoLanguage PTR, BYVAL AS CONST ZSTRING PTR) AS gboolean

DECLARE FUNCTION pango_language_includes_script(BYVAL AS PangoLanguage PTR, BYVAL AS PangoScript) AS gboolean
DECLARE FUNCTION pango_language_get_scripts(BYVAL AS PangoLanguage PTR, BYVAL AS INTEGER PTR) AS CONST PangoScript PTR

#ENDIF ' __PANGO_LANGUAGE_H__

DECLARE FUNCTION pango_script_get_sample_language(BYVAL AS PangoScript) AS PangoLanguage PTR

#ENDIF ' __PANGO_SCRIPT_H__

DECLARE FUNCTION pango_gravity_to_rotation(BYVAL AS PangoGravity) AS DOUBLE
DECLARE FUNCTION pango_gravity_get_for_matrix(BYVAL AS CONST PangoMatrix PTR) AS PangoGravity
DECLARE FUNCTION pango_gravity_get_for_script(BYVAL AS PangoScript, BYVAL AS PangoGravity, BYVAL AS PangoGravityHint) AS PangoGravity
DECLARE FUNCTION pango_gravity_get_for_script_and_width(BYVAL AS PangoScript, BYVAL AS gboolean, BYVAL AS PangoGravity, BYVAL AS PangoGravityHint) AS PangoGravity

#ENDIF ' __PANGO_GRAVITY_H__

#IFNDEF __PANGO_BIDI_TYPE_H__
#DEFINE __PANGO_BIDI_TYPE_H__

ENUM PangoBidiType
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
END ENUM

DECLARE FUNCTION pango_bidi_type_for_unichar(BYVAL AS gunichar) AS PangoBidiType

ENUM PangoDirection
  PANGO_DIRECTION_LTR
  PANGO_DIRECTION_RTL
  PANGO_DIRECTION_TTB_LTR
  PANGO_DIRECTION_TTB_RTL
  PANGO_DIRECTION_WEAK_LTR
  PANGO_DIRECTION_WEAK_RTL
  PANGO_DIRECTION_NEUTRAL
END ENUM

DECLARE FUNCTION pango_unichar_direction(BYVAL AS gunichar) AS PangoDirection
DECLARE FUNCTION pango_find_base_dir(BYVAL AS CONST gchar PTR, BYVAL AS gint) AS PangoDirection

#IFNDEF PANGO_DISABLE_DEPRECATED

DECLARE FUNCTION pango_get_mirror_char(BYVAL AS gunichar, BYVAL AS gunichar PTR) AS gboolean

#ENDIF ' PANGO_DISABLE_DEPRECATED
#ENDIF ' __PANGO_BIDI_TYPE_H__
#ENDIF ' __PANGO_TYPES_H__

TYPE PangoFontDescription AS _PangoFontDescription
TYPE PangoFontMetrics AS _PangoFontMetrics

ENUM PangoStyle
  PANGO_STYLE_NORMAL
  PANGO_STYLE_OBLIQUE
  PANGO_STYLE_ITALIC
END ENUM

ENUM PangoVariant
  PANGO_VARIANT_NORMAL
  PANGO_VARIANT_SMALL_CAPS
END ENUM

ENUM PangoWeight
  PANGO_WEIGHT_THIN = 100
  PANGO_WEIGHT_ULTRALIGHT = 200
  PANGO_WEIGHT_LIGHT = 300
  PANGO_WEIGHT_BOOK = 380
  PANGO_WEIGHT_NORMAL = 400
  PANGO_WEIGHT_MEDIUM = 500
  PANGO_WEIGHT_SEMIBOLD = 600
  PANGO_WEIGHT_BOLD = 700
  PANGO_WEIGHT_ULTRABOLD = 800
  PANGO_WEIGHT_HEAVY = 900
  PANGO_WEIGHT_ULTRAHEAVY = 1000
END ENUM

ENUM PangoStretch
  PANGO_STRETCH_ULTRA_CONDENSED
  PANGO_STRETCH_EXTRA_CONDENSED
  PANGO_STRETCH_CONDENSED
  PANGO_STRETCH_SEMI_CONDENSED
  PANGO_STRETCH_NORMAL
  PANGO_STRETCH_SEMI_EXPANDED
  PANGO_STRETCH_EXPANDED
  PANGO_STRETCH_EXTRA_EXPANDED
  PANGO_STRETCH_ULTRA_EXPANDED
END ENUM

ENUM PangoFontMask
  PANGO_FONT_MASK_FAMILY = 1  SHL 0
  PANGO_FONT_MASK_STYLE = 1  SHL 1
  PANGO_FONT_MASK_VARIANT = 1  SHL 2
  PANGO_FONT_MASK_WEIGHT = 1  SHL 3
  PANGO_FONT_MASK_STRETCH = 1  SHL 4
  PANGO_FONT_MASK_SIZE = 1  SHL 5
  PANGO_FONT_MASK_GRAVITY = 1  SHL 6
END ENUM

#DEFINE PANGO_SCALE_XX_SMALL (CAST(DOUBLE, 0.5787037037037))
#DEFINE PANGO_SCALE_X_SMALL (CAST(DOUBLE, 0.6444444444444))
#DEFINE PANGO_SCALE_SMALL (CAST(DOUBLE, 0.8333333333333))
#DEFINE PANGO_SCALE_MEDIUM (CAST(DOUBLE, 1.0))
#DEFINE PANGO_SCALE_LARGE (CAST(DOUBLE, 1.2))
#DEFINE PANGO_SCALE_X_LARGE (CAST(DOUBLE, 1.4399999999999))
#DEFINE PANGO_SCALE_XX_LARGE (CAST(DOUBLE, 1.728))
#DEFINE PANGO_TYPE_FONT_DESCRIPTION (pango_font_description_get_type ())

DECLARE FUNCTION pango_font_description_get_type() AS GType
DECLARE FUNCTION pango_font_description_new() AS PangoFontDescription PTR
DECLARE FUNCTION pango_font_description_copy(BYVAL AS CONST PangoFontDescription PTR) AS PangoFontDescription PTR
DECLARE FUNCTION pango_font_description_copy_static(BYVAL AS CONST PangoFontDescription PTR) AS PangoFontDescription PTR
DECLARE FUNCTION pango_font_description_hash(BYVAL AS CONST PangoFontDescription PTR) AS guint
DECLARE FUNCTION pango_font_description_equal(BYVAL AS CONST PangoFontDescription PTR, BYVAL AS CONST PangoFontDescription PTR) AS gboolean
DECLARE SUB pango_font_description_free(BYVAL AS PangoFontDescription PTR)
DECLARE SUB pango_font_descriptions_free(BYVAL AS PangoFontDescription PTR PTR, BYVAL AS INTEGER)
DECLARE SUB pango_font_description_set_family(BYVAL AS PangoFontDescription PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB pango_font_description_set_family_static(BYVAL AS PangoFontDescription PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE FUNCTION pango_font_description_get_family(BYVAL AS CONST PangoFontDescription PTR) AS CONST ZSTRING PTR
DECLARE SUB pango_font_description_set_style(BYVAL AS PangoFontDescription PTR, BYVAL AS PangoStyle)
DECLARE FUNCTION pango_font_description_get_style(BYVAL AS CONST PangoFontDescription PTR) AS PangoStyle
DECLARE SUB pango_font_description_set_variant(BYVAL AS PangoFontDescription PTR, BYVAL AS PangoVariant)
DECLARE FUNCTION pango_font_description_get_variant(BYVAL AS CONST PangoFontDescription PTR) AS PangoVariant
DECLARE SUB pango_font_description_set_weight(BYVAL AS PangoFontDescription PTR, BYVAL AS PangoWeight)
DECLARE FUNCTION pango_font_description_get_weight(BYVAL AS CONST PangoFontDescription PTR) AS PangoWeight
DECLARE SUB pango_font_description_set_stretch(BYVAL AS PangoFontDescription PTR, BYVAL AS PangoStretch)
DECLARE FUNCTION pango_font_description_get_stretch(BYVAL AS CONST PangoFontDescription PTR) AS PangoStretch
DECLARE SUB pango_font_description_set_size(BYVAL AS PangoFontDescription PTR, BYVAL AS gint)
DECLARE FUNCTION pango_font_description_get_size(BYVAL AS CONST PangoFontDescription PTR) AS gint
DECLARE SUB pango_font_description_set_absolute_size(BYVAL AS PangoFontDescription PTR, BYVAL AS DOUBLE)
DECLARE FUNCTION pango_font_description_get_size_is_absolute(BYVAL AS CONST PangoFontDescription PTR) AS gboolean
DECLARE SUB pango_font_description_set_gravity(BYVAL AS PangoFontDescription PTR, BYVAL AS PangoGravity)
DECLARE FUNCTION pango_font_description_get_gravity(BYVAL AS CONST PangoFontDescription PTR) AS PangoGravity
DECLARE FUNCTION pango_font_description_get_set_fields(BYVAL AS CONST PangoFontDescription PTR) AS PangoFontMask
DECLARE SUB pango_font_description_unset_fields(BYVAL AS PangoFontDescription PTR, BYVAL AS PangoFontMask)
DECLARE SUB pango_font_description_merge(BYVAL AS PangoFontDescription PTR, BYVAL AS CONST PangoFontDescription PTR, BYVAL AS gboolean)
DECLARE SUB pango_font_description_merge_static(BYVAL AS PangoFontDescription PTR, BYVAL AS CONST PangoFontDescription PTR, BYVAL AS gboolean)
DECLARE FUNCTION pango_font_description_better_match(BYVAL AS CONST PangoFontDescription PTR, BYVAL AS CONST PangoFontDescription PTR, BYVAL AS CONST PangoFontDescription PTR) AS gboolean
DECLARE FUNCTION pango_font_description_from_string(BYVAL AS CONST ZSTRING PTR) AS PangoFontDescription PTR
DECLARE FUNCTION pango_font_description_to_string(BYVAL AS CONST PangoFontDescription PTR) AS ZSTRING PTR
DECLARE FUNCTION pango_font_description_to_filename(BYVAL AS CONST PangoFontDescription PTR) AS ZSTRING PTR

#DEFINE PANGO_TYPE_FONT_METRICS (pango_font_metrics_get_type ())

DECLARE FUNCTION pango_font_metrics_get_type() AS GType
DECLARE FUNCTION pango_font_metrics_ref(BYVAL AS PangoFontMetrics PTR) AS PangoFontMetrics PTR
DECLARE SUB pango_font_metrics_unref(BYVAL AS PangoFontMetrics PTR)
DECLARE FUNCTION pango_font_metrics_get_ascent(BYVAL AS PangoFontMetrics PTR) AS INTEGER
DECLARE FUNCTION pango_font_metrics_get_descent(BYVAL AS PangoFontMetrics PTR) AS INTEGER
DECLARE FUNCTION pango_font_metrics_get_approximate_char_width(BYVAL AS PangoFontMetrics PTR) AS INTEGER
DECLARE FUNCTION pango_font_metrics_get_approximate_digit_width(BYVAL AS PangoFontMetrics PTR) AS INTEGER
DECLARE FUNCTION pango_font_metrics_get_underline_position(BYVAL AS PangoFontMetrics PTR) AS INTEGER
DECLARE FUNCTION pango_font_metrics_get_underline_thickness(BYVAL AS PangoFontMetrics PTR) AS INTEGER
DECLARE FUNCTION pango_font_metrics_get_strikethrough_position(BYVAL AS PangoFontMetrics PTR) AS INTEGER
DECLARE FUNCTION pango_font_metrics_get_strikethrough_thickness(BYVAL AS PangoFontMetrics PTR) AS INTEGER

#IFDEF PANGO_ENABLE_BACKEND

DECLARE FUNCTION pango_font_metrics_new() AS PangoFontMetrics PTR

TYPE _PangoFontMetrics
  AS guint ref_count
  AS INTEGER ascent
  AS INTEGER descent
  AS INTEGER approximate_char_width
  AS INTEGER approximate_digit_width
  AS INTEGER underline_position
  AS INTEGER underline_thickness
  AS INTEGER strikethrough_position
  AS INTEGER strikethrough_thickness
END TYPE

#ENDIF ' PANGO_ENABLE_BACKEND

#DEFINE PANGO_TYPE_FONT_FAMILY (pango_font_family_get_type ())
#DEFINE PANGO_FONT_FAMILY(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_FONT_FAMILY, PangoFontFamily))
#DEFINE PANGO_IS_FONT_FAMILY(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_FONT_FAMILY))

TYPE PangoFontFamily AS _PangoFontFamily
TYPE PangoFontFace AS _PangoFontFace

DECLARE FUNCTION pango_font_family_get_type() AS GType
DECLARE SUB pango_font_family_list_faces(BYVAL AS PangoFontFamily PTR, BYVAL AS PangoFontFace PTR PTR PTR, BYVAL AS INTEGER PTR)
DECLARE FUNCTION pango_font_family_get_name(BYVAL AS PangoFontFamily PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION pango_font_family_is_monospace(BYVAL AS PangoFontFamily PTR) AS gboolean

#IFDEF PANGO_ENABLE_BACKEND
#DEFINE PANGO_FONT_FAMILY_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PANGO_TYPE_FONT_FAMILY, PangoFontFamilyClass))
#DEFINE PANGO_IS_FONT_FAMILY_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PANGO_TYPE_FONT_FAMILY))
#DEFINE PANGO_FONT_FAMILY_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PANGO_TYPE_FONT_FAMILY, PangoFontFamilyClass))

TYPE PangoFontFamilyClass AS _PangoFontFamilyClass

TYPE _PangoFontFamily
  AS GObject parent_instance
END TYPE

TYPE _PangoFontFamilyClass
  AS GObjectClass parent_class
  list_faces AS SUB(BYVAL AS PangoFontFamily PTR, BYVAL AS PangoFontFace PTR PTR PTR, BYVAL AS INTEGER PTR)
  get_name AS FUNCTION(BYVAL AS PangoFontFamily PTR) AS CONST ZSTRING PTR
  is_monospace AS FUNCTION(BYVAL AS PangoFontFamily PTR) AS gboolean
  _pango_reserved2 AS SUB()
  _pango_reserved3 AS SUB()
  _pango_reserved4 AS SUB()
END TYPE

#ENDIF ' PANGO_ENABLE_BACKEND

#DEFINE PANGO_TYPE_FONT_FACE (pango_font_face_get_type ())
#DEFINE PANGO_FONT_FACE(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_FONT_FACE, PangoFontFace))
#DEFINE PANGO_IS_FONT_FACE(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_FONT_FACE))

DECLARE FUNCTION pango_font_face_get_type() AS GType
DECLARE FUNCTION pango_font_face_describe(BYVAL AS PangoFontFace PTR) AS PangoFontDescription PTR
DECLARE FUNCTION pango_font_face_get_face_name(BYVAL AS PangoFontFace PTR) AS CONST ZSTRING PTR
DECLARE SUB pango_font_face_list_sizes(BYVAL AS PangoFontFace PTR, BYVAL AS INTEGER PTR PTR, BYVAL AS INTEGER PTR)
DECLARE FUNCTION pango_font_face_is_synthesized(BYVAL AS PangoFontFace PTR) AS gboolean

#IFDEF PANGO_ENABLE_BACKEND
#DEFINE PANGO_FONT_FACE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PANGO_TYPE_FONT_FACE, PangoFontFaceClass))
#DEFINE PANGO_IS_FONT_FACE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PANGO_TYPE_FONT_FACE))
#DEFINE PANGO_FONT_FACE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PANGO_TYPE_FONT_FACE, PangoFontFaceClass))

TYPE PangoFontFaceClass AS _PangoFontFaceClass

TYPE _PangoFontFace
  AS GObject parent_instance
END TYPE

TYPE _PangoFontFaceClass
  AS GObjectClass parent_class
  get_face_name AS FUNCTION(BYVAL AS PangoFontFace PTR) AS CONST ZSTRING PTR
  describe AS FUNCTION(BYVAL AS PangoFontFace PTR) AS PangoFontDescription PTR
  list_sizes AS SUB(BYVAL AS PangoFontFace PTR, BYVAL AS INTEGER PTR PTR, BYVAL AS INTEGER PTR)
  is_synthesized AS FUNCTION(BYVAL AS PangoFontFace PTR) AS gboolean
  _pango_reserved3 AS SUB()
  _pango_reserved4 AS SUB()
END TYPE

#ENDIF ' PANGO_ENABLE_BACKEND

#DEFINE PANGO_TYPE_FONT (pango_font_get_type ())
#DEFINE PANGO_FONT(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_FONT, PangoFont))
#DEFINE PANGO_IS_FONT(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_FONT))

DECLARE FUNCTION pango_font_get_type() AS GType
DECLARE FUNCTION pango_font_describe(BYVAL AS PangoFont PTR) AS PangoFontDescription PTR
DECLARE FUNCTION pango_font_describe_with_absolute_size(BYVAL AS PangoFont PTR) AS PangoFontDescription PTR
DECLARE FUNCTION pango_font_get_coverage(BYVAL AS PangoFont PTR, BYVAL AS PangoLanguage PTR) AS PangoCoverage PTR
DECLARE FUNCTION pango_font_find_shaper(BYVAL AS PangoFont PTR, BYVAL AS PangoLanguage PTR, BYVAL AS guint32) AS PangoEngineShape PTR
DECLARE FUNCTION pango_font_get_metrics(BYVAL AS PangoFont PTR, BYVAL AS PangoLanguage PTR) AS PangoFontMetrics PTR
DECLARE SUB pango_font_get_glyph_extents(BYVAL AS PangoFont PTR, BYVAL AS PangoGlyph, BYVAL AS PangoRectangle PTR, BYVAL AS PangoRectangle PTR)
DECLARE FUNCTION pango_font_get_font_map(BYVAL AS PangoFont PTR) AS PangoFontMap PTR

#IFDEF PANGO_ENABLE_BACKEND
#DEFINE PANGO_FONT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PANGO_TYPE_FONT, PangoFontClass))
#DEFINE PANGO_IS_FONT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PANGO_TYPE_FONT))
#DEFINE PANGO_FONT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PANGO_TYPE_FONT, PangoFontClass))

TYPE PangoFontClass AS _PangoFontClass

TYPE _PangoFont
  AS GObject parent_instance
END TYPE

TYPE _PangoFontClass
  AS GObjectClass parent_class
  describe AS FUNCTION(BYVAL AS PangoFont PTR) AS PangoFontDescription PTR
  get_coverage AS FUNCTION(BYVAL AS PangoFont PTR, BYVAL AS PangoLanguage PTR) AS PangoCoverage PTR
  find_shaper AS FUNCTION(BYVAL AS PangoFont PTR, BYVAL AS PangoLanguage PTR, BYVAL AS guint32) AS PangoEngineShape PTR
  get_glyph_extents AS SUB(BYVAL AS PangoFont PTR, BYVAL AS PangoGlyph, BYVAL AS PangoRectangle PTR, BYVAL AS PangoRectangle PTR)
  get_metrics AS FUNCTION(BYVAL AS PangoFont PTR, BYVAL AS PangoLanguage PTR) AS PangoFontMetrics PTR
  get_font_map AS FUNCTION(BYVAL AS PangoFont PTR) AS PangoFontMap PTR
  describe_absolute AS FUNCTION(BYVAL AS PangoFont PTR) AS PangoFontDescription PTR
  _pango_reserved1 AS SUB()
  _pango_reserved2 AS SUB()
END TYPE

#DEFINE PANGO_UNKNOWN_GLYPH_WIDTH 10
#DEFINE PANGO_UNKNOWN_GLYPH_HEIGHT 14
#ENDIF ' PANGO_ENABLE_BACKEND

#DEFINE PANGO_GLYPH_EMPTY (CAST(PangoGlyph, &h0FFFFFFF))
#DEFINE PANGO_GLYPH_INVALID_INPUT (CAST(PangoGlyph, &hFFFFFFFF))
#DEFINE PANGO_GLYPH_UNKNOWN_FLAG (CAST(PangoGlyph, &h10000000))
#DEFINE PANGO_GET_UNKNOWN_GLYPH(wc) (CAST(PangoGlyph, (wc)) ORPANGO_GLYPH_UNKNOWN_FLAG)
#ENDIF ' __PANGO_FONT_H__

TYPE PangoColor AS _PangoColor

TYPE _PangoColor
  AS guint16 red
  AS guint16 green
  AS guint16 blue
END TYPE

#DEFINE PANGO_TYPE_COLOR pango_color_get_type ()

DECLARE FUNCTION pango_color_get_type() AS GType
DECLARE FUNCTION pango_color_copy(BYVAL AS CONST PangoColor PTR) AS PangoColor PTR
DECLARE SUB pango_color_free(BYVAL AS PangoColor PTR)
DECLARE FUNCTION pango_color_parse(BYVAL AS PangoColor PTR, BYVAL AS CONST ZSTRING PTR) AS gboolean
DECLARE FUNCTION pango_color_to_string(BYVAL AS CONST PangoColor PTR) AS gchar PTR

TYPE PangoAttribute AS _PangoAttribute
TYPE PangoAttrClass AS _PangoAttrClass
TYPE PangoAttrString AS _PangoAttrString
TYPE PangoAttrLanguage AS _PangoAttrLanguage
TYPE PangoAttrInt AS _PangoAttrInt
TYPE PangoAttrSize AS _PangoAttrSize
TYPE PangoAttrFloat AS _PangoAttrFloat
TYPE PangoAttrColor AS _PangoAttrColor
TYPE PangoAttrFontDesc AS _PangoAttrFontDesc
TYPE PangoAttrShape AS _PangoAttrShape

#DEFINE PANGO_TYPE_ATTR_LIST pango_attr_list_get_type ()

TYPE PangoAttrList AS _PangoAttrList
TYPE PangoAttrIterator AS _PangoAttrIterator

ENUM PangoAttrType
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
END ENUM

ENUM PangoUnderline
  PANGO_UNDERLINE_NONE
  PANGO_UNDERLINE_SINGLE
  PANGO_UNDERLINE_DOUBLE
  PANGO_UNDERLINE_LOW
  PANGO_UNDERLINE_ERROR
END ENUM

#DEFINE PANGO_ATTR_INDEX_FROM_TEXT_BEGINNING 0
#DEFINE PANGO_ATTR_INDEX_TO_TEXT_END G_MAXUINT

TYPE _PangoAttribute
  AS CONST PangoAttrClass PTR klass
  AS guint start_index
  AS guint end_index
END TYPE

TYPE PangoAttrFilterFunc AS FUNCTION(BYVAL AS PangoAttribute PTR, BYVAL AS gpointer) AS gboolean
TYPE PangoAttrDataCopyFunc AS FUNCTION(BYVAL AS gconstpointer) AS gpointer

TYPE _PangoAttrClass
  AS PangoAttrType type
  copy AS FUNCTION(BYVAL AS CONST PangoAttribute PTR) AS PangoAttribute PTR
  destroy AS SUB(BYVAL AS PangoAttribute PTR)
  equal AS FUNCTION(BYVAL AS CONST PangoAttribute PTR, BYVAL AS CONST PangoAttribute PTR) AS gboolean
END TYPE

TYPE _PangoAttrString
  AS PangoAttribute attr
  AS ZSTRING PTR value
END TYPE

TYPE _PangoAttrLanguage
  AS PangoAttribute attr
  AS PangoLanguage PTR value
END TYPE

TYPE _PangoAttrInt
  AS PangoAttribute attr
  AS INTEGER value
END TYPE

TYPE _PangoAttrFloat
  AS PangoAttribute attr
  AS DOUBLE value
END TYPE

TYPE _PangoAttrColor
  AS PangoAttribute attr
  AS PangoColor color
END TYPE

TYPE _PangoAttrSize
  AS PangoAttribute attr
  AS INTEGER size
  AS guint absolute : 1
END TYPE

TYPE _PangoAttrShape
  AS PangoAttribute attr
  AS PangoRectangle ink_rect
  AS PangoRectangle logical_rect
  AS gpointer data
  AS PangoAttrDataCopyFunc copy_func
  AS GDestroyNotify destroy_func
END TYPE

TYPE _PangoAttrFontDesc
  AS PangoAttribute attr
  AS PangoFontDescription PTR desc
END TYPE

DECLARE FUNCTION pango_attr_type_register(BYVAL AS CONST gchar PTR) AS PangoAttrType
DECLARE FUNCTION pango_attr_type_get_name(BYVAL AS PangoAttrType) AS CONST ZSTRING PTR
DECLARE SUB pango_attribute_init(BYVAL AS PangoAttribute PTR, BYVAL AS CONST PangoAttrClass PTR)
DECLARE FUNCTION pango_attribute_copy(BYVAL AS CONST PangoAttribute PTR) AS PangoAttribute PTR
DECLARE SUB pango_attribute_destroy(BYVAL AS PangoAttribute PTR)
DECLARE FUNCTION pango_attribute_equal(BYVAL AS CONST PangoAttribute PTR, BYVAL AS CONST PangoAttribute PTR) AS gboolean
DECLARE FUNCTION pango_attr_language_new(BYVAL AS PangoLanguage PTR) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_family_new(BYVAL AS CONST ZSTRING PTR) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_foreground_new(BYVAL AS guint16, BYVAL AS guint16, BYVAL AS guint16) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_background_new(BYVAL AS guint16, BYVAL AS guint16, BYVAL AS guint16) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_size_new(BYVAL AS INTEGER) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_size_new_absolute(BYVAL AS INTEGER) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_style_new(BYVAL AS PangoStyle) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_weight_new(BYVAL AS PangoWeight) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_variant_new(BYVAL AS PangoVariant) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_stretch_new(BYVAL AS PangoStretch) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_font_desc_new(BYVAL AS CONST PangoFontDescription PTR) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_underline_new(BYVAL AS PangoUnderline) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_underline_color_new(BYVAL AS guint16, BYVAL AS guint16, BYVAL AS guint16) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_strikethrough_new(BYVAL AS gboolean) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_strikethrough_color_new(BYVAL AS guint16, BYVAL AS guint16, BYVAL AS guint16) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_rise_new(BYVAL AS INTEGER) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_scale_new(BYVAL AS DOUBLE) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_fallback_new(BYVAL AS gboolean) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_letter_spacing_new(BYVAL AS INTEGER) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_shape_new(BYVAL AS CONST PangoRectangle PTR, BYVAL AS CONST PangoRectangle PTR) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_shape_new_with_data(BYVAL AS CONST PangoRectangle PTR, BYVAL AS CONST PangoRectangle PTR, BYVAL AS gpointer, BYVAL AS PangoAttrDataCopyFunc, BYVAL AS GDestroyNotify) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_gravity_new(BYVAL AS PangoGravity) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_gravity_hint_new(BYVAL AS PangoGravityHint) AS PangoAttribute PTR
DECLARE FUNCTION pango_attr_list_get_type() AS GType
DECLARE FUNCTION pango_attr_list_new() AS PangoAttrList PTR
DECLARE FUNCTION pango_attr_list_ref(BYVAL AS PangoAttrList PTR) AS PangoAttrList PTR
DECLARE SUB pango_attr_list_unref(BYVAL AS PangoAttrList PTR)
DECLARE FUNCTION pango_attr_list_copy(BYVAL AS PangoAttrList PTR) AS PangoAttrList PTR
DECLARE SUB pango_attr_list_insert(BYVAL AS PangoAttrList PTR, BYVAL AS PangoAttribute PTR)
DECLARE SUB pango_attr_list_insert_before(BYVAL AS PangoAttrList PTR, BYVAL AS PangoAttribute PTR)
DECLARE SUB pango_attr_list_change(BYVAL AS PangoAttrList PTR, BYVAL AS PangoAttribute PTR)
DECLARE SUB pango_attr_list_splice(BYVAL AS PangoAttrList PTR, BYVAL AS PangoAttrList PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE FUNCTION pango_attr_list_filter(BYVAL AS PangoAttrList PTR, BYVAL AS PangoAttrFilterFunc, BYVAL AS gpointer) AS PangoAttrList PTR
DECLARE FUNCTION pango_attr_list_get_iterator(BYVAL AS PangoAttrList PTR) AS PangoAttrIterator PTR
DECLARE SUB pango_attr_iterator_range(BYVAL AS PangoAttrIterator PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE FUNCTION pango_attr_iterator_next(BYVAL AS PangoAttrIterator PTR) AS gboolean
DECLARE FUNCTION pango_attr_iterator_copy(BYVAL AS PangoAttrIterator PTR) AS PangoAttrIterator PTR
DECLARE SUB pango_attr_iterator_destroy(BYVAL AS PangoAttrIterator PTR)
DECLARE FUNCTION pango_attr_iterator_get(BYVAL AS PangoAttrIterator PTR, BYVAL AS PangoAttrType) AS PangoAttribute PTR
DECLARE SUB pango_attr_iterator_get_font(BYVAL AS PangoAttrIterator PTR, BYVAL AS PangoFontDescription PTR, BYVAL AS PangoLanguage PTR PTR, BYVAL AS GSList PTR PTR)
DECLARE FUNCTION pango_attr_iterator_get_attrs(BYVAL AS PangoAttrIterator PTR) AS GSList PTR
DECLARE FUNCTION pango_parse_markup(BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS gunichar, BYVAL AS PangoAttrList PTR PTR, BYVAL AS ZSTRING PTR PTR, BYVAL AS gunichar PTR, BYVAL AS GError PTR PTR) AS gboolean

#ENDIF ' __PANGO_ATTRIBUTES_H__

#IFNDEF __PANGO_BREAK_H__
#DEFINE __PANGO_BREAK_H__

#IFNDEF __PANGO_ITEM_H__
#DEFINE __PANGO_ITEM_H__

TYPE PangoAnalysis AS _PangoAnalysis
TYPE PangoItem AS _PangoItem

#DEFINE PANGO_ANALYSIS_FLAG_CENTERED_BASELINE (1  SHL 0)

TYPE _PangoAnalysis
  AS PangoEngineShape PTR shape_engine
  AS PangoEngineLang PTR lang_engine
  AS PangoFont PTR font
  AS guint8 level
  AS guint8 gravity
  AS guint8 flags
  AS guint8 script
  AS PangoLanguage PTR language
  AS GSList PTR extra_attrs
END TYPE

TYPE _PangoItem
  AS gint offset
  AS gint length
  AS gint num_chars
  AS PangoAnalysis analysis
END TYPE

#DEFINE PANGO_TYPE_ITEM (pango_item_get_type ())

DECLARE FUNCTION pango_item_get_type() AS GType
DECLARE FUNCTION pango_item_new() AS PangoItem PTR
DECLARE FUNCTION pango_item_copy(BYVAL AS PangoItem PTR) AS PangoItem PTR
DECLARE SUB pango_item_free(BYVAL AS PangoItem PTR)
DECLARE FUNCTION pango_item_split(BYVAL AS PangoItem PTR, BYVAL AS INTEGER, BYVAL AS INTEGER) AS PangoItem PTR

#ENDIF ' __PANGO_ITEM_H__

TYPE _PangoLogAttr
  AS guint is_line_break : 1
  AS guint is_mandatory_break : 1
  AS guint is_char_break : 1
  AS guint is_white : 1
  AS guint is_cursor_position : 1
  AS guint is_word_start : 1
  AS guint is_word_end : 1
  AS guint is_sentence_boundary : 1
  AS guint is_sentence_start : 1
  AS guint is_sentence_end : 1
  AS guint backspace_deletes_character : 1
  AS guint is_expandable_space : 1
  AS guint is_word_boundary : 1
END TYPE

DECLARE SUB pango_break(BYVAL AS CONST gchar PTR, BYVAL AS INTEGER, BYVAL AS PangoAnalysis PTR, BYVAL AS PangoLogAttr PTR, BYVAL AS INTEGER)
DECLARE SUB pango_find_paragraph_boundary(BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB pango_get_log_attrs(BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS PangoLanguage PTR, BYVAL AS PangoLogAttr PTR, BYVAL AS INTEGER)

#IFDEF PANGO_ENABLE_ENGINE

DECLARE SUB pango_default_break(BYVAL AS CONST gchar PTR, BYVAL AS INTEGER, BYVAL AS PangoAnalysis PTR, BYVAL AS PangoLogAttr PTR, BYVAL AS INTEGER)

#ENDIF ' PANGO_ENABLE_ENGINE
#ENDIF ' __PANGO_BREAK_H__

#IFNDEF __PANGO_CONTEXT_H__
#DEFINE __PANGO_CONTEXT_H__

#IFNDEF __PANGO_FONTMAP_H__
#DEFINE __PANGO_FONTMAP_H__

#IFNDEF __PANGO_FONTSET_H__
#DEFINE __PANGO_FONTSET_H__

#DEFINE PANGO_TYPE_FONTSET (pango_fontset_get_type ())
#DEFINE PANGO_FONTSET(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_FONTSET, PangoFontset))
#DEFINE PANGO_IS_FONTSET(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_FONTSET))

DECLARE FUNCTION pango_fontset_get_type() AS GType

TYPE PangoFontset AS _PangoFontset
TYPE PangoFontsetForeachFunc AS FUNCTION(BYVAL AS PangoFontset PTR, BYVAL AS PangoFont PTR, BYVAL AS gpointer) AS gboolean

DECLARE FUNCTION pango_fontset_get_font(BYVAL AS PangoFontset PTR, BYVAL AS guint) AS PangoFont PTR
DECLARE FUNCTION pango_fontset_get_metrics(BYVAL AS PangoFontset PTR) AS PangoFontMetrics PTR
DECLARE SUB pango_fontset_foreach(BYVAL AS PangoFontset PTR, BYVAL AS PangoFontsetForeachFunc, BYVAL AS gpointer)

#IFDEF PANGO_ENABLE_BACKEND

TYPE PangoFontsetClass AS _PangoFontsetClass

#DEFINE PANGO_FONTSET_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PANGO_TYPE_FONTSET, PangoFontsetClass))
#DEFINE PANGO_IS_FONTSET_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PANGO_TYPE_FONTSET))
#DEFINE PANGO_FONTSET_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PANGO_TYPE_FONTSET, PangoFontsetClass))

TYPE _PangoFontset
  AS GObject parent_instance
END TYPE

TYPE _PangoFontsetClass
  AS GObjectClass parent_class
  get_font AS FUNCTION(BYVAL AS PangoFontset PTR, BYVAL AS guint) AS PangoFont PTR
  get_metrics AS FUNCTION(BYVAL AS PangoFontset PTR) AS PangoFontMetrics PTR
  get_language AS FUNCTION(BYVAL AS PangoFontset PTR) AS PangoLanguage PTR
  foreach AS SUB(BYVAL AS PangoFontset PTR, BYVAL AS PangoFontsetForeachFunc, BYVAL AS gpointer)
  _pango_reserved1 AS SUB()
  _pango_reserved2 AS SUB()
  _pango_reserved3 AS SUB()
  _pango_reserved4 AS SUB()
END TYPE

#DEFINE PANGO_TYPE_FONTSET_SIMPLE (pango_fontset_simple_get_type ())
#DEFINE PANGO_FONTSET_SIMPLE(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_FONTSET_SIMPLE, PangoFontsetSimple))
#DEFINE PANGO_IS_FONTSET_SIMPLE(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_FONTSET_SIMPLE))

TYPE PangoFontsetSimple AS _PangoFontsetSimple
TYPE PangoFontsetSimpleClass AS _PangoFontsetSimpleClass

DECLARE FUNCTION pango_fontset_simple_get_type() AS GType
DECLARE FUNCTION pango_fontset_simple_new(BYVAL AS PangoLanguage PTR) AS PangoFontsetSimple PTR
DECLARE SUB pango_fontset_simple_append(BYVAL AS PangoFontsetSimple PTR, BYVAL AS PangoFont PTR)
DECLARE FUNCTION pango_fontset_simple_size(BYVAL AS PangoFontsetSimple PTR) AS INTEGER

#ENDIF ' PANGO_ENABLE_BACKEND
#ENDIF ' __PANGO_FONTSET_H__

#DEFINE PANGO_TYPE_FONT_MAP (pango_font_map_get_type ())
#DEFINE PANGO_FONT_MAP(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_FONT_MAP, PangoFontMap))
#DEFINE PANGO_IS_FONT_MAP(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_FONT_MAP))

TYPE PangoContext AS _PangoContext

DECLARE FUNCTION pango_font_map_get_type() AS GType
DECLARE FUNCTION pango_font_map_create_context(BYVAL AS PangoFontMap PTR) AS PangoContext PTR
DECLARE FUNCTION pango_font_map_load_font(BYVAL AS PangoFontMap PTR, BYVAL AS PangoContext PTR, BYVAL AS CONST PangoFontDescription PTR) AS PangoFont PTR
DECLARE FUNCTION pango_font_map_load_fontset(BYVAL AS PangoFontMap PTR, BYVAL AS PangoContext PTR, BYVAL AS CONST PangoFontDescription PTR, BYVAL AS PangoLanguage PTR) AS PangoFontset PTR
DECLARE SUB pango_font_map_list_families(BYVAL AS PangoFontMap PTR, BYVAL AS PangoFontFamily PTR PTR PTR, BYVAL AS INTEGER PTR)

#IFDEF PANGO_ENABLE_BACKEND
#DEFINE PANGO_FONT_MAP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PANGO_TYPE_FONT_MAP, PangoFontMapClass))
#DEFINE PANGO_IS_FONT_MAP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PANGO_TYPE_FONT_MAP))
#DEFINE PANGO_FONT_MAP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PANGO_TYPE_FONT_MAP, PangoFontMapClass))

TYPE PangoFontMapClass AS _PangoFontMapClass

TYPE _PangoFontMap
  AS GObject parent_instance
END TYPE

TYPE _PangoFontMapClass
  AS GObjectClass parent_class
  load_font AS FUNCTION(BYVAL AS PangoFontMap PTR, BYVAL AS PangoContext PTR, BYVAL AS CONST PangoFontDescription PTR) AS PangoFont PTR
  list_families AS SUB(BYVAL AS PangoFontMap PTR, BYVAL AS PangoFontFamily PTR PTR PTR, BYVAL AS INTEGER PTR)
  load_fontset AS FUNCTION(BYVAL AS PangoFontMap PTR, BYVAL AS PangoContext PTR, BYVAL AS CONST PangoFontDescription PTR, BYVAL AS PangoLanguage PTR) AS PangoFontset PTR
  AS CONST ZSTRING PTR shape_engine_type
  _pango_reserved1 AS SUB()
  _pango_reserved2 AS SUB()
  _pango_reserved3 AS SUB()
  _pango_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION pango_font_map_get_shape_engine_type(BYVAL AS PangoFontMap PTR) AS CONST ZSTRING PTR

#ENDIF ' PANGO_ENABLE_BACKEND
#ENDIF ' __PANGO_FONTMAP_H__

TYPE PangoContextClass AS _PangoContextClass

#DEFINE PANGO_TYPE_CONTEXT (pango_context_get_type ())
#DEFINE PANGO_CONTEXT(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_CONTEXT, PangoContext))
#DEFINE PANGO_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PANGO_TYPE_CONTEXT, PangoContextClass))
#DEFINE PANGO_IS_CONTEXT(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_CONTEXT))
#DEFINE PANGO_IS_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PANGO_TYPE_CONTEXT))
#DEFINE PANGO_CONTEXT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PANGO_TYPE_CONTEXT, PangoContextClass))

DECLARE FUNCTION pango_context_get_type() AS GType
DECLARE FUNCTION pango_context_new() AS PangoContext PTR
DECLARE SUB pango_context_set_font_map(BYVAL AS PangoContext PTR, BYVAL AS PangoFontMap PTR)
DECLARE FUNCTION pango_context_get_font_map(BYVAL AS PangoContext PTR) AS PangoFontMap PTR
DECLARE SUB pango_context_list_families(BYVAL AS PangoContext PTR, BYVAL AS PangoFontFamily PTR PTR PTR, BYVAL AS INTEGER PTR)
DECLARE FUNCTION pango_context_load_font(BYVAL AS PangoContext PTR, BYVAL AS CONST PangoFontDescription PTR) AS PangoFont PTR
DECLARE FUNCTION pango_context_load_fontset(BYVAL AS PangoContext PTR, BYVAL AS CONST PangoFontDescription PTR, BYVAL AS PangoLanguage PTR) AS PangoFontset PTR
DECLARE FUNCTION pango_context_get_metrics(BYVAL AS PangoContext PTR, BYVAL AS CONST PangoFontDescription PTR, BYVAL AS PangoLanguage PTR) AS PangoFontMetrics PTR
DECLARE SUB pango_context_set_font_description(BYVAL AS PangoContext PTR, BYVAL AS CONST PangoFontDescription PTR)
DECLARE FUNCTION pango_context_get_font_description(BYVAL AS PangoContext PTR) AS PangoFontDescription PTR
DECLARE FUNCTION pango_context_get_language(BYVAL AS PangoContext PTR) AS PangoLanguage PTR
DECLARE SUB pango_context_set_language(BYVAL AS PangoContext PTR, BYVAL AS PangoLanguage PTR)
DECLARE SUB pango_context_set_base_dir(BYVAL AS PangoContext PTR, BYVAL AS PangoDirection)
DECLARE FUNCTION pango_context_get_base_dir(BYVAL AS PangoContext PTR) AS PangoDirection
DECLARE SUB pango_context_set_base_gravity(BYVAL AS PangoContext PTR, BYVAL AS PangoGravity)
DECLARE FUNCTION pango_context_get_base_gravity(BYVAL AS PangoContext PTR) AS PangoGravity
DECLARE FUNCTION pango_context_get_gravity(BYVAL AS PangoContext PTR) AS PangoGravity
DECLARE SUB pango_context_set_gravity_hint(BYVAL AS PangoContext PTR, BYVAL AS PangoGravityHint)
DECLARE FUNCTION pango_context_get_gravity_hint(BYVAL AS PangoContext PTR) AS PangoGravityHint
DECLARE SUB pango_context_set_matrix(BYVAL AS PangoContext PTR, BYVAL AS CONST PangoMatrix PTR)
DECLARE FUNCTION pango_context_get_matrix(BYVAL AS PangoContext PTR) AS CONST PangoMatrix PTR
DECLARE FUNCTION pango_itemize(BYVAL AS PangoContext PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS PangoAttrList PTR, BYVAL AS PangoAttrIterator PTR) AS GList PTR
DECLARE FUNCTION pango_itemize_with_base_dir(BYVAL AS PangoContext PTR, BYVAL AS PangoDirection, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS PangoAttrList PTR, BYVAL AS PangoAttrIterator PTR) AS GList PTR

#ENDIF ' __PANGO_CONTEXT_H__

#IFNDEF __PANGO_ENGINE_H__
#DEFINE __PANGO_ENGINE_H__

#IFNDEF __PANGO_GLYPH_H__
#DEFINE __PANGO_GLYPH_H__

TYPE PangoGlyphGeometry AS _PangoGlyphGeometry
TYPE PangoGlyphVisAttr AS _PangoGlyphVisAttr
TYPE PangoGlyphInfo AS _PangoGlyphInfo
TYPE PangoGlyphString AS _PangoGlyphString
TYPE PangoGlyphUnit AS gint32

TYPE _PangoGlyphGeometry
  AS PangoGlyphUnit width
  AS PangoGlyphUnit x_offset
  AS PangoGlyphUnit y_offset
END TYPE

TYPE _PangoGlyphVisAttr
  AS guint is_cluster_start : 1
END TYPE

TYPE _PangoGlyphInfo
  AS PangoGlyph glyph
  AS PangoGlyphGeometry geometry
  AS PangoGlyphVisAttr attr
END TYPE

TYPE _PangoGlyphString
  AS gint num_glyphs
  AS PangoGlyphInfo PTR glyphs
  AS gint PTR log_clusters
  AS gint space
END TYPE

#DEFINE PANGO_TYPE_GLYPH_STRING (pango_glyph_string_get_type ())

DECLARE FUNCTION pango_glyph_string_new() AS PangoGlyphString PTR
DECLARE SUB pango_glyph_string_set_size(BYVAL AS PangoGlyphString PTR, BYVAL AS gint)
DECLARE FUNCTION pango_glyph_string_get_type() AS GType
DECLARE FUNCTION pango_glyph_string_copy(BYVAL AS PangoGlyphString PTR) AS PangoGlyphString PTR
DECLARE SUB pango_glyph_string_free(BYVAL AS PangoGlyphString PTR)
DECLARE SUB pango_glyph_string_extents(BYVAL AS PangoGlyphString PTR, BYVAL AS PangoFont PTR, BYVAL AS PangoRectangle PTR, BYVAL AS PangoRectangle PTR)
DECLARE FUNCTION pango_glyph_string_get_width(BYVAL AS PangoGlyphString PTR) AS INTEGER
DECLARE SUB pango_glyph_string_extents_range(BYVAL AS PangoGlyphString PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS PangoFont PTR, BYVAL AS PangoRectangle PTR, BYVAL AS PangoRectangle PTR)
DECLARE SUB pango_glyph_string_get_logical_widths(BYVAL AS PangoGlyphString PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER PTR)
DECLARE SUB pango_glyph_string_index_to_x(BYVAL AS PangoGlyphString PTR, BYVAL AS ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS PangoAnalysis PTR, BYVAL AS INTEGER, BYVAL AS gboolean, BYVAL AS INTEGER PTR)
DECLARE SUB pango_glyph_string_x_to_index(BYVAL AS PangoGlyphString PTR, BYVAL AS ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS PangoAnalysis PTR, BYVAL AS INTEGER, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR)
DECLARE SUB pango_shape(BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS CONST PangoAnalysis PTR, BYVAL AS PangoGlyphString PTR)
DECLARE FUNCTION pango_reorder_items(BYVAL AS GList PTR) AS GList PTR

#ENDIF ' __PANGO_GLYPH_H__

#IFDEF PANGO_ENABLE_ENGINE
#INCLUDE ONCE "gmodule.bi" '__HEADERS__: gmodule.h
#DEFINE PANGO_RENDER_TYPE_NONE @!"PangoRenderNone"
#DEFINE PANGO_TYPE_ENGINE (pango_engine_get_type ())
#DEFINE PANGO_ENGINE(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_ENGINE, PangoEngine))
#DEFINE PANGO_IS_ENGINE(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_ENGINE))
#DEFINE PANGO_ENGINE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PANGO_TYPE_ENGINE, PangoEngineClass))
#DEFINE PANGO_IS_ENGINE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PANGO_TYPE_ENGINE))
#DEFINE PANGO_ENGINE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PANGO_TYPE_ENGINE, PangoEngineClass))

TYPE PangoEngine AS _PangoEngine
TYPE PangoEngineClass AS _PangoEngineClass

TYPE _PangoEngine
  AS GObject parent_instance
END TYPE

TYPE _PangoEngineClass
  AS GObjectClass parent_class
END TYPE

DECLARE FUNCTION pango_engine_get_type() AS GType

#DEFINE PANGO_ENGINE_TYPE_LANG @!"PangoEngineLang"
#DEFINE PANGO_TYPE_ENGINE_LANG (pango_engine_lang_get_type ())
#DEFINE PANGO_ENGINE_LANG(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_ENGINE_LANG, PangoEngineLang))
#DEFINE PANGO_IS_ENGINE_LANG(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_ENGINE_LANG))
#DEFINE PANGO_ENGINE_LANG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PANGO_TYPE_ENGINE_LANG, PangoEngineLangClass))
#DEFINE PANGO_IS_ENGINE_LANG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PANGO_TYPE_ENGINE_LANG))
#DEFINE PANGO_ENGINE_LANG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PANGO_TYPE_ENGINE_LANG, PangoEngineLangClass))

TYPE PangoEngineLangClass AS _PangoEngineLangClass

TYPE _PangoEngineLang
  AS PangoEngine parent_instance
END TYPE

TYPE _PangoEngineLangClass
  AS PangoEngineClass parent_class
  script_break AS SUB(BYVAL AS PangoEngineLang PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS PangoAnalysis PTR, BYVAL AS PangoLogAttr PTR, BYVAL AS INTEGER)
END TYPE

DECLARE FUNCTION pango_engine_lang_get_type() AS GType

#DEFINE PANGO_ENGINE_TYPE_SHAPE @!"PangoEngineShape"
#DEFINE PANGO_TYPE_ENGINE_SHAPE (pango_engine_shape_get_type ())
#DEFINE PANGO_ENGINE_SHAPE(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_ENGINE_SHAPE, PangoEngineShape))
#DEFINE PANGO_IS_ENGINE_SHAPE(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_ENGINE_SHAPE))
#DEFINE PANGO_ENGINE_SHAPE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PANGO_TYPE_ENGINE_SHAPE, PangoEngine_ShapeClass))
#DEFINE PANGO_IS_ENGINE_SHAPE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PANGO_TYPE_ENGINE_SHAPE))
#DEFINE PANGO_ENGINE_SHAPE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PANGO_TYPE_ENGINE_SHAPE, PangoEngineShapeClass))

TYPE PangoEngineShapeClass AS _PangoEngineShapeClass

TYPE _PangoEngineShape
  AS PangoEngine parent_instance
END TYPE

TYPE _PangoEngineShapeClass
  AS PangoEngineClass parent_class
  script_shape AS SUB(BYVAL AS PangoEngineShape PTR, BYVAL AS PangoFont PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS CONST PangoAnalysis PTR, BYVAL AS PangoGlyphString PTR)
  covers AS FUNCTION(BYVAL AS PangoEngineShape PTR, BYVAL AS PangoFont PTR, BYVAL AS PangoLanguage PTR, BYVAL AS gunichar) AS PangoCoverageLevel
END TYPE

DECLARE FUNCTION pango_engine_shape_get_type() AS GType

TYPE PangoEngineInfo AS _PangoEngineInfo
TYPE PangoEngineScriptInfo AS _PangoEngineScriptInfo

TYPE _PangoEngineScriptInfo
  AS PangoScript script
  AS CONST gchar PTR langs
END TYPE

TYPE _PangoEngineInfo
  AS CONST gchar PTR id
  AS CONST gchar PTR engine_type
  AS CONST gchar PTR render_type
  AS PangoEngineScriptInfo PTR scripts
  AS gint n_scripts
END TYPE

DECLARE SUB script_engine_list(BYVAL AS PangoEngineInfo PTR PTR, BYVAL AS INTEGER PTR)
DECLARE SUB script_engine_init(BYVAL AS GTypeModule PTR)
DECLARE SUB script_engine_exit()
DECLARE FUNCTION script_engine_create(BYVAL AS CONST ZSTRING PTR) AS PangoEngine PTR

#MACRO PANGO_ENGINE_DEFINE_TYPE(name, prefix, class_init, instance_init, parent_type)
 STATIC SHARED AS GType prefix##_type
 SUB prefix##_register_type(BYVAL module AS GTypeModule PTR)
   DIM AS CONST GTypeInfo object_info = TYPE<GTypeInfo>( _
      SIZEOF (name##Class), _
      CAST(GBaseInitFunc, NULL), _
      CAST(GBaseFinalizeFunc, NULL), _
      CAST(GClassInitFunc, @class_init), _
      CAST(GClassFinalizeFunc, NULL), _
      NULL, _
      SIZEOF (name), _
      0, _
      CAST(GInstanceInitFunc, @instance_init), _
      NULL _
      )
   prefix##_type = g_type_module_register_type (module, parent_type, #name, @object_info, 0)
 END SUB
#ENDMACRO

#DEFINE PANGO_ENGINE_LANG_DEFINE_TYPE(name, prefix, class_init, instance_init) _
  PANGO_ENGINE_DEFINE_TYPE (name, prefix, _
       class_init, instance_init, _
       PANGO_TYPE_ENGINE_LANG)
#DEFINE PANGO_ENGINE_SHAPE_DEFINE_TYPE(name, prefix, class_init, instance_init) _
  PANGO_ENGINE_DEFINE_TYPE (name, prefix, _
       class_init, instance_init, _
       PANGO_TYPE_ENGINE_SHAPE)

#IFDEF PANGO_MODULE_PREFIX
#DEFINE PANGO_MODULE_ENTRY(func) _PANGO_MODULE_ENTRY2(PANGO_MODULE_PREFIX,func)
#DEFINE _PANGO_MODULE_ENTRY2(prefix,func) _PANGO_MODULE_ENTRY3(prefix,func)
#DEFINE _PANGO_MODULE_ENTRY3(prefix,func) prefix##_script_engine_##func
#ELSE ' PANGO_MODULE_PREFIX
#DEFINE PANGO_MODULE_ENTRY(func) script_engine_##func
#ENDIF ' PANGO_MODULE_PREFIX
#ENDIF ' PANGO_ENABLE_ENGINE
#ENDIF ' __PANGO_ENGINE_H__

#IFNDEF __PANGO_ENUM_TYPES_H__
#DEFINE __PANGO_ENUM_TYPES_H__

DECLARE FUNCTION pango_attr_type_get_type() AS GType
#DEFINE PANGO_TYPE_ATTR_TYPE (pango_attr_type_get_type())
DECLARE FUNCTION pango_underline_get_type() AS GType
#DEFINE PANGO_TYPE_UNDERLINE (pango_underline_get_type())
DECLARE FUNCTION pango_bidi_type_get_type() AS GType
#DEFINE PANGO_TYPE_BIDI_TYPE (pango_bidi_type_get_type())
DECLARE FUNCTION pango_direction_get_type() AS GType
#DEFINE PANGO_TYPE_DIRECTION (pango_direction_get_type())
DECLARE FUNCTION pango_coverage_level_get_type() AS GType
#DEFINE PANGO_TYPE_COVERAGE_LEVEL (pango_coverage_level_get_type())
DECLARE FUNCTION pango_style_get_type() AS GType
#DEFINE PANGO_TYPE_STYLE (pango_style_get_type())
DECLARE FUNCTION pango_variant_get_type() AS GType
#DEFINE PANGO_TYPE_VARIANT (pango_variant_get_type())
DECLARE FUNCTION pango_weight_get_type() AS GType
#DEFINE PANGO_TYPE_WEIGHT (pango_weight_get_type())
DECLARE FUNCTION pango_stretch_get_type() AS GType
#DEFINE PANGO_TYPE_STRETCH (pango_stretch_get_type())
DECLARE FUNCTION pango_font_mask_get_type() AS GType
#DEFINE PANGO_TYPE_FONT_MASK (pango_font_mask_get_type())
DECLARE FUNCTION pango_gravity_get_type() AS GType
#DEFINE PANGO_TYPE_GRAVITY (pango_gravity_get_type())
DECLARE FUNCTION pango_gravity_hint_get_type() AS GType
#DEFINE PANGO_TYPE_GRAVITY_HINT (pango_gravity_hint_get_type())
DECLARE FUNCTION pango_alignment_get_type() AS GType
#DEFINE PANGO_TYPE_ALIGNMENT (pango_alignment_get_type())
DECLARE FUNCTION pango_wrap_mode_get_type() AS GType
#DEFINE PANGO_TYPE_WRAP_MODE (pango_wrap_mode_get_type())
DECLARE FUNCTION pango_ellipsize_mode_get_type() AS GType
#DEFINE PANGO_TYPE_ELLIPSIZE_MODE (pango_ellipsize_mode_get_type())
DECLARE FUNCTION pango_render_part_get_type() AS GType
#DEFINE PANGO_TYPE_RENDER_PART (pango_render_part_get_type())
DECLARE FUNCTION pango_script_get_type() AS GType
#DEFINE PANGO_TYPE_SCRIPT (pango_script_get_type())
DECLARE FUNCTION pango_tab_align_get_type() AS GType

#DEFINE PANGO_TYPE_TAB_ALIGN (pango_tab_align_get_type())
#ENDIF ' __PANGO_ENUM_TYPES_H__

#IFNDEF PANGO_FEATURES_H
#DEFINE PANGO_FEATURES_H
#DEFINE PANGO_VERSION_MAJOR 1
#DEFINE PANGO_VERSION_MINOR 30
#DEFINE PANGO_VERSION_MICRO 1
#DEFINE PANGO_VERSION_STRING @!"1.30.1"
#ENDIF ' PANGO_FEATURES_H

#IFNDEF __PANGO_GLYPH_ITEM_H__
#DEFINE __PANGO_GLYPH_ITEM_H__

TYPE PangoGlyphItem AS _PangoGlyphItem

TYPE _PangoGlyphItem
  AS PangoItem PTR item
  AS PangoGlyphString PTR glyphs
END TYPE

#DEFINE PANGO_TYPE_GLYPH_ITEM (pango_glyph_item_get_type ())

DECLARE FUNCTION pango_glyph_item_get_type() AS GType
DECLARE FUNCTION pango_glyph_item_split(BYVAL AS PangoGlyphItem PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER) AS PangoGlyphItem PTR
DECLARE FUNCTION pango_glyph_item_copy(BYVAL AS PangoGlyphItem PTR) AS PangoGlyphItem PTR
DECLARE SUB pango_glyph_item_free(BYVAL AS PangoGlyphItem PTR)
DECLARE FUNCTION pango_glyph_item_apply_attrs(BYVAL AS PangoGlyphItem PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS PangoAttrList PTR) AS GSList PTR
DECLARE SUB pango_glyph_item_letter_space(BYVAL AS PangoGlyphItem PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS PangoLogAttr PTR, BYVAL AS INTEGER)
DECLARE SUB pango_glyph_item_get_logical_widths(BYVAL AS PangoGlyphItem PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER PTR)

TYPE PangoGlyphItemIter AS _PangoGlyphItemIter

TYPE _PangoGlyphItemIter
  AS PangoGlyphItem PTR glyph_item
  AS CONST gchar PTR text
  AS INTEGER start_glyph
  AS INTEGER start_index
  AS INTEGER start_char
  AS INTEGER end_glyph
  AS INTEGER end_index
  AS INTEGER end_char
END TYPE

#DEFINE PANGO_TYPE_GLYPH_ITEM_ITER (pango_glyph_item_iter_get_type ())

DECLARE FUNCTION pango_glyph_item_iter_get_type() AS GType
DECLARE FUNCTION pango_glyph_item_iter_copy(BYVAL AS PangoGlyphItemIter PTR) AS PangoGlyphItemIter PTR
DECLARE SUB pango_glyph_item_iter_free(BYVAL AS PangoGlyphItemIter PTR)
DECLARE FUNCTION pango_glyph_item_iter_init_start(BYVAL AS PangoGlyphItemIter PTR, BYVAL AS PangoGlyphItem PTR, BYVAL AS CONST ZSTRING PTR) AS gboolean
DECLARE FUNCTION pango_glyph_item_iter_init_end(BYVAL AS PangoGlyphItemIter PTR, BYVAL AS PangoGlyphItem PTR, BYVAL AS CONST ZSTRING PTR) AS gboolean
DECLARE FUNCTION pango_glyph_item_iter_next_cluster(BYVAL AS PangoGlyphItemIter PTR) AS gboolean
DECLARE FUNCTION pango_glyph_item_iter_prev_cluster(BYVAL AS PangoGlyphItemIter PTR) AS gboolean

#ENDIF ' __PANGO_GLYPH_ITEM_H__

#IFNDEF __PANGO_LAYOUT_H__
#DEFINE __PANGO_LAYOUT_H__

#IFNDEF __PANGO_TABS_H__
#DEFINE __PANGO_TABS_H__

TYPE PangoTabArray AS _PangoTabArray

ENUM PangoTabAlign
  PANGO_TAB_LEFT
END ENUM

#DEFINE PANGO_TYPE_TAB_ARRAY (pango_tab_array_get_type ())

DECLARE FUNCTION pango_tab_array_new(BYVAL AS gint, BYVAL AS gboolean) AS PangoTabArray PTR
DECLARE FUNCTION pango_tab_array_new_with_positions(BYVAL AS gint, BYVAL AS gboolean, BYVAL AS PangoTabAlign, BYVAL AS gint, ...) AS PangoTabArray PTR
DECLARE FUNCTION pango_tab_array_get_type() AS GType
DECLARE FUNCTION pango_tab_array_copy(BYVAL AS PangoTabArray PTR) AS PangoTabArray PTR
DECLARE SUB pango_tab_array_free(BYVAL AS PangoTabArray PTR)
DECLARE FUNCTION pango_tab_array_get_size(BYVAL AS PangoTabArray PTR) AS gint
DECLARE SUB pango_tab_array_resize(BYVAL AS PangoTabArray PTR, BYVAL AS gint)
DECLARE SUB pango_tab_array_set_tab(BYVAL AS PangoTabArray PTR, BYVAL AS gint, BYVAL AS PangoTabAlign, BYVAL AS gint)
DECLARE SUB pango_tab_array_get_tab(BYVAL AS PangoTabArray PTR, BYVAL AS gint, BYVAL AS PangoTabAlign PTR, BYVAL AS gint PTR)
DECLARE SUB pango_tab_array_get_tabs(BYVAL AS PangoTabArray PTR, BYVAL AS PangoTabAlign PTR PTR, BYVAL AS gint PTR PTR)
DECLARE FUNCTION pango_tab_array_get_positions_in_pixels(BYVAL AS PangoTabArray PTR) AS gboolean

#ENDIF ' __PANGO_TABS_H__

TYPE PangoLayout AS _PangoLayout
TYPE PangoLayoutClass AS _PangoLayoutClass
TYPE PangoLayoutLine AS _PangoLayoutLine
TYPE PangoLayoutRun AS PangoGlyphItem

ENUM PangoAlignment
  PANGO_ALIGN_LEFT
  PANGO_ALIGN_CENTER
  PANGO_ALIGN_RIGHT
END ENUM

ENUM PangoWrapMode
  PANGO_WRAP_WORD
  PANGO_WRAP_CHAR
  PANGO_WRAP_WORD_CHAR
END ENUM

ENUM PangoEllipsizeMode
  PANGO_ELLIPSIZE_NONE
  PANGO_ELLIPSIZE_START
  PANGO_ELLIPSIZE_MIDDLE
  PANGO_ELLIPSIZE_END
END ENUM

TYPE _PangoLayoutLine
  AS PangoLayout PTR layout
  AS gint start_index
  AS gint length
  AS GSList PTR runs
  AS guint is_paragraph_start : 1
  AS guint resolved_dir : 3
END TYPE

#DEFINE PANGO_TYPE_LAYOUT (pango_layout_get_type ())
#DEFINE PANGO_LAYOUT(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_LAYOUT, PangoLayout))
#DEFINE PANGO_LAYOUT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PANGO_TYPE_LAYOUT, PangoLayoutClass))
#DEFINE PANGO_IS_LAYOUT(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_LAYOUT))
#DEFINE PANGO_IS_LAYOUT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PANGO_TYPE_LAYOUT))
#DEFINE PANGO_LAYOUT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PANGO_TYPE_LAYOUT, PangoLayoutClass))

DECLARE FUNCTION pango_layout_get_type() AS GType
DECLARE FUNCTION pango_layout_new(BYVAL AS PangoContext PTR) AS PangoLayout PTR
DECLARE FUNCTION pango_layout_copy(BYVAL AS PangoLayout PTR) AS PangoLayout PTR
DECLARE FUNCTION pango_layout_get_context(BYVAL AS PangoLayout PTR) AS PangoContext PTR
DECLARE SUB pango_layout_set_attributes(BYVAL AS PangoLayout PTR, BYVAL AS PangoAttrList PTR)
DECLARE FUNCTION pango_layout_get_attributes(BYVAL AS PangoLayout PTR) AS PangoAttrList PTR
DECLARE SUB pango_layout_set_text(BYVAL AS PangoLayout PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER)
DECLARE FUNCTION pango_layout_get_text(BYVAL AS PangoLayout PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION pango_layout_get_character_count(BYVAL AS PangoLayout PTR) AS gint
DECLARE SUB pango_layout_set_markup(BYVAL AS PangoLayout PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER)
DECLARE SUB pango_layout_set_markup_with_accel(BYVAL AS PangoLayout PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS gunichar, BYVAL AS gunichar PTR)
DECLARE SUB pango_layout_set_font_description(BYVAL AS PangoLayout PTR, BYVAL AS CONST PangoFontDescription PTR)
DECLARE FUNCTION pango_layout_get_font_description(BYVAL AS PangoLayout PTR) AS CONST PangoFontDescription PTR
DECLARE SUB pango_layout_set_width(BYVAL AS PangoLayout PTR, BYVAL AS INTEGER)
DECLARE FUNCTION pango_layout_get_width(BYVAL AS PangoLayout PTR) AS INTEGER
DECLARE SUB pango_layout_set_height(BYVAL AS PangoLayout PTR, BYVAL AS INTEGER)
DECLARE FUNCTION pango_layout_get_height(BYVAL AS PangoLayout PTR) AS INTEGER
DECLARE SUB pango_layout_set_wrap(BYVAL AS PangoLayout PTR, BYVAL AS PangoWrapMode)
DECLARE FUNCTION pango_layout_get_wrap(BYVAL AS PangoLayout PTR) AS PangoWrapMode
DECLARE FUNCTION pango_layout_is_wrapped(BYVAL AS PangoLayout PTR) AS gboolean
DECLARE SUB pango_layout_set_indent(BYVAL AS PangoLayout PTR, BYVAL AS INTEGER)
DECLARE FUNCTION pango_layout_get_indent(BYVAL AS PangoLayout PTR) AS INTEGER
DECLARE SUB pango_layout_set_spacing(BYVAL AS PangoLayout PTR, BYVAL AS INTEGER)
DECLARE FUNCTION pango_layout_get_spacing(BYVAL AS PangoLayout PTR) AS INTEGER
DECLARE SUB pango_layout_set_justify(BYVAL AS PangoLayout PTR, BYVAL AS gboolean)
DECLARE FUNCTION pango_layout_get_justify(BYVAL AS PangoLayout PTR) AS gboolean
DECLARE SUB pango_layout_set_auto_dir(BYVAL AS PangoLayout PTR, BYVAL AS gboolean)
DECLARE FUNCTION pango_layout_get_auto_dir(BYVAL AS PangoLayout PTR) AS gboolean
DECLARE SUB pango_layout_set_alignment(BYVAL AS PangoLayout PTR, BYVAL AS PangoAlignment)
DECLARE FUNCTION pango_layout_get_alignment(BYVAL AS PangoLayout PTR) AS PangoAlignment
DECLARE SUB pango_layout_set_tabs(BYVAL AS PangoLayout PTR, BYVAL AS PangoTabArray PTR)
DECLARE FUNCTION pango_layout_get_tabs(BYVAL AS PangoLayout PTR) AS PangoTabArray PTR
DECLARE SUB pango_layout_set_single_paragraph_mode(BYVAL AS PangoLayout PTR, BYVAL AS gboolean)
DECLARE FUNCTION pango_layout_get_single_paragraph_mode(BYVAL AS PangoLayout PTR) AS gboolean
DECLARE SUB pango_layout_set_ellipsize(BYVAL AS PangoLayout PTR, BYVAL AS PangoEllipsizeMode)
DECLARE FUNCTION pango_layout_get_ellipsize(BYVAL AS PangoLayout PTR) AS PangoEllipsizeMode
DECLARE FUNCTION pango_layout_is_ellipsized(BYVAL AS PangoLayout PTR) AS gboolean
DECLARE FUNCTION pango_layout_get_unknown_glyphs_count(BYVAL AS PangoLayout PTR) AS INTEGER
DECLARE SUB pango_layout_context_changed(BYVAL AS PangoLayout PTR)
DECLARE SUB pango_layout_get_log_attrs(BYVAL AS PangoLayout PTR, BYVAL AS PangoLogAttr PTR PTR, BYVAL AS gint PTR)
DECLARE FUNCTION pango_layout_get_log_attrs_readonly(BYVAL AS PangoLayout PTR, BYVAL AS gint PTR) AS CONST PangoLogAttr PTR
DECLARE SUB pango_layout_index_to_pos(BYVAL AS PangoLayout PTR, BYVAL AS INTEGER, BYVAL AS PangoRectangle PTR)
DECLARE SUB pango_layout_index_to_line_x(BYVAL AS PangoLayout PTR, BYVAL AS INTEGER, BYVAL AS gboolean, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR)
DECLARE SUB pango_layout_get_cursor_pos(BYVAL AS PangoLayout PTR, BYVAL AS INTEGER, BYVAL AS PangoRectangle PTR, BYVAL AS PangoRectangle PTR)
DECLARE SUB pango_layout_move_cursor_visually(BYVAL AS PangoLayout PTR, BYVAL AS gboolean, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR)
DECLARE FUNCTION pango_layout_xy_to_index(BYVAL AS PangoLayout PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR) AS gboolean
DECLARE SUB pango_layout_get_extents(BYVAL AS PangoLayout PTR, BYVAL AS PangoRectangle PTR, BYVAL AS PangoRectangle PTR)
DECLARE SUB pango_layout_get_pixel_extents(BYVAL AS PangoLayout PTR, BYVAL AS PangoRectangle PTR, BYVAL AS PangoRectangle PTR)
DECLARE SUB pango_layout_get_size(BYVAL AS PangoLayout PTR, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR)
DECLARE SUB pango_layout_get_pixel_size(BYVAL AS PangoLayout PTR, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR)
DECLARE FUNCTION pango_layout_get_baseline(BYVAL AS PangoLayout PTR) AS INTEGER
DECLARE FUNCTION pango_layout_get_line_count(BYVAL AS PangoLayout PTR) AS INTEGER
DECLARE FUNCTION pango_layout_get_line(BYVAL AS PangoLayout PTR, BYVAL AS INTEGER) AS PangoLayoutLine PTR
DECLARE FUNCTION pango_layout_get_line_readonly(BYVAL AS PangoLayout PTR, BYVAL AS INTEGER) AS PangoLayoutLine PTR
DECLARE FUNCTION pango_layout_get_lines(BYVAL AS PangoLayout PTR) AS GSList PTR
DECLARE FUNCTION pango_layout_get_lines_readonly(BYVAL AS PangoLayout PTR) AS GSList PTR

#DEFINE PANGO_TYPE_LAYOUT_LINE (pango_layout_line_get_type ())

DECLARE FUNCTION pango_layout_line_get_type() AS GType
DECLARE FUNCTION pango_layout_line_ref(BYVAL AS PangoLayoutLine PTR) AS PangoLayoutLine PTR
DECLARE SUB pango_layout_line_unref(BYVAL AS PangoLayoutLine PTR)
DECLARE FUNCTION pango_layout_line_x_to_index(BYVAL AS PangoLayoutLine PTR, BYVAL AS INTEGER, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR) AS gboolean
DECLARE SUB pango_layout_line_index_to_x(BYVAL AS PangoLayoutLine PTR, BYVAL AS INTEGER, BYVAL AS gboolean, BYVAL AS INTEGER PTR)
DECLARE SUB pango_layout_line_get_x_ranges(BYVAL AS PangoLayoutLine PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER PTR PTR, BYVAL AS INTEGER PTR)
DECLARE SUB pango_layout_line_get_extents(BYVAL AS PangoLayoutLine PTR, BYVAL AS PangoRectangle PTR, BYVAL AS PangoRectangle PTR)
DECLARE SUB pango_layout_line_get_pixel_extents(BYVAL AS PangoLayoutLine PTR, BYVAL AS PangoRectangle PTR, BYVAL AS PangoRectangle PTR)

TYPE PangoLayoutIter AS _PangoLayoutIter

#DEFINE PANGO_TYPE_LAYOUT_ITER (pango_layout_iter_get_type ())

DECLARE FUNCTION pango_layout_iter_get_type() AS GType
DECLARE FUNCTION pango_layout_get_iter(BYVAL AS PangoLayout PTR) AS PangoLayoutIter PTR
DECLARE FUNCTION pango_layout_iter_copy(BYVAL AS PangoLayoutIter PTR) AS PangoLayoutIter PTR
DECLARE SUB pango_layout_iter_free(BYVAL AS PangoLayoutIter PTR)
DECLARE FUNCTION pango_layout_iter_get_index(BYVAL AS PangoLayoutIter PTR) AS INTEGER
DECLARE FUNCTION pango_layout_iter_get_run(BYVAL AS PangoLayoutIter PTR) AS PangoLayoutRun PTR
DECLARE FUNCTION pango_layout_iter_get_run_readonly(BYVAL AS PangoLayoutIter PTR) AS PangoLayoutRun PTR
DECLARE FUNCTION pango_layout_iter_get_line(BYVAL AS PangoLayoutIter PTR) AS PangoLayoutLine PTR
DECLARE FUNCTION pango_layout_iter_get_line_readonly(BYVAL AS PangoLayoutIter PTR) AS PangoLayoutLine PTR
DECLARE FUNCTION pango_layout_iter_at_last_line(BYVAL AS PangoLayoutIter PTR) AS gboolean
DECLARE FUNCTION pango_layout_iter_get_layout(BYVAL AS PangoLayoutIter PTR) AS PangoLayout PTR
DECLARE FUNCTION pango_layout_iter_next_char(BYVAL AS PangoLayoutIter PTR) AS gboolean
DECLARE FUNCTION pango_layout_iter_next_cluster(BYVAL AS PangoLayoutIter PTR) AS gboolean
DECLARE FUNCTION pango_layout_iter_next_run(BYVAL AS PangoLayoutIter PTR) AS gboolean
DECLARE FUNCTION pango_layout_iter_next_line(BYVAL AS PangoLayoutIter PTR) AS gboolean
DECLARE SUB pango_layout_iter_get_char_extents(BYVAL AS PangoLayoutIter PTR, BYVAL AS PangoRectangle PTR)
DECLARE SUB pango_layout_iter_get_cluster_extents(BYVAL AS PangoLayoutIter PTR, BYVAL AS PangoRectangle PTR, BYVAL AS PangoRectangle PTR)
DECLARE SUB pango_layout_iter_get_run_extents(BYVAL AS PangoLayoutIter PTR, BYVAL AS PangoRectangle PTR, BYVAL AS PangoRectangle PTR)
DECLARE SUB pango_layout_iter_get_line_extents(BYVAL AS PangoLayoutIter PTR, BYVAL AS PangoRectangle PTR, BYVAL AS PangoRectangle PTR)
DECLARE SUB pango_layout_iter_get_line_yrange(BYVAL AS PangoLayoutIter PTR, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR)
DECLARE SUB pango_layout_iter_get_layout_extents(BYVAL AS PangoLayoutIter PTR, BYVAL AS PangoRectangle PTR, BYVAL AS PangoRectangle PTR)
DECLARE FUNCTION pango_layout_iter_get_baseline(BYVAL AS PangoLayoutIter PTR) AS INTEGER

#ENDIF ' __PANGO_LAYOUT_H__

#IFNDEF __PANGO_RENDERER_H_
#DEFINE __PANGO_RENDERER_H_

#DEFINE PANGO_TYPE_RENDERER (pango_renderer_get_type())
#DEFINE PANGO_RENDERER(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_RENDERER, PangoRenderer))
#DEFINE PANGO_IS_RENDERER(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_RENDERER))
#DEFINE PANGO_RENDERER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PANGO_TYPE_RENDERER, PangoRendererClass))
#DEFINE PANGO_IS_RENDERER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PANGO_TYPE_RENDERER))
#DEFINE PANGO_RENDERER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PANGO_TYPE_RENDERER, PangoRendererClass))

TYPE PangoRenderer AS _PangoRenderer
TYPE PangoRendererClass AS _PangoRendererClass
TYPE PangoRendererPrivate AS _PangoRendererPrivate

ENUM PangoRenderPart
  PANGO_RENDER_PART_FOREGROUND
  PANGO_RENDER_PART_BACKGROUND
  PANGO_RENDER_PART_UNDERLINE
  PANGO_RENDER_PART_STRIKETHROUGH
END ENUM

TYPE _PangoRenderer
  AS GObject parent_instance
  AS PangoUnderline underline
  AS gboolean strikethrough
  AS INTEGER active_count
  AS PangoMatrix PTR matrix
  AS PangoRendererPrivate PTR priv
END TYPE

TYPE _PangoRendererClass
  AS GObjectClass parent_class
  draw_glyphs AS SUB(BYVAL AS PangoRenderer PTR, BYVAL AS PangoFont PTR, BYVAL AS PangoGlyphString PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
  draw_rectangle AS SUB(BYVAL AS PangoRenderer PTR, BYVAL AS PangoRenderPart, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER)
  draw_error_underline AS SUB(BYVAL AS PangoRenderer PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER)
  draw_shape AS SUB(BYVAL AS PangoRenderer PTR, BYVAL AS PangoAttrShape PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
  draw_trapezoid AS SUB(BYVAL AS PangoRenderer PTR, BYVAL AS PangoRenderPart, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
  draw_glyph AS SUB(BYVAL AS PangoRenderer PTR, BYVAL AS PangoFont PTR, BYVAL AS PangoGlyph, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
  part_changed AS SUB(BYVAL AS PangoRenderer PTR, BYVAL AS PangoRenderPart)
  begin AS SUB(BYVAL AS PangoRenderer PTR)
  end_ AS SUB(BYVAL AS PangoRenderer PTR)
  prepare_run AS SUB(BYVAL AS PangoRenderer PTR, BYVAL AS PangoLayoutRun PTR)
  draw_glyph_item AS SUB(BYVAL AS PangoRenderer PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS PangoGlyphItem PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
  _pango_reserved2 AS SUB()
  _pango_reserved3 AS SUB()
  _pango_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION pango_renderer_get_type() AS GType
DECLARE SUB pango_renderer_draw_layout(BYVAL AS PangoRenderer PTR, BYVAL AS PangoLayout PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB pango_renderer_draw_layout_line(BYVAL AS PangoRenderer PTR, BYVAL AS PangoLayoutLine PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB pango_renderer_draw_glyphs(BYVAL AS PangoRenderer PTR, BYVAL AS PangoFont PTR, BYVAL AS PangoGlyphString PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB pango_renderer_draw_glyph_item(BYVAL AS PangoRenderer PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS PangoGlyphItem PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB pango_renderer_draw_rectangle(BYVAL AS PangoRenderer PTR, BYVAL AS PangoRenderPart, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB pango_renderer_draw_error_underline(BYVAL AS PangoRenderer PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB pango_renderer_draw_trapezoid(BYVAL AS PangoRenderer PTR, BYVAL AS PangoRenderPart, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB pango_renderer_draw_glyph(BYVAL AS PangoRenderer PTR, BYVAL AS PangoFont PTR, BYVAL AS PangoGlyph, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB pango_renderer_activate(BYVAL AS PangoRenderer PTR)
DECLARE SUB pango_renderer_deactivate(BYVAL AS PangoRenderer PTR)
DECLARE SUB pango_renderer_part_changed(BYVAL AS PangoRenderer PTR, BYVAL AS PangoRenderPart)
DECLARE SUB pango_renderer_set_color(BYVAL AS PangoRenderer PTR, BYVAL AS PangoRenderPart, BYVAL AS CONST PangoColor PTR)
DECLARE FUNCTION pango_renderer_get_color(BYVAL AS PangoRenderer PTR, BYVAL AS PangoRenderPart) AS PangoColor PTR
DECLARE SUB pango_renderer_set_matrix(BYVAL AS PangoRenderer PTR, BYVAL AS CONST PangoMatrix PTR)
DECLARE FUNCTION pango_renderer_get_matrix(BYVAL AS PangoRenderer PTR) AS CONST PangoMatrix PTR
DECLARE FUNCTION pango_renderer_get_layout(BYVAL AS PangoRenderer PTR) AS PangoLayout PTR
DECLARE FUNCTION pango_renderer_get_layout_line(BYVAL AS PangoRenderer PTR) AS PangoLayoutLine PTR

#ENDIF ' __PANGO_RENDERER_H_

#IFNDEF __PANGO_UTILS_H__
#DEFINE __PANGO_UTILS_H__
#INCLUDE ONCE "crt/stdio.bi" '__HEADERS__: stdio.h

DECLARE FUNCTION pango_split_file_list(BYVAL AS CONST ZSTRING PTR) AS ZSTRING PTR PTR
DECLARE FUNCTION pango_trim_string(BYVAL AS CONST ZSTRING PTR) AS ZSTRING PTR
DECLARE FUNCTION pango_read_line(BYVAL AS FILE PTR, BYVAL AS GString PTR) AS gint
DECLARE FUNCTION pango_skip_space(BYVAL AS CONST ZSTRING PTR PTR) AS gboolean
DECLARE FUNCTION pango_scan_word(BYVAL AS CONST ZSTRING PTR PTR, BYVAL AS GString PTR) AS gboolean
DECLARE FUNCTION pango_scan_string(BYVAL AS CONST ZSTRING PTR PTR, BYVAL AS GString PTR) AS gboolean
DECLARE FUNCTION pango_scan_int(BYVAL AS CONST ZSTRING PTR PTR, BYVAL AS INTEGER PTR) AS gboolean

#IFDEF PANGO_ENABLE_BACKEND

DECLARE FUNCTION pango_config_key_get(BYVAL AS CONST ZSTRING PTR) AS ZSTRING PTR
DECLARE SUB pango_lookup_aliases(BYVAL AS CONST ZSTRING PTR, BYVAL AS ZSTRING PTR PTR PTR, BYVAL AS INTEGER PTR)

#ENDIF ' PANGO_ENABLE_BACKEND

DECLARE FUNCTION pango_parse_enum(BYVAL AS GType, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER PTR, BYVAL AS gboolean, BYVAL AS ZSTRING PTR PTR) AS gboolean
DECLARE FUNCTION pango_parse_style(BYVAL AS CONST ZSTRING PTR, BYVAL AS PangoStyle PTR, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION pango_parse_variant(BYVAL AS CONST ZSTRING PTR, BYVAL AS PangoVariant PTR, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION pango_parse_weight(BYVAL AS CONST ZSTRING PTR, BYVAL AS PangoWeight PTR, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION pango_parse_stretch(BYVAL AS CONST ZSTRING PTR, BYVAL AS PangoStretch PTR, BYVAL AS gboolean) AS gboolean

#IFDEF PANGO_ENABLE_BACKEND

DECLARE FUNCTION pango_get_sysconf_subdirectory() AS CONST ZSTRING PTR
DECLARE FUNCTION pango_get_lib_subdirectory() AS CONST ZSTRING PTR

#ENDIF ' PANGO_ENABLE_BACKEND

DECLARE SUB pango_quantize_line_geometry(BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR)
DECLARE FUNCTION pango_log2vis_get_embedding_levels(BYVAL AS CONST gchar PTR, BYVAL AS INTEGER, BYVAL AS PangoDirection PTR) AS guint8 PTR
DECLARE FUNCTION pango_is_zero_width(BYVAL AS gunichar) AS gboolean

#DEFINE PANGO_VERSION_ENCODE(major, minor, micro) ( _
   ((major) * 10000) _
 + ((minor) * 100) _
 + ((micro) * 1))
#DEFINE PANGO_VERSION PANGO_VERSION_ENCODE( _
 PANGO_VERSION_MAJOR, _
 PANGO_VERSION_MINOR, _
 PANGO_VERSION_MICRO)
#DEFINE PANGO_VERSION_CHECK(major,minor,micro) _
 (PANGO_VERSION  >= PANGO_VERSION_ENCODE(major,minor,micro))

DECLARE FUNCTION pango_version_ ALIAS "pango_version"() AS INTEGER
DECLARE FUNCTION pango_version_string_ ALIAS "pango_version_string"() AS CONST ZSTRING PTR
DECLARE FUNCTION pango_version_check_ ALIAS "pango_version_check"(BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER) AS CONST ZSTRING PTR

#ENDIF ' __PANGO_UTILS_H__
#ENDIF ' __PANGO_H__

END EXTERN ' (h_2_bi -P_oCD option)

#IFDEF __FB_WIN32__
#PRAGMA pop(msbitfields)
#ENDIF

' Translated at 12-08-18 19:03:42, by h_2_bi (version 0.2.2.1,
' released under GPLv3 by Thomas[ dot ]Freiherr{ at }gmx[ dot ]net)

'   Protocol: PANGO-1.30.1.bi
' Parameters: PANGO-1.30.1
'                                  Process time [s]: 0.2928439745446667
'                                  Bytes translated: 79552
'                                      Maximum deep: 7
'                                SUB/FUNCTION names: 399
'                                mangled TYPE names: 0
'                                        files done: 24
' pango-1.30.1/pango/pango.h
' pango-1.30.1/pango/pango-attributes.h
' pango-1.30.1/pango/pango-font.h
' pango-1.30.1/pango/pango-coverage.h
' pango-1.30.1/pango/pango-types.h
' pango-1.30.1/pango/pango-gravity.h
' pango-1.30.1/pango/pango-matrix.h
' pango-1.30.1/pango/pango-script.h
' pango-1.30.1/pango/pango-language.h
' pango-1.30.1/pango/pango-bidi-type.h
' pango-1.30.1/pango/pango-break.h
' pango-1.30.1/pango/pango-item.h
' pango-1.30.1/pango/pango-context.h
' pango-1.30.1/pango/pango-fontmap.h
' pango-1.30.1/pango/pango-fontset.h
' pango-1.30.1/pango/pango-engine.h
' pango-1.30.1/pango/pango-glyph.h
' pango-1.30.1/pango/pango-enum-types.h
' pango-1.30.1/pango/pango-features.h
' pango-1.30.1/pango/pango-glyph-item.h
' pango-1.30.1/pango/pango-layout.h
' pango-1.30.1/pango/pango-tabs.h
' pango-1.30.1/pango/pango-renderer.h
' pango-1.30.1/pango/pango-utils.h
'                                      files missed: 0
'                                       __FOLDERS__: 2
' pango-1.30.1/pango/
' pango-1.30.1/
'                                        __MACROS__: 4
' 22: #define G_BEGIN_DECLS
' 22: #define G_END_DECLS
' 41: #define G_GNUC_CONST
' 1: #define G_DEPRECATED_FOR(f)
'                                       __HEADERS__: 0
'                                         __TYPES__: 0
'                                     __POST_REPS__: 4
' 1: pango_version&_ ALIAS "pango_version"
' 1: pango_version_string&_ ALIAS "pango_version_string"
' 1: pango_version_check&_ ALIAS "pango_version_check"
' 2: pango_language_to_string&_ ALIAS "pango_language_to_string"
