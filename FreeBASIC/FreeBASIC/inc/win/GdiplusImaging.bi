''
''
'' GdiplusImaging -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_GdiplusImaging_bi__
#define __win_GdiplusImaging_bi__

type ImageCodecInfo
	Clsid as CLSID
	FormatID as GUID
	CodecName as WCHAR ptr
	DllName as WCHAR ptr
	FormatDescription as WCHAR ptr
	FilenameExtension as WCHAR ptr
	MimeType as WCHAR ptr
	Flags as DWORD
	Version as DWORD
	SigCount as DWORD
	SigSize as DWORD
	SigPattern as UBYTE ptr
	SigMask as UBYTE ptr
end type

enum ImageCodecFlags
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

type BitmapData
	Width as UINT
	Height as UINT
	Stride as INT_
	PixelFormat as PixelFormat
	Scan0 as any ptr
	Reserved as UINT_PTR
end type

enum ImageLockMode
	ImageLockModeRead = &h0001
	ImageLockModeWrite = &h0002
	ImageLockModeUserInputBuf = &h0004
end enum

enum ImageFlags
	ImageFlagsNone = 0
	ImageFlagsScalable = &h0001
	ImageFlagsHasAlpha = &h0002
	ImageFlagsHasTranslucent = &h0004
	ImageFlagsPartiallyScalable = &h0008
	ImageFlagsColorSpaceRGB = &h0010
	ImageFlagsColorSpaceCMYK = &h0020
	ImageFlagsColorSpaceGRAY = &h0040
	ImageFlagsColorSpaceYCBCR = &h0080
	ImageFlagsColorSpaceYCCK = &h0100
	ImageFlagsHasRealDPI = &h1000
	ImageFlagsHasRealPixelSize = &h2000
	ImageFlagsReadOnly = &h00010000
	ImageFlagsCaching = &h00020000
end enum

enum RotateFlipType
	RotateNoneFlipNone = 0
	Rotate90FlipNone = 1
	Rotate180FlipNone = 2
	Rotate270FlipNone = 3
	RotateNoneFlipX = 4
	Rotate90FlipX = 5
	Rotate180FlipX = 6
	Rotate270FlipX = 7
	RotateNoneFlipY = Rotate180FlipX
	Rotate90FlipY = Rotate270FlipX
	Rotate180FlipY = RotateNoneFlipX
	Rotate270FlipY = Rotate90FlipX
	RotateNoneFlipXY = Rotate180FlipNone
	Rotate90FlipXY = Rotate270FlipNone
	Rotate180FlipXY = RotateNoneFlipNone
	Rotate270FlipXY = Rotate90FlipNone
end enum

type EncoderParameter
	Guid as GUID
	NumberOfValues as ULONG
	Type as ULONG
	Value as any ptr
end type

type EncoderParameters
	Count as UINT
	Parameter(0 to 1-1) as EncoderParameter
end type

type PropertyItem
	id as PROPID
	length as ULONG
	type as WORD
	value as any ptr
end type
	
#define PropertyTagTypeByte 1
#define PropertyTagTypeASCII 2
#define PropertyTagTypeShort 3
#define PropertyTagTypeLong 4
#define PropertyTagTypeRational 5
#define PropertyTagTypeUndefined 7
#define PropertyTagTypeSLONG 9
#define PropertyTagTypeSRational 10
#define PropertyTagExifIFD &h8769
#define PropertyTagGpsIFD &h8825
#define PropertyTagNewSubfileType &h00FE
#define PropertyTagSubfileType &h00FF
#define PropertyTagImageWidth &h0100
#define PropertyTagImageHeight &h0101
#define PropertyTagBitsPerSample &h0102
#define PropertyTagCompression &h0103
#define PropertyTagPhotometricInterp &h0106
#define PropertyTagThreshHolding &h0107
#define PropertyTagCellWidth &h0108
#define PropertyTagCellHeight &h0109
#define PropertyTagFillOrder &h010A
#define PropertyTagDocumentName &h010D
#define PropertyTagImageDescription &h010E
#define PropertyTagEquipMake &h010F
#define PropertyTagEquipModel &h0110
#define PropertyTagStripOffsets &h0111
#define PropertyTagOrientation &h0112
#define PropertyTagSamplesPerPixel &h0115
#define PropertyTagRowsPerStrip &h0116
#define PropertyTagStripBytesCount &h0117
#define PropertyTagMinSampleValue &h0118
#define PropertyTagMaxSampleValue &h0119
#define PropertyTagXResolution &h011A
#define PropertyTagYResolution &h011B
#define PropertyTagPlanarConfig &h011C
#define PropertyTagPageName &h011D
#define PropertyTagXPosition &h011E
#define PropertyTagYPosition &h011F
#define PropertyTagFreeOffset &h0120
#define PropertyTagFreeByteCounts &h0121
#define PropertyTagGrayResponseUnit &h0122
#define PropertyTagGrayResponseCurve &h0123
#define PropertyTagT4Option &h0124
#define PropertyTagT6Option &h0125
#define PropertyTagResolutionUnit &h0128
#define PropertyTagPageNumber &h0129
#define PropertyTagTransferFuncition &h012D
#define PropertyTagSoftwareUsed &h0131
#define PropertyTagDateTime &h0132
#define PropertyTagArtist &h013B
#define PropertyTagHostComputer &h013C
#define PropertyTagPredictor &h013D
#define PropertyTagWhitePoint &h013E
#define PropertyTagPrimaryChromaticities &h013F
#define PropertyTagColorMap &h0140
#define PropertyTagHalftoneHints &h0141
#define PropertyTagTileWidth &h0142
#define PropertyTagTileLength &h0143
#define PropertyTagTileOffset &h0144
#define PropertyTagTileByteCounts &h0145
#define PropertyTagInkSet &h014C
#define PropertyTagInkNames &h014D
#define PropertyTagNumberOfInks &h014E
#define PropertyTagDotRange &h0150
#define PropertyTagTargetPrinter &h0151
#define PropertyTagExtraSamples &h0152
#define PropertyTagSampleFormat &h0153
#define PropertyTagSMinSampleValue &h0154
#define PropertyTagSMaxSampleValue &h0155
#define PropertyTagTransferRange &h0156
#define PropertyTagJPEGProc &h0200
#define PropertyTagJPEGInterFormat &h0201
#define PropertyTagJPEGInterLength &h0202
#define PropertyTagJPEGRestartInterval &h0203
#define PropertyTagJPEGLosslessPredictors &h0205
#define PropertyTagJPEGPointTransforms &h0206
#define PropertyTagJPEGQTables &h0207
#define PropertyTagJPEGDCTables &h0208
#define PropertyTagJPEGACTables &h0209
#define PropertyTagYCbCrCoefficients &h0211
#define PropertyTagYCbCrSubsampling &h0212
#define PropertyTagYCbCrPositioning &h0213
#define PropertyTagREFBlackWhite &h0214
#define PropertyTagICCProfile &h8773
#define PropertyTagGamma &h0301
#define PropertyTagICCProfileDescriptor &h0302
#define PropertyTagSRGBRenderingIntent &h0303
#define PropertyTagImageTitle &h0320
#define PropertyTagCopyright &h8298
#define PropertyTagResolutionXUnit &h5001
#define PropertyTagResolutionYUnit &h5002
#define PropertyTagResolutionXLengthUnit &h5003
#define PropertyTagResolutionYLengthUnit &h5004
#define PropertyTagPrintFlags &h5005
#define PropertyTagPrintFlagsVersion &h5006
#define PropertyTagPrintFlagsCrop &h5007
#define PropertyTagPrintFlagsBleedWidth &h5008
#define PropertyTagPrintFlagsBleedWidthScale &h5009
#define PropertyTagHalftoneLPI &h500A
#define PropertyTagHalftoneLPIUnit &h500B
#define PropertyTagHalftoneDegree &h500C
#define PropertyTagHalftoneShape &h500D
#define PropertyTagHalftoneMisc &h500E
#define PropertyTagHalftoneScreen &h500F
#define PropertyTagJPEGQuality &h5010
#define PropertyTagGridSize &h5011
#define PropertyTagThumbnailFormat &h5012
#define PropertyTagThumbnailWidth &h5013
#define PropertyTagThumbnailHeight &h5014
#define PropertyTagThumbnailColorDepth &h5015
#define PropertyTagThumbnailPlanes &h5016
#define PropertyTagThumbnailRawBytes &h5017
#define PropertyTagThumbnailSize &h5018
#define PropertyTagThumbnailCompressedSize &h5019
#define PropertyTagColorTransferFunction &h501A
#define PropertyTagThumbnailData &h501B
#define PropertyTagThumbnailImageWidth &h5020
#define PropertyTagThumbnailImageHeight &h5021
#define PropertyTagThumbnailBitsPerSample &h5022
#define PropertyTagThumbnailCompression &h5023
#define PropertyTagThumbnailPhotometricInterp &h5024
#define PropertyTagThumbnailImageDescription &h5025
#define PropertyTagThumbnailEquipMake &h5026
#define PropertyTagThumbnailEquipModel &h5027
#define PropertyTagThumbnailStripOffsets &h5028
#define PropertyTagThumbnailOrientation &h5029
#define PropertyTagThumbnailSamplesPerPixel &h502A
#define PropertyTagThumbnailRowsPerStrip &h502B
#define PropertyTagThumbnailStripBytesCount &h502C
#define PropertyTagThumbnailResolutionX &h502D
#define PropertyTagThumbnailResolutionY &h502E
#define PropertyTagThumbnailPlanarConfig &h502F
#define PropertyTagThumbnailResolutionUnit &h5030
#define PropertyTagThumbnailTransferFunction &h5031
#define PropertyTagThumbnailSoftwareUsed &h5032
#define PropertyTagThumbnailDateTime &h5033
#define PropertyTagThumbnailArtist &h5034
#define PropertyTagThumbnailWhitePoint &h5035
#define PropertyTagThumbnailPrimaryChromaticities &h5036
#define PropertyTagThumbnailYCbCrCoefficients &h5037
#define PropertyTagThumbnailYCbCrSubsampling &h5038
#define PropertyTagThumbnailYCbCrPositioning &h5039
#define PropertyTagThumbnailRefBlackWhite &h503A
#define PropertyTagThumbnailCopyRight &h503B
#define PropertyTagLuminanceTable &h5090
#define PropertyTagChrominanceTable &h5091
#define PropertyTagFrameDelay &h5100
#define PropertyTagLoopCount &h5101
#define PropertyTagPixelUnit &h5110
#define PropertyTagPixelPerUnitX &h5111
#define PropertyTagPixelPerUnitY &h5112
#define PropertyTagPaletteHistogram &h5113
#define PropertyTagExifExposureTime &h829A
#define PropertyTagExifFNumber &h829D
#define PropertyTagExifExposureProg &h8822
#define PropertyTagExifSpectralSense &h8824
#define PropertyTagExifISOSpeed &h8827
#define PropertyTagExifOECF &h8828
#define PropertyTagExifVer &h9000
#define PropertyTagExifDTOrig &h9003
#define PropertyTagExifDTDigitized &h9004
#define PropertyTagExifCompConfig &h9101
#define PropertyTagExifCompBPP &h9102
#define PropertyTagExifShutterSpeed &h9201
#define PropertyTagExifAperture &h9202
#define PropertyTagExifBrightness &h9203
#define PropertyTagExifExposureBias &h9204
#define PropertyTagExifMaxAperture &h9205
#define PropertyTagExifSubjectDist &h9206
#define PropertyTagExifMeteringMode &h9207
#define PropertyTagExifLightSource &h9208
#define PropertyTagExifFlash &h9209
#define PropertyTagExifFocalLength &h920A
#define PropertyTagExifMakerNote &h927C
#define PropertyTagExifUserComment &h9286
#define PropertyTagExifDTSubsec &h9290
#define PropertyTagExifDTOrigSS &h9291
#define PropertyTagExifDTDigSS &h9292
#define PropertyTagExifFPXVer &hA000
#define PropertyTagExifColorSpace &hA001
#define PropertyTagExifPixXDim &hA002
#define PropertyTagExifPixYDim &hA003
#define PropertyTagExifRelatedWav &hA004
#define PropertyTagExifInterop &hA005
#define PropertyTagExifFlashEnergy &hA20B
#define PropertyTagExifSpatialFR &hA20C
#define PropertyTagExifFocalXRes &hA20E
#define PropertyTagExifFocalYRes &hA20F
#define PropertyTagExifFocalResUnit &hA210
#define PropertyTagExifSubjectLoc &hA214
#define PropertyTagExifExposureIndex &hA215
#define PropertyTagExifSensingMethod &hA217
#define PropertyTagExifFileSource &hA300
#define PropertyTagExifSceneType &hA301
#define PropertyTagExifCfaPattern &hA302
#define PropertyTagGpsVer &h0000
#define PropertyTagGpsLatitudeRef &h0001
#define PropertyTagGpsLatitude &h0002
#define PropertyTagGpsLongitudeRef &h0003
#define PropertyTagGpsLongitude &h0004
#define PropertyTagGpsAltitudeRef &h0005
#define PropertyTagGpsAltitude &h0006
#define PropertyTagGpsGpsTime &h0007
#define PropertyTagGpsGpsSatellites &h0008
#define PropertyTagGpsGpsStatus &h0009
#define PropertyTagGpsGpsMeasureMode &h00A
#define PropertyTagGpsGpsDop &h000B
#define PropertyTagGpsSpeedRef &h000C
#define PropertyTagGpsSpeed &h000D
#define PropertyTagGpsTrackRef &h000E
#define PropertyTagGpsTrack &h000F
#define PropertyTagGpsImgDirRef &h0010
#define PropertyTagGpsImgDir &h0011
#define PropertyTagGpsMapDatum &h0012
#define PropertyTagGpsDestLatRef &h0013
#define PropertyTagGpsDestLat &h0014
#define PropertyTagGpsDestLongRef &h0015
#define PropertyTagGpsDestLong &h0016
#define PropertyTagGpsDestBearRef &h0017
#define PropertyTagGpsDestBear &h0018
#define PropertyTagGpsDestDistRef &h0019
#define PropertyTagGpsDestDist &h001A

#endif
