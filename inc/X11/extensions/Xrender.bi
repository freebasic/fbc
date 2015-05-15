'' FreeBASIC binding for libXrender-0.9.8
''
'' based on the C header files:
''
''   Copyright © 2000 SuSE, Inc.
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation, and that the name of SuSE not be used in advertising or
''   publicity pertaining to distribution of the software without specific,
''   written prior permission.  SuSE makes no representations about the
''   suitability of this software for any purpose.  It is provided "as is"
''   without express or implied warranty.
''
''   SuSE DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL
''   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL SuSE
''   BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
''   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
''   OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
''   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
''
''   Author:  Keith Packard, SuSE, Inc.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Xlib.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/Xosdefs.bi"
#include once "X11/Xutil.bi"
#include once "X11/extensions/render.bi"

extern "C"

#define _XRENDER_H_

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
	as long type
	depth as long
	direct as XRenderDirectFormat
	colormap as Colormap
end type

const PictFormatID = 1 shl 0
const PictFormatType = 1 shl 1
const PictFormatDepth = 1 shl 2
const PictFormatRed = 1 shl 3
const PictFormatRedMask = 1 shl 4
const PictFormatGreen = 1 shl 5
const PictFormatGreenMask = 1 shl 6
const PictFormatBlue = 1 shl 7
const PictFormatBlueMask = 1 shl 8
const PictFormatAlpha = 1 shl 9
const PictFormatAlphaMask = 1 shl 10
const PictFormatColormap = 1 shl 11

type _XRenderPictureAttributes
	repeat as long
	alpha_map as Picture
	alpha_x_origin as long
	alpha_y_origin as long
	clip_x_origin as long
	clip_y_origin as long
	clip_mask as Pixmap
	graphics_exposures as long
	subwindow_mode as long
	poly_edge as long
	poly_mode as long
	dither as XAtom
	component_alpha as long
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
	glyphset as XGlyphSet
	chars as const zstring ptr
	nchars as long
	xOff as long
	yOff as long
end type

type XGlyphElt8 as _XGlyphElt8

type _XGlyphElt16
	glyphset as XGlyphSet
	chars as const ushort ptr
	nchars as long
	xOff as long
	yOff as long
end type

type XGlyphElt16 as _XGlyphElt16

type _XGlyphElt32
	glyphset as XGlyphSet
	chars as const ulong ptr
	nchars as long
	xOff as long
	yOff as long
end type

type XGlyphElt32 as _XGlyphElt32
type XDouble as double

type _XPointDouble
	x as XDouble
	y as XDouble
end type

type XPointDouble as _XPointDouble
#define XDoubleToFixed(f) cast(XFixed, (f) * 65536)
#define XFixedToDouble(f) (cast(XDouble, (f)) / 65536)
type XFixed as long

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
	matrix(0 to 2, 0 to 2) as XFixed
end type

type XTransform as _XTransform

type _XFilters
	nfilter as long
	filter as zstring ptr ptr
	nalias as long
	alias as short ptr
end type

type XFilters as _XFilters

type _XIndexValue
	pixel as culong
	red as ushort
	green as ushort
	blue as ushort
	alpha as ushort
end type

type XIndexValue as _XIndexValue

type _XAnimCursor
	cursor as Cursor
	delay as culong
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
declare function XRenderQueryExtension(byval dpy as Display ptr, byval event_basep as long ptr, byval error_basep as long ptr) as long
declare function XRenderQueryVersion(byval dpy as Display ptr, byval major_versionp as long ptr, byval minor_versionp as long ptr) as long
declare function XRenderQueryFormats(byval dpy as Display ptr) as long
declare function XRenderQuerySubpixelOrder(byval dpy as Display ptr, byval screen as long) as long
declare function XRenderSetSubpixelOrder(byval dpy as Display ptr, byval screen as long, byval subpixel as long) as long
declare function XRenderFindVisualFormat(byval dpy as Display ptr, byval visual as const Visual ptr) as XRenderPictFormat ptr
declare function XRenderFindFormat(byval dpy as Display ptr, byval mask as culong, byval templ as const XRenderPictFormat ptr, byval count as long) as XRenderPictFormat ptr

const PictStandardARGB32 = 0
const PictStandardRGB24 = 1
const PictStandardA8 = 2
const PictStandardA4 = 3
const PictStandardA1 = 4
const PictStandardNUM = 5

declare function XRenderFindStandardFormat(byval dpy as Display ptr, byval format as long) as XRenderPictFormat ptr
declare function XRenderQueryPictIndexValues(byval dpy as Display ptr, byval format as const XRenderPictFormat ptr, byval num as long ptr) as XIndexValue ptr
declare function XRenderCreatePicture(byval dpy as Display ptr, byval drawable as Drawable, byval format as const XRenderPictFormat ptr, byval valuemask as culong, byval attributes as const XRenderPictureAttributes ptr) as Picture
declare sub XRenderChangePicture(byval dpy as Display ptr, byval picture as Picture, byval valuemask as culong, byval attributes as const XRenderPictureAttributes ptr)
declare sub XRenderSetPictureClipRectangles(byval dpy as Display ptr, byval picture as Picture, byval xOrigin as long, byval yOrigin as long, byval rects as const XRectangle ptr, byval n as long)
declare sub XRenderSetPictureClipRegion(byval dpy as Display ptr, byval picture as Picture, byval r as Region)
declare sub XRenderSetPictureTransform(byval dpy as Display ptr, byval picture as Picture, byval transform as XTransform ptr)
declare sub XRenderFreePicture(byval dpy as Display ptr, byval picture as Picture)
declare sub XRenderComposite(byval dpy as Display ptr, byval op as long, byval src as Picture, byval mask as Picture, byval dst as Picture, byval src_x as long, byval src_y as long, byval mask_x as long, byval mask_y as long, byval dst_x as long, byval dst_y as long, byval width as ulong, byval height as ulong)
declare function XRenderCreateGlyphSet(byval dpy as Display ptr, byval format as const XRenderPictFormat ptr) as XGlyphSet
declare function XRenderReferenceGlyphSet(byval dpy as Display ptr, byval existing as XGlyphSet) as XGlyphSet
declare sub XRenderFreeGlyphSet(byval dpy as Display ptr, byval glyphset as XGlyphSet)
declare sub XRenderAddGlyphs(byval dpy as Display ptr, byval glyphset as XGlyphSet, byval gids as const Glyph ptr, byval glyphs as const XGlyphInfo ptr, byval nglyphs as long, byval images as const zstring ptr, byval nbyte_images as long)
declare sub XRenderFreeGlyphs(byval dpy as Display ptr, byval glyphset as XGlyphSet, byval gids as const Glyph ptr, byval nglyphs as long)
declare sub XRenderCompositeString8(byval dpy as Display ptr, byval op as long, byval src as Picture, byval dst as Picture, byval maskFormat as const XRenderPictFormat ptr, byval glyphset as XGlyphSet, byval xSrc as long, byval ySrc as long, byval xDst as long, byval yDst as long, byval string as const zstring ptr, byval nchar as long)
declare sub XRenderCompositeString16(byval dpy as Display ptr, byval op as long, byval src as Picture, byval dst as Picture, byval maskFormat as const XRenderPictFormat ptr, byval glyphset as XGlyphSet, byval xSrc as long, byval ySrc as long, byval xDst as long, byval yDst as long, byval string as const ushort ptr, byval nchar as long)
declare sub XRenderCompositeString32(byval dpy as Display ptr, byval op as long, byval src as Picture, byval dst as Picture, byval maskFormat as const XRenderPictFormat ptr, byval glyphset as XGlyphSet, byval xSrc as long, byval ySrc as long, byval xDst as long, byval yDst as long, byval string as const ulong ptr, byval nchar as long)
declare sub XRenderCompositeText8(byval dpy as Display ptr, byval op as long, byval src as Picture, byval dst as Picture, byval maskFormat as const XRenderPictFormat ptr, byval xSrc as long, byval ySrc as long, byval xDst as long, byval yDst as long, byval elts as const XGlyphElt8 ptr, byval nelt as long)
declare sub XRenderCompositeText16(byval dpy as Display ptr, byval op as long, byval src as Picture, byval dst as Picture, byval maskFormat as const XRenderPictFormat ptr, byval xSrc as long, byval ySrc as long, byval xDst as long, byval yDst as long, byval elts as const XGlyphElt16 ptr, byval nelt as long)
declare sub XRenderCompositeText32(byval dpy as Display ptr, byval op as long, byval src as Picture, byval dst as Picture, byval maskFormat as const XRenderPictFormat ptr, byval xSrc as long, byval ySrc as long, byval xDst as long, byval yDst as long, byval elts as const XGlyphElt32 ptr, byval nelt as long)
declare sub XRenderFillRectangle(byval dpy as Display ptr, byval op as long, byval dst as Picture, byval color as const XRenderColor ptr, byval x as long, byval y as long, byval width as ulong, byval height as ulong)
declare sub XRenderFillRectangles(byval dpy as Display ptr, byval op as long, byval dst as Picture, byval color as const XRenderColor ptr, byval rectangles as const XRectangle ptr, byval n_rects as long)
declare sub XRenderCompositeTrapezoids(byval dpy as Display ptr, byval op as long, byval src as Picture, byval dst as Picture, byval maskFormat as const XRenderPictFormat ptr, byval xSrc as long, byval ySrc as long, byval traps as const XTrapezoid ptr, byval ntrap as long)
declare sub XRenderCompositeTriangles(byval dpy as Display ptr, byval op as long, byval src as Picture, byval dst as Picture, byval maskFormat as const XRenderPictFormat ptr, byval xSrc as long, byval ySrc as long, byval triangles as const XTriangle ptr, byval ntriangle as long)
declare sub XRenderCompositeTriStrip(byval dpy as Display ptr, byval op as long, byval src as Picture, byval dst as Picture, byval maskFormat as const XRenderPictFormat ptr, byval xSrc as long, byval ySrc as long, byval points as const XPointFixed ptr, byval npoint as long)
declare sub XRenderCompositeTriFan(byval dpy as Display ptr, byval op as long, byval src as Picture, byval dst as Picture, byval maskFormat as const XRenderPictFormat ptr, byval xSrc as long, byval ySrc as long, byval points as const XPointFixed ptr, byval npoint as long)
declare sub XRenderCompositeDoublePoly(byval dpy as Display ptr, byval op as long, byval src as Picture, byval dst as Picture, byval maskFormat as const XRenderPictFormat ptr, byval xSrc as long, byval ySrc as long, byval xDst as long, byval yDst as long, byval fpoints as const XPointDouble ptr, byval npoints as long, byval winding as long)
declare function XRenderParseColor(byval dpy as Display ptr, byval spec as zstring ptr, byval def as XRenderColor ptr) as long
declare function XRenderCreateCursor(byval dpy as Display ptr, byval source as Picture, byval x as ulong, byval y as ulong) as Cursor
declare function XRenderQueryFilters(byval dpy as Display ptr, byval drawable as Drawable) as XFilters ptr
declare sub XRenderSetPictureFilter(byval dpy as Display ptr, byval picture as Picture, byval filter as const zstring ptr, byval params as XFixed ptr, byval nparams as long)
declare function XRenderCreateAnimCursor(byval dpy as Display ptr, byval ncursor as long, byval cursors as XAnimCursor ptr) as Cursor
declare sub XRenderAddTraps(byval dpy as Display ptr, byval picture as Picture, byval xOff as long, byval yOff as long, byval traps as const XTrap ptr, byval ntrap as long)
declare function XRenderCreateSolidFill(byval dpy as Display ptr, byval color as const XRenderColor ptr) as Picture
declare function XRenderCreateLinearGradient(byval dpy as Display ptr, byval gradient as const XLinearGradient ptr, byval stops as const XFixed ptr, byval colors as const XRenderColor ptr, byval nstops as long) as Picture
declare function XRenderCreateRadialGradient(byval dpy as Display ptr, byval gradient as const XRadialGradient ptr, byval stops as const XFixed ptr, byval colors as const XRenderColor ptr, byval nstops as long) as Picture
declare function XRenderCreateConicalGradient(byval dpy as Display ptr, byval gradient as const XConicalGradient ptr, byval stops as const XFixed ptr, byval colors as const XRenderColor ptr, byval nstops as long) as Picture

end extern
