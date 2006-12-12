''
''
'' gdkregion -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkregion_bi__
#define __gdkregion_bi__

#include once "gdktypes.bi"

enum GdkFillRule
	GDK_EVEN_ODD_RULE
	GDK_WINDING_RULE
end enum


enum GdkOverlapType
	GDK_OVERLAP_RECTANGLE_IN
	GDK_OVERLAP_RECTANGLE_OUT
	GDK_OVERLAP_RECTANGLE_PART
end enum

type GdkSpanFunc as sub cdecl(byval as GdkSpan ptr, byval as gpointer)

declare function gdk_region_new () as GdkRegion ptr
declare function gdk_region_polygon (byval points as GdkPoint ptr, byval npoints as gint, byval fill_rule as GdkFillRule) as GdkRegion ptr
declare function gdk_region_copy (byval region as GdkRegion ptr) as GdkRegion ptr
declare function gdk_region_rectangle (byval rectangle as GdkRectangle ptr) as GdkRegion ptr
declare sub gdk_region_destroy (byval region as GdkRegion ptr)
declare sub gdk_region_get_clipbox (byval region as GdkRegion ptr, byval rectangle as GdkRectangle ptr)
declare sub gdk_region_get_rectangles (byval region as GdkRegion ptr, byval rectangles as GdkRectangle ptr ptr, byval n_rectangles as gint ptr)
declare function gdk_region_empty (byval region as GdkRegion ptr) as gboolean
declare function gdk_region_equal (byval region1 as GdkRegion ptr, byval region2 as GdkRegion ptr) as gboolean
declare function gdk_region_point_in (byval region as GdkRegion ptr, byval x as integer, byval y as integer) as gboolean
declare function gdk_region_rect_in (byval region as GdkRegion ptr, byval rect as GdkRectangle ptr) as GdkOverlapType
declare sub gdk_region_offset (byval region as GdkRegion ptr, byval dx as gint, byval dy as gint)
declare sub gdk_region_shrink (byval region as GdkRegion ptr, byval dx as gint, byval dy as gint)
declare sub gdk_region_union_with_rect (byval region as GdkRegion ptr, byval rect as GdkRectangle ptr)
declare sub gdk_region_intersect (byval source1 as GdkRegion ptr, byval source2 as GdkRegion ptr)
declare sub gdk_region_union (byval source1 as GdkRegion ptr, byval source2 as GdkRegion ptr)
declare sub gdk_region_subtract (byval source1 as GdkRegion ptr, byval source2 as GdkRegion ptr)
declare sub gdk_region_xor (byval source1 as GdkRegion ptr, byval source2 as GdkRegion ptr)
declare sub gdk_region_spans_intersect_foreach (byval region as GdkRegion ptr, byval spans as GdkSpan ptr, byval n_spans as integer, byval sorted as gboolean, byval function as GdkSpanFunc, byval data as gpointer)

#endif
