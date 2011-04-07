''
''
'' pango-tabs -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pango_tabs_bi__
#define __pango_tabs_bi__

#include once "pango-types.bi"

type PangoTabArray as _PangoTabArray

enum PangoTabAlign
	PANGO_TAB_LEFT
end enum


declare function pango_tab_array_new (byval initial_size as gint, byval positions_in_pixels as gboolean) as PangoTabArray ptr
declare function pango_tab_array_new_with_positions (byval size as gint, byval positions_in_pixels as gboolean, byval first_alignment as PangoTabAlign, byval first_position as gint, ...) as PangoTabArray ptr
declare function pango_tab_array_get_type () as GType
declare function pango_tab_array_copy (byval src as PangoTabArray ptr) as PangoTabArray ptr
declare sub pango_tab_array_free (byval tab_array as PangoTabArray ptr)
declare function pango_tab_array_get_size (byval tab_array as PangoTabArray ptr) as gint
declare sub pango_tab_array_resize (byval tab_array as PangoTabArray ptr, byval new_size as gint)
declare sub pango_tab_array_set_tab (byval tab_array as PangoTabArray ptr, byval tab_index as gint, byval alignment as PangoTabAlign, byval location as gint)
declare sub pango_tab_array_get_tab (byval tab_array as PangoTabArray ptr, byval tab_index as gint, byval alignment as PangoTabAlign ptr, byval location as gint ptr)
declare sub pango_tab_array_get_tabs (byval tab_array as PangoTabArray ptr, byval alignments as PangoTabAlign ptr ptr, byval locations as gint ptr ptr)
declare function pango_tab_array_get_positions_in_pixels (byval tab_array as PangoTabArray ptr) as gboolean

#endif
