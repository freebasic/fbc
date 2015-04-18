'' FreeBASIC binding for renderproto-0.11.1
''
'' based on the C header files:
''   $XFree86: xc/include/extensions/renderproto.h,v 1.12 2002/09/26 02:56:48 keithp Exp $
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

#include once "X11/Xmd.bi"
#include once "X11/extensions/render.bi"

'' The following symbols have been renamed:
''     struct xIndexValue => xIndexValue_
''     struct xRenderColor => xRenderColor_
''     struct xPointFixed => xPointFixed_
''     struct xLineFixed => xLineFixed_
''     struct xTriangle => xTriangle_
''     struct xTrapezoid => xTrapezoid_
''     struct xGlyphInfo => xGlyphInfo_
''     struct xSpanFix => xSpanFix_
''     struct xTrap => xTrap_

#define _XRENDERP_H_

type xDirectFormat
	red as CARD16
	redMask as CARD16
	green as CARD16
	greenMask as CARD16
	blue as CARD16
	blueMask as CARD16
	alpha as CARD16
	alphaMask as CARD16
end type

const sz_xDirectFormat = 16

type xPictFormInfo
	id as CARD32
	as CARD8 type
	depth as CARD8
	pad1 as CARD16
	direct as xDirectFormat
	colormap as CARD32
end type

const sz_xPictFormInfo = 28

type xPictVisual
	visual as CARD32
	format as CARD32
end type

const sz_xPictVisual = 8

type xPictDepth
	depth as CARD8
	pad1 as CARD8
	nPictVisuals as CARD16
	pad2 as CARD32
end type

const sz_xPictDepth = 8

type xPictScreen
	nDepth as CARD32
	fallback as CARD32
end type

const sz_xPictScreen = 8

type xIndexValue_
	pixel as CARD32
	red as CARD16
	green as CARD16
	blue as CARD16
	alpha as CARD16
end type

const sz_xIndexValue = 12

type xRenderColor_
	red as CARD16
	green as CARD16
	blue as CARD16
	alpha as CARD16
end type

const sz_xRenderColor = 8

type xPointFixed_
	x as INT32
	y as INT32
end type

const sz_xPointFixed = 8

type xLineFixed_
	p1 as xPointFixed_
	p2 as xPointFixed_
end type

const sz_xLineFixed = 16

type xTriangle_
	p1 as xPointFixed_
	p2 as xPointFixed_
	p3 as xPointFixed_
end type

const sz_xTriangle = 24

type xTrapezoid_
	top as INT32
	bottom as INT32
	left as xLineFixed_
	right as xLineFixed_
end type

const sz_xTrapezoid = 40

type xGlyphInfo_
	width as CARD16
	height as CARD16
	x as INT16
	y as INT16
	xOff as INT16
	yOff as INT16
end type

const sz_xGlyphInfo = 12

type xGlyphElt
	len as CARD8
	pad1 as CARD8
	pad2 as CARD16
	deltax as INT16
	deltay as INT16
end type

const sz_xGlyphElt = 8

type xSpanFix_
	l as INT32
	r as INT32
	y as INT32
end type

const sz_xSpanFix = 12

type xTrap_
	top as xSpanFix_
	bot as xSpanFix_
end type

const sz_xTrap = 24

type xRenderQueryVersionReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	majorVersion as CARD32
	minorVersion as CARD32
end type

const sz_xRenderQueryVersionReq = 12

type xRenderQueryVersionReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	majorVersion as CARD32
	minorVersion as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xRenderQueryVersionReply = 32

type xRenderQueryPictFormatsReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
end type

const sz_xRenderQueryPictFormatsReq = 4

type xRenderQueryPictFormatsReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	numFormats as CARD32
	numScreens as CARD32
	numDepths as CARD32
	numVisuals as CARD32
	numSubpixel as CARD32
	pad5 as CARD32
end type

const sz_xRenderQueryPictFormatsReply = 32

type xRenderQueryPictIndexValuesReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	format as CARD32
end type

const sz_xRenderQueryPictIndexValuesReq = 8

type xRenderQueryPictIndexValuesReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	numIndexValues as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xRenderQueryPictIndexValuesReply = 32

type xRenderCreatePictureReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	pid as CARD32
	drawable as CARD32
	format as CARD32
	mask as CARD32
end type

const sz_xRenderCreatePictureReq = 20

type xRenderChangePictureReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	picture as CARD32
	mask as CARD32
end type

const sz_xRenderChangePictureReq = 12

type xRenderSetPictureClipRectanglesReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	picture as CARD32
	xOrigin as INT16
	yOrigin as INT16
end type

const sz_xRenderSetPictureClipRectanglesReq = 12

type xRenderFreePictureReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	picture as CARD32
end type

const sz_xRenderFreePictureReq = 8

type xRenderCompositeReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	op as CARD8
	pad1 as CARD8
	pad2 as CARD16
	src as CARD32
	mask as CARD32
	dst as CARD32
	xSrc as INT16
	ySrc as INT16
	xMask as INT16
	yMask as INT16
	xDst as INT16
	yDst as INT16
	width as CARD16
	height as CARD16
end type

const sz_xRenderCompositeReq = 36

type xRenderScaleReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	src as CARD32
	dst as CARD32
	colorScale as CARD32
	alphaScale as CARD32
	xSrc as INT16
	ySrc as INT16
	xDst as INT16
	yDst as INT16
	width as CARD16
	height as CARD16
end type

const sz_xRenderScaleReq = 32

type xRenderTrapezoidsReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	op as CARD8
	pad1 as CARD8
	pad2 as CARD16
	src as CARD32
	dst as CARD32
	maskFormat as CARD32
	xSrc as INT16
	ySrc as INT16
end type

const sz_xRenderTrapezoidsReq = 24

type xRenderTrianglesReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	op as CARD8
	pad1 as CARD8
	pad2 as CARD16
	src as CARD32
	dst as CARD32
	maskFormat as CARD32
	xSrc as INT16
	ySrc as INT16
end type

const sz_xRenderTrianglesReq = 24

type xRenderTriStripReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	op as CARD8
	pad1 as CARD8
	pad2 as CARD16
	src as CARD32
	dst as CARD32
	maskFormat as CARD32
	xSrc as INT16
	ySrc as INT16
end type

const sz_xRenderTriStripReq = 24

type xRenderTriFanReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	op as CARD8
	pad1 as CARD8
	pad2 as CARD16
	src as CARD32
	dst as CARD32
	maskFormat as CARD32
	xSrc as INT16
	ySrc as INT16
end type

const sz_xRenderTriFanReq = 24

type xRenderCreateGlyphSetReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	gsid as CARD32
	format as CARD32
end type

const sz_xRenderCreateGlyphSetReq = 12

type xRenderReferenceGlyphSetReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	gsid as CARD32
	existing as CARD32
end type

const sz_xRenderReferenceGlyphSetReq = 24

type xRenderFreeGlyphSetReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	glyphset as CARD32
end type

const sz_xRenderFreeGlyphSetReq = 8

type xRenderAddGlyphsReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	glyphset as CARD32
	nglyphs as CARD32
end type

const sz_xRenderAddGlyphsReq = 12

type xRenderFreeGlyphsReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	glyphset as CARD32
end type

const sz_xRenderFreeGlyphsReq = 8

type xRenderCompositeGlyphsReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	op as CARD8
	pad1 as CARD8
	pad2 as CARD16
	src as CARD32
	dst as CARD32
	maskFormat as CARD32
	glyphset as CARD32
	xSrc as INT16
	ySrc as INT16
end type

type xRenderCompositeGlyphs8Req as xRenderCompositeGlyphsReq
type xRenderCompositeGlyphs16Req as xRenderCompositeGlyphsReq
type xRenderCompositeGlyphs32Req as xRenderCompositeGlyphsReq

const sz_xRenderCompositeGlyphs8Req = 28
const sz_xRenderCompositeGlyphs16Req = 28
const sz_xRenderCompositeGlyphs32Req = 28

type xRenderFillRectanglesReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	op as CARD8
	pad1 as CARD8
	pad2 as CARD16
	dst as CARD32
	color as xRenderColor_
end type

const sz_xRenderFillRectanglesReq = 20

type xRenderCreateCursorReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	cid as CARD32
	src as CARD32
	x as CARD16
	y as CARD16
end type

const sz_xRenderCreateCursorReq = 16

type xRenderTransform
	matrix11 as INT32
	matrix12 as INT32
	matrix13 as INT32
	matrix21 as INT32
	matrix22 as INT32
	matrix23 as INT32
	matrix31 as INT32
	matrix32 as INT32
	matrix33 as INT32
end type

const sz_xRenderTransform = 36

type xRenderSetPictureTransformReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	picture as CARD32
	transform as xRenderTransform
end type

const sz_xRenderSetPictureTransformReq = 44

type xRenderQueryFiltersReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	drawable as CARD32
end type

const sz_xRenderQueryFiltersReq = 8

type xRenderQueryFiltersReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	numAliases as CARD32
	numFilters as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xRenderQueryFiltersReply = 32

type xRenderSetPictureFilterReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	picture as CARD32
	nbytes as CARD16
	pad as CARD16
end type

const sz_xRenderSetPictureFilterReq = 12

type xAnimCursorElt
	cursor as CARD32
	delay as CARD32
end type

const sz_xAnimCursorElt = 8

type xRenderCreateAnimCursorReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	cid as CARD32
end type

const sz_xRenderCreateAnimCursorReq = 8

type xRenderAddTrapsReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	picture as CARD32
	xOff as INT16
	yOff as INT16
end type

const sz_xRenderAddTrapsReq = 12

type xRenderCreateSolidFillReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	pid as CARD32
	color as xRenderColor_
end type

const sz_xRenderCreateSolidFillReq = 16

type xRenderCreateLinearGradientReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	pid as CARD32
	p1 as xPointFixed_
	p2 as xPointFixed_
	nStops as CARD32
end type

const sz_xRenderCreateLinearGradientReq = 28

type xRenderCreateRadialGradientReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	pid as CARD32
	inner as xPointFixed_
	outer as xPointFixed_
	inner_radius as INT32
	outer_radius as INT32
	nStops as CARD32
end type

const sz_xRenderCreateRadialGradientReq = 36

type xRenderCreateConicalGradientReq
	reqType as CARD8
	renderReqType as CARD8
	length as CARD16
	pid as CARD32
	center as xPointFixed_
	angle as INT32
	nStops as CARD32
end type

const sz_xRenderCreateConicalGradientReq = 24
