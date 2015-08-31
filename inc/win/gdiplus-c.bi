'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Contributors:
''     Created by Markus Koenig <markus@stber-koenig.de>
''
''   THIS SOFTWARE IS NOT COPYRIGHTED
''
''   This source code is offered for use in the public domain. You may
''   use, modify or distribute it freely.
''
''   This code is distributed in the hope that it will be useful but
''   WITHOUT ANY WARRANTY. ALL WARRANTIES, EXPRESS OR IMPLIED ARE HEREBY
''   DISCLAIMED. This includes but is not limited to warranties of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/stddef.bi"
#include once "crt/math.bi"
#include once "windef.bi"
#include once "wingdi.bi"
#include once "basetyps.bi"
#include once "ddraw.bi"

'' The following symbols have been renamed:
''     struct Size => Size_
''     struct Point => Point_
''     struct PointF => PointF_
''     struct Rect => Rect_

extern "Windows"

#define __GDIPLUS_H
type REAL as single
type INT16 as SHORT
type UINT16 as WORD
#define __GDIPLUS_ENUMS_H

type BrushType as long
enum
	BrushTypeSolidColor = 0
	BrushTypeHatchFill = 1
	BrushTypeTextureFill = 2
	BrushTypePathGradient = 3
	BrushTypeLinearGradient = 4
end enum

type CombineMode as long
enum
	CombineModeReplace = 0
	CombineModeIntersect = 1
	CombineModeUnion = 2
	CombineModeXor = 3
	CombineModeExclude = 4
	CombineModeComplement = 5
end enum

type CompositingMode as long
enum
	CompositingModeSourceOver = 0
	CompositingModeSourceCopy = 1
end enum

type CompositingQuality as long
enum
	CompositingQualityDefault = 0
	CompositingQualityHighSpeed = 1
	CompositingQualityHighQuality = 2
	CompositingQualityGammaCorrected = 3
	CompositingQualityAssumeLinear = 4
end enum

type CoordinateSpace as long
enum
	CoordinateSpaceWorld = 0
	CoordinateSpacePage = 1
	CoordinateSpaceDevice = 2
end enum

type CustomLineCapType as long
enum
	CustomLineCapTypeDefault = 0
	CustomLineCapTypeAdjustableArrow = 1
end enum

type DashCap as long
enum
	DashCapFlat = 0
	DashCapRound = 2
	DashCapTriangle = 3
end enum

type DashStyle as long
enum
	DashStyleSolid = 0
	DashStyleDash = 1
	DashStyleDot = 2
	DashStyleDashDot = 3
	DashStyleDashDotDot = 4
	DashStyleCustom = 5
end enum

type DitherType as long
enum
	DitherTypeNone = 0
	DitherTypeSolid = 1
	DitherTypeOrdered4x4 = 2
	DitherTypeOrdered8x8 = 3
	DitherTypeOrdered16x16 = 4
	DitherTypeOrdered91x91 = 5
	DitherTypeSpiral4x4 = 6
	DitherTypeSpiral8x8 = 7
	DitherTypeDualSpiral4x4 = 8
	DitherTypeDualSpiral8x8 = 9
	DitherTypeErrorDiffusion = 10
end enum

type DriverStringOptions as long
enum
	DriverStringOptionsCmapLookup = 1
	DriverStringOptionsVertical = 2
	DriverStringOptionsRealizedAdvance = 4
	DriverStringOptionsLimitSubpixel = 8
end enum

#define GDIP_WMF_RECORD_TO_EMFPLUS(meta) ((meta) or &h10000)
const GDIP_EMFPLUS_RECORD_BASE = &h4000

type EmfPlusRecordType as long
enum
	WmfRecordTypeSetBkColor = &h0201 or &h10000
	WmfRecordTypeSetBkMode = &h0102 or &h10000
	WmfRecordTypeSetMapMode = &h0103 or &h10000
	WmfRecordTypeSetROP2 = &h0104 or &h10000
	WmfRecordTypeSetRelAbs = &h0105 or &h10000
	WmfRecordTypeSetPolyFillMode = &h0106 or &h10000
	WmfRecordTypeSetStretchBltMode = &h0107 or &h10000
	WmfRecordTypeSetTextCharExtra = &h0108 or &h10000
	WmfRecordTypeSetTextColor = &h0209 or &h10000
	WmfRecordTypeSetTextJustification = &h020A or &h10000
	WmfRecordTypeSetWindowOrg = &h020B or &h10000
	WmfRecordTypeSetWindowExt = &h020C or &h10000
	WmfRecordTypeSetViewportOrg = &h020D or &h10000
	WmfRecordTypeSetViewportExt = &h020E or &h10000
	WmfRecordTypeOffsetWindowOrg = &h020F or &h10000
	WmfRecordTypeScaleWindowExt = &h0410 or &h10000
	WmfRecordTypeOffsetViewportOrg = &h0211 or &h10000
	WmfRecordTypeScaleViewportExt = &h0412 or &h10000
	WmfRecordTypeLineTo = &h0213 or &h10000
	WmfRecordTypeMoveTo = &h0214 or &h10000
	WmfRecordTypeExcludeClipRect = &h0415 or &h10000
	WmfRecordTypeIntersectClipRect = &h0416 or &h10000
	WmfRecordTypeArc = &h0817 or &h10000
	WmfRecordTypeEllipse = &h0418 or &h10000
	WmfRecordTypeFloodFill = &h0419 or &h10000
	WmfRecordTypePie = &h081A or &h10000
	WmfRecordTypeRectangle = &h041B or &h10000
	WmfRecordTypeRoundRect = &h061C or &h10000
	WmfRecordTypePatBlt = &h061D or &h10000
	WmfRecordTypeSaveDC = &h001E or &h10000
	WmfRecordTypeSetPixel = &h041F or &h10000
	WmfRecordTypeOffsetClipRgn = &h0220 or &h10000
	WmfRecordTypeTextOut = &h0521 or &h10000
	WmfRecordTypeBitBlt = &h0922 or &h10000
	WmfRecordTypeStretchBlt = &h0B23 or &h10000
	WmfRecordTypePolygon = &h0324 or &h10000
	WmfRecordTypePolyline = &h0325 or &h10000
	WmfRecordTypeEscape = &h0626 or &h10000
	WmfRecordTypeRestoreDC = &h0127 or &h10000
	WmfRecordTypeFillRegion = &h0228 or &h10000
	WmfRecordTypeFrameRegion = &h0429 or &h10000
	WmfRecordTypeInvertRegion = &h012A or &h10000
	WmfRecordTypePaintRegion = &h012B or &h10000
	WmfRecordTypeSelectClipRegion = &h012C or &h10000
	WmfRecordTypeSelectObject = &h012D or &h10000
	WmfRecordTypeSetTextAlign = &h012E or &h10000
	WmfRecordTypeDrawText = &h062F or &h10000
	WmfRecordTypeChord = &h0830 or &h10000
	WmfRecordTypeSetMapperFlags = &h0231 or &h10000
	WmfRecordTypeExtTextOut = &h0a32 or &h10000
	WmfRecordTypeSetDIBToDev = &h0d33 or &h10000
	WmfRecordTypeSelectPalette = &h0234 or &h10000
	WmfRecordTypeRealizePalette = &h0035 or &h10000
	WmfRecordTypeAnimatePalette = &h0436 or &h10000
	WmfRecordTypeSetPalEntries = &h0037 or &h10000
	WmfRecordTypePolyPolygon = &h0538 or &h10000
	WmfRecordTypeResizePalette = &h0139 or &h10000
	WmfRecordTypeDIBBitBlt = &h0940 or &h10000
	WmfRecordTypeDIBStretchBlt = &h0b41 or &h10000
	WmfRecordTypeDIBCreatePatternBrush = &h0142 or &h10000
	WmfRecordTypeStretchDIB = &h0f43 or &h10000
	WmfRecordTypeExtFloodFill = &h0548 or &h10000
	WmfRecordTypeSetLayout = &h0149 or &h10000
	WmfRecordTypeResetDC = &h014C or &h10000
	WmfRecordTypeStartDoc = &h014D or &h10000
	WmfRecordTypeStartPage = &h004F or &h10000
	WmfRecordTypeEndPage = &h0050 or &h10000
	WmfRecordTypeAbortDoc = &h0052 or &h10000
	WmfRecordTypeEndDoc = &h005E or &h10000
	WmfRecordTypeDeleteObject = &h01f0 or &h10000
	WmfRecordTypeCreatePalette = &h00f7 or &h10000
	WmfRecordTypeCreateBrush = &h00F8 or &h10000
	WmfRecordTypeCreatePatternBrush = &h01F9 or &h10000
	WmfRecordTypeCreatePenIndirect = &h02FA or &h10000
	WmfRecordTypeCreateFontIndirect = &h02FB or &h10000
	WmfRecordTypeCreateBrushIndirect = &h02FC or &h10000
	WmfRecordTypeCreateBitmapIndirect = &h02FD or &h10000
	WmfRecordTypeCreateBitmap = &h06FE or &h10000
	WmfRecordTypeCreateRegion = &h06FF or &h10000
	EmfRecordTypeHeader = 1
	EmfRecordTypePolyBezier = 2
	EmfRecordTypePolygon = 3
	EmfRecordTypePolyline = 4
	EmfRecordTypePolyBezierTo = 5
	EmfRecordTypePolyLineTo = 6
	EmfRecordTypePolyPolyline = 7
	EmfRecordTypePolyPolygon = 8
	EmfRecordTypeSetWindowExtEx = 9
	EmfRecordTypeSetWindowOrgEx = 10
	EmfRecordTypeSetViewportExtEx = 11
	EmfRecordTypeSetViewportOrgEx = 12
	EmfRecordTypeSetBrushOrgEx = 13
	EmfRecordTypeEOF = 14
	EmfRecordTypeSetPixelV = 15
	EmfRecordTypeSetMapperFlags = 16
	EmfRecordTypeSetMapMode = 17
	EmfRecordTypeSetBkMode = 18
	EmfRecordTypeSetPolyFillMode = 19
	EmfRecordTypeSetROP2 = 20
	EmfRecordTypeSetStretchBltMode = 21
	EmfRecordTypeSetTextAlign = 22
	EmfRecordTypeSetColorAdjustment = 23
	EmfRecordTypeSetTextColor = 24
	EmfRecordTypeSetBkColor = 25
	EmfRecordTypeOffsetClipRgn = 26
	EmfRecordTypeMoveToEx = 27
	EmfRecordTypeSetMetaRgn = 28
	EmfRecordTypeExcludeClipRect = 29
	EmfRecordTypeIntersectClipRect = 30
	EmfRecordTypeScaleViewportExtEx = 31
	EmfRecordTypeScaleWindowExtEx = 32
	EmfRecordTypeSaveDC = 33
	EmfRecordTypeRestoreDC = 34
	EmfRecordTypeSetWorldTransform = 35
	EmfRecordTypeModifyWorldTransform = 36
	EmfRecordTypeSelectObject = 37
	EmfRecordTypeCreatePen = 38
	EmfRecordTypeCreateBrushIndirect = 39
	EmfRecordTypeDeleteObject = 40
	EmfRecordTypeAngleArc = 41
	EmfRecordTypeEllipse = 42
	EmfRecordTypeRectangle = 43
	EmfRecordTypeRoundRect = 44
	EmfRecordTypeArc = 45
	EmfRecordTypeChord = 46
	EmfRecordTypePie = 47
	EmfRecordTypeSelectPalette = 48
	EmfRecordTypeCreatePalette = 49
	EmfRecordTypeSetPaletteEntries = 50
	EmfRecordTypeResizePalette = 51
	EmfRecordTypeRealizePalette = 52
	EmfRecordTypeExtFloodFill = 53
	EmfRecordTypeLineTo = 54
	EmfRecordTypeArcTo = 55
	EmfRecordTypePolyDraw = 56
	EmfRecordTypeSetArcDirection = 57
	EmfRecordTypeSetMiterLimit = 58
	EmfRecordTypeBeginPath = 59
	EmfRecordTypeEndPath = 60
	EmfRecordTypeCloseFigure = 61
	EmfRecordTypeFillPath = 62
	EmfRecordTypeStrokeAndFillPath = 63
	EmfRecordTypeStrokePath = 64
	EmfRecordTypeFlattenPath = 65
	EmfRecordTypeWidenPath = 66
	EmfRecordTypeSelectClipPath = 67
	EmfRecordTypeAbortPath = 68
	EmfRecordTypeReserved_069 = 69
	EmfRecordTypeGdiComment = 70
	EmfRecordTypeFillRgn = 71
	EmfRecordTypeFrameRgn = 72
	EmfRecordTypeInvertRgn = 73
	EmfRecordTypePaintRgn = 74
	EmfRecordTypeExtSelectClipRgn = 75
	EmfRecordTypeBitBlt = 76
	EmfRecordTypeStretchBlt = 77
	EmfRecordTypeMaskBlt = 78
	EmfRecordTypePlgBlt = 79
	EmfRecordTypeSetDIBitsToDevice = 80
	EmfRecordTypeStretchDIBits = 81
	EmfRecordTypeExtCreateFontIndirect = 82
	EmfRecordTypeExtTextOutA = 83
	EmfRecordTypeExtTextOutW = 84
	EmfRecordTypePolyBezier16 = 85
	EmfRecordTypePolygon16 = 86
	EmfRecordTypePolyline16 = 87
	EmfRecordTypePolyBezierTo16 = 88
	EmfRecordTypePolylineTo16 = 89
	EmfRecordTypePolyPolyline16 = 90
	EmfRecordTypePolyPolygon16 = 91
	EmfRecordTypePolyDraw16 = 92
	EmfRecordTypeCreateMonoBrush = 93
	EmfRecordTypeCreateDIBPatternBrushPt = 94
	EmfRecordTypeExtCreatePen = 95
	EmfRecordTypePolyTextOutA = 96
	EmfRecordTypePolyTextOutW = 97
	EmfRecordTypeSetICMMode = 98
	EmfRecordTypeCreateColorSpace = 99
	EmfRecordTypeSetColorSpace = 100
	EmfRecordTypeDeleteColorSpace = 101
	EmfRecordTypeGLSRecord = 102
	EmfRecordTypeGLSBoundedRecord = 103
	EmfRecordTypePixelFormat = 104
	EmfRecordTypeDrawEscape = 105
	EmfRecordTypeExtEscape = 106
	EmfRecordTypeStartDoc = 107
	EmfRecordTypeSmallTextOut = 108
	EmfRecordTypeForceUFIMapping = 109
	EmfRecordTypeNamedEscape = 110
	EmfRecordTypeColorCorrectPalette = 111
	EmfRecordTypeSetICMProfileA = 112
	EmfRecordTypeSetICMProfileW = 113
	EmfRecordTypeAlphaBlend = 114
	EmfRecordTypeSetLayout = 115
	EmfRecordTypeTransparentBlt = 116
	EmfRecordTypeReserved_117 = 117
	EmfRecordTypeGradientFill = 118
	EmfRecordTypeSetLinkedUFIs = 119
	EmfRecordTypeSetTextJustification = 120
	EmfRecordTypeColorMatchToTargetW = 121
	EmfRecordTypeCreateColorSpaceW = 122
	EmfRecordTypeMax = 122
	EmfRecordTypeMin = 1
	EmfPlusRecordTypeInvalid = &h4000
	EmfPlusRecordTypeHeader
	EmfPlusRecordTypeEndOfFile
	EmfPlusRecordTypeComment
	EmfPlusRecordTypeGetDC
	EmfPlusRecordTypeMultiFormatStart
	EmfPlusRecordTypeMultiFormatSection
	EmfPlusRecordTypeMultiFormatEnd
	EmfPlusRecordTypeObject
	EmfPlusRecordTypeClear
	EmfPlusRecordTypeFillRects
	EmfPlusRecordTypeDrawRects
	EmfPlusRecordTypeFillPolygon
	EmfPlusRecordTypeDrawLines
	EmfPlusRecordTypeFillEllipse
	EmfPlusRecordTypeDrawEllipse
	EmfPlusRecordTypeFillPie
	EmfPlusRecordTypeDrawPie
	EmfPlusRecordTypeDrawArc
	EmfPlusRecordTypeFillRegion
	EmfPlusRecordTypeFillPath
	EmfPlusRecordTypeDrawPath
	EmfPlusRecordTypeFillClosedCurve
	EmfPlusRecordTypeDrawClosedCurve
	EmfPlusRecordTypeDrawCurve
	EmfPlusRecordTypeDrawBeziers
	EmfPlusRecordTypeDrawImage
	EmfPlusRecordTypeDrawImagePoints
	EmfPlusRecordTypeDrawString
	EmfPlusRecordTypeSetRenderingOrigin
	EmfPlusRecordTypeSetAntiAliasMode
	EmfPlusRecordTypeSetTextRenderingHint
	EmfPlusRecordTypeSetTextContrast
	EmfPlusRecordTypeSetGammaValue
	EmfPlusRecordTypeSetInterpolationMode
	EmfPlusRecordTypeSetPixelOffsetMode
	EmfPlusRecordTypeSetCompositingMode
	EmfPlusRecordTypeSetCompositingQuality
	EmfPlusRecordTypeSave
	EmfPlusRecordTypeRestore
	EmfPlusRecordTypeBeginContainer
	EmfPlusRecordTypeBeginContainerNoParams
	EmfPlusRecordTypeEndContainer
	EmfPlusRecordTypeSetWorldTransform
	EmfPlusRecordTypeResetWorldTransform
	EmfPlusRecordTypeMultiplyWorldTransform
	EmfPlusRecordTypeTranslateWorldTransform
	EmfPlusRecordTypeScaleWorldTransform
	EmfPlusRecordTypeRotateWorldTransform
	EmfPlusRecordTypeSetPageTransform
	EmfPlusRecordTypeResetClip
	EmfPlusRecordTypeSetClipRect
	EmfPlusRecordTypeSetClipPath
	EmfPlusRecordTypeSetClipRegion
	EmfPlusRecordTypeOffsetClip
	EmfPlusRecordTypeDrawDriverString
	EmfPlusRecordTypeStrokeFillPath
	EmfPlusRecordTypeSerializableObject
	EmfPlusRecordTypeSetTSGraphics
	EmfPlusRecordTypeSetTSClip
	EmfPlusRecordTotal
	EmfPlusRecordTypeMax = EmfPlusRecordTotal - 1
	EmfPlusRecordTypeMin = EmfPlusRecordTypeHeader
end enum

type EmfToWmfBitsFlags as long
enum
	EmfToWmfBitsFlagsDefault = 0
	EmfToWmfBitsFlagsEmbedEmf = 1
	EmfToWmfBitsFlagsIncludePlaceable = 2
	EmfToWmfBitsFlagsNoXORClip = 4
end enum

type EmfType as long
enum
	EmfTypeEmfOnly = 3
	EmfTypeEmfPlusOnly = 4
	EmfTypeEmfPlusDual = 5
end enum

type EncoderParameterValueType as long
enum
	EncoderParameterValueTypeByte = 1
	EncoderParameterValueTypeASCII = 2
	EncoderParameterValueTypeShort = 3
	EncoderParameterValueTypeLong = 4
	EncoderParameterValueTypeRational = 5
	EncoderParameterValueTypeLongRange = 6
	EncoderParameterValueTypeUndefined = 7
	EncoderParameterValueTypeRationalRange = 8
	EncoderParameterValueTypePointer = 9
end enum

type EncoderValue as long
enum
	EncoderValueColorTypeCMYK = 0
	EncoderValueColorTypeYCCK = 1
	EncoderValueCompressionLZW = 2
	EncoderValueCompressionCCITT3 = 3
	EncoderValueCompressionCCITT4 = 4
	EncoderValueCompressionRle = 5
	EncoderValueCompressionNone = 6
	EncoderValueScanMethodInterlaced = 7
	EncoderValueScanMethodNonInterlaced = 8
	EncoderValueVersionGif87 = 9
	EncoderValueVersionGif89 = 10
	EncoderValueRenderProgressive = 11
	EncoderValueRenderNonProgressive = 12
	EncoderValueTransformRotate90 = 13
	EncoderValueTransformRotate180 = 14
	EncoderValueTransformRotate270 = 15
	EncoderValueTransformFlipHorizontal = 16
	EncoderValueTransformFlipVertical = 17
	EncoderValueMultiFrame = 18
	EncoderValueLastFrame = 19
	EncoderValueFlush = 20
	EncoderValueFrameDimensionTime = 21
	EncoderValueFrameDimensionResolution = 22
	EncoderValueFrameDimensionPage = 23
end enum

type FillMode as long
enum
	FillModeAlternate = 0
	FillModeWinding = 1
end enum

type FlushIntention as long
enum
	FlushIntentionFlush = 0
	FlushIntentionSync = 1
end enum

type FontStyle as long
enum
	FontStyleRegular = 0
	FontStyleBold = 1
	FontStyleItalic = 2
	FontStyleBoldItalic = 3
	FontStyleUnderline = 4
	FontStyleStrikeout = 8
end enum

type HatchStyle as long
enum
	HatchStyleHorizontal = 0
	HatchStyleVertical = 1
	HatchStyleForwardDiagonal = 2
	HatchStyleBackwardDiagonal = 3
	HatchStyleCross = 4
	HatchStyleLargeGrid = 4
	HatchStyleDiagonalCross = 5
	HatchStyle05Percent = 6
	HatchStyle10Percent = 7
	HatchStyle20Percent = 8
	HatchStyle25Percent = 9
	HatchStyle30Percent = 10
	HatchStyle40Percent = 11
	HatchStyle50Percent = 12
	HatchStyle60Percent = 13
	HatchStyle70Percent = 14
	HatchStyle75Percent = 15
	HatchStyle80Percent = 16
	HatchStyle90Percent = 17
	HatchStyleLightDownwardDiagonal = 18
	HatchStyleLightUpwardDiagonal = 19
	HatchStyleDarkDownwardDiagonal = 20
	HatchStyleDarkUpwardDiagonal = 21
	HatchStyleWideDownwardDiagonal = 22
	HatchStyleWideUpwardDiagonal = 23
	HatchStyleLightVertical = 24
	HatchStyleLightHorizontal = 25
	HatchStyleNarrowVertical = 26
	HatchStyleNarrowHorizontal = 27
	HatchStyleDarkVertical = 28
	HatchStyleDarkHorizontal = 29
	HatchStyleDashedDownwardDiagonal = 30
	HatchStyleDashedUpwardDiagonal = 31
	HatchStyleDashedHorizontal = 32
	HatchStyleDashedVertical = 33
	HatchStyleSmallConfetti = 34
	HatchStyleLargeConfetti = 35
	HatchStyleZigZag = 36
	HatchStyleWave = 37
	HatchStyleDiagonalBrick = 38
	HatchStyleHorizontalBrick = 39
	HatchStyleWeave = 40
	HatchStylePlaid = 41
	HatchStyleDivot = 42
	HatchStyleDottedGrid = 43
	HatchStyleDottedDiamond = 44
	HatchStyleShingle = 45
	HatchStyleTrellis = 46
	HatchStyleSphere = 47
	HatchStyleSmallGrid = 48
	HatchStyleSmallCheckerBoard = 49
	HatchStyleLargeCheckerBoard = 50
	HatchStyleOutlinedDiamond = 51
	HatchStyleSolidDiamond = 52
	HatchStyleTotal = 53
	HatchStyleMin = HatchStyleHorizontal
	HatchStyleMax = HatchStyleTotal - 1
end enum

type HotkeyPrefix as long
enum
	HotkeyPrefixNone = 0
	HotkeyPrefixShow = 1
	HotkeyPrefixHide = 2
end enum

type ImageType as long
enum
	ImageTypeUnknown = 0
	ImageTypeBitmap = 1
	ImageTypeMetafile = 2
end enum

type InterpolationMode as long
enum
	InterpolationModeInvalid = -1
	InterpolationModeDefault = 0
	InterpolationModeLowQuality = 1
	InterpolationModeHighQuality = 2
	InterpolationModeBilinear = 3
	InterpolationModeBicubic = 4
	InterpolationModeNearestNeighbor = 5
	InterpolationModeHighQualityBilinear = 6
	InterpolationModeHighQualityBicubic = 7
end enum

type LinearGradientMode as long
enum
	LinearGradientModeHorizontal = 0
	LinearGradientModeVertical = 1
	LinearGradientModeForwardDiagonal = 2
	LinearGradientModeBackwardDiagonal = 3
end enum

type LineCap as long
enum
	LineCapFlat = 0
	LineCapSquare = 1
	LineCapRound = 2
	LineCapTriangle = 3
	LineCapNoAnchor = 16
	LineCapSquareAnchor = 17
	LineCapRoundAnchor = 18
	LineCapDiamondAnchor = 19
	LineCapArrowAnchor = 20
	LineCapCustom = 255
end enum

type LineJoin as long
enum
	LineJoinMiter = 0
	LineJoinBevel = 1
	LineJoinRound = 2
	LineJoinMiterClipped = 3
end enum

type MatrixOrder as long
enum
	MatrixOrderPrepend = 0
	MatrixOrderAppend = 1
end enum

type MetafileFrameUnit as long
enum
	MetafileFrameUnitPixel = 2
	MetafileFrameUnitPoint = 3
	MetafileFrameUnitInch = 4
	MetafileFrameUnitDocument = 5
	MetafileFrameUnitMillimeter = 6
	MetafileFrameUnitGdi = 7
end enum

type MetafileType as long
enum
	MetafileTypeInvalid = 0
	MetafileTypeWmf = 1
	MetafileTypeWmfPlaceable = 2
	MetafileTypeEmf = 3
	MetafileTypeEmfPlusOnly = 4
	MetafileTypeEmfPlusDual = 5
end enum

type ObjectType as long
enum
	ObjectTypeInvalid = 0
	ObjectTypeBrush = 1
	ObjectTypePen = 2
	ObjectTypePath = 3
	ObjectTypeRegion = 4
	ObjectTypeFont = 5
	ObjectTypeStringFormat = 6
	ObjectTypeImageAttributes = 7
	ObjectTypeCustomLineCap = 8
	ObjectTypeGraphics = 9
	ObjectTypeMin = ObjectTypeBrush
	ObjectTypeMax = ObjectTypeGraphics
end enum

type PathPointType as long
enum
	PathPointTypeStart = &h00
	PathPointTypeLine = &h01
	PathPointTypeBezier = &h03
	PathPointTypeBezier3 = &h03
	PathPointTypePathTypeMask = &h07
	PathPointTypePathDashMode = &h10
	PathPointTypePathMarker = &h20
	PathPointTypeCloseSubpath = &h80
end enum

type PenAlignment as long
enum
	PenAlignmentCenter = 0
	PenAlignmentInset = 1
end enum

type PenType as long
enum
	PenTypeUnknown = -1
	PenTypeSolidColor = 0
	PenTypeHatchFill = 1
	PenTypeTextureFill = 2
	PenTypePathGradient = 3
	PenTypeLinearGradient = 4
end enum

type PixelOffsetMode as long
enum
	PixelOffsetModeInvalid = -1
	PixelOffsetModeDefault = 0
	PixelOffsetModeHighSpeed = 1
	PixelOffsetModeHighQuality = 2
	PixelOffsetModeNone = 3
	PixelOffsetModeHalf = 4
end enum

type QualityMode as long
enum
	QualityModeInvalid = -1
	QualityModeDefault = 0
	QualityModeLow = 1
	QualityModeHigh = 2
end enum

type SmoothingMode as long
enum
	SmoothingModeInvalid = QualityModeInvalid
	SmoothingModeDefault = 0
	SmoothingModeHighSpeed = 1
	SmoothingModeHighQuality = 2
	SmoothingModeNone = 3
	SmoothingModeAntiAlias8x4 = 4
	SmoothingModeAntiAlias = 4
	SmoothingModeAntiAlias8x8 = 5
end enum

type StringAlignment as long
enum
	StringAlignmentNear = 0
	StringAlignmentCenter = 1
	StringAlignmentFar = 2
end enum

type StringDigitSubstitute as long
enum
	StringDigitSubstituteUser = 0
	StringDigitSubstituteNone = 1
	StringDigitSubstituteNational = 2
	StringDigitSubstituteTraditional = 3
end enum

type StringFormatFlags as long
enum
	StringFormatFlagsDirectionRightToLeft = &h00000001
	StringFormatFlagsDirectionVertical = &h00000002
	StringFormatFlagsNoFitBlackBox = &h00000004
	StringFormatFlagsDisplayFormatControl = &h00000020
	StringFormatFlagsNoFontFallback = &h00000400
	StringFormatFlagsMeasureTrailingSpaces = &h00000800
	StringFormatFlagsNoWrap = &h00001000
	StringFormatFlagsLineLimit = &h00002000
	StringFormatFlagsNoClip = &h00004000
end enum

type StringTrimming as long
enum
	StringTrimmingNone = 0
	StringTrimmingCharacter = 1
	StringTrimmingWord = 2
	StringTrimmingEllipsisCharacter = 3
	StringTrimmingEllipsisWord = 4
	StringTrimmingEllipsisPath = 5
end enum

type TextRenderingHint as long
enum
	TextRenderingHintSystemDefault = 0
	TextRenderingHintSingleBitPerPixelGridFit = 1
	TextRenderingHintSingleBitPerPixel = 2
	TextRenderingHintAntiAliasGridFit = 3
	TextRenderingHintAntiAlias = 4
	TextRenderingHintClearTypeGridFit = 5
end enum

type Unit as long
enum
	UnitWorld = 0
	UnitDisplay = 1
	UnitPixel = 2
	UnitPoint = 3
	UnitInch = 4
	UnitDocument = 5
	UnitMillimeter = 6
end enum

type WarpMode as long
enum
	WarpModePerspective = 0
	WarpModeBilinear = 1
end enum

type WrapMode as long
enum
	WrapModeTile = 0
	WrapModeTileFlipX = 1
	WrapModeTileFlipY = 2
	WrapModeTileFlipXY = 3
	WrapModeClamp = 4
end enum

type GpTestControlEnum as long
enum
	TestControlForceBilinear = 0
	TestControlForceNoICM = 1
	TestControlGetBuildNumber = 2
end enum

type GraphicsContainer as DWORD
type GraphicsState as DWORD
const FlatnessDefault = cast(REAL, 0.25f)

private function ObjectTypeIsValid cdecl(byval type_ as ObjectType) as BOOL
	function = -((type_ >= ObjectTypeMin) and (type_ <= ObjectTypeMax))
end function

#define __GDIPLUS_TYPES_H
#define WINGDIPAPI __stdcall

type GpStatus as long
enum
	Ok = 0
	GenericError = 1
	InvalidParameter = 2
	OutOfMemory = 3
	ObjectBusy = 4
	InsufficientBuffer = 5
	NotImplemented = 6
	Win32Error = 7
	WrongState = 8
	Aborted = 9
	FileNotFound = 10
	ValueOverflow = 11
	AccessDenied = 12
	UnknownImageFormat = 13
	FontFamilyNotFound = 14
	FontStyleNotFound = 15
	NotTrueTypeFont = 16
	UnsupportedGdiplusVersion = 17
	GdiplusNotInitialized = 18
	PropertyNotFound = 19
	PropertyNotSupported = 20
	ProfileNotFound = 21
end enum

type Size_
	Width as INT_
	Height as INT_
end type

type SizeF
	Width as REAL
	Height as REAL
end type

type Point_
	X as INT_
	Y as INT_
end type

type PointF_
	X as REAL
	Y as REAL
end type

type Rect_
	X as INT_
	Y as INT_
	Width as INT_
	Height as INT_
end type

type RectF
	X as REAL
	Y as REAL
	Width as REAL
	Height as REAL
end type

type CharacterRange
	First as INT_
	Length as INT_
end type

type PathData
	Count as INT_
	Points as PointF_ ptr
	Types as UBYTE ptr
end type

type DebugEventProc as any ptr
type EnumerateMetafileProc as function(byval as EmfPlusRecordType, byval as UINT, byval as UINT, byval as const UBYTE ptr, byval as any ptr) as BOOL
type DrawImageAbort as any ptr
type GetThumbnailImageAbort as any ptr
#define __GDIPLUS_GPSTUBS_H
type GpPoint as Point_
type GpPointF as PointF_
type GpRect as Rect_
type GpRectF as RectF
type GpSize as Size_
type GpSizeF as SizeF
type GpBrushType as BrushType
type GpCombineMode as CombineMode
type GpCompositingMode as CompositingMode
type GpCompositingQuality as CompositingQuality
type GpCoordinateSpace as CoordinateSpace
type GpCustomLineCapType as CustomLineCapType
type GpDashCap as DashCap
type GpDashStyle as DashStyle
type GpDitherType as DitherType
type GpDriverStringOptions as DriverStringOptions
type GpEmfPlusRecordType as EmfPlusRecordType
type GpEmfToWmfBitsFlags as EmfToWmfBitsFlags
type GpEmfType as EmfType
type GpEncoderParameterValueType as EncoderParameterValueType
type GpEncoderValue as EncoderValue
type GpFillMode as FillMode
type GpFlushIntention as FlushIntention
type GpFontStyle as FontStyle
type GpHatchStyle as HatchStyle
type GpHotkeyPrefix as HotkeyPrefix
type GpImageType as ImageType
type GpInterpolationMode as InterpolationMode
type GpLinearGradientMode as LinearGradientMode
type GpLineCap as LineCap
type GpLineJoin as LineJoin
type GpMatrixOrder as MatrixOrder
type GpMetafileFrameUnit as MetafileFrameUnit
type GpMetafileType as MetafileType
type GpObjectType as ObjectType
type GpPathPointType as PathPointType
type GpPenAlignment as PenAlignment
type GpPenType as PenType
type GpPixelOffsetMode as PixelOffsetMode
type GpQualityMode as QualityMode
type GpSmoothingMode as SmoothingMode
type GpStringAlignment as StringAlignment
type GpStringDigitSubstitute as StringDigitSubstitute
type GpStringFormatFlags as StringFormatFlags
type GpStringTrimming as StringTrimming
type GpTextRenderingHint as TextRenderingHint
type GpUnit as Unit
type GpWarpMode as WarpMode
type GpWrapMode as WrapMode
type CGpEffect as any
type GpAdjustableArrowCap as any
type GpBitmap as any
type GpBrush as any
type GpCachedBitmap as any
type GpCustomLineCap as any
type GpFont as any
type GpFontFamily as any
type GpFontCollection as any
type GpGraphics as any
type GpHatch as any
type GpImage as any
type GpImageAttributes as any
type GpLineGradient as any
type GpMatrix as any
type GpMetafile as any
type GpPath as any
type GpPathData as any
type GpPathGradient as any
type GpPathIterator as any
type GpPen as any
type GpRegion as any
type GpSolidFill as any
type GpStringFormat as any
type GpTexture as any
#define __GDIPLUS_IMAGING_H

type ImageCodecFlags as long
enum
	ImageCodecFlagsEncoder = &h00000001
	ImageCodecFlagsDecoder = &h00000002
	ImageCodecFlagsSupportBitmap = &h00000004
	ImageCodecFlagsSupportVector = &h00000008
	ImageCodecFlagsSeekableEncode = &h00000010
	ImageCodecFlagsBlockingDecode = &h00000020
	ImageCodecFlagsBuiltin = &h00010000
	ImageCodecFlagsSystem = &h00020000
	ImageCodecFlagsUser = &h00040000
end enum

type ImageFlags as long
enum
	ImageFlagsNone = 0
	ImageFlagsScalable = &h00000001
	ImageFlagsHasAlpha = &h00000002
	ImageFlagsHasTranslucent = &h00000004
	ImageFlagsPartiallyScalable = &h00000008
	ImageFlagsColorSpaceRGB = &h00000010
	ImageFlagsColorSpaceCMYK = &h00000020
	ImageFlagsColorSpaceGRAY = &h00000040
	ImageFlagsColorSpaceYCBCR = &h00000080
	ImageFlagsColorSpaceYCCK = &h00000100
	ImageFlagsHasRealDPI = &h00001000
	ImageFlagsHasRealPixelSize = &h00002000
	ImageFlagsReadOnly = &h00010000
	ImageFlagsCaching = &h00020000
end enum

type ImageLockMode as long
enum
	ImageLockModeRead = 1
	ImageLockModeWrite = 2
	ImageLockModeUserInputBuf = 4
end enum

type ItemDataPosition as long
enum
	ItemDataPositionAfterHeader = 0
	ItemDataPositionAfterPalette = 1
	ItemDataPositionAfterBits = 2
end enum

type RotateFlipType as long
enum
	RotateNoneFlipNone = 0
	Rotate90FlipNone = 1
	Rotate180FlipNone = 2
	Rotate270FlipNone = 3
	RotateNoneFlipX = 4
	Rotate90FlipX = 5
	Rotate180FlipX = 6
	Rotate270FlipX = 7
	Rotate180FlipXY = 0
	Rotate270FlipXY = 1
	RotateNoneFlipXY = 2
	Rotate90FlipXY = 3
	Rotate180FlipY = 4
	Rotate270FlipY = 5
	RotateNoneFlipY = 6
	Rotate90FlipY = 7
end enum

type BitmapData
	Width as UINT
	Height as UINT
	Stride as INT_
	PixelFormat as INT_
	Scan0 as any ptr
	Reserved as UINT_PTR
end type

type EncoderParameter
	Guid as GUID
	NumberOfValues as ULONG
	as ULONG Type
	Value as any ptr
end type

type EncoderParameters
	Count as UINT
	Parameter(0 to 0) as EncoderParameter
end type

type ImageCodecInfo
	Clsid as CLSID
	FormatID as GUID
	CodecName as wstring ptr
	DllName as wstring ptr
	FormatDescription as wstring ptr
	FilenameExtension as wstring ptr
	MimeType as wstring ptr
	Flags as DWORD
	Version as DWORD
	SigCount as DWORD
	SigSize as DWORD
	SigPattern as UBYTE ptr
	SigMask as UBYTE ptr
end type

type ImageItemData
	Size as UINT
	Position as UINT
	Desc as any ptr
	DescSize as UINT
	Data as UINT ptr
	DataSize as UINT
	Cookie as UINT
end type

type PropertyItem
	id as PROPID
	length as ULONG
	as WORD type
	value as any ptr
end type

const PropertyTagGpsVer = cast(PROPID, &h0000)
const PropertyTagGpsLatitudeRef = cast(PROPID, &h0001)
const PropertyTagGpsLatitude = cast(PROPID, &h0002)
const PropertyTagGpsLongitudeRef = cast(PROPID, &h0003)
const PropertyTagGpsLongitude = cast(PROPID, &h0004)
const PropertyTagGpsAltitudeRef = cast(PROPID, &h0005)
const PropertyTagGpsAltitude = cast(PROPID, &h0006)
const PropertyTagGpsGpsTime = cast(PROPID, &h0007)
const PropertyTagGpsGpsSatellites = cast(PROPID, &h0008)
const PropertyTagGpsGpsStatus = cast(PROPID, &h0009)
const PropertyTagGpsGpsMeasureMode = cast(PROPID, &h000A)
const PropertyTagGpsGpsDop = cast(PROPID, &h000B)
const PropertyTagGpsSpeedRef = cast(PROPID, &h000C)
const PropertyTagGpsSpeed = cast(PROPID, &h000D)
const PropertyTagGpsTrackRef = cast(PROPID, &h000E)
const PropertyTagGpsTrack = cast(PROPID, &h000F)
const PropertyTagGpsImgDirRef = cast(PROPID, &h0010)
const PropertyTagGpsImgDir = cast(PROPID, &h0011)
const PropertyTagGpsMapDatum = cast(PROPID, &h0012)
const PropertyTagGpsDestLatRef = cast(PROPID, &h0013)
const PropertyTagGpsDestLat = cast(PROPID, &h0014)
const PropertyTagGpsDestLongRef = cast(PROPID, &h0015)
const PropertyTagGpsDestLong = cast(PROPID, &h0016)
const PropertyTagGpsDestBearRef = cast(PROPID, &h0017)
const PropertyTagGpsDestBear = cast(PROPID, &h0018)
const PropertyTagGpsDestDistRef = cast(PROPID, &h0019)
const PropertyTagGpsDestDist = cast(PROPID, &h001A)
const PropertyTagNewSubfileType = cast(PROPID, &h00FE)
const PropertyTagSubfileType = cast(PROPID, &h00FF)
const PropertyTagImageWidth = cast(PROPID, &h0100)
const PropertyTagImageHeight = cast(PROPID, &h0101)
const PropertyTagBitsPerSample = cast(PROPID, &h0102)
const PropertyTagCompression = cast(PROPID, &h0103)
const PropertyTagPhotometricInterp = cast(PROPID, &h0106)
const PropertyTagThreshHolding = cast(PROPID, &h0107)
const PropertyTagCellWidth = cast(PROPID, &h0108)
const PropertyTagCellHeight = cast(PROPID, &h0109)
const PropertyTagFillOrder = cast(PROPID, &h010A)
const PropertyTagDocumentName = cast(PROPID, &h010D)
const PropertyTagImageDescription = cast(PROPID, &h010E)
const PropertyTagEquipMake = cast(PROPID, &h010F)
const PropertyTagEquipModel = cast(PROPID, &h0110)
const PropertyTagStripOffsets = cast(PROPID, &h0111)
const PropertyTagOrientation = cast(PROPID, &h0112)
const PropertyTagSamplesPerPixel = cast(PROPID, &h0115)
const PropertyTagRowsPerStrip = cast(PROPID, &h0116)
const PropertyTagStripBytesCount = cast(PROPID, &h0117)
const PropertyTagMinSampleValue = cast(PROPID, &h0118)
const PropertyTagMaxSampleValue = cast(PROPID, &h0119)
const PropertyTagXResolution = cast(PROPID, &h011A)
const PropertyTagYResolution = cast(PROPID, &h011B)
const PropertyTagPlanarConfig = cast(PROPID, &h011C)
const PropertyTagPageName = cast(PROPID, &h011D)
const PropertyTagXPosition = cast(PROPID, &h011E)
const PropertyTagYPosition = cast(PROPID, &h011F)
const PropertyTagFreeOffset = cast(PROPID, &h0120)
const PropertyTagFreeByteCounts = cast(PROPID, &h0121)
const PropertyTagGrayResponseUnit = cast(PROPID, &h0122)
const PropertyTagGrayResponseCurve = cast(PROPID, &h0123)
const PropertyTagT4Option = cast(PROPID, &h0124)
const PropertyTagT6Option = cast(PROPID, &h0125)
const PropertyTagResolutionUnit = cast(PROPID, &h0128)
const PropertyTagPageNumber = cast(PROPID, &h0129)
const PropertyTagTransferFunction = cast(PROPID, &h012D)
const PropertyTagSoftwareUsed = cast(PROPID, &h0131)
const PropertyTagDateTime = cast(PROPID, &h0132)
const PropertyTagArtist = cast(PROPID, &h013B)
const PropertyTagHostComputer = cast(PROPID, &h013C)
const PropertyTagPredictor = cast(PROPID, &h013D)
const PropertyTagWhitePoint = cast(PROPID, &h013E)
const PropertyTagPrimaryChromaticities = cast(PROPID, &h013F)
const PropertyTagColorMap = cast(PROPID, &h0140)
const PropertyTagHalftoneHints = cast(PROPID, &h0141)
const PropertyTagTileWidth = cast(PROPID, &h0142)
const PropertyTagTileLength = cast(PROPID, &h0143)
const PropertyTagTileOffset = cast(PROPID, &h0144)
const PropertyTagTileByteCounts = cast(PROPID, &h0145)
const PropertyTagInkSet = cast(PROPID, &h014C)
const PropertyTagInkNames = cast(PROPID, &h014D)
const PropertyTagNumberOfInks = cast(PROPID, &h014E)
const PropertyTagDotRange = cast(PROPID, &h0150)
const PropertyTagTargetPrinter = cast(PROPID, &h0151)
const PropertyTagExtraSamples = cast(PROPID, &h0152)
const PropertyTagSampleFormat = cast(PROPID, &h0153)
const PropertyTagSMinSampleValue = cast(PROPID, &h0154)
const PropertyTagSMaxSampleValue = cast(PROPID, &h0155)
const PropertyTagTransferRange = cast(PROPID, &h0156)
const PropertyTagJPEGProc = cast(PROPID, &h0200)
const PropertyTagJPEGInterFormat = cast(PROPID, &h0201)
const PropertyTagJPEGInterLength = cast(PROPID, &h0202)
const PropertyTagJPEGRestartInterval = cast(PROPID, &h0203)
const PropertyTagJPEGLosslessPredictors = cast(PROPID, &h0205)
const PropertyTagJPEGPointTransforms = cast(PROPID, &h0206)
const PropertyTagJPEGQTables = cast(PROPID, &h0207)
const PropertyTagJPEGDCTables = cast(PROPID, &h0208)
const PropertyTagJPEGACTables = cast(PROPID, &h0209)
const PropertyTagYCbCrCoefficients = cast(PROPID, &h0211)
const PropertyTagYCbCrSubsampling = cast(PROPID, &h0212)
const PropertyTagYCbCrPositioning = cast(PROPID, &h0213)
const PropertyTagREFBlackWhite = cast(PROPID, &h0214)
const PropertyTagGamma = cast(PROPID, &h0301)
const PropertyTagICCProfileDescriptor = cast(PROPID, &h0302)
const PropertyTagSRGBRenderingIntent = cast(PROPID, &h0303)
const PropertyTagImageTitle = cast(PROPID, &h0320)
const PropertyTagResolutionXUnit = cast(PROPID, &h5001)
const PropertyTagResolutionYUnit = cast(PROPID, &h5002)
const PropertyTagResolutionXLengthUnit = cast(PROPID, &h5003)
const PropertyTagResolutionYLengthUnit = cast(PROPID, &h5004)
const PropertyTagPrintFlags = cast(PROPID, &h5005)
const PropertyTagPrintFlagsVersion = cast(PROPID, &h5006)
const PropertyTagPrintFlagsCrop = cast(PROPID, &h5007)
const PropertyTagPrintFlagsBleedWidth = cast(PROPID, &h5008)
const PropertyTagPrintFlagsBleedWidthScale = cast(PROPID, &h5009)
const PropertyTagHalftoneLPI = cast(PROPID, &h500A)
const PropertyTagHalftoneLPIUnit = cast(PROPID, &h500B)
const PropertyTagHalftoneDegree = cast(PROPID, &h500C)
const PropertyTagHalftoneShape = cast(PROPID, &h500D)
const PropertyTagHalftoneMisc = cast(PROPID, &h500E)
const PropertyTagHalftoneScreen = cast(PROPID, &h500F)
const PropertyTagJPEGQuality = cast(PROPID, &h5010)
const PropertyTagGridSize = cast(PROPID, &h5011)
const PropertyTagThumbnailFormat = cast(PROPID, &h5012)
const PropertyTagThumbnailWidth = cast(PROPID, &h5013)
const PropertyTagThumbnailHeight = cast(PROPID, &h5014)
const PropertyTagThumbnailColorDepth = cast(PROPID, &h5015)
const PropertyTagThumbnailPlanes = cast(PROPID, &h5016)
const PropertyTagThumbnailRawBytes = cast(PROPID, &h5017)
const PropertyTagThumbnailSize = cast(PROPID, &h5018)
const PropertyTagThumbnailCompressedSize = cast(PROPID, &h5019)
const PropertyTagColorTransferFunction = cast(PROPID, &h501A)
const PropertyTagThumbnailData = cast(PROPID, &h501B)
const PropertyTagThumbnailImageWidth = cast(PROPID, &h5020)
const PropertyTagThumbnailImageHeight = cast(PROPID, &h5021)
const PropertyTagThumbnailBitsPerSample = cast(PROPID, &h5022)
const PropertyTagThumbnailCompression = cast(PROPID, &h5023)
const PropertyTagThumbnailPhotometricInterp = cast(PROPID, &h5024)
const PropertyTagThumbnailImageDescription = cast(PROPID, &h5025)
const PropertyTagThumbnailEquipMake = cast(PROPID, &h5026)
const PropertyTagThumbnailEquipModel = cast(PROPID, &h5027)
const PropertyTagThumbnailStripOffsets = cast(PROPID, &h5028)
const PropertyTagThumbnailOrientation = cast(PROPID, &h5029)
const PropertyTagThumbnailSamplesPerPixel = cast(PROPID, &h502A)
const PropertyTagThumbnailRowsPerStrip = cast(PROPID, &h502B)
const PropertyTagThumbnailStripBytesCount = cast(PROPID, &h502C)
const PropertyTagThumbnailResolutionX = cast(PROPID, &h502D)
const PropertyTagThumbnailResolutionY = cast(PROPID, &h502E)
const PropertyTagThumbnailPlanarConfig = cast(PROPID, &h502F)
const PropertyTagThumbnailResolutionUnit = cast(PROPID, &h5030)
const PropertyTagThumbnailTransferFunction = cast(PROPID, &h5031)
const PropertyTagThumbnailSoftwareUsed = cast(PROPID, &h5032)
const PropertyTagThumbnailDateTime = cast(PROPID, &h5033)
const PropertyTagThumbnailArtist = cast(PROPID, &h5034)
const PropertyTagThumbnailWhitePoint = cast(PROPID, &h5035)
const PropertyTagThumbnailPrimaryChromaticities = cast(PROPID, &h5036)
const PropertyTagThumbnailYCbCrCoefficients = cast(PROPID, &h5037)
const PropertyTagThumbnailYCbCrSubsampling = cast(PROPID, &h5038)
const PropertyTagThumbnailYCbCrPositioning = cast(PROPID, &h5039)
const PropertyTagThumbnailRefBlackWhite = cast(PROPID, &h503A)
const PropertyTagThumbnailCopyRight = cast(PROPID, &h503B)
const PropertyTagLuminanceTable = cast(PROPID, &h5090)
const PropertyTagChrominanceTable = cast(PROPID, &h5091)
const PropertyTagFrameDelay = cast(PROPID, &h5100)
const PropertyTagLoopCount = cast(PROPID, &h5101)
const PropertyTagGlobalPalette = cast(PROPID, &h5102)
const PropertyTagIndexBackground = cast(PROPID, &h5103)
const PropertyTagIndexTransparent = cast(PROPID, &h5104)
const PropertyTagPixelUnit = cast(PROPID, &h5110)
const PropertyTagPixelPerUnitX = cast(PROPID, &h5111)
const PropertyTagPixelPerUnitY = cast(PROPID, &h5112)
const PropertyTagPaletteHistogram = cast(PROPID, &h5113)
const PropertyTagCopyright = cast(PROPID, &h8298)
const PropertyTagExifExposureTime = cast(PROPID, &h829A)
const PropertyTagExifFNumber = cast(PROPID, &h829D)
const PropertyTagExifIFD = cast(PROPID, &h8769)
const PropertyTagICCProfile = cast(PROPID, &h8773)
const PropertyTagExifExposureProg = cast(PROPID, &h8822)
const PropertyTagExifSpectralSense = cast(PROPID, &h8824)
const PropertyTagGpsIFD = cast(PROPID, &h8825)
const PropertyTagExifISOSpeed = cast(PROPID, &h8827)
const PropertyTagExifOECF = cast(PROPID, &h8828)
const PropertyTagExifVer = cast(PROPID, &h9000)
const PropertyTagExifDTOrig = cast(PROPID, &h9003)
const PropertyTagExifDTDigitized = cast(PROPID, &h9004)
const PropertyTagExifCompConfig = cast(PROPID, &h9101)
const PropertyTagExifCompBPP = cast(PROPID, &h9102)
const PropertyTagExifShutterSpeed = cast(PROPID, &h9201)
const PropertyTagExifAperture = cast(PROPID, &h9202)
const PropertyTagExifBrightness = cast(PROPID, &h9203)
const PropertyTagExifExposureBias = cast(PROPID, &h9204)
const PropertyTagExifMaxAperture = cast(PROPID, &h9205)
const PropertyTagExifSubjectDist = cast(PROPID, &h9206)
const PropertyTagExifMeteringMode = cast(PROPID, &h9207)
const PropertyTagExifLightSource = cast(PROPID, &h9208)
const PropertyTagExifFlash = cast(PROPID, &h9209)
const PropertyTagExifFocalLength = cast(PROPID, &h920A)
const PropertyTagExifMakerNote = cast(PROPID, &h927C)
const PropertyTagExifUserComment = cast(PROPID, &h9286)
const PropertyTagExifDTSubsec = cast(PROPID, &h9290)
const PropertyTagExifDTOrigSS = cast(PROPID, &h9291)
const PropertyTagExifDTDigSS = cast(PROPID, &h9292)
const PropertyTagExifFPXVer = cast(PROPID, &hA000)
const PropertyTagExifColorSpace = cast(PROPID, &hA001)
const PropertyTagExifPixXDim = cast(PROPID, &hA002)
const PropertyTagExifPixYDim = cast(PROPID, &hA003)
const PropertyTagExifRelatedWav = cast(PROPID, &hA004)
const PropertyTagExifInterop = cast(PROPID, &hA005)
const PropertyTagExifFlashEnergy = cast(PROPID, &hA20B)
const PropertyTagExifSpatialFR = cast(PROPID, &hA20C)
const PropertyTagExifFocalXRes = cast(PROPID, &hA20E)
const PropertyTagExifFocalYRes = cast(PROPID, &hA20F)
const PropertyTagExifFocalResUnit = cast(PROPID, &hA210)
const PropertyTagExifSubjectLoc = cast(PROPID, &hA214)
const PropertyTagExifExposureIndex = cast(PROPID, &hA215)
const PropertyTagExifSensingMethod = cast(PROPID, &hA217)
const PropertyTagExifFileSource = cast(PROPID, &hA300)
const PropertyTagExifSceneType = cast(PROPID, &hA301)
const PropertyTagExifCfaPattern = cast(PROPID, &hA302)
const PropertyTagTypeByte = cast(WORD, 1)
const PropertyTagTypeASCII = cast(WORD, 2)
const PropertyTagTypeShort = cast(WORD, 3)
const PropertyTagTypeLong = cast(WORD, 4)
const PropertyTagTypeRational = cast(WORD, 5)
const PropertyTagTypeUndefined = cast(WORD, 7)
const PropertyTagTypeSLONG = cast(WORD, 9)
const PropertyTagTypeSRational = cast(WORD, 10)

extern EncoderChrominanceTable as const GUID
extern EncoderColorDepth as const GUID
extern EncoderColorSpace as const GUID
extern EncoderCompression as const GUID
extern EncoderImageItems as const GUID
extern EncoderLuminanceTable as const GUID
extern EncoderQuality as const GUID
extern EncoderRenderMethod as const GUID
extern EncoderSaveAsCMYK as const GUID
extern EncoderSaveFlag as const GUID
extern EncoderScanMethod as const GUID
extern EncoderTransformation as const GUID
extern EncoderVersion as const GUID
extern ImageFormatBMP as const GUID
extern ImageFormatEMF as const GUID
extern ImageFormatEXIF as const GUID
extern ImageFormatGIF as const GUID
extern ImageFormatIcon as const GUID
extern ImageFormatJPEG as const GUID
extern ImageFormatMemoryBMP as const GUID
extern ImageFormatPNG as const GUID
extern ImageFormatTIFF as const GUID
extern ImageFormatUndefined as const GUID
extern ImageFormatWMF as const GUID
extern FrameDimensionPage as const GUID
extern FrameDimensionResolution as const GUID
extern FrameDimensionTime as const GUID
#define __GDIPLUS_INIT_H

type GdiplusStartupInput
	GdiplusVersion as UINT32
	DebugEventCallback as DebugEventProc
	SuppressBackgroundThread as BOOL
	SuppressExternalCodecs as BOOL
end type

type NotificationHookProc as function(byval token as ULONG_PTR ptr) as GpStatus
type NotificationUnhookProc as sub(byval token as ULONG_PTR)

type GdiplusStartupOutput
	NotificationHook as NotificationHookProc
	NotificationUnhook as NotificationUnhookProc
end type

declare function GdiplusStartup(byval as ULONG_PTR ptr, byval as const GdiplusStartupInput ptr, byval as GdiplusStartupOutput ptr) as GpStatus
declare sub GdiplusShutdown(byval as ULONG_PTR)
declare function GdiplusNotificationHook(byval as ULONG_PTR ptr) as GpStatus
declare sub GdiplusNotificationUnhook(byval as ULONG_PTR)
#define __GDIPLUS_MEM_H
declare function GdipAlloc(byval as uinteger) as any ptr
declare sub GdipFree(byval as any ptr)
#define __GDIPLUS_METAHEADER_H
const GDIP_EMFPLUSFLAGS_DISPLAY = cast(UINT, 1)

type tagENHMETAHEADER3
	iType as DWORD
	nSize as DWORD
	rclBounds as RECTL
	rclFrame as RECTL
	dSignature as DWORD
	nVersion as DWORD
	nBytes as DWORD
	nRecords as DWORD
	nHandles as WORD
	sReserved as WORD
	nDescription as DWORD
	offDescription as DWORD
	nPalEntries as DWORD
	szlDevice as SIZEL
	szlMillimeters as SIZEL
end type

type ENHMETAHEADER3 as tagENHMETAHEADER3
type LPENHMETAHEADER3 as tagENHMETAHEADER3 ptr

type PWMFRect16
	Left as INT16
	Top as INT16
	Right as INT16
	Bottom as INT16
end type

type WmfPlaceableFileHeader
	Key as UINT32
	Hmf as INT16
	BoundingBox as PWMFRect16
	Inch as INT16
	Reserved as UINT32
	Checksum as INT16
end type

type MetafileHeader
	as MetafileType Type
	Size as UINT
	Version as UINT
	EmfPlusFlags as UINT
	DpiX as REAL
	DpiY as REAL
	X as INT_
	Y as INT_
	Width as INT_
	Height as INT_

	union
		WmfHeader as METAHEADER
		EmfHeader as ENHMETAHEADER3
	end union

	EmfPlusHeaderSize as INT_
	LogicalDpiX as INT_
	LogicalDpiY as INT_
end type

#define __GDIPLUS_PIXELFORMATS_H
type ARGB as DWORD
type PixelFormat as INT_
#define PixelFormatIndexed cast(INT_, &h00010000)
#define PixelFormatGDI cast(INT_, &h00020000)
#define PixelFormatAlpha cast(INT_, &h00040000)
#define PixelFormatPAlpha cast(INT_, &h00080000)
#define PixelFormatExtended cast(INT_, &h00100000)
#define PixelFormatCanonical cast(INT_, &h00200000)
#define PixelFormatUndefined cast(INT_, 0)
#define PixelFormatDontCare cast(INT_, 0)
#define PixelFormat1bppIndexed cast(INT_, ((1 or (1 shl 8)) or PixelFormatIndexed) or PixelFormatGDI)
#define PixelFormat4bppIndexed cast(INT_, ((2 or (4 shl 8)) or PixelFormatIndexed) or PixelFormatGDI)
#define PixelFormat8bppIndexed cast(INT_, ((3 or (8 shl 8)) or PixelFormatIndexed) or PixelFormatGDI)
#define PixelFormat16bppGrayScale cast(INT_, (4 or (16 shl 8)) or PixelFormatExtended)
#define PixelFormat16bppRGB555 cast(INT_, (5 or (16 shl 8)) or PixelFormatGDI)
#define PixelFormat16bppRGB565 cast(INT_, (6 or (16 shl 8)) or PixelFormatGDI)
#define PixelFormat16bppARGB1555 cast(INT_, ((7 or (16 shl 8)) or PixelFormatAlpha) or PixelFormatGDI)
#define PixelFormat24bppRGB cast(INT_, (8 or (24 shl 8)) or PixelFormatGDI)
#define PixelFormat32bppRGB cast(INT_, (9 or (32 shl 8)) or PixelFormatGDI)
#define PixelFormat32bppARGB cast(INT_, (((10 or (32 shl 8)) or PixelFormatAlpha) or PixelFormatGDI) or PixelFormatCanonical)
#define PixelFormat32bppPARGB cast(INT_, (((11 or (32 shl 8)) or PixelFormatAlpha) or PixelFormatPAlpha) or PixelFormatGDI)
#define PixelFormat48bppRGB cast(INT_, (12 or (48 shl 8)) or PixelFormatExtended)
#define PixelFormat64bppARGB cast(INT_, (((13 or (64 shl 8)) or PixelFormatAlpha) or PixelFormatCanonical) or PixelFormatExtended)
#define PixelFormat64bppPARGB cast(INT_, (((14 or (64 shl 8)) or PixelFormatAlpha) or PixelFormatPAlpha) or PixelFormatExtended)
#define PixelFormatMax cast(INT_, 15)

type PaletteFlags as long
enum
	PaletteFlagsHasAlpha = 1
	PaletteFlagsGrayScale = 2
	PaletteFlagsHalftone = 4
end enum

type PaletteType as long
enum
	PaletteTypeCustom = 0
	PaletteTypeOptimal = 1
	PaletteTypeFixedBW = 2
	PaletteTypeFixedHalftone8 = 3
	PaletteTypeFixedHalftone27 = 4
	PaletteTypeFixedHalftone64 = 5
	PaletteTypeFixedHalftone125 = 6
	PaletteTypeFixedHalftone216 = 7
	PaletteTypeFixedHalftone252 = 8
	PaletteTypeFixedHalftone256 = 9
end enum

type ColorPalette
	Flags as UINT
	Count as UINT
	Entries(0 to 0) as ARGB
end type

#define GetPixelFormatSize(pixfmt) cast(UINT, (cast(UINT, (pixfmt)) and &hff00u) shr 8)
#define IsAlphaPixelFormat(pixfmt) cast(BOOL, -(((pixfmt) and cast(INT_, &h00040000)) <> 0))
#define IsCanonicalPixelFormat(pixfmt) cast(BOOL, -(((pixfmt) and cast(INT_, &h00200000)) <> 0))
#define IsExtendedPixelFormat(pixfmt) cast(BOOL, -(((pixfmt) and cast(INT_, &h00100000)) <> 0))
#define IsIndexedPixelFormat(pixfmt) cast(BOOL, -(((pixfmt) and cast(INT_, &h00010000)) <> 0))
#define __GDIPLUS_COLOR_H

type ColorChannelFlags as long
enum
	ColorChannelFlagsC = 0
	ColorChannelFlagsM = 1
	ColorChannelFlagsY = 2
	ColorChannelFlagsK = 3
	ColorChannelFlagsLast = 4
end enum

type Color
	Value as ARGB
end type

#define __GDIPLUS_COLORMATRIX_H

type ColorAdjustType as long
enum
	ColorAdjustTypeDefault = 0
	ColorAdjustTypeBitmap = 1
	ColorAdjustTypeBrush = 2
	ColorAdjustTypePen = 3
	ColorAdjustTypeText = 4
	ColorAdjustTypeCount = 5
	ColorAdjustTypeAny = 6
end enum

type ColorMatrixFlags as long
enum
	ColorMatrixFlagsDefault = 0
	ColorMatrixFlagsSkipGrays = 1
	ColorMatrixFlagsAltGray = 2
end enum

type HistogramFormat as long
enum
	HistogramFormatARGB = 0
	HistogramFormatPARGB = 1
	HistogramFormatRGB = 2
	HistogramFormatGray = 3
	HistogramFormatB = 4
	HistogramFormatG = 5
	HistogramFormatR = 6
	HistogramFormatA = 7
end enum

type ColorMap_
	oldColor as Color
	newColor as Color
end type

type ColorMatrix
	m(0 to 4, 0 to 4) as REAL
end type

#define __GDIPLUS_FLAT_H
declare function GdipCreateAdjustableArrowCap(byval as REAL, byval as REAL, byval as BOOL, byval as GpAdjustableArrowCap ptr ptr) as GpStatus
declare function GdipSetAdjustableArrowCapHeight(byval as GpAdjustableArrowCap ptr, byval as REAL) as GpStatus
declare function GdipGetAdjustableArrowCapHeight(byval as GpAdjustableArrowCap ptr, byval as REAL ptr) as GpStatus
declare function GdipSetAdjustableArrowCapWidth(byval as GpAdjustableArrowCap ptr, byval as REAL) as GpStatus
declare function GdipGetAdjustableArrowCapWidth(byval as GpAdjustableArrowCap ptr, byval as REAL ptr) as GpStatus
declare function GdipSetAdjustableArrowCapMiddleInset(byval as GpAdjustableArrowCap ptr, byval as REAL) as GpStatus
declare function GdipGetAdjustableArrowCapMiddleInset(byval as GpAdjustableArrowCap ptr, byval as REAL ptr) as GpStatus
declare function GdipSetAdjustableArrowCapFillState(byval as GpAdjustableArrowCap ptr, byval as BOOL) as GpStatus
declare function GdipGetAdjustableArrowCapFillState(byval as GpAdjustableArrowCap ptr, byval as BOOL ptr) as GpStatus
declare function GdipCreateBitmapFromStream(byval as IStream ptr, byval as GpBitmap ptr ptr) as GpStatus
declare function GdipCreateBitmapFromFile(byval as const wstring ptr, byval as GpBitmap ptr ptr) as GpStatus
declare function GdipCreateBitmapFromStreamICM(byval as IStream ptr, byval as GpBitmap ptr ptr) as GpStatus
declare function GdipCreateBitmapFromFileICM(byval as const wstring ptr, byval as GpBitmap ptr ptr) as GpStatus
declare function GdipCreateBitmapFromScan0(byval as INT_, byval as INT_, byval as INT_, byval as PixelFormat, byval as UBYTE ptr, byval as GpBitmap ptr ptr) as GpStatus
declare function GdipCreateBitmapFromGraphics(byval as INT_, byval as INT_, byval as GpGraphics ptr, byval as GpBitmap ptr ptr) as GpStatus
declare function GdipCreateBitmapFromDirectDrawSurface(byval as IDirectDrawSurface7 ptr, byval as GpBitmap ptr ptr) as GpStatus
declare function GdipCreateBitmapFromGdiDib(byval as const BITMAPINFO ptr, byval as any ptr, byval as GpBitmap ptr ptr) as GpStatus
declare function GdipCreateBitmapFromHBITMAP(byval as HBITMAP, byval as HPALETTE, byval as GpBitmap ptr ptr) as GpStatus
declare function GdipCreateHBITMAPFromBitmap(byval as GpBitmap ptr, byval as HBITMAP ptr, byval as ARGB) as GpStatus
declare function GdipCreateBitmapFromHICON(byval as HICON, byval as GpBitmap ptr ptr) as GpStatus
declare function GdipCreateHICONFromBitmap(byval as GpBitmap ptr, byval as HICON ptr) as GpStatus
declare function GdipCreateBitmapFromResource(byval as HINSTANCE, byval as const wstring ptr, byval as GpBitmap ptr ptr) as GpStatus
declare function GdipCloneBitmapArea(byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as PixelFormat, byval as GpBitmap ptr, byval as GpBitmap ptr ptr) as GpStatus
declare function GdipCloneBitmapAreaI(byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as PixelFormat, byval as GpBitmap ptr, byval as GpBitmap ptr ptr) as GpStatus
declare function GdipBitmapLockBits(byval as GpBitmap ptr, byval as const GpRect ptr, byval as UINT, byval as PixelFormat, byval as BitmapData ptr) as GpStatus
declare function GdipBitmapUnlockBits(byval as GpBitmap ptr, byval as BitmapData ptr) as GpStatus
declare function GdipBitmapGetPixel(byval as GpBitmap ptr, byval as INT_, byval as INT_, byval as ARGB ptr) as GpStatus
declare function GdipBitmapSetPixel(byval as GpBitmap ptr, byval as INT_, byval as INT_, byval as ARGB) as GpStatus
declare function GdipBitmapSetResolution(byval as GpBitmap ptr, byval as REAL, byval as REAL) as GpStatus
declare function GdipBitmapConvertFormat(byval as GpBitmap ptr, byval as PixelFormat, byval as DitherType, byval as PaletteType, byval as ColorPalette ptr, byval as REAL) as GpStatus
declare function GdipInitializePalette(byval as ColorPalette ptr, byval as PaletteType, byval as INT_, byval as BOOL, byval as GpBitmap ptr) as GpStatus
declare function GdipBitmapApplyEffect(byval as GpBitmap ptr, byval as CGpEffect ptr, byval as RECT ptr, byval as BOOL, byval as any ptr ptr, byval as INT_ ptr) as GpStatus
declare function GdipBitmapCreateApplyEffect(byval as GpBitmap ptr ptr, byval as INT_, byval as CGpEffect ptr, byval as RECT ptr, byval as RECT ptr, byval as GpBitmap ptr ptr, byval as BOOL, byval as any ptr ptr, byval as INT_ ptr) as GpStatus
declare function GdipBitmapGetHistogram(byval as GpBitmap ptr, byval as HistogramFormat, byval as UINT, byval as UINT ptr, byval as UINT ptr, byval as UINT ptr, byval as UINT ptr) as GpStatus
declare function GdipBitmapGetHistogramSize(byval as HistogramFormat, byval as UINT ptr) as GpStatus
declare function GdipCloneBrush(byval as GpBrush ptr, byval as GpBrush ptr ptr) as GpStatus
declare function GdipDeleteBrush(byval as GpBrush ptr) as GpStatus
declare function GdipGetBrushType(byval as GpBrush ptr, byval as GpBrushType ptr) as GpStatus
declare function GdipCreateCachedBitmap(byval as GpBitmap ptr, byval as GpGraphics ptr, byval as GpCachedBitmap ptr ptr) as GpStatus
declare function GdipDeleteCachedBitmap(byval as GpCachedBitmap ptr) as GpStatus
declare function GdipDrawCachedBitmap(byval as GpGraphics ptr, byval as GpCachedBitmap ptr, byval as INT_, byval as INT_) as GpStatus
declare function GdipCreateCustomLineCap(byval as GpPath ptr, byval as GpPath ptr, byval as GpLineCap, byval as REAL, byval as GpCustomLineCap ptr ptr) as GpStatus
declare function GdipDeleteCustomLineCap(byval as GpCustomLineCap ptr) as GpStatus
declare function GdipCloneCustomLineCap(byval as GpCustomLineCap ptr, byval as GpCustomLineCap ptr ptr) as GpStatus
declare function GdipGetCustomLineCapType(byval as GpCustomLineCap ptr, byval as CustomLineCapType ptr) as GpStatus
declare function GdipSetCustomLineCapStrokeCaps(byval as GpCustomLineCap ptr, byval as GpLineCap, byval as GpLineCap) as GpStatus
declare function GdipGetCustomLineCapStrokeCaps(byval as GpCustomLineCap ptr, byval as GpLineCap ptr, byval as GpLineCap ptr) as GpStatus
declare function GdipSetCustomLineCapStrokeJoin(byval as GpCustomLineCap ptr, byval as GpLineJoin) as GpStatus
declare function GdipGetCustomLineCapStrokeJoin(byval as GpCustomLineCap ptr, byval as GpLineJoin ptr) as GpStatus
declare function GdipSetCustomLineCapBaseCap(byval as GpCustomLineCap ptr, byval as GpLineCap) as GpStatus
declare function GdipGetCustomLineCapBaseCap(byval as GpCustomLineCap ptr, byval as GpLineCap ptr) as GpStatus
declare function GdipSetCustomLineCapBaseInset(byval as GpCustomLineCap ptr, byval as REAL) as GpStatus
declare function GdipGetCustomLineCapBaseInset(byval as GpCustomLineCap ptr, byval as REAL ptr) as GpStatus
declare function GdipSetCustomLineCapWidthScale(byval as GpCustomLineCap ptr, byval as REAL) as GpStatus
declare function GdipGetCustomLineCapWidthScale(byval as GpCustomLineCap ptr, byval as REAL ptr) as GpStatus
declare function GdipCreateEffect(byval as const GUID, byval as CGpEffect ptr ptr) as GpStatus
declare function GdipDeleteEffect(byval as CGpEffect ptr) as GpStatus
declare function GdipGetEffectParameterSize(byval as CGpEffect ptr, byval as UINT ptr) as GpStatus
declare function GdipSetEffectParameters(byval as CGpEffect ptr, byval as const any ptr, byval as UINT) as GpStatus
declare function GdipGetEffectParameters(byval as CGpEffect ptr, byval as UINT ptr, byval as any ptr) as GpStatus
declare function GdipCreateFontFromDC(byval as HDC, byval as GpFont ptr ptr) as GpStatus
declare function GdipCreateFontFromLogfontA(byval as HDC, byval as const LOGFONTA ptr, byval as GpFont ptr ptr) as GpStatus
declare function GdipCreateFontFromLogfontW(byval as HDC, byval as const LOGFONTW ptr, byval as GpFont ptr ptr) as GpStatus
declare function GdipCreateFont(byval as const GpFontFamily ptr, byval as REAL, byval as INT_, byval as Unit, byval as GpFont ptr ptr) as GpStatus
declare function GdipCloneFont(byval as GpFont ptr, byval as GpFont ptr ptr) as GpStatus
declare function GdipDeleteFont(byval as GpFont ptr) as GpStatus
declare function GdipGetFamily(byval as GpFont ptr, byval as GpFontFamily ptr ptr) as GpStatus
declare function GdipGetFontStyle(byval as GpFont ptr, byval as INT_ ptr) as GpStatus
declare function GdipGetFontSize(byval as GpFont ptr, byval as REAL ptr) as GpStatus
declare function GdipGetFontUnit(byval as GpFont ptr, byval as Unit ptr) as GpStatus
declare function GdipGetFontHeight(byval as const GpFont ptr, byval as const GpGraphics ptr, byval as REAL ptr) as GpStatus
declare function GdipGetFontHeightGivenDPI(byval as const GpFont ptr, byval as REAL, byval as REAL ptr) as GpStatus
declare function GdipGetLogFontA(byval as GpFont ptr, byval as GpGraphics ptr, byval as LOGFONTA ptr) as GpStatus
declare function GdipGetLogFontW(byval as GpFont ptr, byval as GpGraphics ptr, byval as LOGFONTW ptr) as GpStatus
declare function GdipNewInstalledFontCollection(byval as GpFontCollection ptr ptr) as GpStatus
declare function GdipNewPrivateFontCollection(byval as GpFontCollection ptr ptr) as GpStatus
declare function GdipDeletePrivateFontCollection(byval as GpFontCollection ptr ptr) as GpStatus
declare function GdipGetFontCollectionFamilyCount(byval as GpFontCollection ptr, byval as INT_ ptr) as GpStatus
declare function GdipGetFontCollectionFamilyList(byval as GpFontCollection ptr, byval as INT_, byval as GpFontFamily ptr ptr, byval as INT_ ptr) as GpStatus
declare function GdipPrivateAddFontFile(byval as GpFontCollection ptr, byval as const wstring ptr) as GpStatus
declare function GdipPrivateAddMemoryFont(byval as GpFontCollection ptr, byval as const any ptr, byval as INT_) as GpStatus
declare function GdipCreateFontFamilyFromName(byval as const wstring ptr, byval as GpFontCollection ptr, byval as GpFontFamily ptr ptr) as GpStatus
declare function GdipDeleteFontFamily(byval as GpFontFamily ptr) as GpStatus
declare function GdipCloneFontFamily(byval as GpFontFamily ptr, byval as GpFontFamily ptr ptr) as GpStatus
declare function GdipGetGenericFontFamilySansSerif(byval as GpFontFamily ptr ptr) as GpStatus
declare function GdipGetGenericFontFamilySerif(byval as GpFontFamily ptr ptr) as GpStatus
declare function GdipGetGenericFontFamilyMonospace(byval as GpFontFamily ptr ptr) as GpStatus
declare function GdipGetFamilyName(byval as const GpFontFamily ptr, byval as wstring ptr, byval as LANGID) as GpStatus
declare function GdipIsStyleAvailable(byval as const GpFontFamily ptr, byval as INT_, byval as BOOL ptr) as GpStatus
declare function GdipFontCollectionEnumerable(byval as GpFontCollection ptr, byval as GpGraphics ptr, byval as INT_ ptr) as GpStatus
declare function GdipFontCollectionEnumerate(byval as GpFontCollection ptr, byval as INT_, byval as GpFontFamily ptr ptr, byval as INT_ ptr, byval as GpGraphics ptr) as GpStatus
declare function GdipGetEmHeight(byval as const GpFontFamily ptr, byval as INT_, byval as UINT16 ptr) as GpStatus
declare function GdipGetCellAscent(byval as const GpFontFamily ptr, byval as INT_, byval as UINT16 ptr) as GpStatus
declare function GdipGetCellDescent(byval as const GpFontFamily ptr, byval as INT_, byval as UINT16 ptr) as GpStatus
declare function GdipGetLineSpacing(byval as const GpFontFamily ptr, byval as INT_, byval as UINT16 ptr) as GpStatus
declare function GdipFlush(byval as GpGraphics ptr, byval as GpFlushIntention) as GpStatus
declare function GdipCreateFromHDC(byval as HDC, byval as GpGraphics ptr ptr) as GpStatus
declare function GdipCreateFromHDC2(byval as HDC, byval as HANDLE, byval as GpGraphics ptr ptr) as GpStatus
declare function GdipCreateFromHWND(byval as HWND, byval as GpGraphics ptr ptr) as GpStatus
declare function GdipCreateFromHWNDICM(byval as HWND, byval as GpGraphics ptr ptr) as GpStatus
declare function GdipDeleteGraphics(byval as GpGraphics ptr) as GpStatus
declare function GdipGetDC(byval as GpGraphics ptr, byval as HDC ptr) as GpStatus
declare function GdipReleaseDC(byval as GpGraphics ptr, byval as HDC) as GpStatus
declare function GdipSetCompositingMode(byval as GpGraphics ptr, byval as CompositingMode) as GpStatus
declare function GdipGetCompositingMode(byval as GpGraphics ptr, byval as CompositingMode ptr) as GpStatus
declare function GdipSetRenderingOrigin(byval as GpGraphics ptr, byval as INT_, byval as INT_) as GpStatus
declare function GdipGetRenderingOrigin(byval as GpGraphics ptr, byval as INT_ ptr, byval as INT_ ptr) as GpStatus
declare function GdipSetCompositingQuality(byval as GpGraphics ptr, byval as CompositingQuality) as GpStatus
declare function GdipGetCompositingQuality(byval as GpGraphics ptr, byval as CompositingQuality ptr) as GpStatus
declare function GdipSetSmoothingMode(byval as GpGraphics ptr, byval as SmoothingMode) as GpStatus
declare function GdipGetSmoothingMode(byval as GpGraphics ptr, byval as SmoothingMode ptr) as GpStatus
declare function GdipSetPixelOffsetMode(byval as GpGraphics ptr, byval as PixelOffsetMode) as GpStatus
declare function GdipGetPixelOffsetMode(byval as GpGraphics ptr, byval as PixelOffsetMode ptr) as GpStatus
declare function GdipSetTextRenderingHint(byval as GpGraphics ptr, byval as TextRenderingHint) as GpStatus
declare function GdipGetTextRenderingHint(byval as GpGraphics ptr, byval as TextRenderingHint ptr) as GpStatus
declare function GdipSetTextContrast(byval as GpGraphics ptr, byval as UINT) as GpStatus
declare function GdipGetTextContrast(byval as GpGraphics ptr, byval as UINT ptr) as GpStatus
declare function GdipSetInterpolationMode(byval as GpGraphics ptr, byval as InterpolationMode) as GpStatus
type GdiplusAbort as GdiplusAbort_
declare function GdipGraphicsSetAbort(byval as GpGraphics ptr, byval as GdiplusAbort ptr) as GpStatus
declare function GdipGetInterpolationMode(byval as GpGraphics ptr, byval as InterpolationMode ptr) as GpStatus
declare function GdipSetWorldTransform(byval as GpGraphics ptr, byval as GpMatrix ptr) as GpStatus
declare function GdipResetWorldTransform(byval as GpGraphics ptr) as GpStatus
declare function GdipMultiplyWorldTransform(byval as GpGraphics ptr, byval as const GpMatrix ptr, byval as GpMatrixOrder) as GpStatus
declare function GdipTranslateWorldTransform(byval as GpGraphics ptr, byval as REAL, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipScaleWorldTransform(byval as GpGraphics ptr, byval as REAL, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipRotateWorldTransform(byval as GpGraphics ptr, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipGetWorldTransform(byval as GpGraphics ptr, byval as GpMatrix ptr) as GpStatus
declare function GdipResetPageTransform(byval as GpGraphics ptr) as GpStatus
declare function GdipGetPageUnit(byval as GpGraphics ptr, byval as GpUnit ptr) as GpStatus
declare function GdipGetPageScale(byval as GpGraphics ptr, byval as REAL ptr) as GpStatus
declare function GdipSetPageUnit(byval as GpGraphics ptr, byval as GpUnit) as GpStatus
declare function GdipSetPageScale(byval as GpGraphics ptr, byval as REAL) as GpStatus
declare function GdipGetDpiX(byval as GpGraphics ptr, byval as REAL ptr) as GpStatus
declare function GdipGetDpiY(byval as GpGraphics ptr, byval as REAL ptr) as GpStatus
declare function GdipTransformPoints(byval as GpGraphics ptr, byval as GpCoordinateSpace, byval as GpCoordinateSpace, byval as GpPointF ptr, byval as INT_) as GpStatus
declare function GdipTransformPointsI(byval as GpGraphics ptr, byval as GpCoordinateSpace, byval as GpCoordinateSpace, byval as GpPoint ptr, byval as INT_) as GpStatus
declare function GdipGetNearestColor(byval as GpGraphics ptr, byval as ARGB ptr) as GpStatus
declare function GdipCreateHalftonePalette() as HPALETTE
declare function GdipDrawLine(byval as GpGraphics ptr, byval as GpPen ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL) as GpStatus
declare function GdipDrawLineI(byval as GpGraphics ptr, byval as GpPen ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_) as GpStatus
declare function GdipDrawLines(byval as GpGraphics ptr, byval as GpPen ptr, byval as const GpPointF ptr, byval as INT_) as GpStatus
declare function GdipDrawLinesI(byval as GpGraphics ptr, byval as GpPen ptr, byval as const GpPoint ptr, byval as INT_) as GpStatus
declare function GdipDrawArc(byval as GpGraphics ptr, byval as GpPen ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL) as GpStatus
declare function GdipDrawArcI(byval as GpGraphics ptr, byval as GpPen ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as REAL, byval as REAL) as GpStatus
declare function GdipDrawBezier(byval as GpGraphics ptr, byval as GpPen ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL) as GpStatus
declare function GdipDrawBezierI(byval as GpGraphics ptr, byval as GpPen ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as INT_) as GpStatus
declare function GdipDrawBeziers(byval as GpGraphics ptr, byval as GpPen ptr, byval as const GpPointF ptr, byval as INT_) as GpStatus
declare function GdipDrawBeziersI(byval as GpGraphics ptr, byval as GpPen ptr, byval as const GpPoint ptr, byval as INT_) as GpStatus
declare function GdipDrawRectangle(byval as GpGraphics ptr, byval as GpPen ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL) as GpStatus
declare function GdipDrawRectangleI(byval as GpGraphics ptr, byval as GpPen ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_) as GpStatus
declare function GdipDrawRectangles(byval as GpGraphics ptr, byval as GpPen ptr, byval as const GpRectF ptr, byval as INT_) as GpStatus
declare function GdipDrawRectanglesI(byval as GpGraphics ptr, byval as GpPen ptr, byval as const GpRect ptr, byval as INT_) as GpStatus
declare function GdipDrawEllipse(byval as GpGraphics ptr, byval as GpPen ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL) as GpStatus
declare function GdipDrawEllipseI(byval as GpGraphics ptr, byval as GpPen ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_) as GpStatus
declare function GdipDrawPie(byval as GpGraphics ptr, byval as GpPen ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL) as GpStatus
declare function GdipDrawPieI(byval as GpGraphics ptr, byval as GpPen ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as REAL, byval as REAL) as GpStatus
declare function GdipDrawPolygon(byval as GpGraphics ptr, byval as GpPen ptr, byval as const GpPointF ptr, byval as INT_) as GpStatus
declare function GdipDrawPolygonI(byval as GpGraphics ptr, byval as GpPen ptr, byval as const GpPoint ptr, byval as INT_) as GpStatus
declare function GdipDrawPath(byval as GpGraphics ptr, byval as GpPen ptr, byval as GpPath ptr) as GpStatus
declare function GdipDrawCurve(byval as GpGraphics ptr, byval as GpPen ptr, byval as const GpPointF ptr, byval as INT_) as GpStatus
declare function GdipDrawCurveI(byval as GpGraphics ptr, byval as GpPen ptr, byval as const GpPoint ptr, byval as INT_) as GpStatus
declare function GdipDrawCurve2(byval as GpGraphics ptr, byval as GpPen ptr, byval as const GpPointF ptr, byval as INT_, byval as REAL) as GpStatus
declare function GdipDrawCurve2I(byval as GpGraphics ptr, byval as GpPen ptr, byval as const GpPoint ptr, byval as INT_, byval as REAL) as GpStatus
declare function GdipDrawCurve3(byval as GpGraphics ptr, byval as GpPen ptr, byval as const GpPointF ptr, byval as INT_, byval as INT_, byval as INT_, byval as REAL) as GpStatus
declare function GdipDrawCurve3I(byval as GpGraphics ptr, byval as GpPen ptr, byval as const GpPoint ptr, byval as INT_, byval as INT_, byval as INT_, byval as REAL) as GpStatus
declare function GdipDrawClosedCurve(byval as GpGraphics ptr, byval as GpPen ptr, byval as const GpPointF ptr, byval as INT_) as GpStatus
declare function GdipDrawClosedCurveI(byval as GpGraphics ptr, byval as GpPen ptr, byval as const GpPoint ptr, byval as INT_) as GpStatus
declare function GdipDrawClosedCurve2(byval as GpGraphics ptr, byval as GpPen ptr, byval as const GpPointF ptr, byval as INT_, byval as REAL) as GpStatus
declare function GdipDrawClosedCurve2I(byval as GpGraphics ptr, byval as GpPen ptr, byval as const GpPoint ptr, byval as INT_, byval as REAL) as GpStatus
declare function GdipGraphicsClear(byval as GpGraphics ptr, byval as ARGB) as GpStatus
declare function GdipFillRectangle(byval as GpGraphics ptr, byval as GpBrush ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL) as GpStatus
declare function GdipFillRectangleI(byval as GpGraphics ptr, byval as GpBrush ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_) as GpStatus
declare function GdipFillRectangles(byval as GpGraphics ptr, byval as GpBrush ptr, byval as const GpRectF ptr, byval as INT_) as GpStatus
declare function GdipFillRectanglesI(byval as GpGraphics ptr, byval as GpBrush ptr, byval as const GpRect ptr, byval as INT_) as GpStatus
declare function GdipFillPolygon(byval as GpGraphics ptr, byval as GpBrush ptr, byval as const GpPointF ptr, byval as INT_, byval as GpFillMode) as GpStatus
declare function GdipFillPolygonI(byval as GpGraphics ptr, byval as GpBrush ptr, byval as const GpPoint ptr, byval as INT_, byval as GpFillMode) as GpStatus
declare function GdipFillPolygon2(byval as GpGraphics ptr, byval as GpBrush ptr, byval as const GpPointF ptr, byval as INT_) as GpStatus
declare function GdipFillPolygon2I(byval as GpGraphics ptr, byval as GpBrush ptr, byval as const GpPoint ptr, byval as INT_) as GpStatus
declare function GdipFillEllipse(byval as GpGraphics ptr, byval as GpBrush ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL) as GpStatus
declare function GdipFillEllipseI(byval as GpGraphics ptr, byval as GpBrush ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_) as GpStatus
declare function GdipFillPie(byval as GpGraphics ptr, byval as GpBrush ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL) as GpStatus
declare function GdipFillPieI(byval as GpGraphics ptr, byval as GpBrush ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as REAL, byval as REAL) as GpStatus
declare function GdipFillPath(byval as GpGraphics ptr, byval as GpBrush ptr, byval as GpPath ptr) as GpStatus
declare function GdipFillClosedCurve(byval as GpGraphics ptr, byval as GpBrush ptr, byval as const GpPointF ptr, byval as INT_) as GpStatus
declare function GdipFillClosedCurveI(byval as GpGraphics ptr, byval as GpBrush ptr, byval as const GpPoint ptr, byval as INT_) as GpStatus
declare function GdipFillClosedCurve2(byval as GpGraphics ptr, byval as GpBrush ptr, byval as const GpPointF ptr, byval as INT_, byval as REAL, byval as GpFillMode) as GpStatus
declare function GdipFillClosedCurve2I(byval as GpGraphics ptr, byval as GpBrush ptr, byval as const GpPoint ptr, byval as INT_, byval as REAL, byval as GpFillMode) as GpStatus
declare function GdipFillRegion(byval as GpGraphics ptr, byval as GpBrush ptr, byval as GpRegion ptr) as GpStatus
declare function GdipDrawImage(byval as GpGraphics ptr, byval as GpImage ptr, byval as REAL, byval as REAL) as GpStatus
declare function GdipDrawImageI(byval as GpGraphics ptr, byval as GpImage ptr, byval as INT_, byval as INT_) as GpStatus
declare function GdipDrawImageRect(byval as GpGraphics ptr, byval as GpImage ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL) as GpStatus
declare function GdipDrawImageRectI(byval as GpGraphics ptr, byval as GpImage ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_) as GpStatus
declare function GdipDrawImagePoints(byval as GpGraphics ptr, byval as GpImage ptr, byval as const GpPointF ptr, byval as INT_) as GpStatus
declare function GdipDrawImagePointsI(byval as GpGraphics ptr, byval as GpImage ptr, byval as const GpPoint ptr, byval as INT_) as GpStatus
declare function GdipDrawImagePointRect(byval as GpGraphics ptr, byval as GpImage ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as GpUnit) as GpStatus
declare function GdipDrawImagePointRectI(byval as GpGraphics ptr, byval as GpImage ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as GpUnit) as GpStatus
declare function GdipDrawImageRectRect(byval as GpGraphics ptr, byval as GpImage ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as GpUnit, byval as const GpImageAttributes ptr, byval as DrawImageAbort, byval as any ptr) as GpStatus
declare function GdipDrawImageRectRectI(byval as GpGraphics ptr, byval as GpImage ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as GpUnit, byval as const GpImageAttributes ptr, byval as DrawImageAbort, byval as any ptr) as GpStatus
declare function GdipDrawImagePointsRect(byval as GpGraphics ptr, byval as GpImage ptr, byval as const GpPointF ptr, byval as INT_, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as GpUnit, byval as const GpImageAttributes ptr, byval as DrawImageAbort, byval as any ptr) as GpStatus
declare function GdipDrawImagePointsRectI(byval as GpGraphics ptr, byval as GpImage ptr, byval as const GpPoint ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as GpUnit, byval as const GpImageAttributes ptr, byval as DrawImageAbort, byval as any ptr) as GpStatus
declare function GdipDrawImageFX(byval as GpGraphics ptr, byval as GpImage ptr, byval as GpRectF ptr, byval as GpMatrix ptr, byval as CGpEffect ptr, byval as GpImageAttributes ptr, byval as GpUnit) as GpStatus
declare function GdipEnumerateMetafileDestPoints(byval as GpGraphics ptr, byval as const GpMetafile ptr, byval as const PointF_ ptr, byval as INT_, byval as EnumerateMetafileProc, byval as any ptr, byval as const GpImageAttributes ptr) as GpStatus
declare function GdipEnumerateMetafileDestPointsI(byval as GpGraphics ptr, byval as const GpMetafile ptr, byval as const Point_ ptr, byval as INT_, byval as EnumerateMetafileProc, byval as any ptr, byval as const GpImageAttributes ptr) as GpStatus
declare function GdipSetClipGraphics(byval as GpGraphics ptr, byval as GpGraphics ptr, byval as CombineMode) as GpStatus
declare function GdipSetClipRect(byval as GpGraphics ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as CombineMode) as GpStatus
declare function GdipSetClipRectI(byval as GpGraphics ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as CombineMode) as GpStatus
declare function GdipSetClipPath(byval as GpGraphics ptr, byval as GpPath ptr, byval as CombineMode) as GpStatus
declare function GdipSetClipRegion(byval as GpGraphics ptr, byval as GpRegion ptr, byval as CombineMode) as GpStatus
declare function GdipSetClipHrgn(byval as GpGraphics ptr, byval as HRGN, byval as CombineMode) as GpStatus
declare function GdipResetClip(byval as GpGraphics ptr) as GpStatus
declare function GdipTranslateClip(byval as GpGraphics ptr, byval as REAL, byval as REAL) as GpStatus
declare function GdipTranslateClipI(byval as GpGraphics ptr, byval as INT_, byval as INT_) as GpStatus
declare function GdipGetClip(byval as GpGraphics ptr, byval as GpRegion ptr) as GpStatus
declare function GdipGetClipBounds(byval as GpGraphics ptr, byval as GpRectF ptr) as GpStatus
declare function GdipGetClipBoundsI(byval as GpGraphics ptr, byval as GpRect ptr) as GpStatus
declare function GdipIsClipEmpty(byval as GpGraphics ptr, byval as BOOL ptr) as GpStatus
declare function GdipGetVisibleClipBounds(byval as GpGraphics ptr, byval as GpRectF ptr) as GpStatus
declare function GdipGetVisibleClipBoundsI(byval as GpGraphics ptr, byval as GpRect ptr) as GpStatus
declare function GdipIsVisibleClipEmpty(byval as GpGraphics ptr, byval as BOOL ptr) as GpStatus
declare function GdipIsVisiblePoint(byval as GpGraphics ptr, byval as REAL, byval as REAL, byval as BOOL ptr) as GpStatus
declare function GdipIsVisiblePointI(byval as GpGraphics ptr, byval as INT_, byval as INT_, byval as BOOL ptr) as GpStatus
declare function GdipIsVisibleRect(byval as GpGraphics ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as BOOL ptr) as GpStatus
declare function GdipIsVisibleRectI(byval as GpGraphics ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as BOOL ptr) as GpStatus
declare function GdipSaveGraphics(byval as GpGraphics ptr, byval as GraphicsState ptr) as GpStatus
declare function GdipRestoreGraphics(byval as GpGraphics ptr, byval as GraphicsState) as GpStatus
declare function GdipBeginContainer(byval as GpGraphics ptr, byval as const GpRectF ptr, byval as const GpRectF ptr, byval as GpUnit, byval as GraphicsContainer ptr) as GpStatus
declare function GdipBeginContainerI(byval as GpGraphics ptr, byval as const GpRect ptr, byval as const GpRect ptr, byval as GpUnit, byval as GraphicsContainer ptr) as GpStatus
declare function GdipBeginContainer2(byval as GpGraphics ptr, byval as GraphicsContainer ptr) as GpStatus
declare function GdipEndContainer(byval as GpGraphics ptr, byval as GraphicsContainer) as GpStatus
declare function GdipComment(byval as GpGraphics ptr, byval as UINT, byval as const UBYTE ptr) as GpStatus
declare function GdipCreatePath(byval as GpFillMode, byval as GpPath ptr ptr) as GpStatus
declare function GdipCreatePath2(byval as const GpPointF ptr, byval as const UBYTE ptr, byval as INT_, byval as GpFillMode, byval as GpPath ptr ptr) as GpStatus
declare function GdipCreatePath2I(byval as const GpPoint ptr, byval as const UBYTE ptr, byval as INT_, byval as GpFillMode, byval as GpPath ptr ptr) as GpStatus
declare function GdipClonePath(byval as GpPath ptr, byval as GpPath ptr ptr) as GpStatus
declare function GdipDeletePath(byval as GpPath ptr) as GpStatus
declare function GdipResetPath(byval as GpPath ptr) as GpStatus
declare function GdipGetPointCount(byval as GpPath ptr, byval as INT_ ptr) as GpStatus
declare function GdipGetPathTypes(byval as GpPath ptr, byval as UBYTE ptr, byval as INT_) as GpStatus
declare function GdipGetPathPoints(byval as GpPath ptr, byval as GpPointF ptr, byval as INT_) as GpStatus
declare function GdipGetPathPointsI(byval as GpPath ptr, byval as GpPoint ptr, byval as INT_) as GpStatus
declare function GdipGetPathFillMode(byval as GpPath ptr, byval as GpFillMode ptr) as GpStatus
declare function GdipSetPathFillMode(byval as GpPath ptr, byval as GpFillMode) as GpStatus
declare function GdipGetPathData(byval as GpPath ptr, byval as GpPathData ptr) as GpStatus
declare function GdipStartPathFigure(byval as GpPath ptr) as GpStatus
declare function GdipClosePathFigure(byval as GpPath ptr) as GpStatus
declare function GdipClosePathFigures(byval as GpPath ptr) as GpStatus
declare function GdipSetPathMarker(byval as GpPath ptr) as GpStatus
declare function GdipClearPathMarkers(byval as GpPath ptr) as GpStatus
declare function GdipReversePath(byval as GpPath ptr) as GpStatus
declare function GdipGetPathLastPoint(byval as GpPath ptr, byval as GpPointF ptr) as GpStatus
declare function GdipAddPathLine(byval as GpPath ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL) as GpStatus
declare function GdipAddPathLine2(byval as GpPath ptr, byval as const GpPointF ptr, byval as INT_) as GpStatus
declare function GdipAddPathArc(byval as GpPath ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL) as GpStatus
declare function GdipAddPathBezier(byval as GpPath ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL) as GpStatus
declare function GdipAddPathBeziers(byval as GpPath ptr, byval as const GpPointF ptr, byval as INT_) as GpStatus
declare function GdipAddPathCurve(byval as GpPath ptr, byval as const GpPointF ptr, byval as INT_) as GpStatus
declare function GdipAddPathCurve2(byval as GpPath ptr, byval as const GpPointF ptr, byval as INT_, byval as REAL) as GpStatus
declare function GdipAddPathCurve3(byval as GpPath ptr, byval as const GpPointF ptr, byval as INT_, byval as INT_, byval as INT_, byval as REAL) as GpStatus
declare function GdipAddPathClosedCurve(byval as GpPath ptr, byval as const GpPointF ptr, byval as INT_) as GpStatus
declare function GdipAddPathClosedCurve2(byval as GpPath ptr, byval as const GpPointF ptr, byval as INT_, byval as REAL) as GpStatus
declare function GdipAddPathRectangle(byval as GpPath ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL) as GpStatus
declare function GdipAddPathRectangles(byval as GpPath ptr, byval as const GpRectF ptr, byval as INT_) as GpStatus
declare function GdipAddPathEllipse(byval as GpPath ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL) as GpStatus
declare function GdipAddPathPie(byval as GpPath ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL) as GpStatus
declare function GdipAddPathPolygon(byval as GpPath ptr, byval as const GpPointF ptr, byval as INT_) as GpStatus
declare function GdipAddPathPath(byval as GpPath ptr, byval as const GpPath ptr, byval as BOOL) as GpStatus
declare function GdipAddPathString(byval as GpPath ptr, byval as const wstring ptr, byval as INT_, byval as const GpFontFamily ptr, byval as INT_, byval as REAL, byval as const RectF ptr, byval as const GpStringFormat ptr) as GpStatus
declare function GdipAddPathStringI(byval as GpPath ptr, byval as const wstring ptr, byval as INT_, byval as const GpFontFamily ptr, byval as INT_, byval as REAL, byval as const Rect_ ptr, byval as const GpStringFormat ptr) as GpStatus
declare function GdipAddPathLineI(byval as GpPath ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_) as GpStatus
declare function GdipAddPathLine2I(byval as GpPath ptr, byval as const GpPoint ptr, byval as INT_) as GpStatus
declare function GdipAddPathArcI(byval as GpPath ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as REAL, byval as REAL) as GpStatus
declare function GdipAddPathBezierI(byval as GpPath ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as INT_) as GpStatus
declare function GdipAddPathBeziersI(byval as GpPath ptr, byval as const GpPoint ptr, byval as INT_) as GpStatus
declare function GdipAddPathCurveI(byval as GpPath ptr, byval as const GpPoint ptr, byval as INT_) as GpStatus
declare function GdipAddPathCurve2I(byval as GpPath ptr, byval as const GpPoint ptr, byval as INT_, byval as REAL) as GpStatus
declare function GdipAddPathCurve3I(byval as GpPath ptr, byval as const GpPoint ptr, byval as INT_, byval as INT_, byval as INT_, byval as REAL) as GpStatus
declare function GdipAddPathClosedCurveI(byval as GpPath ptr, byval as const GpPoint ptr, byval as INT_) as GpStatus
declare function GdipAddPathClosedCurve2I(byval as GpPath ptr, byval as const GpPoint ptr, byval as INT_, byval as REAL) as GpStatus
declare function GdipAddPathRectangleI(byval as GpPath ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_) as GpStatus
declare function GdipAddPathRectanglesI(byval as GpPath ptr, byval as const GpRect ptr, byval as INT_) as GpStatus
declare function GdipAddPathEllipseI(byval as GpPath ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_) as GpStatus
declare function GdipAddPathPieI(byval as GpPath ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as REAL, byval as REAL) as GpStatus
declare function GdipAddPathPolygonI(byval as GpPath ptr, byval as const GpPoint ptr, byval as INT_) as GpStatus
declare function GdipFlattenPath(byval as GpPath ptr, byval as GpMatrix ptr, byval as REAL) as GpStatus
declare function GdipWindingModeOutline(byval as GpPath ptr, byval as GpMatrix ptr, byval as REAL) as GpStatus
declare function GdipWidenPath(byval as GpPath ptr, byval as GpPen ptr, byval as GpMatrix ptr, byval as REAL) as GpStatus
declare function GdipWarpPath(byval as GpPath ptr, byval as GpMatrix ptr, byval as const GpPointF ptr, byval as INT_, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as WarpMode, byval as REAL) as GpStatus
declare function GdipTransformPath(byval as GpPath ptr, byval as GpMatrix ptr) as GpStatus
declare function GdipGetPathWorldBounds(byval as GpPath ptr, byval as GpRectF ptr, byval as const GpMatrix ptr, byval as const GpPen ptr) as GpStatus
declare function GdipGetPathWorldBoundsI(byval as GpPath ptr, byval as GpRect ptr, byval as const GpMatrix ptr, byval as const GpPen ptr) as GpStatus
declare function GdipIsVisiblePathPoint(byval as GpPath ptr, byval as REAL, byval as REAL, byval as GpGraphics ptr, byval as BOOL ptr) as GpStatus
declare function GdipIsVisiblePathPointI(byval as GpPath ptr, byval as INT_, byval as INT_, byval as GpGraphics ptr, byval as BOOL ptr) as GpStatus
declare function GdipIsOutlineVisiblePathPoint(byval as GpPath ptr, byval as REAL, byval as REAL, byval as GpPen ptr, byval as GpGraphics ptr, byval as BOOL ptr) as GpStatus
declare function GdipIsOutlineVisiblePathPointI(byval as GpPath ptr, byval as INT_, byval as INT_, byval as GpPen ptr, byval as GpGraphics ptr, byval as BOOL ptr) as GpStatus
declare function GdipCreateHatchBrush(byval as GpHatchStyle, byval as ARGB, byval as ARGB, byval as GpHatch ptr ptr) as GpStatus
declare function GdipGetHatchStyle(byval as GpHatch ptr, byval as GpHatchStyle ptr) as GpStatus
declare function GdipGetHatchForegroundColor(byval as GpHatch ptr, byval as ARGB ptr) as GpStatus
declare function GdipGetHatchBackgroundColor(byval as GpHatch ptr, byval as ARGB ptr) as GpStatus
declare function GdipLoadImageFromStream(byval as IStream ptr, byval as GpImage ptr ptr) as GpStatus
declare function GdipLoadImageFromFile(byval as const wstring ptr, byval as GpImage ptr ptr) as GpStatus
declare function GdipLoadImageFromStreamICM(byval as IStream ptr, byval as GpImage ptr ptr) as GpStatus
declare function GdipLoadImageFromFileICM(byval as const wstring ptr, byval as GpImage ptr ptr) as GpStatus
declare function GdipCloneImage(byval as GpImage ptr, byval as GpImage ptr ptr) as GpStatus
declare function GdipDisposeImage(byval as GpImage ptr) as GpStatus
declare function GdipSaveImageToFile(byval as GpImage ptr, byval as const wstring ptr, byval as const CLSID ptr, byval as const EncoderParameters ptr) as GpStatus
declare function GdipSaveImageToStream(byval as GpImage ptr, byval as IStream ptr, byval as const CLSID ptr, byval as const EncoderParameters ptr) as GpStatus
declare function GdipSaveAdd(byval as GpImage ptr, byval as const EncoderParameters ptr) as GpStatus
declare function GdipSaveAddImage(byval as GpImage ptr, byval as GpImage ptr, byval as const EncoderParameters ptr) as GpStatus
declare function GdipGetImageGraphicsContext(byval as GpImage ptr, byval as GpGraphics ptr ptr) as GpStatus
declare function GdipGetImageBounds(byval as GpImage ptr, byval as GpRectF ptr, byval as GpUnit ptr) as GpStatus
declare function GdipGetImageDimension(byval as GpImage ptr, byval as REAL ptr, byval as REAL ptr) as GpStatus
declare function GdipGetImageType(byval as GpImage ptr, byval as ImageType ptr) as GpStatus
declare function GdipGetImageWidth(byval as GpImage ptr, byval as UINT ptr) as GpStatus
declare function GdipGetImageHeight(byval as GpImage ptr, byval as UINT ptr) as GpStatus
declare function GdipGetImageHorizontalResolution(byval as GpImage ptr, byval as REAL ptr) as GpStatus
declare function GdipGetImageVerticalResolution(byval as GpImage ptr, byval as REAL ptr) as GpStatus
declare function GdipGetImageFlags(byval as GpImage ptr, byval as UINT ptr) as GpStatus
declare function GdipGetImageRawFormat(byval as GpImage ptr, byval as GUID ptr) as GpStatus
declare function GdipGetImagePixelFormat(byval as GpImage ptr, byval as PixelFormat ptr) as GpStatus
declare function GdipGetImageThumbnail(byval as GpImage ptr, byval as UINT, byval as UINT, byval as GpImage ptr ptr, byval as GetThumbnailImageAbort, byval as any ptr) as GpStatus
declare function GdipGetEncoderParameterListSize(byval as GpImage ptr, byval as const CLSID ptr, byval as UINT ptr) as GpStatus
declare function GdipGetEncoderParameterList(byval as GpImage ptr, byval as const CLSID ptr, byval as UINT, byval as EncoderParameters ptr) as GpStatus
declare function GdipImageGetFrameDimensionsCount(byval as GpImage ptr, byval as UINT ptr) as GpStatus
declare function GdipImageGetFrameDimensionsList(byval as GpImage ptr, byval as GUID ptr, byval as UINT) as GpStatus
declare function GdipImageGetFrameCount(byval as GpImage ptr, byval as const GUID ptr, byval as UINT ptr) as GpStatus
declare function GdipImageSelectActiveFrame(byval as GpImage ptr, byval as const GUID ptr, byval as UINT) as GpStatus
declare function GdipImageRotateFlip(byval as GpImage ptr, byval as RotateFlipType) as GpStatus
declare function GdipGetImagePalette(byval as GpImage ptr, byval as ColorPalette ptr, byval as INT_) as GpStatus
declare function GdipSetImagePalette(byval as GpImage ptr, byval as const ColorPalette ptr) as GpStatus
declare function GdipGetImagePaletteSize(byval as GpImage ptr, byval as INT_ ptr) as GpStatus
declare function GdipGetPropertyCount(byval as GpImage ptr, byval as UINT ptr) as GpStatus
declare function GdipGetPropertyIdList(byval as GpImage ptr, byval as UINT, byval as PROPID ptr) as GpStatus
declare function GdipGetPropertyItemSize(byval as GpImage ptr, byval as PROPID, byval as UINT ptr) as GpStatus
declare function GdipGetPropertyItem(byval as GpImage ptr, byval as PROPID, byval as UINT, byval as PropertyItem ptr) as GpStatus
declare function GdipGetPropertySize(byval as GpImage ptr, byval as UINT ptr, byval as UINT ptr) as GpStatus
declare function GdipGetAllPropertyItems(byval as GpImage ptr, byval as UINT, byval as UINT, byval as PropertyItem ptr) as GpStatus
declare function GdipRemovePropertyItem(byval as GpImage ptr, byval as PROPID) as GpStatus
declare function GdipSetPropertyItem(byval as GpImage ptr, byval as const PropertyItem ptr) as GpStatus
declare function GdipFindFirstImageItem(byval as GpImage ptr, byval as ImageItemData ptr) as GpStatus
declare function GdipFindNextImageItem(byval as GpImage ptr, byval as ImageItemData ptr) as GpStatus
declare function GdipGetImageItemData(byval as GpImage ptr, byval as ImageItemData ptr) as GpStatus
declare function GdipImageSetAbort(byval as GpImage ptr, byval as GdiplusAbort ptr) as GpStatus
declare function GdipImageForceValidation(byval as GpImage ptr) as GpStatus
declare function GdipGetImageDecodersSize(byval as UINT ptr, byval as UINT ptr) as GpStatus
declare function GdipGetImageDecoders(byval as UINT, byval as UINT, byval as ImageCodecInfo ptr) as GpStatus
declare function GdipGetImageEncodersSize(byval as UINT ptr, byval as UINT ptr) as GpStatus
declare function GdipGetImageEncoders(byval as UINT, byval as UINT, byval as ImageCodecInfo ptr) as GpStatus
declare function GdipCreateImageAttributes(byval as GpImageAttributes ptr ptr) as GpStatus
declare function GdipCloneImageAttributes(byval as const GpImageAttributes ptr, byval as GpImageAttributes ptr ptr) as GpStatus
declare function GdipDisposeImageAttributes(byval as GpImageAttributes ptr) as GpStatus
declare function GdipSetImageAttributesToIdentity(byval as GpImageAttributes ptr, byval as ColorAdjustType) as GpStatus
declare function GdipResetImageAttributes(byval as GpImageAttributes ptr, byval as ColorAdjustType) as GpStatus
declare function GdipSetImageAttributesColorMatrix(byval as GpImageAttributes ptr, byval as ColorAdjustType, byval as BOOL, byval as const ColorMatrix ptr, byval as const ColorMatrix ptr, byval as ColorMatrixFlags) as GpStatus
declare function GdipSetImageAttributesThreshold(byval as GpImageAttributes ptr, byval as ColorAdjustType, byval as BOOL, byval as REAL) as GpStatus
declare function GdipSetImageAttributesGamma(byval as GpImageAttributes ptr, byval as ColorAdjustType, byval as BOOL, byval as REAL) as GpStatus
declare function GdipSetImageAttributesNoOp(byval as GpImageAttributes ptr, byval as ColorAdjustType, byval as BOOL) as GpStatus
declare function GdipSetImageAttributesColorKeys(byval as GpImageAttributes ptr, byval as ColorAdjustType, byval as BOOL, byval as ARGB, byval as ARGB) as GpStatus
declare function GdipSetImageAttributesOutputChannel(byval as GpImageAttributes ptr, byval as ColorAdjustType, byval as BOOL, byval as ColorChannelFlags) as GpStatus
declare function GdipSetImageAttributesOutputChannelColorProfile(byval as GpImageAttributes ptr, byval as ColorAdjustType, byval as BOOL, byval as const wstring ptr) as GpStatus
declare function GdipSetImageAttributesRemapTable(byval as GpImageAttributes ptr, byval as ColorAdjustType, byval as BOOL, byval as UINT, byval as const ColorMap_ ptr) as GpStatus
declare function GdipSetImageAttributesWrapMode(byval as GpImageAttributes ptr, byval as WrapMode, byval as ARGB, byval as BOOL) as GpStatus
declare function GdipSetImageAttributesICMMode(byval as GpImageAttributes ptr, byval as BOOL) as GpStatus
declare function GdipGetImageAttributesAdjustedPalette(byval as GpImageAttributes ptr, byval as ColorPalette ptr, byval as ColorAdjustType) as GpStatus
declare function GdipSetImageAttributesCachedBackground(byval as GpImageAttributes ptr, byval as BOOL) as GpStatus
declare function GdipCreateLineBrush(byval as const GpPointF ptr, byval as const GpPointF ptr, byval as ARGB, byval as ARGB, byval as GpWrapMode, byval as GpLineGradient ptr ptr) as GpStatus
declare function GdipCreateLineBrushI(byval as const GpPoint ptr, byval as const GpPoint ptr, byval as ARGB, byval as ARGB, byval as GpWrapMode, byval as GpLineGradient ptr ptr) as GpStatus
declare function GdipCreateLineBrushFromRect(byval as const GpRectF ptr, byval as ARGB, byval as ARGB, byval as LinearGradientMode, byval as GpWrapMode, byval as GpLineGradient ptr ptr) as GpStatus
declare function GdipCreateLineBrushFromRectI(byval as const GpRect ptr, byval as ARGB, byval as ARGB, byval as LinearGradientMode, byval as GpWrapMode, byval as GpLineGradient ptr ptr) as GpStatus
declare function GdipCreateLineBrushFromRectWithAngle(byval as const GpRectF ptr, byval as ARGB, byval as ARGB, byval as REAL, byval as BOOL, byval as GpWrapMode, byval as GpLineGradient ptr ptr) as GpStatus
declare function GdipCreateLineBrushFromRectWithAngleI(byval as const GpRect ptr, byval as ARGB, byval as ARGB, byval as REAL, byval as BOOL, byval as GpWrapMode, byval as GpLineGradient ptr ptr) as GpStatus
declare function GdipSetLineColors(byval as GpLineGradient ptr, byval as ARGB, byval as ARGB) as GpStatus
declare function GdipGetLineColors(byval as GpLineGradient ptr, byval as ARGB ptr) as GpStatus
declare function GdipGetLineRect(byval as GpLineGradient ptr, byval as GpRectF ptr) as GpStatus
declare function GdipGetLineRectI(byval as GpLineGradient ptr, byval as GpRect ptr) as GpStatus
declare function GdipSetLineGammaCorrection(byval as GpLineGradient ptr, byval as BOOL) as GpStatus
declare function GdipGetLineGammaCorrection(byval as GpLineGradient ptr, byval as BOOL ptr) as GpStatus
declare function GdipGetLineBlendCount(byval as GpLineGradient ptr, byval as INT_ ptr) as GpStatus
declare function GdipGetLineBlend(byval as GpLineGradient ptr, byval as REAL ptr, byval as REAL ptr, byval as INT_) as GpStatus
declare function GdipSetLineBlend(byval as GpLineGradient ptr, byval as const REAL ptr, byval as const REAL ptr, byval as INT_) as GpStatus
declare function GdipGetLinePresetBlendCount(byval as GpLineGradient ptr, byval as INT_ ptr) as GpStatus
declare function GdipGetLinePresetBlend(byval as GpLineGradient ptr, byval as ARGB ptr, byval as REAL ptr, byval as INT_) as GpStatus
declare function GdipSetLinePresetBlend(byval as GpLineGradient ptr, byval as const ARGB ptr, byval as const REAL ptr, byval as INT_) as GpStatus
declare function GdipSetLineSigmaBlend(byval as GpLineGradient ptr, byval as REAL, byval as REAL) as GpStatus
declare function GdipSetLineLinearBlend(byval as GpLineGradient ptr, byval as REAL, byval as REAL) as GpStatus
declare function GdipSetLineWrapMode(byval as GpLineGradient ptr, byval as GpWrapMode) as GpStatus
declare function GdipGetLineWrapMode(byval as GpLineGradient ptr, byval as GpWrapMode ptr) as GpStatus
declare function GdipGetLineTransform(byval as GpLineGradient ptr, byval as GpMatrix ptr) as GpStatus
declare function GdipSetLineTransform(byval as GpLineGradient ptr, byval as const GpMatrix ptr) as GpStatus
declare function GdipResetLineTransform(byval as GpLineGradient ptr) as GpStatus
declare function GdipMultiplyLineTransform(byval as GpLineGradient ptr, byval as const GpMatrix ptr, byval as GpMatrixOrder) as GpStatus
declare function GdipTranslateLineTransform(byval as GpLineGradient ptr, byval as REAL, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipScaleLineTransform(byval as GpLineGradient ptr, byval as REAL, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipRotateLineTransform(byval as GpLineGradient ptr, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipCreateMatrix(byval as GpMatrix ptr ptr) as GpStatus
declare function GdipCreateMatrix2(byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as GpMatrix ptr ptr) as GpStatus
declare function GdipCreateMatrix3(byval as const GpRectF ptr, byval as const GpPointF ptr, byval as GpMatrix ptr ptr) as GpStatus
declare function GdipCreateMatrix3I(byval as const GpRect ptr, byval as const GpPoint ptr, byval as GpMatrix ptr ptr) as GpStatus
declare function GdipCloneMatrix(byval as GpMatrix ptr, byval as GpMatrix ptr ptr) as GpStatus
declare function GdipDeleteMatrix(byval as GpMatrix ptr) as GpStatus
declare function GdipSetMatrixElements(byval as GpMatrix ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as REAL) as GpStatus
declare function GdipMultiplyMatrix(byval as GpMatrix ptr, byval as GpMatrix ptr, byval as GpMatrixOrder) as GpStatus
declare function GdipTranslateMatrix(byval as GpMatrix ptr, byval as REAL, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipScaleMatrix(byval as GpMatrix ptr, byval as REAL, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipRotateMatrix(byval as GpMatrix ptr, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipShearMatrix(byval as GpMatrix ptr, byval as REAL, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipInvertMatrix(byval as GpMatrix ptr) as GpStatus
declare function GdipTransformMatrixPoints(byval as GpMatrix ptr, byval as GpPointF ptr, byval as INT_) as GpStatus
declare function GdipTransformMatrixPointsI(byval as GpMatrix ptr, byval as GpPoint ptr, byval as INT_) as GpStatus
declare function GdipVectorTransformMatrixPoints(byval as GpMatrix ptr, byval as GpPointF ptr, byval as INT_) as GpStatus
declare function GdipVectorTransformMatrixPointsI(byval as GpMatrix ptr, byval as GpPoint ptr, byval as INT_) as GpStatus
declare function GdipGetMatrixElements(byval as const GpMatrix ptr, byval as REAL ptr) as GpStatus
declare function GdipIsMatrixInvertible(byval as const GpMatrix ptr, byval as BOOL ptr) as GpStatus
declare function GdipIsMatrixIdentity(byval as const GpMatrix ptr, byval as BOOL ptr) as GpStatus
declare function GdipIsMatrixEqual(byval as const GpMatrix ptr, byval as const GpMatrix ptr, byval as BOOL ptr) as GpStatus
declare function GdipGetMetafileHeaderFromEmf(byval as HENHMETAFILE, byval as MetafileHeader ptr) as GpStatus
declare function GdipGetMetafileHeaderFromFile(byval as const wstring ptr, byval as MetafileHeader ptr) as GpStatus
declare function GdipGetMetafileHeaderFromStream(byval as IStream ptr, byval as MetafileHeader ptr) as GpStatus
declare function GdipGetMetafileHeaderFromMetafile(byval as GpMetafile ptr, byval as MetafileHeader ptr) as GpStatus
declare function GdipGetHemfFromMetafile(byval as GpMetafile ptr, byval as HENHMETAFILE ptr) as GpStatus
declare function GdipCreateStreamOnFile(byval as const wstring ptr, byval as UINT, byval as IStream ptr ptr) as GpStatus
declare function GdipCreateMetafileFromWmf(byval as HMETAFILE, byval as BOOL, byval as const WmfPlaceableFileHeader ptr, byval as GpMetafile ptr ptr) as GpStatus
declare function GdipCreateMetafileFromEmf(byval as HENHMETAFILE, byval as BOOL, byval as GpMetafile ptr ptr) as GpStatus
declare function GdipCreateMetafileFromFile(byval as const wstring ptr, byval as GpMetafile ptr ptr) as GpStatus
declare function GdipCreateMetafileFromWmfFile(byval as const wstring ptr, byval as const WmfPlaceableFileHeader ptr, byval as GpMetafile ptr ptr) as GpStatus
declare function GdipCreateMetafileFromStream(byval as IStream ptr, byval as GpMetafile ptr ptr) as GpStatus
declare function GdipRecordMetafile(byval as HDC, byval as EmfType, byval as const GpRectF ptr, byval as MetafileFrameUnit, byval as const wstring ptr, byval as GpMetafile ptr ptr) as GpStatus
declare function GdipRecordMetafileI(byval as HDC, byval as EmfType, byval as const GpRect ptr, byval as MetafileFrameUnit, byval as const wstring ptr, byval as GpMetafile ptr ptr) as GpStatus
declare function GdipRecordMetafileFileName(byval as const wstring ptr, byval as HDC, byval as EmfType, byval as const GpRectF ptr, byval as MetafileFrameUnit, byval as const wstring ptr, byval as GpMetafile ptr ptr) as GpStatus
declare function GdipRecordMetafileFileNameI(byval as const wstring ptr, byval as HDC, byval as EmfType, byval as const GpRect ptr, byval as MetafileFrameUnit, byval as const wstring ptr, byval as GpMetafile ptr ptr) as GpStatus
declare function GdipRecordMetafileStream(byval as IStream ptr, byval as HDC, byval as EmfType, byval as const GpRectF ptr, byval as MetafileFrameUnit, byval as const wstring ptr, byval as GpMetafile ptr ptr) as GpStatus
declare function GdipRecordMetafileStreamI(byval as IStream ptr, byval as HDC, byval as EmfType, byval as const GpRect ptr, byval as MetafileFrameUnit, byval as const wstring ptr, byval as GpMetafile ptr ptr) as GpStatus
declare function GdipPlayMetafileRecord(byval as const GpMetafile ptr, byval as EmfPlusRecordType, byval as UINT, byval as UINT, byval as const UBYTE ptr) as GpStatus
declare function GdipSetMetafileDownLevelRasterizationLimit(byval as GpMetafile ptr, byval as UINT) as GpStatus
declare function GdipGetMetafileDownLevelRasterizationLimit(byval as const GpMetafile ptr, byval as UINT ptr) as GpStatus
declare function GdipConvertToEmfPlus(byval as const GpGraphics ptr, byval as GpMetafile ptr, byval as BOOL ptr, byval as EmfType, byval as const wstring ptr, byval as GpMetafile ptr ptr) as GpStatus
declare function GdipConvertToEmfPlusToFile(byval as const GpGraphics ptr, byval as GpMetafile ptr, byval as BOOL ptr, byval as const wstring ptr, byval as EmfType, byval as const wstring ptr, byval as GpMetafile ptr ptr) as GpStatus
declare function GdipConvertToEmfPlusToStream(byval as const GpGraphics ptr, byval as GpMetafile ptr, byval as BOOL ptr, byval as IStream ptr, byval as EmfType, byval as const wstring ptr, byval as GpMetafile ptr ptr) as GpStatus
declare function GdipEmfToWmfBits(byval as HENHMETAFILE, byval as UINT, byval as LPBYTE, byval as INT_, byval as INT_) as UINT
declare function GdipCreatePathGradient(byval as const GpPointF ptr, byval as INT_, byval as GpWrapMode, byval as GpPathGradient ptr ptr) as GpStatus
declare function GdipCreatePathGradientI(byval as const GpPoint ptr, byval as INT_, byval as GpWrapMode, byval as GpPathGradient ptr ptr) as GpStatus
declare function GdipCreatePathGradientFromPath(byval as const GpPath ptr, byval as GpPathGradient ptr ptr) as GpStatus
declare function GdipGetPathGradientCenterColor(byval as GpPathGradient ptr, byval as ARGB ptr) as GpStatus
declare function GdipSetPathGradientCenterColor(byval as GpPathGradient ptr, byval as ARGB) as GpStatus
declare function GdipGetPathGradientSurroundColorsWithCount(byval as GpPathGradient ptr, byval as ARGB ptr, byval as INT_ ptr) as GpStatus
declare function GdipSetPathGradientSurroundColorsWithCount(byval as GpPathGradient ptr, byval as const ARGB ptr, byval as INT_ ptr) as GpStatus
declare function GdipGetPathGradientPath(byval as GpPathGradient ptr, byval as GpPath ptr) as GpStatus
declare function GdipSetPathGradientPath(byval as GpPathGradient ptr, byval as const GpPath ptr) as GpStatus
declare function GdipGetPathGradientCenterPoint(byval as GpPathGradient ptr, byval as GpPointF ptr) as GpStatus
declare function GdipGetPathGradientCenterPointI(byval as GpPathGradient ptr, byval as GpPoint ptr) as GpStatus
declare function GdipSetPathGradientCenterPoint(byval as GpPathGradient ptr, byval as const GpPointF ptr) as GpStatus
declare function GdipSetPathGradientCenterPointI(byval as GpPathGradient ptr, byval as const GpPoint ptr) as GpStatus
declare function GdipGetPathGradientRect(byval as GpPathGradient ptr, byval as GpRectF ptr) as GpStatus
declare function GdipGetPathGradientRectI(byval as GpPathGradient ptr, byval as GpRect ptr) as GpStatus
declare function GdipGetPathGradientPointCount(byval as GpPathGradient ptr, byval as INT_ ptr) as GpStatus
declare function GdipGetPathGradientSurroundColorCount(byval as GpPathGradient ptr, byval as INT_ ptr) as GpStatus
declare function GdipSetPathGradientGammaCorrection(byval as GpPathGradient ptr, byval as BOOL) as GpStatus
declare function GdipGetPathGradientGammaCorrection(byval as GpPathGradient ptr, byval as BOOL ptr) as GpStatus
declare function GdipGetPathGradientBlendCount(byval as GpPathGradient ptr, byval as INT_ ptr) as GpStatus
declare function GdipGetPathGradientBlend(byval as GpPathGradient ptr, byval as REAL ptr, byval as REAL ptr, byval as INT_) as GpStatus
declare function GdipSetPathGradientBlend(byval as GpPathGradient ptr, byval as const REAL ptr, byval as const REAL ptr, byval as INT_) as GpStatus
declare function GdipGetPathGradientPresetBlendCount(byval as GpPathGradient ptr, byval as INT_ ptr) as GpStatus
declare function GdipGetPathGradientPresetBlend(byval as GpPathGradient ptr, byval as ARGB ptr, byval as REAL ptr, byval as INT_) as GpStatus
declare function GdipSetPathGradientPresetBlend(byval as GpPathGradient ptr, byval as const ARGB ptr, byval as const REAL ptr, byval as INT_) as GpStatus
declare function GdipSetPathGradientSigmaBlend(byval as GpPathGradient ptr, byval as REAL, byval as REAL) as GpStatus
declare function GdipSetPathGradientLinearBlend(byval as GpPathGradient ptr, byval as REAL, byval as REAL) as GpStatus
declare function GdipGetPathGradientWrapMode(byval as GpPathGradient ptr, byval as GpWrapMode ptr) as GpStatus
declare function GdipSetPathGradientWrapMode(byval as GpPathGradient ptr, byval as GpWrapMode) as GpStatus
declare function GdipGetPathGradientTransform(byval as GpPathGradient ptr, byval as GpMatrix ptr) as GpStatus
declare function GdipSetPathGradientTransform(byval as GpPathGradient ptr, byval as GpMatrix ptr) as GpStatus
declare function GdipResetPathGradientTransform(byval as GpPathGradient ptr) as GpStatus
declare function GdipMultiplyPathGradientTransform(byval as GpPathGradient ptr, byval as const GpMatrix ptr, byval as GpMatrixOrder) as GpStatus
declare function GdipTranslatePathGradientTransform(byval as GpPathGradient ptr, byval as REAL, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipScalePathGradientTransform(byval as GpPathGradient ptr, byval as REAL, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipRotatePathGradientTransform(byval as GpPathGradient ptr, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipGetPathGradientFocusScales(byval as GpPathGradient ptr, byval as REAL ptr, byval as REAL ptr) as GpStatus
declare function GdipSetPathGradientFocusScales(byval as GpPathGradient ptr, byval as REAL, byval as REAL) as GpStatus
declare function GdipCreatePathIter(byval as GpPathIterator ptr ptr, byval as GpPath ptr) as GpStatus
declare function GdipDeletePathIter(byval as GpPathIterator ptr) as GpStatus
declare function GdipPathIterNextSubpath(byval as GpPathIterator ptr, byval as INT_ ptr, byval as INT_ ptr, byval as INT_ ptr, byval as BOOL ptr) as GpStatus
declare function GdipPathIterNextSubpathPath(byval as GpPathIterator ptr, byval as INT_ ptr, byval as GpPath ptr, byval as BOOL ptr) as GpStatus
declare function GdipPathIterNextPathType(byval as GpPathIterator ptr, byval as INT_ ptr, byval as UBYTE ptr, byval as INT_ ptr, byval as INT_ ptr) as GpStatus
declare function GdipPathIterNextMarker(byval as GpPathIterator ptr, byval as INT_ ptr, byval as INT_ ptr, byval as INT_ ptr) as GpStatus
declare function GdipPathIterNextMarkerPath(byval as GpPathIterator ptr, byval as INT_ ptr, byval as GpPath ptr) as GpStatus
declare function GdipPathIterGetCount(byval as GpPathIterator ptr, byval as INT_ ptr) as GpStatus
declare function GdipPathIterGetSubpathCount(byval as GpPathIterator ptr, byval as INT_ ptr) as GpStatus
declare function GdipPathIterIsValid(byval as GpPathIterator ptr, byval as BOOL ptr) as GpStatus
declare function GdipPathIterHasCurve(byval as GpPathIterator ptr, byval as BOOL ptr) as GpStatus
declare function GdipPathIterRewind(byval as GpPathIterator ptr) as GpStatus
declare function GdipPathIterEnumerate(byval as GpPathIterator ptr, byval as INT_ ptr, byval as GpPointF ptr, byval as UBYTE ptr, byval as INT_) as GpStatus
declare function GdipPathIterCopyData(byval as GpPathIterator ptr, byval as INT_ ptr, byval as GpPointF ptr, byval as UBYTE ptr, byval as INT_, byval as INT_) as GpStatus
declare function GdipCreatePen1(byval as ARGB, byval as REAL, byval as GpUnit, byval as GpPen ptr ptr) as GpStatus
declare function GdipCreatePen2(byval as GpBrush ptr, byval as REAL, byval as GpUnit, byval as GpPen ptr ptr) as GpStatus
declare function GdipClonePen(byval as GpPen ptr, byval as GpPen ptr ptr) as GpStatus
declare function GdipDeletePen(byval as GpPen ptr) as GpStatus
declare function GdipSetPenWidth(byval as GpPen ptr, byval as REAL) as GpStatus
declare function GdipGetPenWidth(byval as GpPen ptr, byval as REAL ptr) as GpStatus
declare function GdipSetPenUnit(byval as GpPen ptr, byval as GpUnit) as GpStatus
declare function GdipGetPenUnit(byval as GpPen ptr, byval as GpUnit ptr) as GpStatus
declare function GdipSetPenLineCap197819(byval as GpPen ptr, byval as GpLineCap, byval as GpLineCap, byval as GpDashCap) as GpStatus
declare function GdipSetPenStartCap(byval as GpPen ptr, byval as GpLineCap) as GpStatus
declare function GdipSetPenEndCap(byval as GpPen ptr, byval as GpLineCap) as GpStatus
declare function GdipSetPenDashCap197819(byval as GpPen ptr, byval as GpDashCap) as GpStatus
declare function GdipGetPenStartCap(byval as GpPen ptr, byval as GpLineCap ptr) as GpStatus
declare function GdipGetPenEndCap(byval as GpPen ptr, byval as GpLineCap ptr) as GpStatus
declare function GdipGetPenDashCap197819(byval as GpPen ptr, byval as GpDashCap ptr) as GpStatus
declare function GdipSetPenLineJoin(byval as GpPen ptr, byval as GpLineJoin) as GpStatus
declare function GdipGetPenLineJoin(byval as GpPen ptr, byval as GpLineJoin ptr) as GpStatus
declare function GdipSetPenCustomStartCap(byval as GpPen ptr, byval as GpCustomLineCap ptr) as GpStatus
declare function GdipGetPenCustomStartCap(byval as GpPen ptr, byval as GpCustomLineCap ptr ptr) as GpStatus
declare function GdipSetPenCustomEndCap(byval as GpPen ptr, byval as GpCustomLineCap ptr) as GpStatus
declare function GdipGetPenCustomEndCap(byval as GpPen ptr, byval as GpCustomLineCap ptr ptr) as GpStatus
declare function GdipSetPenMiterLimit(byval as GpPen ptr, byval as REAL) as GpStatus
declare function GdipGetPenMiterLimit(byval as GpPen ptr, byval as REAL ptr) as GpStatus
declare function GdipSetPenMode(byval as GpPen ptr, byval as GpPenAlignment) as GpStatus
declare function GdipGetPenMode(byval as GpPen ptr, byval as GpPenAlignment ptr) as GpStatus
declare function GdipSetPenTransform(byval as GpPen ptr, byval as GpMatrix ptr) as GpStatus
declare function GdipGetPenTransform(byval as GpPen ptr, byval as GpMatrix ptr) as GpStatus
declare function GdipResetPenTransform(byval as GpPen ptr) as GpStatus
declare function GdipMultiplyPenTransform(byval as GpPen ptr, byval as const GpMatrix ptr, byval as GpMatrixOrder) as GpStatus
declare function GdipTranslatePenTransform(byval as GpPen ptr, byval as REAL, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipScalePenTransform(byval as GpPen ptr, byval as REAL, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipRotatePenTransform(byval as GpPen ptr, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipSetPenColor(byval as GpPen ptr, byval as ARGB) as GpStatus
declare function GdipGetPenColor(byval as GpPen ptr, byval as ARGB ptr) as GpStatus
declare function GdipSetPenBrushFill(byval as GpPen ptr, byval as GpBrush ptr) as GpStatus
declare function GdipGetPenBrushFill(byval as GpPen ptr, byval as GpBrush ptr ptr) as GpStatus
declare function GdipGetPenFillType(byval as GpPen ptr, byval as GpPenType ptr) as GpStatus
declare function GdipGetPenDashStyle(byval as GpPen ptr, byval as GpDashStyle ptr) as GpStatus
declare function GdipSetPenDashStyle(byval as GpPen ptr, byval as GpDashStyle) as GpStatus
declare function GdipGetPenDashOffset(byval as GpPen ptr, byval as REAL ptr) as GpStatus
declare function GdipSetPenDashOffset(byval as GpPen ptr, byval as REAL) as GpStatus
declare function GdipGetPenDashCount(byval as GpPen ptr, byval as INT_ ptr) as GpStatus
declare function GdipSetPenDashArray(byval as GpPen ptr, byval as const REAL ptr, byval as INT_) as GpStatus
declare function GdipGetPenDashArray(byval as GpPen ptr, byval as REAL ptr, byval as INT_) as GpStatus
declare function GdipGetPenCompoundCount(byval as GpPen ptr, byval as INT_ ptr) as GpStatus
declare function GdipSetPenCompoundArray(byval as GpPen ptr, byval as const REAL ptr, byval as INT_) as GpStatus
declare function GdipGetPenCompoundArray(byval as GpPen ptr, byval as REAL ptr, byval as INT_) as GpStatus
declare function GdipCreateRegion(byval as GpRegion ptr ptr) as GpStatus
declare function GdipCreateRegionRect(byval as const GpRectF ptr, byval as GpRegion ptr ptr) as GpStatus
declare function GdipCreateRegionRectI(byval as const GpRect ptr, byval as GpRegion ptr ptr) as GpStatus
declare function GdipCreateRegionPath(byval as GpPath ptr, byval as GpRegion ptr ptr) as GpStatus
declare function GdipCreateRegionRgnData(byval as const UBYTE ptr, byval as INT_, byval as GpRegion ptr ptr) as GpStatus
declare function GdipCreateRegionHrgn(byval as HRGN, byval as GpRegion ptr ptr) as GpStatus
declare function GdipCloneRegion(byval as GpRegion ptr, byval as GpRegion ptr ptr) as GpStatus
declare function GdipDeleteRegion(byval as GpRegion ptr) as GpStatus
declare function GdipSetInfinite(byval as GpRegion ptr) as GpStatus
declare function GdipSetEmpty(byval as GpRegion ptr) as GpStatus
declare function GdipCombineRegionRect(byval as GpRegion ptr, byval as const GpRectF ptr, byval as CombineMode) as GpStatus
declare function GdipCombineRegionRectI(byval as GpRegion ptr, byval as const GpRect ptr, byval as CombineMode) as GpStatus
declare function GdipCombineRegionPath(byval as GpRegion ptr, byval as GpPath ptr, byval as CombineMode) as GpStatus
declare function GdipCombineRegionRegion(byval as GpRegion ptr, byval as GpRegion ptr, byval as CombineMode) as GpStatus
declare function GdipTranslateRegion(byval as GpRegion ptr, byval as REAL, byval as REAL) as GpStatus
declare function GdipTranslateRegionI(byval as GpRegion ptr, byval as INT_, byval as INT_) as GpStatus
declare function GdipTransformRegion(byval as GpRegion ptr, byval as GpMatrix ptr) as GpStatus
declare function GdipGetRegionBounds(byval as GpRegion ptr, byval as GpGraphics ptr, byval as GpRectF ptr) as GpStatus
declare function GdipGetRegionBoundsI(byval as GpRegion ptr, byval as GpGraphics ptr, byval as GpRect ptr) as GpStatus
declare function GdipGetRegionHRgn(byval as GpRegion ptr, byval as GpGraphics ptr, byval as HRGN ptr) as GpStatus
declare function GdipIsEmptyRegion(byval as GpRegion ptr, byval as GpGraphics ptr, byval as BOOL ptr) as GpStatus
declare function GdipIsInfiniteRegion(byval as GpRegion ptr, byval as GpGraphics ptr, byval as BOOL ptr) as GpStatus
declare function GdipIsEqualRegion(byval as GpRegion ptr, byval as GpRegion ptr, byval as GpGraphics ptr, byval as BOOL ptr) as GpStatus
declare function GdipGetRegionDataSize(byval as GpRegion ptr, byval as UINT ptr) as GpStatus
declare function GdipGetRegionData(byval as GpRegion ptr, byval as UBYTE ptr, byval as UINT, byval as UINT ptr) as GpStatus
declare function GdipIsVisibleRegionPoint(byval as GpRegion ptr, byval as REAL, byval as REAL, byval as GpGraphics ptr, byval as BOOL ptr) as GpStatus
declare function GdipIsVisibleRegionPointI(byval as GpRegion ptr, byval as INT_, byval as INT_, byval as GpGraphics ptr, byval as BOOL ptr) as GpStatus
declare function GdipIsVisibleRegionRect(byval as GpRegion ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as GpGraphics ptr, byval as BOOL ptr) as GpStatus
declare function GdipIsVisibleRegionRectI(byval as GpRegion ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as GpGraphics ptr, byval as BOOL ptr) as GpStatus
declare function GdipGetRegionScansCount(byval as GpRegion ptr, byval as UINT ptr, byval as GpMatrix ptr) as GpStatus
declare function GdipGetRegionScans(byval as GpRegion ptr, byval as GpRectF ptr, byval as INT_ ptr, byval as GpMatrix ptr) as GpStatus
declare function GdipGetRegionScansI(byval as GpRegion ptr, byval as GpRect ptr, byval as INT_ ptr, byval as GpMatrix ptr) as GpStatus
declare function GdipCreateSolidFill(byval as ARGB, byval as GpSolidFill ptr ptr) as GpStatus
declare function GdipSetSolidFillColor(byval as GpSolidFill ptr, byval as ARGB) as GpStatus
declare function GdipGetSolidFillColor(byval as GpSolidFill ptr, byval as ARGB ptr) as GpStatus
declare function GdipCreateStringFormat(byval as INT_, byval as LANGID, byval as GpStringFormat ptr ptr) as GpStatus
declare function GdipStringFormatGetGenericDefault(byval as GpStringFormat ptr ptr) as GpStatus
declare function GdipStringFormatGetGenericTypographic(byval as GpStringFormat ptr ptr) as GpStatus
declare function GdipDeleteStringFormat(byval as GpStringFormat ptr) as GpStatus
declare function GdipCloneStringFormat(byval as const GpStringFormat ptr, byval as GpStringFormat ptr ptr) as GpStatus
declare function GdipSetStringFormatFlags(byval as GpStringFormat ptr, byval as INT_) as GpStatus
declare function GdipGetStringFormatFlags(byval as const GpStringFormat ptr, byval as INT_ ptr) as GpStatus
declare function GdipSetStringFormatAlign(byval as GpStringFormat ptr, byval as StringAlignment) as GpStatus
declare function GdipGetStringFormatAlign(byval as const GpStringFormat ptr, byval as StringAlignment ptr) as GpStatus
declare function GdipSetStringFormatLineAlign(byval as GpStringFormat ptr, byval as StringAlignment) as GpStatus
declare function GdipGetStringFormatLineAlign(byval as const GpStringFormat ptr, byval as StringAlignment ptr) as GpStatus
declare function GdipSetStringFormatTrimming(byval as GpStringFormat ptr, byval as StringTrimming) as GpStatus
declare function GdipGetStringFormatTrimming(byval as const GpStringFormat ptr, byval as StringTrimming ptr) as GpStatus
declare function GdipSetStringFormatHotkeyPrefix(byval as GpStringFormat ptr, byval as INT_) as GpStatus
declare function GdipGetStringFormatHotkeyPrefix(byval as const GpStringFormat ptr, byval as INT_ ptr) as GpStatus
declare function GdipSetStringFormatTabStops(byval as GpStringFormat ptr, byval as REAL, byval as INT_, byval as const REAL ptr) as GpStatus
declare function GdipGetStringFormatTabStops(byval as const GpStringFormat ptr, byval as INT_, byval as REAL ptr, byval as REAL ptr) as GpStatus
declare function GdipGetStringFormatTabStopCount(byval as const GpStringFormat ptr, byval as INT_ ptr) as GpStatus
declare function GdipSetStringFormatDigitSubstitution(byval as GpStringFormat ptr, byval as LANGID, byval as StringDigitSubstitute) as GpStatus
declare function GdipGetStringFormatDigitSubstitution(byval as const GpStringFormat ptr, byval as LANGID ptr, byval as StringDigitSubstitute ptr) as GpStatus
declare function GdipGetStringFormatMeasurableCharacterRangeCount(byval as const GpStringFormat ptr, byval as INT_ ptr) as GpStatus
declare function GdipSetStringFormatMeasurableCharacterRanges(byval as GpStringFormat ptr, byval as INT_, byval as const CharacterRange ptr) as GpStatus
declare function GdipDrawString(byval as GpGraphics ptr, byval as const wstring ptr, byval as INT_, byval as const GpFont ptr, byval as const RectF ptr, byval as const GpStringFormat ptr, byval as const GpBrush ptr) as GpStatus
declare function GdipMeasureString(byval as GpGraphics ptr, byval as const wstring ptr, byval as INT_, byval as const GpFont ptr, byval as const RectF ptr, byval as const GpStringFormat ptr, byval as RectF ptr, byval as INT_ ptr, byval as INT_ ptr) as GpStatus
declare function GdipDrawDriverString(byval as GpGraphics ptr, byval as const UINT16 ptr, byval as INT_, byval as const GpFont ptr, byval as const GpBrush ptr, byval as const PointF_ ptr, byval as INT_, byval as const GpMatrix ptr) as GpStatus
declare function GdipMeasureDriverString(byval as GpGraphics ptr, byval as const UINT16 ptr, byval as INT_, byval as const GpFont ptr, byval as const PointF_ ptr, byval as INT_, byval as const GpMatrix ptr, byval as RectF ptr) as GpStatus
declare function GdipCreateTexture(byval as GpImage ptr, byval as GpWrapMode, byval as GpTexture ptr ptr) as GpStatus
declare function GdipCreateTexture2(byval as GpImage ptr, byval as GpWrapMode, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as GpTexture ptr ptr) as GpStatus
declare function GdipCreateTexture2I(byval as GpImage ptr, byval as GpWrapMode, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as GpTexture ptr ptr) as GpStatus
declare function GdipCreateTextureIA(byval as GpImage ptr, byval as const GpImageAttributes ptr, byval as REAL, byval as REAL, byval as REAL, byval as REAL, byval as GpTexture ptr ptr) as GpStatus
declare function GdipCreateTextureIAI(byval as GpImage ptr, byval as const GpImageAttributes ptr, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as GpTexture ptr ptr) as GpStatus
declare function GdipGetTextureTransform(byval as GpTexture ptr, byval as GpMatrix ptr) as GpStatus
declare function GdipSetTextureTransform(byval as GpTexture ptr, byval as const GpMatrix ptr) as GpStatus
declare function GdipResetTextureTransform(byval as GpTexture ptr) as GpStatus
declare function GdipMultiplyTextureTransform(byval as GpTexture ptr, byval as const GpMatrix ptr, byval as GpMatrixOrder) as GpStatus
declare function GdipTranslateTextureTransform(byval as GpTexture ptr, byval as REAL, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipScaleTextureTransform(byval as GpTexture ptr, byval as REAL, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipRotateTextureTransform(byval as GpTexture ptr, byval as REAL, byval as GpMatrixOrder) as GpStatus
declare function GdipSetTextureWrapMode(byval as GpTexture ptr, byval as GpWrapMode) as GpStatus
declare function GdipGetTextureWrapMode(byval as GpTexture ptr, byval as GpWrapMode ptr) as GpStatus
declare function GdipGetTextureImage(byval as GpTexture ptr, byval as GpImage ptr ptr) as GpStatus
declare function GdipTestControl(byval as GpTestControlEnum, byval as any ptr) as GpStatus
#define __GDIPLUS_EFFECTS_H

type CurveAdjustments as long
enum
	AdjustExposure = 0
	AdjustDensity = 1
	AdjustContrast = 2
	AdjustHighlight = 3
	AdjustShadow = 4
	AdjustMidtone = 5
	AdjustWhiteSaturation = 6
	AdjustBlackSaturation = 7
end enum

type CurveChannel as long
enum
	CurveChannelAll = 0
	CurveChannelRed = 1
	CurveChannelGreen = 2
	CurveChannelBlue = 3
end enum

type BlurParams
	radius as REAL
	expandEdge as BOOL
end type

type BrightnessContrastParams
	brightnessLevel as INT_
	contrastLevel as INT_
end type

type ColorBalanceParams
	cyanRed as INT_
	magentaGreen as INT_
	yellowBlue as INT_
end type

type ColorCurveParams
	adjustment as CurveAdjustments
	channel as CurveChannel
	adjustValue as INT_
end type

type ColorLUTParams
	lutB(0 to 255) as UBYTE
	lutG(0 to 255) as UBYTE
	lutR(0 to 255) as UBYTE
	lutA(0 to 255) as UBYTE
end type

type HueSaturationLightnessParams
	hueLevel as INT_
	saturationLevel as INT_
	lightnessLevel as INT_
end type

type LevelsParams
	highlight as INT_
	midtone as INT_
	shadow as INT_
end type

type RedEyeCorrectionParams
	numberOfAreas as UINT
	areas as RECT ptr
end type

type SharpenParams
	radius as REAL
	amount as REAL
end type

type TintParams
	hue as INT_
	amount as INT_
end type

extern BlurEffectGuid as const GUID
extern BrightnessContrastEffectGuid as const GUID
extern ColorBalanceEffectGuid as const GUID
extern ColorCurveEffectGuid as const GUID
extern ColorLUTEffectGuid as const GUID
extern ColorMatrixEffectGuid as const GUID
extern HueSaturationLightnessEffectGuid as const GUID
extern LevelsEffectGuid as const GUID
extern RedEyeCorrectionEffectGuid as const GUID
extern SharpenEffectGuid as const GUID
extern TintEffectGuid as const GUID

#define __GDIPLUS_IMAGECODEC_H
#define GetImageDecoders(numDecoders, size, decoders) cast(GpStatus, GdipGetImageDecoders((numDecoders), (size), (decoders)))
#define GetImageDecodersSize(numDecoders, size) cast(GpStatus, GdipGetImageDecodersSize((numDecoders), (size)))
#define GetImageEncoders(numEncoders, size, encoders) cast(GpStatus, GdipGetImageEncoders((numEncoders), (size), (encoders)))
#define GetImageEncodersSize(numEncoders, size) cast(GpStatus, GdipGetImageEncodersSize((numEncoders), (size)))

end extern
