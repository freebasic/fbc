'' FreeBASIC binding for renderproto-0.11.1
''
'' based on the C header files:
''   $XFree86: xc/include/extensions/render.h,v 1.10 2002/11/06 22:47:49 keithp Exp $
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

#include once "X11/Xdefs.bi"

'' The following symbols have been renamed:
''     typedef GlyphSet => XGlyphSet

#define _RENDER_H_
type Glyph as XID
type XGlyphSet as XID
type Picture as XID
type PictFormat as XID

#define RENDER_NAME "RENDER"
const RENDER_MAJOR = 0
const RENDER_MINOR = 11
const X_RenderQueryVersion = 0
const X_RenderQueryPictFormats = 1
const X_RenderQueryPictIndexValues = 2
const X_RenderQueryDithers = 3
const X_RenderCreatePicture = 4
const X_RenderChangePicture = 5
const X_RenderSetPictureClipRectangles = 6
const X_RenderFreePicture = 7
const X_RenderComposite = 8
const X_RenderScale = 9
const X_RenderTrapezoids = 10
const X_RenderTriangles = 11
const X_RenderTriStrip = 12
const X_RenderTriFan = 13
const X_RenderColorTrapezoids = 14
const X_RenderColorTriangles = 15
const X_RenderCreateGlyphSet = 17
const X_RenderReferenceGlyphSet = 18
const X_RenderFreeGlyphSet = 19
const X_RenderAddGlyphs = 20
const X_RenderAddGlyphsFromPicture = 21
const X_RenderFreeGlyphs = 22
const X_RenderCompositeGlyphs8 = 23
const X_RenderCompositeGlyphs16 = 24
const X_RenderCompositeGlyphs32 = 25
const X_RenderFillRectangles = 26
const X_RenderCreateCursor = 27
const X_RenderSetPictureTransform = 28
const X_RenderQueryFilters = 29
const X_RenderSetPictureFilter = 30
const X_RenderCreateAnimCursor = 31
const X_RenderAddTraps = 32
const X_RenderCreateSolidFill = 33
const X_RenderCreateLinearGradient = 34
const X_RenderCreateRadialGradient = 35
const X_RenderCreateConicalGradient = 36
const RenderNumberRequests = X_RenderCreateConicalGradient + 1
const BadPictFormat = 0
const BadPicture = 1
const BadPictOp = 2
const BadGlyphSet = 3
const BadGlyph = 4
const RenderNumberErrors = BadGlyph + 1
const PictTypeIndexed = 0
const PictTypeDirect = 1
const PictOpMinimum = 0
const PictOpClear = 0
const PictOpSrc = 1
const PictOpDst = 2
const PictOpOver = 3
const PictOpOverReverse = 4
const PictOpIn = 5
const PictOpInReverse = 6
const PictOpOut = 7
const PictOpOutReverse = 8
const PictOpAtop = 9
const PictOpAtopReverse = 10
const PictOpXor = 11
const PictOpAdd = 12
const PictOpSaturate = 13
const PictOpMaximum = 13
const PictOpDisjointMinimum = &h10
const PictOpDisjointClear = &h10
const PictOpDisjointSrc = &h11
const PictOpDisjointDst = &h12
const PictOpDisjointOver = &h13
const PictOpDisjointOverReverse = &h14
const PictOpDisjointIn = &h15
const PictOpDisjointInReverse = &h16
const PictOpDisjointOut = &h17
const PictOpDisjointOutReverse = &h18
const PictOpDisjointAtop = &h19
const PictOpDisjointAtopReverse = &h1a
const PictOpDisjointXor = &h1b
const PictOpDisjointMaximum = &h1b
const PictOpConjointMinimum = &h20
const PictOpConjointClear = &h20
const PictOpConjointSrc = &h21
const PictOpConjointDst = &h22
const PictOpConjointOver = &h23
const PictOpConjointOverReverse = &h24
const PictOpConjointIn = &h25
const PictOpConjointInReverse = &h26
const PictOpConjointOut = &h27
const PictOpConjointOutReverse = &h28
const PictOpConjointAtop = &h29
const PictOpConjointAtopReverse = &h2a
const PictOpConjointXor = &h2b
const PictOpConjointMaximum = &h2b
const PictOpBlendMinimum = &h30
const PictOpMultiply = &h30
const PictOpScreen = &h31
const PictOpOverlay = &h32
const PictOpDarken = &h33
const PictOpLighten = &h34
const PictOpColorDodge = &h35
const PictOpColorBurn = &h36
const PictOpHardLight = &h37
const PictOpSoftLight = &h38
const PictOpDifference = &h39
const PictOpExclusion = &h3a
const PictOpHSLHue = &h3b
const PictOpHSLSaturation = &h3c
const PictOpHSLColor = &h3d
const PictOpHSLLuminosity = &h3e
const PictOpBlendMaximum = &h3e
const PolyEdgeSharp = 0
const PolyEdgeSmooth = 1
const PolyModePrecise = 0
const PolyModeImprecise = 1
const CPRepeat = 1 shl 0
const CPAlphaMap = 1 shl 1
const CPAlphaXOrigin = 1 shl 2
const CPAlphaYOrigin = 1 shl 3
const CPClipXOrigin = 1 shl 4
const CPClipYOrigin = 1 shl 5
const CPClipMask = 1 shl 6
const CPGraphicsExposure = 1 shl 7
const CPSubwindowMode = 1 shl 8
const CPPolyEdge = 1 shl 9
const CPPolyMode = 1 shl 10
const CPDither = 1 shl 11
const CPComponentAlpha = 1 shl 12
const CPLastBit = 12
#define FilterNearest "nearest"
#define FilterBilinear "bilinear"
#define FilterConvolution "convolution"
#define FilterFast "fast"
#define FilterGood "good"
#define FilterBest "best"
const FilterAliasNone = -1
const SubPixelUnknown = 0
const SubPixelHorizontalRGB = 1
const SubPixelHorizontalBGR = 2
const SubPixelVerticalRGB = 3
const SubPixelVerticalBGR = 4
const SubPixelNone = 5
const RepeatNone = 0
const RepeatNormal = 1
const RepeatPad = 2
const RepeatReflect = 3
