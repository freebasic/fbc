''
''
'' render -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __render_bi__
#define __render_bi__

type Glyph as XID
type GlyphSet as XID
type Picture as XID
type PictFormat as XID

#define RENDER_NAME "RENDER"
#define RENDER_MAJOR 0
#define RENDER_MINOR 10
#define X_RenderQueryVersion 0
#define X_RenderQueryPictFormats 1
#define X_RenderQueryPictIndexValues 2
#define X_RenderQueryDithers 3
#define X_RenderCreatePicture 4
#define X_RenderChangePicture 5
#define X_RenderSetPictureClipRectangles 6
#define X_RenderFreePicture 7
#define X_RenderComposite 8
#define X_RenderScale 9
#define X_RenderTrapezoids 10
#define X_RenderTriangles 11
#define X_RenderTriStrip 12
#define X_RenderTriFan 13
#define X_RenderColorTrapezoids 14
#define X_RenderColorTriangles 15
#define X_RenderCreateGlyphSet 17
#define X_RenderReferenceGlyphSet 18
#define X_RenderFreeGlyphSet 19
#define X_RenderAddGlyphs 20
#define X_RenderAddGlyphsFromPicture 21
#define X_RenderFreeGlyphs 22
#define X_RenderCompositeGlyphs8 23
#define X_RenderCompositeGlyphs16 24
#define X_RenderCompositeGlyphs32 25
#define X_RenderFillRectangles 26
#define X_RenderCreateCursor 27
#define X_RenderSetPictureTransform 28
#define X_RenderQueryFilters 29
#define X_RenderSetPictureFilter 30
#define X_RenderCreateAnimCursor 31
#define X_RenderAddTraps 32
#define X_RenderCreateSolidFill 33
#define X_RenderCreateLinearGradient 34
#define X_RenderCreateRadialGradient 35
#define X_RenderCreateConicalGradient 36
#define RenderNumberRequests (36+1)
#define BadPictFormat 0
#define BadPicture 1
#define BadPictOp 2
#define BadGlyphSet 3
#define BadGlyph 4
#define RenderNumberErrors (4+1)
#define PictTypeIndexed 0
#define PictTypeDirect 1
#define PictOpMinimum 0
#define PictOpClear 0
#define PictOpSrc 1
#define PictOpDst 2
#define PictOpOver 3
#define PictOpOverReverse 4
#define PictOpIn 5
#define PictOpInReverse 6
#define PictOpOut 7
#define PictOpOutReverse 8
#define PictOpAtop 9
#define PictOpAtopReverse 10
#define PictOpXor 11
#define PictOpAdd 12
#define PictOpSaturate 13
#define PictOpMaximum 13
#define PictOpDisjointMinimum &h10
#define PictOpDisjointClear &h10
#define PictOpDisjointSrc &h11
#define PictOpDisjointDst &h12
#define PictOpDisjointOver &h13
#define PictOpDisjointOverReverse &h14
#define PictOpDisjointIn &h15
#define PictOpDisjointInReverse &h16
#define PictOpDisjointOut &h17
#define PictOpDisjointOutReverse &h18
#define PictOpDisjointAtop &h19
#define PictOpDisjointAtopReverse &h1a
#define PictOpDisjointXor &h1b
#define PictOpDisjointMaximum &h1b
#define PictOpConjointMinimum &h20
#define PictOpConjointClear &h20
#define PictOpConjointSrc &h21
#define PictOpConjointDst &h22
#define PictOpConjointOver &h23
#define PictOpConjointOverReverse &h24
#define PictOpConjointIn &h25
#define PictOpConjointInReverse &h26
#define PictOpConjointOut &h27
#define PictOpConjointOutReverse &h28
#define PictOpConjointAtop &h29
#define PictOpConjointAtopReverse &h2a
#define PictOpConjointXor &h2b
#define PictOpConjointMaximum &h2b
#define PolyEdgeSharp 0
#define PolyEdgeSmooth 1
#define PolyModePrecise 0
#define PolyModeImprecise 1
#define CPRepeat (1 shl 0)
#define CPAlphaMap (1 shl 1)
#define CPAlphaXOrigin (1 shl 2)
#define CPAlphaYOrigin (1 shl 3)
#define CPClipXOrigin (1 shl 4)
#define CPClipYOrigin (1 shl 5)
#define CPClipMask (1 shl 6)
#define CPGraphicsExposure (1 shl 7)
#define CPSubwindowMode (1 shl 8)
#define CPPolyEdge (1 shl 9)
#define CPPolyMode (1 shl 10)
#define CPDither (1 shl 11)
#define CPComponentAlpha (1 shl 12)
#define CPLastBit 12
#define FilterNearest "nearest"
#define FilterBilinear "bilinear"
#define FilterConvolution "convolution"
#define FilterFast "fast"
#define FilterGood "good"
#define FilterBest "best"
#define FilterAliasNone -1
#define SubPixelUnknown 0
#define SubPixelHorizontalRGB 1
#define SubPixelHorizontalBGR 2
#define SubPixelVerticalRGB 3
#define SubPixelVerticalBGR 4
#define SubPixelNone 5
#define RepeatNone 0
#define RepeatNormal 1
#define RepeatPad 2
#define RepeatReflect 3

#endif
