''
''
'' gd -- A graphics library for fast image creation (header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gd_bi__
#define __gd_bi__

#inclib "gd"
#inclib "jpeg"
#inclib "png"

#include once "crt.bi"

#define PATHSEPARATOR ":"

#include once "gd/gd_io.bi"

#define gdMaxColors 256
#define gdAlphaMax 127
#define gdAlphaOpaque 0
#define gdAlphaTransparent 127
#define gdRedMax 255
#define gdGreenMax 255
#define gdBlueMax 255

declare function gdAlphaBlend alias "gdAlphaBlend" (byval dest as integer, byval src as integer) as integer

type gdImageStruct
	pixels as ubyte ptr ptr
	sx as integer
	sy as integer
	colorsTotal as integer
	red(0 to 256-1) as integer
	green(0 to 256-1) as integer
	blue(0 to 256-1) as integer
	open(0 to 256-1) as integer
	transparent as integer
	polyInts as integer ptr
	polyAllocated as integer
	brush as gdImageStruct ptr
	tile as gdImageStruct ptr
	brushColorMap(0 to 256-1) as integer
	tileColorMap(0 to 256-1) as integer
	styleLength as integer
	stylePos as integer
	style as integer ptr
	interlace as integer
	thick as integer
	alpha(0 to 256-1) as integer
	trueColor as integer
	tpixels as integer ptr ptr
	alphaBlendingFlag as integer
	saveAlphaFlag as integer
	AA as integer
	AA_color as integer
	AA_dont_blend as integer
	cx1 as integer
	cy1 as integer
	cx2 as integer
	cy2 as integer
end type

type gdImage as gdImageStruct
type gdImagePtr as gdImage ptr

type gdFont
	nchars as integer
	offset as integer
	w as integer
	h as integer
	data as byte ptr
end type

type gdFontPtr as gdFont ptr

#define gdDashSize 4
#define gdStyled (-2)
#define gdBrushed (-3)
#define gdStyledBrushed (-4)
#define gdTiled (-5)
#define gdTransparent (-6)
#define gdAntiAliased (-7)

declare function gdImageCreate alias "gdImageCreate" (byval sx as integer, byval sy as integer) as gdImagePtr
declare function gdImageCreateTrueColor alias "gdImageCreateTrueColor" (byval sx as integer, byval sy as integer) as gdImagePtr
declare function gdImageCreateFromPng alias "gdImageCreateFromPng" (byval fd as FILE ptr) as gdImagePtr
declare function gdImageCreateFromPngCtx alias "gdImageCreateFromPngCtx" (byval in as gdIOCtxPtr) as gdImagePtr
declare function gdImageCreateFromPngPtr alias "gdImageCreateFromPngPtr" (byval size as integer, byval data as any ptr) as gdImagePtr
declare function gdImageCreateFromGif alias "gdImageCreateFromGif" (byval fd as FILE ptr) as gdImagePtr
declare function gdImageCreateFromGifCtx alias "gdImageCreateFromGifCtx" (byval in as gdIOCtxPtr) as gdImagePtr
declare function gdImageCreateFromGifPtr alias "gdImageCreateFromGifPtr" (byval size as integer, byval data as any ptr) as gdImagePtr
declare function gdImageCreateFromWBMP alias "gdImageCreateFromWBMP" (byval inFile as FILE ptr) as gdImagePtr
declare function gdImageCreateFromWBMPCtx alias "gdImageCreateFromWBMPCtx" (byval infile as gdIOCtx ptr) as gdImagePtr
declare function gdImageCreateFromWBMPPtr alias "gdImageCreateFromWBMPPtr" (byval size as integer, byval data as any ptr) as gdImagePtr
declare function gdImageCreateFromJpeg alias "gdImageCreateFromJpeg" (byval infile as FILE ptr) as gdImagePtr
declare function gdImageCreateFromJpegCtx alias "gdImageCreateFromJpegCtx" (byval infile as gdIOCtx ptr) as gdImagePtr
declare function gdImageCreateFromJpegPtr alias "gdImageCreateFromJpegPtr" (byval size as integer, byval data as any ptr) as gdImagePtr

type gdSource
	source as function(byval as any ptr, byval as zstring ptr, byval as integer) as integer
	context as any ptr
end type

type gdSourcePtr as gdSource ptr

declare function gdImageCreateFromPngSource alias "gdImageCreateFromPngSource" (byval in as gdSourcePtr) as gdImagePtr
declare function gdImageCreateFromGd alias "gdImageCreateFromGd" (byval in as FILE ptr) as gdImagePtr
declare function gdImageCreateFromGdCtx alias "gdImageCreateFromGdCtx" (byval in as gdIOCtxPtr) as gdImagePtr
declare function gdImageCreateFromGdPtr alias "gdImageCreateFromGdPtr" (byval size as integer, byval data as any ptr) as gdImagePtr
declare function gdImageCreateFromGd2 alias "gdImageCreateFromGd2" (byval in as FILE ptr) as gdImagePtr
declare function gdImageCreateFromGd2Ctx alias "gdImageCreateFromGd2Ctx" (byval in as gdIOCtxPtr) as gdImagePtr
declare function gdImageCreateFromGd2Ptr alias "gdImageCreateFromGd2Ptr" (byval size as integer, byval data as any ptr) as gdImagePtr
declare function gdImageCreateFromGd2Part alias "gdImageCreateFromGd2Part" (byval in as FILE ptr, byval srcx as integer, byval srcy as integer, byval w as integer, byval h as integer) as gdImagePtr
declare function gdImageCreateFromGd2PartCtx alias "gdImageCreateFromGd2PartCtx" (byval in as gdIOCtxPtr, byval srcx as integer, byval srcy as integer, byval w as integer, byval h as integer) as gdImagePtr
declare function gdImageCreateFromGd2PartPtr alias "gdImageCreateFromGd2PartPtr" (byval size as integer, byval data as any ptr, byval srcx as integer, byval srcy as integer, byval w as integer, byval h as integer) as gdImagePtr
declare function gdImageCreateFromXbm alias "gdImageCreateFromXbm" (byval in as FILE ptr) as gdImagePtr
declare function gdImageCreateFromXpm alias "gdImageCreateFromXpm" (byval filename as zstring ptr) as gdImagePtr
declare sub gdImageDestroy alias "gdImageDestroy" (byval im as gdImagePtr)
declare sub gdImageSetPixel alias "gdImageSetPixel" (byval im as gdImagePtr, byval x as integer, byval y as integer, byval color as integer)
declare function gdImageGetPixel alias "gdImageGetPixel" (byval im as gdImagePtr, byval x as integer, byval y as integer) as integer
declare function gdImageGetTrueColorPixel alias "gdImageGetTrueColorPixel" (byval im as gdImagePtr, byval x as integer, byval y as integer) as integer
declare sub gdImageAABlend alias "gdImageAABlend" (byval im as gdImagePtr)
declare sub gdImageLine alias "gdImageLine" (byval im as gdImagePtr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval color as integer)
declare sub gdImageDashedLine alias "gdImageDashedLine" (byval im as gdImagePtr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval color as integer)
declare sub gdImageRectangle alias "gdImageRectangle" (byval im as gdImagePtr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval color as integer)
declare sub gdImageFilledRectangle alias "gdImageFilledRectangle" (byval im as gdImagePtr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval color as integer)
declare sub gdImageSetClip alias "gdImageSetClip" (byval im as gdImagePtr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer)
declare sub gdImageGetClip alias "gdImageGetClip" (byval im as gdImagePtr, byval x1P as integer ptr, byval y1P as integer ptr, byval x2P as integer ptr, byval y2P as integer ptr)
declare function gdImageBoundsSafe alias "gdImageBoundsSafe" (byval im as gdImagePtr, byval x as integer, byval y as integer) as integer
declare sub gdImageChar alias "gdImageChar" (byval im as gdImagePtr, byval f as gdFontPtr, byval x as integer, byval y as integer, byval c as integer, byval color as integer)
declare sub gdImageCharUp alias "gdImageCharUp" (byval im as gdImagePtr, byval f as gdFontPtr, byval x as integer, byval y as integer, byval c as integer, byval color as integer)
declare sub gdImageString alias "gdImageString" (byval im as gdImagePtr, byval f as gdFontPtr, byval x as integer, byval y as integer, byval s as ubyte ptr, byval color as integer)
declare sub gdImageStringUp alias "gdImageStringUp" (byval im as gdImagePtr, byval f as gdFontPtr, byval x as integer, byval y as integer, byval s as ubyte ptr, byval color as integer)
declare sub gdImageString16 alias "gdImageString16" (byval im as gdImagePtr, byval f as gdFontPtr, byval x as integer, byval y as integer, byval s as ushort ptr, byval color as integer)
declare sub gdImageStringUp16 alias "gdImageStringUp16" (byval im as gdImagePtr, byval f as gdFontPtr, byval x as integer, byval y as integer, byval s as ushort ptr, byval color as integer)
declare function gdFontCacheSetup alias "gdFontCacheSetup" () as integer
declare sub gdFontCacheShutdown alias "gdFontCacheShutdown" ()
declare sub gdFreeFontCache alias "gdFreeFontCache" ()
declare function gdImageStringTTF alias "gdImageStringTTF" (byval im as gdImage ptr, byval brect as integer ptr, byval fg as integer, byval fontlist as zstring ptr, byval ptsize as double, byval angle as double, byval x as integer, byval y as integer, byval string as zstring ptr) as zstring ptr
declare function gdImageStringFT alias "gdImageStringFT" (byval im as gdImage ptr, byval brect as integer ptr, byval fg as integer, byval fontlist as zstring ptr, byval ptsize as double, byval angle as double, byval x as integer, byval y as integer, byval string as zstring ptr) as zstring ptr

type gdFTStringExtra
	flags as integer
	linespacing as double
	charmap as integer
	hdpi as integer
	vdpi as integer
	xshow as byte ptr
	fontpath as byte ptr
end type

type gdFTStringExtraPtr as gdFTStringExtra ptr

#define gdFTEX_LINESPACE 1
#define gdFTEX_CHARMAP 2
#define gdFTEX_RESOLUTION 4
#define gdFTEX_DISABLE_KERNING 8
#define gdFTEX_XSHOW 16
#define gdFTEX_FONTPATHNAME 32
#define gdFTEX_FONTCONFIG 64
#define gdFTEX_RETURNFONTPATHNAME 128

declare function gdFTUseFontConfig alias "gdFTUseFontConfig" (byval flag as integer) as integer

#define gdFTEX_Unicode 0
#define gdFTEX_Shift_JIS 1
#define gdFTEX_Big5 2

declare function gdImageStringFTEx alias "gdImageStringFTEx" (byval im as gdImage ptr, byval brect as integer ptr, byval fg as integer, byval fontlist as zstring ptr, byval ptsize as double, byval angle as double, byval x as integer, byval y as integer, byval string as zstring ptr, byval strex as gdFTStringExtraPtr) as zstring ptr

type gdPoint
	x as integer
	y as integer
end type

type gdPointPtr as gdPoint ptr

declare sub gdImagePolygon alias "gdImagePolygon" (byval im as gdImagePtr, byval p as gdPointPtr, byval n as integer, byval c as integer)
declare sub gdImageOpenPolygon alias "gdImageOpenPolygon" (byval im as gdImagePtr, byval p as gdPointPtr, byval n as integer, byval c as integer)
declare sub gdImageFilledPolygon alias "gdImageFilledPolygon" (byval im as gdImagePtr, byval p as gdPointPtr, byval n as integer, byval c as integer)
declare function gdImageColorAllocate alias "gdImageColorAllocate" (byval im as gdImagePtr, byval r as integer, byval g as integer, byval b as integer) as integer
declare function gdImageColorAllocateAlpha alias "gdImageColorAllocateAlpha" (byval im as gdImagePtr, byval r as integer, byval g as integer, byval b as integer, byval a as integer) as integer
declare function gdImageColorClosest alias "gdImageColorClosest" (byval im as gdImagePtr, byval r as integer, byval g as integer, byval b as integer) as integer
declare function gdImageColorClosestAlpha alias "gdImageColorClosestAlpha" (byval im as gdImagePtr, byval r as integer, byval g as integer, byval b as integer, byval a as integer) as integer
declare function gdImageColorClosestHWB alias "gdImageColorClosestHWB" (byval im as gdImagePtr, byval r as integer, byval g as integer, byval b as integer) as integer
declare function gdImageColorExact alias "gdImageColorExact" (byval im as gdImagePtr, byval r as integer, byval g as integer, byval b as integer) as integer
declare function gdImageColorExactAlpha alias "gdImageColorExactAlpha" (byval im as gdImagePtr, byval r as integer, byval g as integer, byval b as integer, byval a as integer) as integer
declare function gdImageColorResolve alias "gdImageColorResolve" (byval im as gdImagePtr, byval r as integer, byval g as integer, byval b as integer) as integer
declare function gdImageColorResolveAlpha alias "gdImageColorResolveAlpha" (byval im as gdImagePtr, byval r as integer, byval g as integer, byval b as integer, byval a as integer) as integer
declare sub gdImageColorDeallocate alias "gdImageColorDeallocate" (byval im as gdImagePtr, byval color as integer)
declare function gdImageCreatePaletteFromTrueColor alias "gdImageCreatePaletteFromTrueColor" (byval im as gdImagePtr, byval ditherFlag as integer, byval colorsWanted as integer) as gdImagePtr
declare sub gdImageTrueColorToPalette alias "gdImageTrueColorToPalette" (byval im as gdImagePtr, byval ditherFlag as integer, byval colorsWanted as integer)
declare sub gdImageColorTransparent alias "gdImageColorTransparent" (byval im as gdImagePtr, byval color as integer)
declare sub gdImagePaletteCopy alias "gdImagePaletteCopy" (byval dst as gdImagePtr, byval src as gdImagePtr)
declare sub gdImageGif alias "gdImageGif" (byval im as gdImagePtr, byval out as FILE ptr)
declare sub gdImagePng alias "gdImagePng" (byval im as gdImagePtr, byval out as FILE ptr)
declare sub gdImagePngCtx alias "gdImagePngCtx" (byval im as gdImagePtr, byval out as gdIOCtx ptr)
declare sub gdImageGifCtx alias "gdImageGifCtx" (byval im as gdImagePtr, byval out as gdIOCtx ptr)
declare sub gdImagePngEx alias "gdImagePngEx" (byval im as gdImagePtr, byval out as FILE ptr, byval level as integer)
declare sub gdImagePngCtxEx alias "gdImagePngCtxEx" (byval im as gdImagePtr, byval out as gdIOCtx ptr, byval level as integer)
declare sub gdImageWBMP alias "gdImageWBMP" (byval image as gdImagePtr, byval fg as integer, byval out as FILE ptr)
declare sub gdImageWBMPCtx alias "gdImageWBMPCtx" (byval image as gdImagePtr, byval fg as integer, byval out as gdIOCtx ptr)
declare sub gdFree alias "gdFree" (byval m as any ptr)
declare function gdImageWBMPPtr alias "gdImageWBMPPtr" (byval im as gdImagePtr, byval size as integer ptr, byval fg as integer) as any ptr
declare sub gdImageJpeg alias "gdImageJpeg" (byval im as gdImagePtr, byval out as FILE ptr, byval quality as integer)
declare sub gdImageJpegCtx alias "gdImageJpegCtx" (byval im as gdImagePtr, byval out as gdIOCtx ptr, byval quality as integer)
declare function gdImageJpegPtr alias "gdImageJpegPtr" (byval im as gdImagePtr, byval size as integer ptr, byval quality as integer) as any ptr

enum 
	gdDisposalUnknown
	gdDisposalNone
	gdDisposalRestoreBackground
	gdDisposalRestorePrevious
end enum

declare sub gdImageGifAnimBegin alias "gdImageGifAnimBegin" (byval im as gdImagePtr, byval outFile as FILE ptr, byval GlobalCM as integer, byval Loops as integer)
declare sub gdImageGifAnimAdd alias "gdImageGifAnimAdd" (byval im as gdImagePtr, byval outFile as FILE ptr, byval LocalCM as integer, byval LeftOfs as integer, byval TopOfs as integer, byval Delay as integer, byval Disposal as integer, byval previm as gdImagePtr)
declare sub gdImageGifAnimEnd alias "gdImageGifAnimEnd" (byval outFile as FILE ptr)
declare sub gdImageGifAnimBeginCtx alias "gdImageGifAnimBeginCtx" (byval im as gdImagePtr, byval out as gdIOCtx ptr, byval GlobalCM as integer, byval Loops as integer)
declare sub gdImageGifAnimAddCtx alias "gdImageGifAnimAddCtx" (byval im as gdImagePtr, byval out as gdIOCtx ptr, byval LocalCM as integer, byval LeftOfs as integer, byval TopOfs as integer, byval Delay as integer, byval Disposal as integer, byval previm as gdImagePtr)
declare sub gdImageGifAnimEndCtx alias "gdImageGifAnimEndCtx" (byval out as gdIOCtx ptr)
declare function gdImageGifAnimBeginPtr alias "gdImageGifAnimBeginPtr" (byval im as gdImagePtr, byval size as integer ptr, byval GlobalCM as integer, byval Loops as integer) as any ptr
declare function gdImageGifAnimAddPtr alias "gdImageGifAnimAddPtr" (byval im as gdImagePtr, byval size as integer ptr, byval LocalCM as integer, byval LeftOfs as integer, byval TopOfs as integer, byval Delay as integer, byval Disposal as integer, byval previm as gdImagePtr) as any ptr
declare function gdImageGifAnimEndPtr alias "gdImageGifAnimEndPtr" (byval size as integer ptr) as any ptr

type gdSink
	sink as function(byval as any ptr, byval as zstring ptr, byval as integer) as integer
	context as any ptr
end type

type gdSinkPtr as gdSink ptr

declare sub gdImagePngToSink alias "gdImagePngToSink" (byval im as gdImagePtr, byval out as gdSinkPtr)
declare sub gdImageGd alias "gdImageGd" (byval im as gdImagePtr, byval out as FILE ptr)
declare sub gdImageGd2 alias "gdImageGd2" (byval im as gdImagePtr, byval out as FILE ptr, byval cs as integer, byval fmt as integer)
declare function gdImageGifPtr alias "gdImageGifPtr" (byval im as gdImagePtr, byval size as integer ptr) as any ptr
declare function gdImagePngPtr alias "gdImagePngPtr" (byval im as gdImagePtr, byval size as integer ptr) as any ptr
declare function gdImagePngPtrEx alias "gdImagePngPtrEx" (byval im as gdImagePtr, byval size as integer ptr, byval level as integer) as any ptr
declare function gdImageGdPtr alias "gdImageGdPtr" (byval im as gdImagePtr, byval size as integer ptr) as any ptr
declare function gdImageGd2Ptr alias "gdImageGd2Ptr" (byval im as gdImagePtr, byval cs as integer, byval fmt as integer, byval size as integer ptr) as any ptr
declare sub gdImageEllipse alias "gdImageEllipse" (byval im as gdImagePtr, byval cx as integer, byval cy as integer, byval w as integer, byval h as integer, byval color as integer)

#define gdArc 0
#define gdPie 0
#define gdChord 1
#define gdNoFill 2
#define gdEdged 4

declare sub gdImageFilledArc alias "gdImageFilledArc" (byval im as gdImagePtr, byval cx as integer, byval cy as integer, byval w as integer, byval h as integer, byval s as integer, byval e as integer, byval color as integer, byval style as integer)
declare sub gdImageArc alias "gdImageArc" (byval im as gdImagePtr, byval cx as integer, byval cy as integer, byval w as integer, byval h as integer, byval s as integer, byval e as integer, byval color as integer)
declare sub gdImageFilledEllipse alias "gdImageFilledEllipse" (byval im as gdImagePtr, byval cx as integer, byval cy as integer, byval w as integer, byval h as integer, byval color as integer)
declare sub gdImageFillToBorder alias "gdImageFillToBorder" (byval im as gdImagePtr, byval x as integer, byval y as integer, byval border as integer, byval color as integer)
declare sub gdImageFill alias "gdImageFill" (byval im as gdImagePtr, byval x as integer, byval y as integer, byval color as integer)
declare sub gdImageCopy alias "gdImageCopy" (byval dst as gdImagePtr, byval src as gdImagePtr, byval dstX as integer, byval dstY as integer, byval srcX as integer, byval srcY as integer, byval w as integer, byval h as integer)
declare sub gdImageCopyMerge alias "gdImageCopyMerge" (byval dst as gdImagePtr, byval src as gdImagePtr, byval dstX as integer, byval dstY as integer, byval srcX as integer, byval srcY as integer, byval w as integer, byval h as integer, byval pct as integer)
declare sub gdImageCopyMergeGray alias "gdImageCopyMergeGray" (byval dst as gdImagePtr, byval src as gdImagePtr, byval dstX as integer, byval dstY as integer, byval srcX as integer, byval srcY as integer, byval w as integer, byval h as integer, byval pct as integer)
declare sub gdImageCopyResized alias "gdImageCopyResized" (byval dst as gdImagePtr, byval src as gdImagePtr, byval dstX as integer, byval dstY as integer, byval srcX as integer, byval srcY as integer, byval dstW as integer, byval dstH as integer, byval srcW as integer, byval srcH as integer)
declare sub gdImageCopyResampled alias "gdImageCopyResampled" (byval dst as gdImagePtr, byval src as gdImagePtr, byval dstX as integer, byval dstY as integer, byval srcX as integer, byval srcY as integer, byval dstW as integer, byval dstH as integer, byval srcW as integer, byval srcH as integer)
declare sub gdImageCopyRotated alias "gdImageCopyRotated" (byval dst as gdImagePtr, byval src as gdImagePtr, byval dstX as double, byval dstY as double, byval srcX as integer, byval srcY as integer, byval srcWidth as integer, byval srcHeight as integer, byval angle as integer)
declare sub gdImageSetBrush alias "gdImageSetBrush" (byval im as gdImagePtr, byval brush as gdImagePtr)
declare sub gdImageSetTile alias "gdImageSetTile" (byval im as gdImagePtr, byval tile as gdImagePtr)
declare sub gdImageSetAntiAliased alias "gdImageSetAntiAliased" (byval im as gdImagePtr, byval c as integer)
declare sub gdImageSetAntiAliasedDontBlend alias "gdImageSetAntiAliasedDontBlend" (byval im as gdImagePtr, byval c as integer, byval dont_blend as integer)
declare sub gdImageSetStyle alias "gdImageSetStyle" (byval im as gdImagePtr, byval style as integer ptr, byval noOfPixels as integer)
declare sub gdImageSetThickness alias "gdImageSetThickness" (byval im as gdImagePtr, byval thickness as integer)
declare sub gdImageInterlace alias "gdImageInterlace" (byval im as gdImagePtr, byval interlaceArg as integer)
declare sub gdImageAlphaBlending alias "gdImageAlphaBlending" (byval im as gdImagePtr, byval alphaBlendingArg as integer)
declare sub gdImageSaveAlpha alias "gdImageSaveAlpha" (byval im as gdImagePtr, byval saveAlphaArg as integer)
declare function gdNewFileCtx alias "gdNewFileCtx" (byval as FILE ptr) as gdIOCtx ptr
declare function gdNewDynamicCtx alias "gdNewDynamicCtx" (byval size as integer, byval data as any ptr) as gdIOCtx ptr
declare function gdNewDynamicCtxEx alias "gdNewDynamicCtxEx" (byval size as integer, byval data as any ptr, byval freeFlag as integer) as gdIOCtx ptr
declare function gdNewSSCtx alias "gdNewSSCtx" (byval in as gdSourcePtr, byval out as gdSinkPtr) as gdIOCtx ptr
declare function gdDPExtractData alias "gdDPExtractData" (byval ctx as gdIOCtx ptr, byval size as integer ptr) as any ptr

#define GD2_CHUNKSIZE 128
#define GD2_CHUNKSIZE_MIN 64
#define GD2_CHUNKSIZE_MAX 4096
#define GD2_VERS 2
#define GD2_ID "gd2"
#define GD2_FMT_RAW 1
#define GD2_FMT_COMPRESSED 2

declare function gdImageCompare alias "gdImageCompare" (byval im1 as gdImagePtr, byval im2 as gdImagePtr) as integer

#define GD_CMP_IMAGE 1
#define GD_CMP_NUM_COLORS 2
#define GD_CMP_COLOR 4
#define GD_CMP_SIZE_X 8
#define GD_CMP_SIZE_Y 16
#define GD_CMP_TRANSPARENT 32
#define GD_CMP_BACKGROUND 64
#define GD_CMP_INTERLACE 128
#define GD_CMP_TRUECOLOR 256
#define GD_RESOLUTION 96

#include once "gd/gdfx.bi"

#endif
