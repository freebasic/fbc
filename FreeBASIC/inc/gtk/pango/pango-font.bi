''
''
'' pango-font -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pango_font_bi__
#define __pango_font_bi__

#include once "gtk/pango/pango-coverage.bi"
#include once "gtk/pango/pango-types.bi"
#include once "gtk/glib-object.bi"

type PangoFontDescription as _PangoFontDescription
type PangoFontMetrics as _PangoFontMetrics

enum PangoStyle
	PANGO_STYLE_NORMAL
	PANGO_STYLE_OBLIQUE
	PANGO_STYLE_ITALIC
end enum


enum PangoVariant
	PANGO_VARIANT_NORMAL
	PANGO_VARIANT_SMALL_CAPS
end enum


enum PangoWeight
	PANGO_WEIGHT_ULTRALIGHT = 200
	PANGO_WEIGHT_LIGHT = 300
	PANGO_WEIGHT_NORMAL = 400
	PANGO_WEIGHT_SEMIBOLD = 600
	PANGO_WEIGHT_BOLD = 700
	PANGO_WEIGHT_ULTRABOLD = 800
	PANGO_WEIGHT_HEAVY = 900
end enum


enum PangoStretch
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


enum PangoFontMask
	PANGO_FONT_MASK_FAMILY = 1 shl 0
	PANGO_FONT_MASK_STYLE = 1 shl 1
	PANGO_FONT_MASK_VARIANT = 1 shl 2
	PANGO_FONT_MASK_WEIGHT = 1 shl 3
	PANGO_FONT_MASK_STRETCH = 1 shl 4
	PANGO_FONT_MASK_SIZE = 1 shl 5
end enum


declare function pango_font_description_get_type cdecl alias "pango_font_description_get_type" () as GType
declare function pango_font_description_new cdecl alias "pango_font_description_new" () as PangoFontDescription ptr
declare function pango_font_description_copy cdecl alias "pango_font_description_copy" (byval desc as PangoFontDescription ptr) as PangoFontDescription ptr
declare function pango_font_description_copy_static cdecl alias "pango_font_description_copy_static" (byval desc as PangoFontDescription ptr) as PangoFontDescription ptr
declare function pango_font_description_hash cdecl alias "pango_font_description_hash" (byval desc as PangoFontDescription ptr) as guint
declare function pango_font_description_equal cdecl alias "pango_font_description_equal" (byval desc1 as PangoFontDescription ptr, byval desc2 as PangoFontDescription ptr) as gboolean
declare sub pango_font_description_free cdecl alias "pango_font_description_free" (byval desc as PangoFontDescription ptr)
declare sub pango_font_descriptions_free cdecl alias "pango_font_descriptions_free" (byval descs as PangoFontDescription ptr ptr, byval n_descs as integer)
declare sub pango_font_description_set_family cdecl alias "pango_font_description_set_family" (byval desc as PangoFontDescription ptr, byval family as string)
declare sub pango_font_description_set_family_static cdecl alias "pango_font_description_set_family_static" (byval desc as PangoFontDescription ptr, byval family as string)
declare function pango_font_description_get_family cdecl alias "pango_font_description_get_family" (byval desc as PangoFontDescription ptr) as zstring ptr
declare sub pango_font_description_set_style cdecl alias "pango_font_description_set_style" (byval desc as PangoFontDescription ptr, byval style as PangoStyle)
declare function pango_font_description_get_style cdecl alias "pango_font_description_get_style" (byval desc as PangoFontDescription ptr) as PangoStyle
declare sub pango_font_description_set_variant cdecl alias "pango_font_description_set_variant" (byval desc as PangoFontDescription ptr, byval variant as PangoVariant)
declare function pango_font_description_get_variant cdecl alias "pango_font_description_get_variant" (byval desc as PangoFontDescription ptr) as PangoVariant
declare sub pango_font_description_set_weight cdecl alias "pango_font_description_set_weight" (byval desc as PangoFontDescription ptr, byval weight as PangoWeight)
declare function pango_font_description_get_weight cdecl alias "pango_font_description_get_weight" (byval desc as PangoFontDescription ptr) as PangoWeight
declare sub pango_font_description_set_stretch cdecl alias "pango_font_description_set_stretch" (byval desc as PangoFontDescription ptr, byval stretch as PangoStretch)
declare function pango_font_description_get_stretch cdecl alias "pango_font_description_get_stretch" (byval desc as PangoFontDescription ptr) as PangoStretch
declare sub pango_font_description_set_size cdecl alias "pango_font_description_set_size" (byval desc as PangoFontDescription ptr, byval size as gint)
declare function pango_font_description_get_size cdecl alias "pango_font_description_get_size" (byval desc as PangoFontDescription ptr) as gint
declare sub pango_font_description_set_absolute_size cdecl alias "pango_font_description_set_absolute_size" (byval desc as PangoFontDescription ptr, byval size as double)
declare function pango_font_description_get_size_is_absolute cdecl alias "pango_font_description_get_size_is_absolute" (byval desc as PangoFontDescription ptr) as gboolean
declare function pango_font_description_get_set_fields cdecl alias "pango_font_description_get_set_fields" (byval desc as PangoFontDescription ptr) as PangoFontMask
declare sub pango_font_description_unset_fields cdecl alias "pango_font_description_unset_fields" (byval desc as PangoFontDescription ptr, byval to_unset as PangoFontMask)
declare sub pango_font_description_merge cdecl alias "pango_font_description_merge" (byval desc as PangoFontDescription ptr, byval desc_to_merge as PangoFontDescription ptr, byval replace_existing as gboolean)
declare sub pango_font_description_merge_static cdecl alias "pango_font_description_merge_static" (byval desc as PangoFontDescription ptr, byval desc_to_merge as PangoFontDescription ptr, byval replace_existing as gboolean)
declare function pango_font_description_better_match cdecl alias "pango_font_description_better_match" (byval desc as PangoFontDescription ptr, byval old_match as PangoFontDescription ptr, byval new_match as PangoFontDescription ptr) as gboolean
declare function pango_font_description_from_string cdecl alias "pango_font_description_from_string" (byval str as string) as PangoFontDescription ptr
declare function pango_font_description_to_string cdecl alias "pango_font_description_to_string" (byval desc as PangoFontDescription ptr) as zstring ptr
declare function pango_font_description_to_filename cdecl alias "pango_font_description_to_filename" (byval desc as PangoFontDescription ptr) as zstring ptr
declare function pango_font_metrics_get_type cdecl alias "pango_font_metrics_get_type" () as GType
declare function pango_font_metrics_ref cdecl alias "pango_font_metrics_ref" (byval metrics as PangoFontMetrics ptr) as PangoFontMetrics ptr
declare sub pango_font_metrics_unref cdecl alias "pango_font_metrics_unref" (byval metrics as PangoFontMetrics ptr)
declare function pango_font_metrics_get_ascent cdecl alias "pango_font_metrics_get_ascent" (byval metrics as PangoFontMetrics ptr) as integer
declare function pango_font_metrics_get_descent cdecl alias "pango_font_metrics_get_descent" (byval metrics as PangoFontMetrics ptr) as integer
declare function pango_font_metrics_get_approximate_char_width cdecl alias "pango_font_metrics_get_approximate_char_width" (byval metrics as PangoFontMetrics ptr) as integer
declare function pango_font_metrics_get_approximate_digit_width cdecl alias "pango_font_metrics_get_approximate_digit_width" (byval metrics as PangoFontMetrics ptr) as integer
declare function pango_font_metrics_get_underline_position cdecl alias "pango_font_metrics_get_underline_position" (byval metrics as PangoFontMetrics ptr) as integer
declare function pango_font_metrics_get_underline_thickness cdecl alias "pango_font_metrics_get_underline_thickness" (byval metrics as PangoFontMetrics ptr) as integer
declare function pango_font_metrics_get_strikethrough_position cdecl alias "pango_font_metrics_get_strikethrough_position" (byval metrics as PangoFontMetrics ptr) as integer
declare function pango_font_metrics_get_strikethrough_thickness cdecl alias "pango_font_metrics_get_strikethrough_thickness" (byval metrics as PangoFontMetrics ptr) as integer

type PangoFontFamily as _PangoFontFamily
type PangoFontFace as _PangoFontFace

declare function pango_font_family_get_type cdecl alias "pango_font_family_get_type" () as GType
declare sub pango_font_family_list_faces cdecl alias "pango_font_family_list_faces" (byval family as PangoFontFamily ptr, byval faces as PangoFontFace ptr ptr ptr, byval n_faces as integer ptr)
declare function pango_font_family_get_name cdecl alias "pango_font_family_get_name" (byval family as PangoFontFamily ptr) as zstring ptr
declare function pango_font_family_is_monospace cdecl alias "pango_font_family_is_monospace" (byval family as PangoFontFamily ptr) as gboolean
declare function pango_font_face_get_type cdecl alias "pango_font_face_get_type" () as GType
declare function pango_font_face_describe cdecl alias "pango_font_face_describe" (byval face as PangoFontFace ptr) as PangoFontDescription ptr
declare function pango_font_face_get_face_name cdecl alias "pango_font_face_get_face_name" (byval face as PangoFontFace ptr) as zstring ptr
declare sub pango_font_face_list_sizes cdecl alias "pango_font_face_list_sizes" (byval face as PangoFontFace ptr, byval sizes as integer ptr ptr, byval n_sizes as integer ptr)
declare function pango_font_get_type cdecl alias "pango_font_get_type" () as GType
declare function pango_font_describe cdecl alias "pango_font_describe" (byval font as PangoFont ptr) as PangoFontDescription ptr
declare function pango_font_get_coverage cdecl alias "pango_font_get_coverage" (byval font as PangoFont ptr, byval language as PangoLanguage ptr) as PangoCoverage ptr
declare function pango_font_find_shaper cdecl alias "pango_font_find_shaper" (byval font as PangoFont ptr, byval language as PangoLanguage ptr, byval ch as guint32) as PangoEngineShape ptr
declare function pango_font_get_metrics cdecl alias "pango_font_get_metrics" (byval font as PangoFont ptr, byval language as PangoLanguage ptr) as PangoFontMetrics ptr
declare sub pango_font_get_glyph_extents cdecl alias "pango_font_get_glyph_extents" (byval font as PangoFont ptr, byval glyph as PangoGlyph, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)

#endif
