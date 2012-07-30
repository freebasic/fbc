''
''
'' XKBgeom -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __XKBgeom_bi__
#define __XKBgeom_bi__

type _XkbProperty
	name as zstring ptr
	value as zstring ptr
end type

type XkbPropertyRec as _XkbProperty
type XkbPropertyPtr as _XkbProperty ptr

type _XkbColor
	pixel as uinteger
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

type _XkbOutline
	num_points as ushort
	sz_points as ushort
	corner_radius as ushort
	points as XkbPointPtr
end type

type XkbOutlineRec as _XkbOutline
type XkbOutlinePtr as _XkbOutline ptr

type _XkbShape
	name as Atom
	num_outlines as ushort
	sz_outlines as ushort
	outlines as XkbOutlinePtr
	approx as XkbOutlinePtr
	primary as XkbOutlinePtr
	bounds as XkbBoundsRec
end type

type XkbShapeRec as _XkbShape
type XkbShapePtr as _XkbShape ptr

type _XkbShapeDoodad
	name as Atom
	type as ubyte
	priority as ubyte
	top as short
	left as short
	angle as short
	color_ndx as ushort
	shape_ndx as ushort
end type

type XkbShapeDoodadRec as _XkbShapeDoodad
type XkbShapeDoodadPtr as _XkbShapeDoodad ptr

type _XkbTextDoodad
	name as Atom
	type as ubyte
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

type _XkbIndicatorDoodad
	name as Atom
	type as ubyte
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

type _XkbLogoDoodad
	name as Atom
	type as ubyte
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

type _XkbAnyDoodad
	name as Atom
	type as ubyte
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

#define XkbUnknownDoodad 0
#define XkbOutlineDoodad 1
#define XkbSolidDoodad 2
#define XkbTextDoodad 3
#define XkbIndicatorDoodad 4
#define XkbLogoDoodad 5

type _XkbKey
	name as XkbKeyNameRec
	gap as short
	shape_ndx as ubyte
	color_ndx as ubyte
end type

type XkbKeyRec as _XkbKey
type XkbKeyPtr as _XkbKey ptr

type _XkbRow
	top as short
	left as short
	num_keys as ushort
	sz_keys as ushort
	vertical as integer
	keys as XkbKeyPtr
	bounds as XkbBoundsRec
end type

type XkbRowRec as _XkbRow
type XkbRowPtr as _XkbRow ptr

type _XkbSection
	name as Atom
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

type _XkbOverlay
	name as Atom
	section_under as XkbSectionPtr
	num_rows as ushort
	sz_rows as ushort
	rows as XkbOverlayRowPtr
	bounds as XkbBoundsPtr
end type

type XkbOverlayRec as _XkbOverlay
type XkbOverlayPtr as _XkbOverlay ptr

type _XkbGeometry
	name as Atom
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

#define XkbGeomPropertiesMask (1 shl 0)
#define XkbGeomColorsMask (1 shl 1)
#define XkbGeomShapesMask (1 shl 2)
#define XkbGeomSectionsMask (1 shl 3)
#define XkbGeomDoodadsMask (1 shl 4)
#define XkbGeomKeyAliasesMask (1 shl 5)
#define XkbGeomAllMask (&h3f)

type _XkbGeometrySizes
	which as uinteger
	num_properties as ushort
	num_colors as ushort
	num_shapes as ushort
	num_sections as ushort
	num_doodads as ushort
	num_key_aliases as ushort
end type

type XkbGeometrySizesRec as _XkbGeometrySizes
type XkbGeometrySizesPtr as _XkbGeometrySizes ptr

declare function XkbAddGeomKeyAlias cdecl alias "XkbAddGeomKeyAlias" (byval as XkbGeometryPtr, byval as zstring ptr, byval as zstring ptr) as XkbKeyAliasPtr
declare function XkbAddGeomColor cdecl alias "XkbAddGeomColor" (byval as XkbGeometryPtr, byval as zstring ptr, byval as uinteger) as XkbColorPtr
declare function XkbAddGeomOutline cdecl alias "XkbAddGeomOutline" (byval as XkbShapePtr, byval as integer) as XkbOutlinePtr
declare function XkbAddGeomShape cdecl alias "XkbAddGeomShape" (byval as XkbGeometryPtr, byval as Atom, byval as integer) as XkbShapePtr
declare function XkbAddGeomKey cdecl alias "XkbAddGeomKey" (byval as XkbRowPtr) as XkbKeyPtr
declare function XkbAddGeomRow cdecl alias "XkbAddGeomRow" (byval as XkbSectionPtr, byval as integer) as XkbRowPtr
declare function XkbAddGeomSection cdecl alias "XkbAddGeomSection" (byval as XkbGeometryPtr, byval as Atom, byval as integer, byval as integer, byval as integer) as XkbSectionPtr
declare function XkbAddGeomOverlay cdecl alias "XkbAddGeomOverlay" (byval as XkbSectionPtr, byval as Atom, byval as integer) as XkbOverlayPtr
declare function XkbAddGeomOverlayRow cdecl alias "XkbAddGeomOverlayRow" (byval as XkbOverlayPtr, byval as integer, byval as integer) as XkbOverlayRowPtr
declare function XkbAddGeomOverlayKey cdecl alias "XkbAddGeomOverlayKey" (byval as XkbOverlayPtr, byval as XkbOverlayRowPtr, byval as zstring ptr, byval as zstring ptr) as XkbOverlayKeyPtr
declare function XkbAddGeomDoodad cdecl alias "XkbAddGeomDoodad" (byval as XkbGeometryPtr, byval as XkbSectionPtr, byval as Atom) as XkbDoodadPtr
declare sub XkbFreeGeomKeyAliases cdecl alias "XkbFreeGeomKeyAliases" (byval as XkbGeometryPtr, byval as integer, byval as integer, byval as Bool)
declare sub XkbFreeGeomColors cdecl alias "XkbFreeGeomColors" (byval as XkbGeometryPtr, byval as integer, byval as integer, byval as Bool)
declare sub XkbFreeGeomDoodads cdecl alias "XkbFreeGeomDoodads" (byval as XkbDoodadPtr, byval as integer, byval as Bool)
declare sub XkbFreeGeomProperties cdecl alias "XkbFreeGeomProperties" (byval as XkbGeometryPtr, byval as integer, byval as integer, byval as Bool)
declare sub XkbFreeGeomOverlayKeys cdecl alias "XkbFreeGeomOverlayKeys" (byval as XkbOverlayRowPtr, byval as integer, byval as integer, byval as Bool)
declare sub XkbFreeGeomOverlayRows cdecl alias "XkbFreeGeomOverlayRows" (byval as XkbOverlayPtr, byval as integer, byval as integer, byval as Bool)
declare sub XkbFreeGeomOverlays cdecl alias "XkbFreeGeomOverlays" (byval as XkbSectionPtr, byval as integer, byval as integer, byval as Bool)
declare sub XkbFreeGeomKeys cdecl alias "XkbFreeGeomKeys" (byval as XkbRowPtr, byval as integer, byval as integer, byval as Bool)
declare sub XkbFreeGeomRows cdecl alias "XkbFreeGeomRows" (byval as XkbSectionPtr, byval as integer, byval as integer, byval as Bool)
declare sub XkbFreeGeomSections cdecl alias "XkbFreeGeomSections" (byval as XkbGeometryPtr, byval as integer, byval as integer, byval as Bool)
declare sub XkbFreeGeomPoints cdecl alias "XkbFreeGeomPoints" (byval as XkbOutlinePtr, byval as integer, byval as integer, byval as Bool)
declare sub XkbFreeGeomOutlines cdecl alias "XkbFreeGeomOutlines" (byval as XkbShapePtr, byval as integer, byval as integer, byval as Bool)
declare sub XkbFreeGeomShapes cdecl alias "XkbFreeGeomShapes" (byval as XkbGeometryPtr, byval as integer, byval as integer, byval as Bool)
declare sub XkbFreeGeometry cdecl alias "XkbFreeGeometry" (byval as XkbGeometryPtr, byval as uinteger, byval as Bool)
declare function XkbAllocGeomProps cdecl alias "XkbAllocGeomProps" (byval as XkbGeometryPtr, byval as integer) as Status
declare function XkbAllocGeomKeyAliases cdecl alias "XkbAllocGeomKeyAliases" (byval as XkbGeometryPtr, byval as integer) as Status
declare function XkbAllocGeomColors cdecl alias "XkbAllocGeomColors" (byval as XkbGeometryPtr, byval as integer) as Status
declare function XkbAllocGeomShapes cdecl alias "XkbAllocGeomShapes" (byval as XkbGeometryPtr, byval as integer) as Status
declare function XkbAllocGeomSections cdecl alias "XkbAllocGeomSections" (byval as XkbGeometryPtr, byval as integer) as Status
declare function XkbAllocGeomOverlays cdecl alias "XkbAllocGeomOverlays" (byval as XkbSectionPtr, byval as integer) as Status
declare function XkbAllocGeomOverlayRows cdecl alias "XkbAllocGeomOverlayRows" (byval as XkbOverlayPtr, byval as integer) as Status
declare function XkbAllocGeomOverlayKeys cdecl alias "XkbAllocGeomOverlayKeys" (byval as XkbOverlayRowPtr, byval as integer) as Status
declare function XkbAllocGeomDoodads cdecl alias "XkbAllocGeomDoodads" (byval as XkbGeometryPtr, byval as integer) as Status
declare function XkbAllocGeomSectionDoodads cdecl alias "XkbAllocGeomSectionDoodads" (byval as XkbSectionPtr, byval as integer) as Status
declare function XkbAllocGeomOutlines cdecl alias "XkbAllocGeomOutlines" (byval as XkbShapePtr, byval as integer) as Status
declare function XkbAllocGeomRows cdecl alias "XkbAllocGeomRows" (byval as XkbSectionPtr, byval as integer) as Status
declare function XkbAllocGeomPoints cdecl alias "XkbAllocGeomPoints" (byval as XkbOutlinePtr, byval as integer) as Status
declare function XkbAllocGeomKeys cdecl alias "XkbAllocGeomKeys" (byval as XkbRowPtr, byval as integer) as Status
declare function XkbAllocGeometry cdecl alias "XkbAllocGeometry" (byval as XkbDescPtr, byval as XkbGeometrySizesPtr) as Status
declare function XkbSetGeometry cdecl alias "XkbSetGeometry" (byval as Display ptr, byval as uinteger, byval as XkbGeometryPtr) as Status
declare function XkbComputeShapeTop cdecl alias "XkbComputeShapeTop" (byval as XkbShapePtr, byval as XkbBoundsPtr) as Bool
declare function XkbComputeShapeBounds cdecl alias "XkbComputeShapeBounds" (byval as XkbShapePtr) as Bool
declare function XkbComputeRowBounds cdecl alias "XkbComputeRowBounds" (byval as XkbGeometryPtr, byval as XkbSectionPtr, byval as XkbRowPtr) as Bool
declare function XkbComputeSectionBounds cdecl alias "XkbComputeSectionBounds" (byval as XkbGeometryPtr, byval as XkbSectionPtr) as Bool
declare function XkbFindOverlayForKey cdecl alias "XkbFindOverlayForKey" (byval as XkbGeometryPtr, byval as XkbSectionPtr, byval as zstring ptr) as zstring ptr
declare function XkbGetGeometry cdecl alias "XkbGetGeometry" (byval as Display ptr, byval as XkbDescPtr) as Status
declare function XkbGetNamedGeometry cdecl alias "XkbGetNamedGeometry" (byval as Display ptr, byval as XkbDescPtr, byval as Atom) as Status

#endif
