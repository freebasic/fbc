'' FreeBASIC binding for kbproto-1.0.6
''
'' based on the C header files:
''   **********************************************************
''   Copyright (c) 1993 by Silicon Graphics Computer Systems, Inc.
''
''   Permission to use, copy, modify, and distribute this
''   software and its documentation for any purpose and without
''   fee is hereby granted, provided that the above copyright
''   notice appear in all copies and that both that copyright
''   notice and this permission notice appear in supporting
''   documentation, and that the name of Silicon Graphics not be 
''   used in advertising or publicity pertaining to distribution 
''   of the software without specific prior written permission.
''   Silicon Graphics makes no representation about the suitability 
''   of this software for any purpose. It is provided "as is"
''   without any express or implied warranty.
''
''   SILICON GRAPHICS DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS 
''   SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY 
''   AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL SILICON
''   GRAPHICS BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL 
''   DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, 
''   DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE 
''   OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION  WITH
''   THE USE OR PERFORMANCE OF THIS SOFTWARE.
''
''   *******************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/extensions/XKBstr.bi"

extern "C"

#define _XKBGEOM_H_

type _XkbProperty
	name as zstring ptr
	value as zstring ptr
end type

type XkbPropertyRec as _XkbProperty
type XkbPropertyPtr as _XkbProperty ptr

type _XkbColor
	pixel as ulong
	spec as zstring ptr
end type

type XkbColorRec as _XkbColor
type XkbColorPtr as _XkbColor ptr

type _XkbPoint
	x as short
	y as short
end type

type XkbPointRec as _XkbPoint
type XkbPointPtr as _XkbPoint ptr

type _XkbBounds
	x1 as short
	y1 as short
	x2 as short
	y2 as short
end type

type XkbBoundsRec as _XkbBounds
type XkbBoundsPtr as _XkbBounds ptr
#define XkbBoundsWidth(b) ((b)->x2 - (b)->x1)
#define XkbBoundsHeight(b) ((b)->y2 - (b)->y1)

type _XkbOutline
	num_points as ushort
	sz_points as ushort
	corner_radius as ushort
	points as XkbPointPtr
end type

type XkbOutlineRec as _XkbOutline
type XkbOutlinePtr as _XkbOutline ptr

type _XkbShape
	name as XAtom
	num_outlines as ushort
	sz_outlines as ushort
	outlines as XkbOutlinePtr
	approx as XkbOutlinePtr
	primary as XkbOutlinePtr
	bounds as XkbBoundsRec
end type

type XkbShapeRec as _XkbShape
type XkbShapePtr as _XkbShape ptr
#define XkbOutlineIndex(s, o) clng((o) - (@(s)->outlines[0]))

type _XkbShapeDoodad
	name as XAtom
	as ubyte type
	priority as ubyte
	top as short
	left as short
	angle as short
	color_ndx as ushort
	shape_ndx as ushort
end type

type XkbShapeDoodadRec as _XkbShapeDoodad
type XkbShapeDoodadPtr as _XkbShapeDoodad ptr
#define XkbShapeDoodadColor(g, d) (@(g)->colors[(d)->color_ndx])
#define XkbShapeDoodadShape(g, d) (@(g)->shapes[(d)->shape_ndx])
#define XkbSetShapeDoodadColor(g, d, c) scope : (d)->color_ndx = (c) - (@(g)->colors[0]) : end scope
#define XkbSetShapeDoodadShape(g, d, s) scope : (d)->shape_ndx = (s) - (@(g)->shapes[0]) : end scope

type _XkbTextDoodad
	name as XAtom
	as ubyte type
	priority as ubyte
	top as short
	left as short
	angle as short
	width as short
	height as short
	color_ndx as ushort
	text as zstring ptr
	font as zstring ptr
end type

type XkbTextDoodadRec as _XkbTextDoodad
type XkbTextDoodadPtr as _XkbTextDoodad ptr
#define XkbTextDoodadColor(g, d) (@(g)->colors[(d)->color_ndx])
#define XkbSetTextDoodadColor(g, d, c) scope : (d)->color_ndx = (c) - (@(g)->colors[0]) : end scope

type _XkbIndicatorDoodad
	name as XAtom
	as ubyte type
	priority as ubyte
	top as short
	left as short
	angle as short
	shape_ndx as ushort
	on_color_ndx as ushort
	off_color_ndx as ushort
end type

type XkbIndicatorDoodadRec as _XkbIndicatorDoodad
type XkbIndicatorDoodadPtr as _XkbIndicatorDoodad ptr
#define XkbIndicatorDoodadShape(g, d) (@(g)->shapes[(d)->shape_ndx])
#define XkbIndicatorDoodadOnColor(g, d) (@(g)->colors[(d)->on_color_ndx])
#define XkbIndicatorDoodadOffColor(g, d) (@(g)->colors[(d)->off_color_ndx])
#define XkbSetIndicatorDoodadOnColor(g, d, c) scope : (d)->on_color_ndx = (c) - (@(g)->colors[0]) : end scope
#define XkbSetIndicatorDoodadOffColor(g, d, c) scope : (d)->off_color_ndx = (c) - (@(g)->colors[0]) : end scope
#define XkbSetIndicatorDoodadShape(g, d, s) scope : (d)->shape_ndx = (s) - (@(g)->shapes[0]) : end scope

type _XkbLogoDoodad
	name as XAtom
	as ubyte type
	priority as ubyte
	top as short
	left as short
	angle as short
	color_ndx as ushort
	shape_ndx as ushort
	logo_name as zstring ptr
end type

type XkbLogoDoodadRec as _XkbLogoDoodad
type XkbLogoDoodadPtr as _XkbLogoDoodad ptr
#define XkbLogoDoodadColor(g, d) (@(g)->colors[(d)->color_ndx])
#define XkbLogoDoodadShape(g, d) (@(g)->shapes[(d)->shape_ndx])
#define XkbSetLogoDoodadColor(g, d, c) scope : (d)->color_ndx = (c) - (@(g)->colors[0]) : end scope
#define XkbSetLogoDoodadShape(g, d, s) scope : (d)->shape_ndx = (s) - (@(g)->shapes[0]) : end scope

type _XkbAnyDoodad
	name as XAtom
	as ubyte type
	priority as ubyte
	top as short
	left as short
	angle as short
end type

type XkbAnyDoodadRec as _XkbAnyDoodad
type XkbAnyDoodadPtr as _XkbAnyDoodad ptr

union _XkbDoodad
	any as XkbAnyDoodadRec
	shape as XkbShapeDoodadRec
	text as XkbTextDoodadRec
	indicator as XkbIndicatorDoodadRec
	logo as XkbLogoDoodadRec
end union

type XkbDoodadRec as _XkbDoodad
type XkbDoodadPtr as _XkbDoodad ptr
const XkbUnknownDoodad = 0
const XkbOutlineDoodad = 1
const XkbSolidDoodad = 2
const XkbTextDoodad = 3
const XkbIndicatorDoodad = 4
const XkbLogoDoodad = 5

type _XkbKey
	name as XkbKeyNameRec
	gap as short
	shape_ndx as ubyte
	color_ndx as ubyte
end type

type XkbKeyRec as _XkbKey
type XkbKeyPtr as _XkbKey ptr
#define XkbKeyShape(g, k) (@(g)->shapes[(k)->shape_ndx])
#define XkbKeyColor(g, k) (@(g)->colors[(k)->color_ndx])
#define XkbSetKeyShape(g, k, s) scope : (k)->shape_ndx = (s) - (@(g)->shapes[0]) : end scope
#define XkbSetKeyColor(g, k, c) scope : (k)->color_ndx = (c) - (@(g)->colors[0]) : end scope

type _XkbRow
	top as short
	left as short
	num_keys as ushort
	sz_keys as ushort
	vertical as long
	keys as XkbKeyPtr
	bounds as XkbBoundsRec
end type

type XkbRowRec as _XkbRow
type XkbRowPtr as _XkbRow ptr
type _XkbOverlay as _XkbOverlay_

type _XkbSection
	name as XAtom
	priority as ubyte
	top as short
	left as short
	width as ushort
	height as ushort
	angle as short
	num_rows as ushort
	num_doodads as ushort
	num_overlays as ushort
	sz_rows as ushort
	sz_doodads as ushort
	sz_overlays as ushort
	rows as XkbRowPtr
	doodads as XkbDoodadPtr
	bounds as XkbBoundsRec
	overlays as _XkbOverlay ptr
end type

type XkbSectionRec as _XkbSection
type XkbSectionPtr as _XkbSection ptr

type _XkbOverlayKey
	over as XkbKeyNameRec
	under as XkbKeyNameRec
end type

type XkbOverlayKeyRec as _XkbOverlayKey
type XkbOverlayKeyPtr as _XkbOverlayKey ptr

type _XkbOverlayRow
	row_under as ushort
	num_keys as ushort
	sz_keys as ushort
	keys as XkbOverlayKeyPtr
end type

type XkbOverlayRowRec as _XkbOverlayRow
type XkbOverlayRowPtr as _XkbOverlayRow ptr

type _XkbOverlay_
	name as XAtom
	section_under as XkbSectionPtr
	num_rows as ushort
	sz_rows as ushort
	rows as XkbOverlayRowPtr
	bounds as XkbBoundsPtr
end type

type XkbOverlayRec as _XkbOverlay
type XkbOverlayPtr as _XkbOverlay ptr

type _XkbGeometry
	name as XAtom
	width_mm as ushort
	height_mm as ushort
	label_font as zstring ptr
	label_color as XkbColorPtr
	base_color as XkbColorPtr
	sz_properties as ushort
	sz_colors as ushort
	sz_shapes as ushort
	sz_sections as ushort
	sz_doodads as ushort
	sz_key_aliases as ushort
	num_properties as ushort
	num_colors as ushort
	num_shapes as ushort
	num_sections as ushort
	num_doodads as ushort
	num_key_aliases as ushort
	properties as XkbPropertyPtr
	colors as XkbColorPtr
	shapes as XkbShapePtr
	sections as XkbSectionPtr
	doodads as XkbDoodadPtr
	key_aliases as XkbKeyAliasPtr
end type

type XkbGeometryRec as _XkbGeometry
#define XkbGeomColorIndex(g, c) clng((c) - (@(g)->colors[0]))
const XkbGeomPropertiesMask = 1 shl 0
const XkbGeomColorsMask = 1 shl 1
const XkbGeomShapesMask = 1 shl 2
const XkbGeomSectionsMask = 1 shl 3
const XkbGeomDoodadsMask = 1 shl 4
const XkbGeomKeyAliasesMask = 1 shl 5
const XkbGeomAllMask = &h3f

type _XkbGeometrySizes
	which as ulong
	num_properties as ushort
	num_colors as ushort
	num_shapes as ushort
	num_sections as ushort
	num_doodads as ushort
	num_key_aliases as ushort
end type

type XkbGeometrySizesRec as _XkbGeometrySizes
type XkbGeometrySizesPtr as _XkbGeometrySizes ptr
declare function XkbAddGeomProperty(byval as XkbGeometryPtr, byval as zstring ptr, byval as zstring ptr) as XkbPropertyPtr
declare function XkbAddGeomKeyAlias(byval as XkbGeometryPtr, byval as zstring ptr, byval as zstring ptr) as XkbKeyAliasPtr
declare function XkbAddGeomColor(byval as XkbGeometryPtr, byval as zstring ptr, byval as ulong) as XkbColorPtr
declare function XkbAddGeomOutline(byval as XkbShapePtr, byval as long) as XkbOutlinePtr
declare function XkbAddGeomShape(byval as XkbGeometryPtr, byval as XAtom, byval as long) as XkbShapePtr
declare function XkbAddGeomKey(byval as XkbRowPtr) as XkbKeyPtr
declare function XkbAddGeomRow(byval as XkbSectionPtr, byval as long) as XkbRowPtr
declare function XkbAddGeomSection(byval as XkbGeometryPtr, byval as XAtom, byval as long, byval as long, byval as long) as XkbSectionPtr
declare function XkbAddGeomOverlay(byval as XkbSectionPtr, byval as XAtom, byval as long) as XkbOverlayPtr
declare function XkbAddGeomOverlayRow(byval as XkbOverlayPtr, byval as long, byval as long) as XkbOverlayRowPtr
declare function XkbAddGeomOverlayKey(byval as XkbOverlayPtr, byval as XkbOverlayRowPtr, byval as zstring ptr, byval as zstring ptr) as XkbOverlayKeyPtr
declare function XkbAddGeomDoodad(byval as XkbGeometryPtr, byval as XkbSectionPtr, byval as XAtom) as XkbDoodadPtr
declare sub XkbFreeGeomKeyAliases(byval as XkbGeometryPtr, byval as long, byval as long, byval as long)
declare sub XkbFreeGeomColors(byval as XkbGeometryPtr, byval as long, byval as long, byval as long)
declare sub XkbFreeGeomDoodads(byval as XkbDoodadPtr, byval as long, byval as long)
declare sub XkbFreeGeomProperties(byval as XkbGeometryPtr, byval as long, byval as long, byval as long)
declare sub XkbFreeGeomOverlayKeys(byval as XkbOverlayRowPtr, byval as long, byval as long, byval as long)
declare sub XkbFreeGeomOverlayRows(byval as XkbOverlayPtr, byval as long, byval as long, byval as long)
declare sub XkbFreeGeomOverlays(byval as XkbSectionPtr, byval as long, byval as long, byval as long)
declare sub XkbFreeGeomKeys(byval as XkbRowPtr, byval as long, byval as long, byval as long)
declare sub XkbFreeGeomRows(byval as XkbSectionPtr, byval as long, byval as long, byval as long)
declare sub XkbFreeGeomSections(byval as XkbGeometryPtr, byval as long, byval as long, byval as long)
declare sub XkbFreeGeomPoints(byval as XkbOutlinePtr, byval as long, byval as long, byval as long)
declare sub XkbFreeGeomOutlines(byval as XkbShapePtr, byval as long, byval as long, byval as long)
declare sub XkbFreeGeomShapes(byval as XkbGeometryPtr, byval as long, byval as long, byval as long)
declare sub XkbFreeGeometry(byval as XkbGeometryPtr, byval as ulong, byval as long)
declare function XkbAllocGeomProps(byval as XkbGeometryPtr, byval as long) as long
declare function XkbAllocGeomKeyAliases(byval as XkbGeometryPtr, byval as long) as long
declare function XkbAllocGeomColors(byval as XkbGeometryPtr, byval as long) as long
declare function XkbAllocGeomShapes(byval as XkbGeometryPtr, byval as long) as long
declare function XkbAllocGeomSections(byval as XkbGeometryPtr, byval as long) as long
declare function XkbAllocGeomOverlays(byval as XkbSectionPtr, byval as long) as long
declare function XkbAllocGeomOverlayRows(byval as XkbOverlayPtr, byval as long) as long
declare function XkbAllocGeomOverlayKeys(byval as XkbOverlayRowPtr, byval as long) as long
declare function XkbAllocGeomDoodads(byval as XkbGeometryPtr, byval as long) as long
declare function XkbAllocGeomSectionDoodads(byval as XkbSectionPtr, byval as long) as long
declare function XkbAllocGeomOutlines(byval as XkbShapePtr, byval as long) as long
declare function XkbAllocGeomRows(byval as XkbSectionPtr, byval as long) as long
declare function XkbAllocGeomPoints(byval as XkbOutlinePtr, byval as long) as long
declare function XkbAllocGeomKeys(byval as XkbRowPtr, byval as long) as long
declare function XkbAllocGeometry(byval as XkbDescPtr, byval as XkbGeometrySizesPtr) as long
declare function XkbSetGeometry(byval as Display ptr, byval as ulong, byval as XkbGeometryPtr) as long
declare function XkbComputeShapeTop(byval as XkbShapePtr, byval as XkbBoundsPtr) as long
declare function XkbComputeShapeBounds(byval as XkbShapePtr) as long
declare function XkbComputeRowBounds(byval as XkbGeometryPtr, byval as XkbSectionPtr, byval as XkbRowPtr) as long
declare function XkbComputeSectionBounds(byval as XkbGeometryPtr, byval as XkbSectionPtr) as long
declare function XkbFindOverlayForKey(byval as XkbGeometryPtr, byval as XkbSectionPtr, byval as zstring ptr) as zstring ptr
declare function XkbGetGeometry(byval as Display ptr, byval as XkbDescPtr) as long
declare function XkbGetNamedGeometry(byval as Display ptr, byval as XkbDescPtr, byval as XAtom) as long

end extern
