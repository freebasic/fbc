''
''
'' Xrender -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xrender_bi__
#define __Xrender_bi__

type XRenderDirectFormat
	red as short
	redMask as short
	green as short
	greenMask as short
	blue as short
	blueMask as short
	alpha as short
	alphaMask as short
end type

type XRenderPictFormat
	id as PictFormat
	type as integer
	depth as integer
	direct as XRenderDirectFormat
	colormap as Colormap
end type

#define PictFormatID (1 shl 0)
#define PictFormatType (1 shl 1)
#define PictFormatDepth (1 shl 2)
#define PictFormatRed (1 shl 3)
#define PictFormatRedMask (1 shl 4)
#define PictFormatGreen (1 shl 5)
#define PictFormatGreenMask (1 shl 6)
#define PictFormatBlue (1 shl 7)
#define PictFormatBlueMask (1 shl 8)
#define PictFormatAlpha (1 shl 9)
#define PictFormatAlphaMask (1 shl 10)
#define PictFormatColormap (1 shl 11)

type _XRenderPictureAttributes
	repeat as integer
	alpha_map as Picture
	alpha_x_origin as integer
	alpha_y_origin as integer
	clip_x_origin as integer
	clip_y_origin as integer
	clip_mask as Pixmap
	graphics_exposures as Bool
	subwindow_mode as integer
	poly_edge as integer
	poly_mode as integer
	dither as Atom
	component_alpha as Bool
end type

type XRenderPictureAttributes as _XRenderPictureAttributes

type XRenderColor
	red as ushort
	green as ushort
	blue as ushort
	alpha as ushort
end type

type _XGlyphInfo
	width as ushort
	height as ushort
	x as short
	y as short
	xOff as short
	yOff as short
end type

type XGlyphInfo as _XGlyphInfo

type _XGlyphElt8
	glyphset as GlyphSet
	nchars as integer
	xOff as integer
	yOff as integer
end type

type XGlyphElt8 as _XGlyphElt8

type _XGlyphElt16
	glyphset as GlyphSet
	nchars as uinteger
	xOff as integer
	yOff as integer
end type

type XGlyphElt16 as _XGlyphElt16

type _XGlyphElt32
	glyphset as GlyphSet
	nchars as uinteger
	xOff as integer
	yOff as integer
end type

type XGlyphElt32 as _XGlyphElt32
type XDouble as double

type _XPointDouble
	x as XDouble
	y as XDouble
end type

type XPointDouble as _XPointDouble
type XFixed as integer

type _XPointFixed
	x as XFixed
	y as XFixed
end type

type XPointFixed as _XPointFixed

type _XLineFixed
	p1 as XPointFixed
	p2 as XPointFixed
end type

type XLineFixed as _XLineFixed

type _XTriangle
	p1 as XPointFixed
	p2 as XPointFixed
	p3 as XPointFixed
end type

type XTriangle as _XTriangle

type _XCircle
	x as XFixed
	y as XFixed
	radius as XFixed
end type

type XCircle as _XCircle

type _XTrapezoid
	top as XFixed
	bottom as XFixed
	left as XLineFixed
	right as XLineFixed
end type

type XTrapezoid as _XTrapezoid

type _XTransform
	matrix(0 to 3-1, 0 to 3-1) as XFixed ptr
end type

type XTransform as _XTransform

type _XFilters
	nfilter as integer
	filter as byte ptr ptr
	nalias as integer
	alias as short ptr
end type

type XFilters as _XFilters

type _XIndexValue
	pixel as uinteger
	red as ushort
	green as ushort
	blue as ushort
	alpha as ushort
end type

type XIndexValue as _XIndexValue

type _XAnimCursor
	cursor as Cursor
	delay as uinteger
end type

type XAnimCursor as _XAnimCursor

type _XSpanFix
	left as XFixed
	right as XFixed
	y as XFixed
end type

type XSpanFix as _XSpanFix

type _XTrap
	top as XSpanFix
	bottom as XSpanFix
end type

type XTrap as _XTrap

type _XLinearGradient
	p1 as XPointFixed
	p2 as XPointFixed
end type

type XLinearGradient as _XLinearGradient

type _XRadialGradient
	inner as XCircle
	outer as XCircle
end type

type XRadialGradient as _XRadialGradient

type _XConicalGradient
	center as XPointFixed
	angle as XFixed
end type

type XConicalGradient as _XConicalGradient

declare function XRenderQueryVersion cdecl alias "XRenderQueryVersion" (byval dpy as Display ptr, byval major_versionp as integer ptr, byval minor_versionp as integer ptr) as Status
declare function XRenderQueryFormats cdecl alias "XRenderQueryFormats" (byval dpy as Display ptr) as Status
declare function XRenderQuerySubpixelOrder cdecl alias "XRenderQuerySubpixelOrder" (byval dpy as Display ptr, byval screen as integer) as integer
declare function XRenderSetSubpixelOrder cdecl alias "XRenderSetSubpixelOrder" (byval dpy as Display ptr, byval screen as integer, byval subpixel as integer) as Bool

#define PictStandardARGB32 0
#define PictStandardRGB24 1
#define PictStandardA8 2
#define PictStandardA4 3
#define PictStandardA1 4
#define PictStandardNUM 5

declare function XRenderFindStandardFormat cdecl alias "XRenderFindStandardFormat" (byval dpy as Display ptr, byval format as integer) as XRenderPictFormat ptr
declare sub XRenderSetPictureClipRegion cdecl alias "XRenderSetPictureClipRegion" (byval dpy as Display ptr, byval picture as Picture, byval r as Region)
declare sub XRenderSetPictureTransform cdecl alias "XRenderSetPictureTransform" (byval dpy as Display ptr, byval picture as Picture, byval transform as XTransform ptr)
declare sub XRenderFreePicture cdecl alias "XRenderFreePicture" (byval dpy as Display ptr, byval picture as Picture)
declare sub XRenderComposite cdecl alias "XRenderComposite" (byval dpy as Display ptr, byval op as integer, byval src as Picture, byval mask as Picture, byval dst as Picture, byval src_x as integer, byval src_y as integer, byval mask_x as integer, byval mask_y as integer, byval dst_x as integer, byval dst_y as integer, byval width as uinteger, byval height as uinteger)
declare function XRenderReferenceGlyphSet cdecl alias "XRenderReferenceGlyphSet" (byval dpy as Display ptr, byval existing as GlyphSet) as GlyphSet
declare sub XRenderFreeGlyphSet cdecl alias "XRenderFreeGlyphSet" (byval dpy as Display ptr, byval glyphset as GlyphSet)
declare function XRenderParseColor cdecl alias "XRenderParseColor" (byval dpy as Display ptr, byval spec as zstring ptr, byval def as XRenderColor ptr) as Status
declare function XRenderCreateCursor cdecl alias "XRenderCreateCursor" (byval dpy as Display ptr, byval source as Picture, byval x as uinteger, byval y as uinteger) as Cursor
declare function XRenderQueryFilters cdecl alias "XRenderQueryFilters" (byval dpy as Display ptr, byval drawable as Drawable) as XFilters ptr
declare sub XRenderSetPictureFilter cdecl alias "XRenderSetPictureFilter" (byval dpy as Display ptr, byval picture as Picture, byval filter as zstring ptr, byval params as XFixed ptr, byval nparams as integer)
declare function XRenderCreateAnimCursor cdecl alias "XRenderCreateAnimCursor" (byval dpy as Display ptr, byval ncursor as integer, byval cursors as XAnimCursor ptr) as Cursor
declare function XRenderCreateSolidFill cdecl alias "XRenderCreateSolidFill" (byval dpy as Display ptr, byval color as XRenderColor ptr) as Picture
declare function XRenderCreateLinearGradient cdecl alias "XRenderCreateLinearGradient" (byval dpy as Display ptr, byval gradient as XLinearGradient ptr, byval stops as XFixed ptr, byval colors as XRenderColor ptr, byval nstops as integer) as Picture
declare function XRenderCreateRadialGradient cdecl alias "XRenderCreateRadialGradient" (byval dpy as Display ptr, byval gradient as XRadialGradient ptr, byval stops as XFixed ptr, byval colors as XRenderColor ptr, byval nstops as integer) as Picture
declare function XRenderCreateConicalGradient cdecl alias "XRenderCreateConicalGradient" (byval dpy as Display ptr, byval gradient as XConicalGradient ptr, byval stops as XFixed ptr, byval colors as XRenderColor ptr, byval nstops as integer) as Picture

#endif
