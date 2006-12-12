''
''
'' gdkfont -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkfont_bi__
#define __gdkfont_bi__

#include once "gdktypes.bi"
#include once "gtk/pango/pango-font.bi"

#define GDK_TYPE_FONT gdk_font_get_type ()

enum GdkFontType
	GDK_FONT_FONT
	GDK_FONT_FONTSET
end enum


type _GdkFont
	type as GdkFontType
	ascent as gint
	descent as gint
end type

declare function gdk_font_get_type () as GType
declare function gdk_font_ref (byval font as GdkFont ptr) as GdkFont ptr
declare sub gdk_font_unref (byval font as GdkFont ptr)
declare function gdk_font_id (byval font as GdkFont ptr) as gint
declare function gdk_font_equal (byval fonta as GdkFont ptr, byval fontb as GdkFont ptr) as gboolean
declare function gdk_font_load_for_display (byval display as GdkDisplay ptr, byval font_name as zstring ptr) as GdkFont ptr
declare function gdk_fontset_load_for_display (byval display as GdkDisplay ptr, byval fontset_name as zstring ptr) as GdkFont ptr
declare function gdk_font_from_description_for_display (byval display as GdkDisplay ptr, byval font_desc as PangoFontDescription ptr) as GdkFont ptr
declare function gdk_font_load (byval font_name as zstring ptr) as GdkFont ptr
declare function gdk_fontset_load (byval fontset_name as zstring ptr) as GdkFont ptr
declare function gdk_font_from_description (byval font_desc as PangoFontDescription ptr) as GdkFont ptr
declare function gdk_string_width (byval font as GdkFont ptr, byval string as zstring ptr) as gint
declare function gdk_text_width (byval font as GdkFont ptr, byval text as zstring ptr, byval text_length as gint) as gint
declare function gdk_text_width_wc (byval font as GdkFont ptr, byval text as GdkWChar ptr, byval text_length as gint) as gint
declare function gdk_char_width (byval font as GdkFont ptr, byval character as gchar) as gint
declare function gdk_char_width_wc (byval font as GdkFont ptr, byval character as GdkWChar) as gint
declare function gdk_string_measure (byval font as GdkFont ptr, byval string as zstring ptr) as gint
declare function gdk_text_measure (byval font as GdkFont ptr, byval text as zstring ptr, byval text_length as gint) as gint
declare function gdk_char_measure (byval font as GdkFont ptr, byval character as gchar) as gint
declare function gdk_string_height (byval font as GdkFont ptr, byval string as zstring ptr) as gint
declare function gdk_text_height (byval font as GdkFont ptr, byval text as zstring ptr, byval text_length as gint) as gint
declare function gdk_char_height (byval font as GdkFont ptr, byval character as gchar) as gint
declare sub gdk_text_extents (byval font as GdkFont ptr, byval text as zstring ptr, byval text_length as gint, byval lbearing as gint ptr, byval rbearing as gint ptr, byval width as gint ptr, byval ascent as gint ptr, byval descent as gint ptr)
declare sub gdk_text_extents_wc (byval font as GdkFont ptr, byval text as GdkWChar ptr, byval text_length as gint, byval lbearing as gint ptr, byval rbearing as gint ptr, byval width as gint ptr, byval ascent as gint ptr, byval descent as gint ptr)
declare sub gdk_string_extents (byval font as GdkFont ptr, byval string as zstring ptr, byval lbearing as gint ptr, byval rbearing as gint ptr, byval width as gint ptr, byval ascent as gint ptr, byval descent as gint ptr)
declare function gdk_font_get_display (byval font as GdkFont ptr) as GdkDisplay ptr

#endif
