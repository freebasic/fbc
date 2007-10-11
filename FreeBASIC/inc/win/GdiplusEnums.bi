''
''
'' GdiplusEnums -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_GdiplusEnums_bi__
#define __win_GdiplusEnums_bi__

const FlatnessDefault = 1.0 / 4.0

type GraphicsState as UINT
type GraphicsContainer as UINT

extern "c"

enum FillMode
	FillModeAlternate
	FillModeWinding
end enum

enum QualityMode
	QualityModeInvalid = -1
	QualityModeDefault = 0
	QualityModeLow = 1
	QualityModeHigh = 2
end enum

enum CompositingMode
	CompositingModeSourceOver
	CompositingModeSourceCopy
end enum

enum CompositingQuality
	CompositingQualityInvalid = QualityModeInvalid
	CompositingQualityDefault = QualityModeDefault
	CompositingQualityHighSpeed = QualityModeLow
	CompositingQualityHighQuality = QualityModeHigh
	CompositingQualityGammaCorrected
	CompositingQualityAssumeLinear
end enum

enum Unit
	UnitWorld
	UnitDisplay
	UnitPixel
	UnitPoint
	UnitInch
	UnitDocument
	UnitMillimeter
end enum

enum MetafileFrameUnit
	MetafileFrameUnitPixel = UnitPixel
	MetafileFrameUnitPoint = UnitPoint
	MetafileFrameUnitInch = UnitInch
	MetafileFrameUnitDocument = UnitDocument
	MetafileFrameUnitMillimeter = UnitMillimeter
	MetafileFrameUnitGdi
end enum

enum CoordinateSpace
	CoordinateSpaceWorld
	CoordinateSpacePage
	CoordinateSpaceDevice
end enum

enum WrapMode
	WrapModeTile
	WrapModeTileFlipX
	WrapModeTileFlipY
	WrapModeTileFlipXY
	WrapModeClamp
end enum

enum HatchStyle
	HatchStyleHorizontal
	HatchStyleVertical
	HatchStyleForwardDiagonal
	HatchStyleBackwardDiagonal
	HatchStyleCross
	HatchStyleDiagonalCross
	HatchStyle05Percent
	HatchStyle10Percent
	HatchStyle20Percent
	HatchStyle25Percent
	HatchStyle30Percent
	HatchStyle40Percent
	HatchStyle50Percent
	HatchStyle60Percent
	HatchStyle70Percent
	HatchStyle75Percent
	HatchStyle80Percent
	HatchStyle90Percent
	HatchStyleLightDownwardDiagonal
	HatchStyleLightUpwardDiagonal
	HatchStyleDarkDownwardDiagonal
	HatchStyleDarkUpwardDiagonal
	HatchStyleWideDownwardDiagonal
	HatchStyleWideUpwardDiagonal
	HatchStyleLightVertical
	HatchStyleLightHorizontal
	HatchStyleNarrowVertical
	HatchStyleNarrowHorizontal
	HatchStyleDarkVertical
	HatchStyleDarkHorizontal
	HatchStyleDashedDownwardDiagonal
	HatchStyleDashedUpwardDiagonal
	HatchStyleDashedHorizontal
	HatchStyleDashedVertical
	HatchStyleSmallConfetti
	HatchStyleLargeConfetti
	HatchStyleZigZag
	HatchStyleWave
	HatchStyleDiagonalBrick
	HatchStyleHorizontalBrick
	HatchStyleWeave
	HatchStylePlaid
	HatchStyleDivot
	HatchStyleDottedGrid
	HatchStyleDottedDiamond
	HatchStyleShingle
	HatchStyleTrellis
	HatchStyleSphere
	HatchStyleSmallGrid
	HatchStyleSmallCheckerBoard
	HatchStyleLargeCheckerBoard
	HatchStyleOutlinedDiamond
	HatchStyleSolidDiamond
	HatchStyleTotal
	HatchStyleLargeGrid = HatchStyleCross
	HatchStyleMin = HatchStyleHorizontal
	HatchStyleMax = HatchStyleTotal-1
end enum

enum DashStyle
	DashStyleSolid
	DashStyleDash
	DashStyleDot
	DashStyleDashDot
	DashStyleDashDotDot
	DashStyleCustom
end enum

enum DashCap
	DashCapFlat = 0
	DashCapRound = 2
	DashCapTriangle = 3
end enum

enum LineCap
	LineCapFlat = 0
	LineCapSquare = 1
	LineCapRound = 2
	LineCapTriangle = 3
	LineCapNoAnchor = &h10
	LineCapSquareAnchor = &h11
	LineCapRoundAnchor = &h12
	LineCapDiamondAnchor = &h13
	LineCapArrowAnchor = &h14
	LineCapCustom = &hff
	LineCapAnchorMask = &hf0
end enum

enum CustomLineCapType
	CustomLineCapTypeDefault = 0
	CustomLineCapTypeAdjustableArrow = 1
end enum

enum LineJoin
	LineJoinMiter = 0
	LineJoinBevel = 1
	LineJoinRound = 2
	LineJoinMiterClipped = 3
end enum

enum PathPointType
	PathPointTypeStart = 0
	PathPointTypeLine = 1
	PathPointTypeBezier = 3
	PathPointTypePathTypeMask = &h07
	PathPointTypeDashMode = &h10
	PathPointTypePathMarker = &h20
	PathPointTypeCloseSubpath = &h80
	PathPointTypeBezier3 = 3
end enum

enum WarpMode
	WarpModePerspective
	WarpModeBilinear
end enum

enum LinearGradientMode
	LinearGradientModeHorizontal
	LinearGradientModeVertical
	LinearGradientModeForwardDiagonal
	LinearGradientModeBackwardDiagonal
end enum

enum CombineMode
	CombineModeReplace
	CombineModeIntersect
	CombineModeUnion
	CombineModeXor
	CombineModeExclude
	CombineModeComplement
end enum

enum ImageType
	ImageTypeUnknown
	ImageTypeBitmap
	ImageTypeMetafile
end enum

enum InterpolationMode
	InterpolationModeInvalid = QualityModeInvalid
	InterpolationModeDefault = QualityModeDefault
	InterpolationModeLowQuality = QualityModeLow
	InterpolationModeHighQuality = QualityModeHigh
	InterpolationModeBilinear
	InterpolationModeBicubic
	InterpolationModeNearestNeighbor
	InterpolationModeHighQualityBilinear
	InterpolationModeHighQualityBicubic
end enum

enum PenAlignment
	PenAlignmentCenter = 0
	PenAlignmentInset = 1
end enum

enum BrushType
	BrushTypeSolidColor = 0
	BrushTypeHatchFill = 1
	BrushTypeTextureFill = 2
	BrushTypePathGradient = 3
	BrushTypeLinearGradient = 4
end enum

enum PenType
	PenTypeSolidColor = BrushTypeSolidColor
	PenTypeHatchFill = BrushTypeHatchFill
	PenTypeTextureFill = BrushTypeTextureFill
	PenTypePathGradient = BrushTypePathGradient
	PenTypeLinearGradient = BrushTypeLinearGradient
	PenTypeUnknown = -1
end enum

enum MatrixOrder
	MatrixOrderPrepend = 0
	MatrixOrderAppend = 1
end enum

enum GenericFontFamily
	GenericFontFamilySerif
	GenericFontFamilySansSerif
	GenericFontFamilyMonospace
end enum

enum FontStyle
	FontStyleRegular = 0
	FontStyleBold = 1
	FontStyleItalic = 2
	FontStyleBoldItalic = 3
	FontStyleUnderline = 4
	FontStyleStrikeout = 8
end enum

enum SmoothingMode
	SmoothingModeInvalid = QualityModeInvalid
	SmoothingModeDefault = QualityModeDefault
	SmoothingModeHighSpeed = QualityModeLow
	SmoothingModeHighQuality = QualityModeHigh
	SmoothingModeNone
	SmoothingModeAntiAlias
end enum

enum PixelOffsetMode
	PixelOffsetModeInvalid = QualityModeInvalid
	PixelOffsetModeDefault = QualityModeDefault
	PixelOffsetModeHighSpeed = QualityModeLow
	PixelOffsetModeHighQuality = QualityModeHigh
	PixelOffsetModeNone
	PixelOffsetModeHalf
end enum

enum TextRenderingHint
	TextRenderingHintSystemDefault = 0
	TextRenderingHintSingleBitPerPixelGridFit
	TextRenderingHintSingleBitPerPixel
	TextRenderingHintAntiAliasGridFit
	TextRenderingHintAntiAlias
	TextRenderingHintClearTypeGridFit
end enum

enum MetafileType
	MetafileTypeInvalid
	MetafileTypeWmf
	MetafileTypeWmfPlaceable
	MetafileTypeEmf
	MetafileTypeEmfPlusOnly
	MetafileTypeEmfPlusDual
end enum

enum EmfType
	EmfTypeEmfOnly = MetafileTypeEmf
	EmfTypeEmfPlusOnly = MetafileTypeEmfPlusOnly
	EmfTypeEmfPlusDual = MetafileTypeEmfPlusDual
end enum

enum ObjectType
	ObjectTypeInvalid
	ObjectTypeBrush
	ObjectTypePen
	ObjectTypePath
	ObjectTypeRegion
	ObjectTypeImage
	ObjectTypeFont
	ObjectTypeStringFormat
	ObjectTypeImageAttributes
	ObjectTypeCustomLineCap
	ObjectTypeMax = ObjectTypeCustomLineCap
	ObjectTypeMin = ObjectTypeBrush
end enum

declare function ObjectTypeIsValid alias "ObjectTypeIsValid" (byval type as ObjectType) as BOOL

#define GDIP_EMFPLUS_RECORD_BASE &h00004000
#define GDIP_WMF_RECORD_BASE &h00010000

enum EmfPlusRecordType
	WmfRecordTypeSetBkColor = (((&h201) or &h00010000))
	WmfRecordTypeSetBkMode = (((&h102) or &h00010000))
	WmfRecordTypeSetMapMode = (((&h103) or &h00010000))
	WmfRecordTypeSetROP2 = (((&h104) or &h00010000))
	WmfRecordTypeSetRelAbs = (((&h105) or &h00010000))
	WmfRecordTypeSetPolyFillMode = (((&h106) or &h00010000))
	WmfRecordTypeSetStretchBltMode = (((&h107) or &h00010000))
	WmfRecordTypeSetTextCharExtra = (((&h108) or &h00010000))
	WmfRecordTypeSetTextColor = (((&h209) or &h00010000))
	WmfRecordTypeSetTextJustification = (((&h20A) or &h00010000))
	WmfRecordTypeSetWindowOrg = (((&h20B) or &h00010000))
	WmfRecordTypeSetWindowExt = (((&h20C) or &h00010000))
	WmfRecordTypeSetViewportOrg = (((&h20D) or &h00010000))
	WmfRecordTypeSetViewportExt = (((&h20E) or &h00010000))
	WmfRecordTypeOffsetWindowOrg = (((&h20F) or &h00010000))
	WmfRecordTypeScaleWindowExt = (((&h410) or &h00010000))
	WmfRecordTypeOffsetViewportOrg = (((&h211) or &h00010000))
	WmfRecordTypeScaleViewportExt = (((&h412) or &h00010000))
	WmfRecordTypeLineTo = (((&h213) or &h00010000))
	WmfRecordTypeMoveTo = (((&h214) or &h00010000))
	WmfRecordTypeExcludeClipRect = (((&h415) or &h00010000))
	WmfRecordTypeIntersectClipRect = (((&h416) or &h00010000))
	WmfRecordTypeArc = (((&h817) or &h00010000))
	WmfRecordTypeEllipse = (((&h418) or &h00010000))
	WmfRecordTypeFloodFill = (((&h419) or &h00010000))
	WmfRecordTypePie = (((&h81A) or &h00010000))
	WmfRecordTypeRectangle = (((&h41B) or &h00010000))
	WmfRecordTypeRoundRect = (((&h61C) or &h00010000))
	WmfRecordTypePatBlt = (((&h61D) or &h00010000))
	WmfRecordTypeSaveDC = (((&h1E) or &h00010000))
	WmfRecordTypeSetPixel = (((&h41F) or &h00010000))
	WmfRecordTypeOffsetClipRgn = (((&h220) or &h00010000))
	WmfRecordTypeTextOut = (((&h521) or &h00010000))
	WmfRecordTypeBitBlt = (((&h922) or &h00010000))
	WmfRecordTypeStretchBlt = (((&hB23) or &h00010000))
	WmfRecordTypePolygon = (((&h324) or &h00010000))
	WmfRecordTypePolyline = (((&h325) or &h00010000))
	WmfRecordTypeEscape = (((&h626) or &h00010000))
	WmfRecordTypeRestoreDC = (((&h127) or &h00010000))
	WmfRecordTypeFillRegion = (((&h228) or &h00010000))
	WmfRecordTypeFrameRegion = (((&h429) or &h00010000))
	WmfRecordTypeInvertRegion = (((&h12A) or &h00010000))
	WmfRecordTypePaintRegion = (((&h12B) or &h00010000))
	WmfRecordTypeSelectClipRegion = (((&h12C) or &h00010000))
	WmfRecordTypeSelectObject = (((&h12D) or &h00010000))
	WmfRecordTypeSetTextAlign = (((&h12E) or &h00010000))
	WmfRecordTypeDrawText = (((&h062F) or &h00010000))
	WmfRecordTypeChord = (((&h830) or &h00010000))
	WmfRecordTypeSetMapperFlags = (((&h231) or &h00010000))
	WmfRecordTypeExtTextOut = (((&ha32) or &h00010000))
	WmfRecordTypeSetDIBToDev = (((&hd33) or &h00010000))
	WmfRecordTypeSelectPalette = (((&h234) or &h00010000))
	WmfRecordTypeRealizePalette = (((&h35) or &h00010000))
	WmfRecordTypeAnimatePalette = (((&h436) or &h00010000))
	WmfRecordTypeSetPalEntries = (((&h37) or &h00010000))
	WmfRecordTypePolyPolygon = (((&h538) or &h00010000))
	WmfRecordTypeResizePalette = (((&h139) or &h00010000))
	WmfRecordTypeDIBBitBlt = (((&h940) or &h00010000))
	WmfRecordTypeDIBStretchBlt = (((&hb41) or &h00010000))
	WmfRecordTypeDIBCreatePatternBrush = (((&h142) or &h00010000))
	WmfRecordTypeStretchDIB = (((&hf43) or &h00010000))
	WmfRecordTypeExtFloodFill = (((&h548) or &h00010000))
	WmfRecordTypeSetLayout = (((&h0149) or &h00010000))
	WmfRecordTypeResetDC = (((&h014C) or &h00010000))
	WmfRecordTypeStartDoc = (((&h014D) or &h00010000))
	WmfRecordTypeStartPage = (((&h004F) or &h00010000))
	WmfRecordTypeEndPage = (((&h0050) or &h00010000))
	WmfRecordTypeAbortDoc = (((&h0052) or &h00010000))
	WmfRecordTypeEndDoc = (((&h005E) or &h00010000))
	WmfRecordTypeDeleteObject = (((&h1f0) or &h00010000))
	WmfRecordTypeCreatePalette = (((&hf7) or &h00010000))
	WmfRecordTypeCreateBrush = (((&h00F8) or &h00010000))
	WmfRecordTypeCreatePatternBrush = (((&h1F9) or &h00010000))
	WmfRecordTypeCreatePenIndirect = (((&h2FA) or &h00010000))
	WmfRecordTypeCreateFontIndirect = (((&h2FB) or &h00010000))
	WmfRecordTypeCreateBrushIndirect = (((&h2FC) or &h00010000))
	WmfRecordTypeCreateBitmapIndirect = (((&h02FD) or &h00010000))
	WmfRecordTypeCreateBitmap = (((&h06FE) or &h00010000))
	WmfRecordTypeCreateRegion = (((&h6FF) or &h00010000))
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
	EmfPlusRecordTypeInvalid = &h00004000
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
	EmfPlusRecordTotal
	EmfPlusRecordTypeMax = EmfPlusRecordTotal-1
	EmfPlusRecordTypeMin = EmfPlusRecordTypeHeader
end enum

enum StringFormatFlags
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

enum StringTrimming
	StringTrimmingNone = 0
	StringTrimmingCharacter = 1
	StringTrimmingWord = 2
	StringTrimmingEllipsisCharacter = 3
	StringTrimmingEllipsisWord = 4
	StringTrimmingEllipsisPath = 5
end enum

enum StringDigitSubstitute
	StringDigitSubstituteUser = 0
	StringDigitSubstituteNone = 1
	StringDigitSubstituteNational = 2
	StringDigitSubstituteTraditional = 3
end enum

enum HotkeyPrefix
	HotkeyPrefixNone = 0
	HotkeyPrefixShow = 1
	HotkeyPrefixHide = 2
end enum

enum StringAlignment
	StringAlignmentNear = 0
	StringAlignmentCenter = 1
	StringAlignmentFar = 2
end enum

enum DriverStringOptions
	DriverStringOptionsCmapLookup = 1
	DriverStringOptionsVertical = 2
	DriverStringOptionsRealizedAdvance = 4
	DriverStringOptionsLimitSubpixel = 8
end enum

enum FlushIntention
	FlushIntentionFlush = 0
	FlushIntentionSync = 1
end enum

enum EncoderParameterValueType
	EncoderParameterValueTypeByte = 1
	EncoderParameterValueTypeASCII = 2
	EncoderParameterValueTypeShort = 3
	EncoderParameterValueTypeLong = 4
	EncoderParameterValueTypeRational = 5
	EncoderParameterValueTypeLongRange = 6
	EncoderParameterValueTypeUndefined = 7
	EncoderParameterValueTypeRationalRange = 8
end enum

enum EncoderValue
	EncoderValueColorTypeCMYK
	EncoderValueColorTypeYCCK
	EncoderValueCompressionLZW
	EncoderValueCompressionCCITT3
	EncoderValueCompressionCCITT4
	EncoderValueCompressionRle
	EncoderValueCompressionNone
	EncoderValueScanMethodInterlaced
	EncoderValueScanMethodNonInterlaced
	EncoderValueVersionGif87
	EncoderValueVersionGif89
	EncoderValueRenderProgressive
	EncoderValueRenderNonProgressive
	EncoderValueTransformRotate90
	EncoderValueTransformRotate180
	EncoderValueTransformRotate270
	EncoderValueTransformFlipHorizontal
	EncoderValueTransformFlipVertical
	EncoderValueMultiFrame
	EncoderValueLastFrame
	EncoderValueFlush
	EncoderValueFrameDimensionTime
	EncoderValueFrameDimensionResolution
	EncoderValueFrameDimensionPage
end enum

enum EmfToWmfBitsFlags
	EmfToWmfBitsFlagsDefault = &h00000000
	EmfToWmfBitsFlagsEmbedEmf = &h00000001
	EmfToWmfBitsFlagsIncludePlaceable = &h00000002
	EmfToWmfBitsFlagsNoXORClip = &h00000004
end enum

enum GpTestControlEnum
	TestControlForceBilinear = 0
	TestControlNoICM = 1
	TestControlGetBuildNumber = 2
end enum

end extern

#endif
