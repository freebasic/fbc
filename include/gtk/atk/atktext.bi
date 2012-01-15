''
''
'' atktext -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atktext_bi__
#define __atktext_bi__

#include once "gtk/glib-object.bi"
#include once "atkobject.bi"
#include once "atkutil.bi"

#define ATK_TYPE_TEXT() atk_text_get_type()
#define ATK_IS_TEXT(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_TEXT)
#define ATK_TEXT(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_TEXT, AtkText)
#define ATK_TEXT_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_TEXT, AtkTextIface)

type AtkAttributeSet as GSList
type AtkAttribute as _AtkAttribute

type _AtkAttribute
	name as zstring ptr
	value as zstring ptr
end type

enum AtkTextAttribute
	ATK_TEXT_ATTR_INVALID = 0
	ATK_TEXT_ATTR_LEFT_MARGIN
	ATK_TEXT_ATTR_RIGHT_MARGIN
	ATK_TEXT_ATTR_INDENT
	ATK_TEXT_ATTR_INVISIBLE
	ATK_TEXT_ATTR_EDITABLE
	ATK_TEXT_ATTR_PIXELS_ABOVE_LINES
	ATK_TEXT_ATTR_PIXELS_BELOW_LINES
	ATK_TEXT_ATTR_PIXELS_INSIDE_WRAP
	ATK_TEXT_ATTR_BG_FULL_HEIGHT
	ATK_TEXT_ATTR_RISE
	ATK_TEXT_ATTR_UNDERLINE
	ATK_TEXT_ATTR_STRIKETHROUGH
	ATK_TEXT_ATTR_SIZE
	ATK_TEXT_ATTR_SCALE
	ATK_TEXT_ATTR_WEIGHT
	ATK_TEXT_ATTR_LANGUAGE
	ATK_TEXT_ATTR_FAMILY_NAME
	ATK_TEXT_ATTR_BG_COLOR
	ATK_TEXT_ATTR_FG_COLOR
	ATK_TEXT_ATTR_BG_STIPPLE
	ATK_TEXT_ATTR_FG_STIPPLE
	ATK_TEXT_ATTR_WRAP_MODE
	ATK_TEXT_ATTR_DIRECTION
	ATK_TEXT_ATTR_JUSTIFICATION
	ATK_TEXT_ATTR_STRETCH
	ATK_TEXT_ATTR_VARIANT
	ATK_TEXT_ATTR_STYLE
	ATK_TEXT_ATTR_LAST_DEFINED
end enum


declare function atk_text_attribute_register (byval name as zstring ptr) as AtkTextAttribute

type AtkText as _AtkText
type AtkTextIface as _AtkTextIface

enum AtkTextBoundary
	ATK_TEXT_BOUNDARY_CHAR
	ATK_TEXT_BOUNDARY_WORD_START
	ATK_TEXT_BOUNDARY_WORD_END
	ATK_TEXT_BOUNDARY_SENTENCE_START
	ATK_TEXT_BOUNDARY_SENTENCE_END
	ATK_TEXT_BOUNDARY_LINE_START
	ATK_TEXT_BOUNDARY_LINE_END
end enum

type AtkTextRectangle as _AtkTextRectangle

type _AtkTextRectangle
	x as gint
	y as gint
	width as gint
	height as gint
end type

type AtkTextRange as _AtkTextRange

type _AtkTextRange
	bounds as AtkTextRectangle
	start_offset as gint
	end_offset as gint
	content as zstring ptr
end type

enum AtkTextClipType
	ATK_TEXT_CLIP_NONE
	ATK_TEXT_CLIP_MIN
	ATK_TEXT_CLIP_MAX
	ATK_TEXT_CLIP_BOTH
end enum


type _AtkTextIface
	parent as GTypeInterface
	get_text as function cdecl(byval as AtkText ptr, byval as gint, byval as gint) as gchar
	get_text_after_offset as function cdecl(byval as AtkText ptr, byval as gint, byval as AtkTextBoundary, byval as gint ptr, byval as gint ptr) as gchar
	get_text_at_offset as function cdecl(byval as AtkText ptr, byval as gint, byval as AtkTextBoundary, byval as gint ptr, byval as gint ptr) as gchar
	get_character_at_offset as function cdecl(byval as AtkText ptr, byval as gint) as gunichar
	get_text_before_offset as function cdecl(byval as AtkText ptr, byval as gint, byval as AtkTextBoundary, byval as gint ptr, byval as gint ptr) as gchar
	get_caret_offset as function cdecl(byval as AtkText ptr) as gint
	get_run_attributes as function cdecl(byval as AtkText ptr, byval as gint, byval as gint ptr, byval as gint ptr) as AtkAttributeSet
	get_default_attributes as function cdecl(byval as AtkText ptr) as AtkAttributeSet
	get_character_extents as sub cdecl(byval as AtkText ptr, byval as gint, byval as gint ptr, byval as gint ptr, byval as gint ptr, byval as gint ptr, byval as AtkCoordType)
	get_character_count as function cdecl(byval as AtkText ptr) as gint
	get_offset_at_point as function cdecl(byval as AtkText ptr, byval as gint, byval as gint, byval as AtkCoordType) as gint
	get_n_selections as function cdecl(byval as AtkText ptr) as gint
	get_selection as function cdecl(byval as AtkText ptr, byval as gint, byval as gint ptr, byval as gint ptr) as gchar
	add_selection as function cdecl(byval as AtkText ptr, byval as gint, byval as gint) as gboolean
	remove_selection as function cdecl(byval as AtkText ptr, byval as gint) as gboolean
	set_selection as function cdecl(byval as AtkText ptr, byval as gint, byval as gint, byval as gint) as gboolean
	set_caret_offset as function cdecl(byval as AtkText ptr, byval as gint) as gboolean
	text_changed as sub cdecl(byval as AtkText ptr, byval as gint, byval as gint)
	text_caret_moved as sub cdecl(byval as AtkText ptr, byval as gint)
	text_selection_changed as sub cdecl(byval as AtkText ptr)
	text_attributes_changed as sub cdecl(byval as AtkText ptr)
	get_range_extents as sub cdecl(byval as AtkText ptr, byval as gint, byval as gint, byval as AtkCoordType, byval as AtkTextRectangle ptr)
	get_bounded_ranges as function cdecl(byval as AtkText ptr, byval as AtkTextRectangle ptr, byval as AtkCoordType, byval as AtkTextClipType, byval as AtkTextClipType) as AtkTextRange
	pad4 as AtkFunction
end type

declare function atk_text_get_type () as GType
declare function atk_text_get_text (byval text as AtkText ptr, byval start_offset as gint, byval end_offset as gint) as zstring ptr
declare function atk_text_get_character_at_offset (byval text as AtkText ptr, byval offset as gint) as gunichar
declare function atk_text_get_text_after_offset (byval text as AtkText ptr, byval offset as gint, byval boundary_type as AtkTextBoundary, byval start_offset as gint ptr, byval end_offset as gint ptr) as zstring ptr
declare function atk_text_get_text_at_offset (byval text as AtkText ptr, byval offset as gint, byval boundary_type as AtkTextBoundary, byval start_offset as gint ptr, byval end_offset as gint ptr) as zstring ptr
declare function atk_text_get_text_before_offset (byval text as AtkText ptr, byval offset as gint, byval boundary_type as AtkTextBoundary, byval start_offset as gint ptr, byval end_offset as gint ptr) as zstring ptr
declare function atk_text_get_caret_offset (byval text as AtkText ptr) as gint
declare sub atk_text_get_character_extents (byval text as AtkText ptr, byval offset as gint, byval x as gint ptr, byval y as gint ptr, byval width as gint ptr, byval height as gint ptr, byval coords as AtkCoordType)
declare function atk_text_get_run_attributes (byval text as AtkText ptr, byval offset as gint, byval start_offset as gint ptr, byval end_offset as gint ptr) as AtkAttributeSet ptr
declare function atk_text_get_default_attributes (byval text as AtkText ptr) as AtkAttributeSet ptr
declare function atk_text_get_character_count (byval text as AtkText ptr) as gint
declare function atk_text_get_offset_at_point (byval text as AtkText ptr, byval x as gint, byval y as gint, byval coords as AtkCoordType) as gint
declare function atk_text_get_n_selections (byval text as AtkText ptr) as gint
declare function atk_text_get_selection (byval text as AtkText ptr, byval selection_num as gint, byval start_offset as gint ptr, byval end_offset as gint ptr) as zstring ptr
declare function atk_text_add_selection (byval text as AtkText ptr, byval start_offset as gint, byval end_offset as gint) as gboolean
declare function atk_text_remove_selection (byval text as AtkText ptr, byval selection_num as gint) as gboolean
declare function atk_text_set_selection (byval text as AtkText ptr, byval selection_num as gint, byval start_offset as gint, byval end_offset as gint) as gboolean
declare function atk_text_set_caret_offset (byval text as AtkText ptr, byval offset as gint) as gboolean
declare sub atk_text_get_range_extents (byval text as AtkText ptr, byval start_offset as gint, byval end_offset as gint, byval coord_type as AtkCoordType, byval rect as AtkTextRectangle ptr)
declare function atk_text_get_bounded_ranges (byval text as AtkText ptr, byval rect as AtkTextRectangle ptr, byval coord_type as AtkCoordType, byval x_clip_type as AtkTextClipType, byval y_clip_type as AtkTextClipType) as AtkTextRange ptr ptr
declare sub atk_text_free_ranges (byval ranges as AtkTextRange ptr ptr)
declare sub atk_attribute_set_free (byval attrib_set as AtkAttributeSet ptr)
declare function atk_text_attribute_get_name (byval attr as AtkTextAttribute) as zstring ptr
declare function atk_text_attribute_for_name (byval name as zstring ptr) as AtkTextAttribute
declare function atk_text_attribute_get_value (byval attr as AtkTextAttribute, byval index_ as gint) as zstring ptr

#endif
