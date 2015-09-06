'' FreeBASIC binding for FreeImage3170
''
'' based on the C header files:
''    FreeImage 3
''
''    Design and implementation by
''    - Floris van den Berg (flvdberg@wxs.nl)
''    - Hervé Drolon (drolon@infonie.fr)
''
''    Contributors:
''    - see changes log named 'Whatsnew.txt', see header of each .h and .cpp file
''
''    This file is part of FreeImage 3
''
''    COVERED CODE IS PROVIDED UNDER THIS LICENSE ON AN "AS IS" BASIS, WITHOUT WARRANTY
''    OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, WITHOUT LIMITATION, WARRANTIES
''    THAT THE COVERED CODE IS FREE OF DEFECTS, MERCHANTABLE, FIT FOR A PARTICULAR PURPOSE
''    OR NON-INFRINGING. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE COVERED
''    CODE IS WITH YOU. SHOULD ANY COVERED CODE PROVE DEFECTIVE IN ANY RESPECT, YOU (NOT
''    THE INITIAL DEVELOPER OR ANY OTHER CONTRIBUTOR) ASSUME THE COST OF ANY NECESSARY
''    SERVICING, REPAIR OR CORRECTION. THIS DISCLAIMER OF WARRANTY CONSTITUTES AN ESSENTIAL
''    PART OF THIS LICENSE. NO USE OF ANY COVERED CODE IS AUTHORIZED HEREUNDER EXCEPT UNDER
''    THIS DISCLAIMER.
''
''    Use at your own risk!
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#ifdef __FB_WIN32__
	#inclib "FreeImage"
#else
	#inclib "freeimage"
#endif

#include once "crt/long.bi"
#include once "crt/wchar.bi"

'' The following symbols have been renamed:
''     constant TRUE => CTRUE

#ifdef __FB_WIN32__
	extern "Windows"
#else
	extern "C"
#endif

#define FREEIMAGE_H
const FREEIMAGE_MAJOR_VERSION = 3
const FREEIMAGE_MINOR_VERSION = 17
const FREEIMAGE_RELEASE_SERIAL = 0
const FREEIMAGE_COLORORDER_BGR = 0
const FREEIMAGE_COLORORDER_RGB = 1
const FREEIMAGE_COLORORDER = FREEIMAGE_COLORORDER_BGR

type FIBITMAP
	data as any ptr
end type

type FIMULTIBITMAP
	data as any ptr
end type

#define _WINDOWS_
#ifndef FALSE
	const FALSE = 0
#endif
#ifndef CTRUE
	const CTRUE = 1
#endif
#ifndef TRUE
	const TRUE = 1
#endif
#ifndef NULL
	const NULL = 0
#endif
#ifndef SEEK_SET
const SEEK_SET = 0
const SEEK_CUR = 1
const SEEK_END = 2
#endif

#ifndef BITMAPINFO
type BOOL as long
type WORD as ushort
type DWORD as ulong
type INT64 as longint
type UINT64 as ulongint

type tagRGBQUAD field = 1
	rgbBlue as UBYTE
	rgbGreen as UBYTE
	rgbRed as UBYTE
	rgbReserved as UBYTE
end type

type RGBQUAD as tagRGBQUAD

type tagRGBTRIPLE field = 1
	rgbtBlue as UBYTE
	rgbtGreen as UBYTE
	rgbtRed as UBYTE
end type

type RGBTRIPLE as tagRGBTRIPLE

type tagBITMAPINFOHEADER
	biSize as DWORD
	biWidth as LONG
	biHeight as LONG
	biPlanes as WORD
	biBitCount as WORD
	biCompression as DWORD
	biSizeImage as DWORD
	biXPelsPerMeter as LONG
	biYPelsPerMeter as LONG
	biClrUsed as DWORD
	biClrImportant as DWORD
end type

type BITMAPINFOHEADER as tagBITMAPINFOHEADER
type PBITMAPINFOHEADER as tagBITMAPINFOHEADER ptr

type tagBITMAPINFO
	bmiHeader as BITMAPINFOHEADER
	bmiColors(0 to 0) as RGBQUAD
end type

type BITMAPINFO as tagBITMAPINFO
type PBITMAPINFO as tagBITMAPINFO ptr
#endif

type tagFIRGB16 field = 1
	red as WORD
	green as WORD
	blue as WORD
end type

type FIRGB16 as tagFIRGB16

type tagFIRGBA16 field = 1
	red as WORD
	green as WORD
	blue as WORD
	alpha as WORD
end type

type FIRGBA16 as tagFIRGBA16

type tagFIRGBF field = 1
	red as single
	green as single
	blue as single
end type

type FIRGBF as tagFIRGBF

type tagFIRGBAF field = 1
	red as single
	green as single
	blue as single
	alpha as single
end type

type FIRGBAF as tagFIRGBAF

type tagFICOMPLEX field = 1
	r as double
	i as double
end type

type FICOMPLEX as tagFICOMPLEX
const FI_RGBA_RED = 2
const FI_RGBA_GREEN = 1
const FI_RGBA_BLUE = 0
const FI_RGBA_ALPHA = 3
const FI_RGBA_RED_MASK = &h00FF0000
const FI_RGBA_GREEN_MASK = &h0000FF00
const FI_RGBA_BLUE_MASK = &h000000FF
const FI_RGBA_ALPHA_MASK = &hFF000000
const FI_RGBA_RED_SHIFT = 16
const FI_RGBA_GREEN_SHIFT = 8
const FI_RGBA_BLUE_SHIFT = 0
const FI_RGBA_ALPHA_SHIFT = 24
const FI_RGBA_RGB_MASK = (FI_RGBA_RED_MASK or FI_RGBA_GREEN_MASK) or FI_RGBA_BLUE_MASK
const FI16_555_RED_MASK = &h7C00
const FI16_555_GREEN_MASK = &h03E0
const FI16_555_BLUE_MASK = &h001F
const FI16_555_RED_SHIFT = 10
const FI16_555_GREEN_SHIFT = 5
const FI16_555_BLUE_SHIFT = 0
const FI16_565_RED_MASK = &hF800
const FI16_565_GREEN_MASK = &h07E0
const FI16_565_BLUE_MASK = &h001F
const FI16_565_RED_SHIFT = 11
const FI16_565_GREEN_SHIFT = 5
const FI16_565_BLUE_SHIFT = 0
const FIICC_DEFAULT = &h00
const FIICC_COLOR_IS_CMYK = &h01

type FIICCPROFILE
	flags as WORD
	size as DWORD
	data as any ptr
end type

type FREE_IMAGE_FORMAT as long
enum
	FIF_UNKNOWN = -1
	FIF_BMP = 0
	FIF_ICO = 1
	FIF_JPEG = 2
	FIF_JNG = 3
	FIF_KOALA = 4
	FIF_LBM = 5
	FIF_IFF = FIF_LBM
	FIF_MNG = 6
	FIF_PBM = 7
	FIF_PBMRAW = 8
	FIF_PCD = 9
	FIF_PCX = 10
	FIF_PGM = 11
	FIF_PGMRAW = 12
	FIF_PNG = 13
	FIF_PPM = 14
	FIF_PPMRAW = 15
	FIF_RAS = 16
	FIF_TARGA = 17
	FIF_TIFF = 18
	FIF_WBMP = 19
	FIF_PSD = 20
	FIF_CUT = 21
	FIF_XBM = 22
	FIF_XPM = 23
	FIF_DDS = 24
	FIF_GIF = 25
	FIF_HDR = 26
	FIF_FAXG3 = 27
	FIF_SGI = 28
	FIF_EXR = 29
	FIF_J2K = 30
	FIF_JP2 = 31
	FIF_PFM = 32
	FIF_PICT = 33
	FIF_RAW = 34
	FIF_WEBP = 35
	FIF_JXR = 36
end enum

type FREE_IMAGE_TYPE as long
enum
	FIT_UNKNOWN = 0
	FIT_BITMAP = 1
	FIT_UINT16 = 2
	FIT_INT16 = 3
	FIT_UINT32 = 4
	FIT_INT32 = 5
	FIT_FLOAT = 6
	FIT_DOUBLE = 7
	FIT_COMPLEX = 8
	FIT_RGB16 = 9
	FIT_RGBA16 = 10
	FIT_RGBF = 11
	FIT_RGBAF = 12
end enum

type FREE_IMAGE_COLOR_TYPE as long
enum
	FIC_MINISWHITE = 0
	FIC_MINISBLACK = 1
	FIC_RGB = 2
	FIC_PALETTE = 3
	FIC_RGBALPHA = 4
	FIC_CMYK = 5
end enum

type FREE_IMAGE_QUANTIZE as long
enum
	FIQ_WUQUANT = 0
	FIQ_NNQUANT = 1
	FIQ_LFPQUANT = 2
end enum

type FREE_IMAGE_DITHER as long
enum
	FID_FS = 0
	FID_BAYER4x4 = 1
	FID_BAYER8x8 = 2
	FID_CLUSTER6x6 = 3
	FID_CLUSTER8x8 = 4
	FID_CLUSTER16x16 = 5
	FID_BAYER16x16 = 6
end enum

type FREE_IMAGE_JPEG_OPERATION as long
enum
	FIJPEG_OP_NONE = 0
	FIJPEG_OP_FLIP_H = 1
	FIJPEG_OP_FLIP_V = 2
	FIJPEG_OP_TRANSPOSE = 3
	FIJPEG_OP_TRANSVERSE = 4
	FIJPEG_OP_ROTATE_90 = 5
	FIJPEG_OP_ROTATE_180 = 6
	FIJPEG_OP_ROTATE_270 = 7
end enum

type FREE_IMAGE_TMO as long
enum
	FITMO_DRAGO03 = 0
	FITMO_REINHARD05 = 1
	FITMO_FATTAL02 = 2
end enum

type FREE_IMAGE_FILTER as long
enum
	FILTER_BOX = 0
	FILTER_BICUBIC = 1
	FILTER_BILINEAR = 2
	FILTER_BSPLINE = 3
	FILTER_CATMULLROM = 4
	FILTER_LANCZOS3 = 5
end enum

type FREE_IMAGE_COLOR_CHANNEL as long
enum
	FICC_RGB = 0
	FICC_RED = 1
	FICC_GREEN = 2
	FICC_BLUE = 3
	FICC_ALPHA = 4
	FICC_BLACK = 5
	FICC_REAL = 6
	FICC_IMAG = 7
	FICC_MAG = 8
	FICC_PHASE = 9
end enum

type FREE_IMAGE_MDTYPE as long
enum
	FIDT_NOTYPE = 0
	FIDT_BYTE = 1
	FIDT_ASCII = 2
	FIDT_SHORT = 3
	FIDT_LONG = 4
	FIDT_RATIONAL = 5
	FIDT_SBYTE = 6
	FIDT_UNDEFINED = 7
	FIDT_SSHORT = 8
	FIDT_SLONG = 9
	FIDT_SRATIONAL = 10
	FIDT_FLOAT = 11
	FIDT_DOUBLE = 12
	FIDT_IFD = 13
	FIDT_PALETTE = 14
	FIDT_LONG8 = 16
	FIDT_SLONG8 = 17
	FIDT_IFD8 = 18
end enum

type FREE_IMAGE_MDMODEL as long
enum
	FIMD_NODATA = -1
	FIMD_COMMENTS = 0
	FIMD_EXIF_MAIN = 1
	FIMD_EXIF_EXIF = 2
	FIMD_EXIF_GPS = 3
	FIMD_EXIF_MAKERNOTE = 4
	FIMD_EXIF_INTEROP = 5
	FIMD_IPTC = 6
	FIMD_XMP = 7
	FIMD_GEOTIFF = 8
	FIMD_ANIMATION = 9
	FIMD_CUSTOM = 10
	FIMD_EXIF_RAW = 11
end enum

type FIMETADATA
	data as any ptr
end type

type FITAG
	data as any ptr
end type

#define FREEIMAGE_IO
type fi_handle as any ptr
type FI_ReadProc as function(byval buffer as any ptr, byval size as ulong, byval count as ulong, byval handle as fi_handle) as ulong
type FI_WriteProc as function(byval buffer as any ptr, byval size as ulong, byval count as ulong, byval handle as fi_handle) as ulong
type FI_SeekProc as function(byval handle as fi_handle, byval offset as clong, byval origin as long) as long
type FI_TellProc as function(byval handle as fi_handle) as clong

type FreeImageIO field = 1
	read_proc as FI_ReadProc
	write_proc as FI_WriteProc
	seek_proc as FI_SeekProc
	tell_proc as FI_TellProc
end type

type FIMEMORY
	data as any ptr
end type

type FI_FormatProc as function() as const zstring ptr
type FI_DescriptionProc as function() as const zstring ptr
type FI_ExtensionListProc as function() as const zstring ptr
type FI_RegExprProc as function() as const zstring ptr
type FI_OpenProc as function(byval io as FreeImageIO ptr, byval handle as fi_handle, byval read as BOOL) as any ptr
type FI_CloseProc as sub(byval io as FreeImageIO ptr, byval handle as fi_handle, byval data as any ptr)
type FI_PageCountProc as function(byval io as FreeImageIO ptr, byval handle as fi_handle, byval data as any ptr) as long
type FI_PageCapabilityProc as function(byval io as FreeImageIO ptr, byval handle as fi_handle, byval data as any ptr) as long
type FI_LoadProc as function(byval io as FreeImageIO ptr, byval handle as fi_handle, byval page as long, byval flags as long, byval data as any ptr) as FIBITMAP ptr
type FI_SaveProc as function(byval io as FreeImageIO ptr, byval dib as FIBITMAP ptr, byval handle as fi_handle, byval page as long, byval flags as long, byval data as any ptr) as BOOL
type FI_ValidateProc as function(byval io as FreeImageIO ptr, byval handle as fi_handle) as BOOL
type FI_MimeProc as function() as const zstring ptr
type FI_SupportsExportBPPProc as function(byval bpp as long) as BOOL
type FI_SupportsExportTypeProc as function(byval type as FREE_IMAGE_TYPE) as BOOL
type FI_SupportsICCProfilesProc as function() as BOOL
type FI_SupportsNoPixelsProc as function() as BOOL

type Plugin
	format_proc as FI_FormatProc
	description_proc as FI_DescriptionProc
	extension_proc as FI_ExtensionListProc
	regexpr_proc as FI_RegExprProc
	open_proc as FI_OpenProc
	close_proc as FI_CloseProc
	pagecount_proc as FI_PageCountProc
	pagecapability_proc as FI_PageCapabilityProc
	load_proc as FI_LoadProc
	save_proc as FI_SaveProc
	validate_proc as FI_ValidateProc
	mime_proc as FI_MimeProc
	supports_export_bpp_proc as FI_SupportsExportBPPProc
	supports_export_type_proc as FI_SupportsExportTypeProc
	supports_icc_profiles_proc as FI_SupportsICCProfilesProc
	supports_no_pixels_proc as FI_SupportsNoPixelsProc
end type

type FI_InitProc as sub(byval plugin as Plugin ptr, byval format_id as long)
const FIF_LOAD_NOPIXELS = &h8000
const BMP_DEFAULT = 0
const BMP_SAVE_RLE = 1
const CUT_DEFAULT = 0
const DDS_DEFAULT = 0
const EXR_DEFAULT = 0
const EXR_FLOAT = &h0001
const EXR_NONE = &h0002
const EXR_ZIP = &h0004
const EXR_PIZ = &h0008
const EXR_PXR24 = &h0010
const EXR_B44 = &h0020
const EXR_LC = &h0040
const FAXG3_DEFAULT = 0
const GIF_DEFAULT = 0
const GIF_LOAD256 = 1
const GIF_PLAYBACK = 2
const HDR_DEFAULT = 0
const ICO_DEFAULT = 0
const ICO_MAKEALPHA = 1
const IFF_DEFAULT = 0
const J2K_DEFAULT = 0
const JP2_DEFAULT = 0
const JPEG_DEFAULT = 0
const JPEG_FAST = &h0001
const JPEG_ACCURATE = &h0002
const JPEG_CMYK = &h0004
const JPEG_EXIFROTATE = &h0008
const JPEG_GREYSCALE = &h0010
const JPEG_QUALITYSUPERB = &h80
const JPEG_QUALITYGOOD = &h0100
const JPEG_QUALITYNORMAL = &h0200
const JPEG_QUALITYAVERAGE = &h0400
const JPEG_QUALITYBAD = &h0800
const JPEG_PROGRESSIVE = &h2000
const JPEG_SUBSAMPLING_411 = &h1000
const JPEG_SUBSAMPLING_420 = &h4000
const JPEG_SUBSAMPLING_422 = &h8000
const JPEG_SUBSAMPLING_444 = &h10000
const JPEG_OPTIMIZE = &h20000
const JPEG_BASELINE = &h40000
const KOALA_DEFAULT = 0
const LBM_DEFAULT = 0
const MNG_DEFAULT = 0
const PCD_DEFAULT = 0
const PCD_BASE = 1
const PCD_BASEDIV4 = 2
const PCD_BASEDIV16 = 3
const PCX_DEFAULT = 0
const PFM_DEFAULT = 0
const PICT_DEFAULT = 0
const PNG_DEFAULT = 0
const PNG_IGNOREGAMMA = 1
const PNG_Z_BEST_SPEED = &h0001
const PNG_Z_DEFAULT_COMPRESSION = &h0006
const PNG_Z_BEST_COMPRESSION = &h0009
const PNG_Z_NO_COMPRESSION = &h0100
const PNG_INTERLACED = &h0200
const PNM_DEFAULT = 0
const PNM_SAVE_RAW = 0
const PNM_SAVE_ASCII = 1
const PSD_DEFAULT = 0
const PSD_CMYK = 1
const PSD_LAB = 2
const RAS_DEFAULT = 0
const RAW_DEFAULT = 0
const RAW_PREVIEW = 1
const RAW_DISPLAY = 2
const RAW_HALFSIZE = 4
const RAW_UNPROCESSED = 8
const SGI_DEFAULT = 0
const TARGA_DEFAULT = 0
const TARGA_LOAD_RGB888 = 1
const TARGA_SAVE_RLE = 2
const TIFF_DEFAULT = 0
const TIFF_CMYK = &h0001
const TIFF_PACKBITS = &h0100
const TIFF_DEFLATE = &h0200
const TIFF_ADOBE_DEFLATE = &h0400
const TIFF_NONE = &h0800
const TIFF_CCITTFAX3 = &h1000
const TIFF_CCITTFAX4 = &h2000
const TIFF_LZW = &h4000
const TIFF_JPEG = &h8000
const TIFF_LOGLUV = &h10000
const WBMP_DEFAULT = 0
const XBM_DEFAULT = 0
const XPM_DEFAULT = 0
const WEBP_DEFAULT = 0
const WEBP_LOSSLESS = &h100
const JXR_DEFAULT = 0
const JXR_LOSSLESS = &h0064
const JXR_PROGRESSIVE = &h2000
const FI_COLOR_IS_RGB_COLOR = &h00
const FI_COLOR_IS_RGBA_COLOR = &h01
const FI_COLOR_FIND_EQUAL_COLOR = &h02
const FI_COLOR_ALPHA_IS_INDEX = &h04
const FI_COLOR_PALETTE_SEARCH_MASK = FI_COLOR_FIND_EQUAL_COLOR or FI_COLOR_ALPHA_IS_INDEX
const FI_RESCALE_DEFAULT = &h00
const FI_RESCALE_TRUE_COLOR = &h01
const FI_RESCALE_OMIT_METADATA = &h02

declare sub FreeImage_Initialise(byval load_local_plugins_only as BOOL = 0)
declare sub FreeImage_DeInitialise()
declare function FreeImage_GetVersion() as const zstring ptr
declare function FreeImage_GetCopyrightMessage() as const zstring ptr
type FreeImage_OutputMessageFunction as sub cdecl(byval fif as FREE_IMAGE_FORMAT, byval msg as const zstring ptr)
type FreeImage_OutputMessageFunctionStdCall as sub(byval fif as FREE_IMAGE_FORMAT, byval msg as const zstring ptr)
declare sub FreeImage_SetOutputMessageStdCall(byval omf as FreeImage_OutputMessageFunctionStdCall)
declare sub FreeImage_SetOutputMessage(byval omf as FreeImage_OutputMessageFunction)
declare sub FreeImage_OutputMessageProc cdecl(byval fif as long, byval fmt as const zstring ptr, ...)
declare function FreeImage_Allocate(byval width as long, byval height as long, byval bpp as long, byval red_mask as ulong = 0, byval green_mask as ulong = 0, byval blue_mask as ulong = 0) as FIBITMAP ptr
declare function FreeImage_AllocateT(byval type as FREE_IMAGE_TYPE, byval width as long, byval height as long, byval bpp as long = 8, byval red_mask as ulong = 0, byval green_mask as ulong = 0, byval blue_mask as ulong = 0) as FIBITMAP ptr
declare function FreeImage_Clone(byval dib as FIBITMAP ptr) as FIBITMAP ptr
declare sub FreeImage_Unload(byval dib as FIBITMAP ptr)
declare function FreeImage_HasPixels(byval dib as FIBITMAP ptr) as BOOL
declare function FreeImage_Load(byval fif as FREE_IMAGE_FORMAT, byval filename as const zstring ptr, byval flags as long = 0) as FIBITMAP ptr
declare function FreeImage_LoadU(byval fif as FREE_IMAGE_FORMAT, byval filename as const wstring ptr, byval flags as long = 0) as FIBITMAP ptr
declare function FreeImage_LoadFromHandle(byval fif as FREE_IMAGE_FORMAT, byval io as FreeImageIO ptr, byval handle as fi_handle, byval flags as long = 0) as FIBITMAP ptr
declare function FreeImage_Save(byval fif as FREE_IMAGE_FORMAT, byval dib as FIBITMAP ptr, byval filename as const zstring ptr, byval flags as long = 0) as BOOL
declare function FreeImage_SaveU(byval fif as FREE_IMAGE_FORMAT, byval dib as FIBITMAP ptr, byval filename as const wstring ptr, byval flags as long = 0) as BOOL
declare function FreeImage_SaveToHandle(byval fif as FREE_IMAGE_FORMAT, byval dib as FIBITMAP ptr, byval io as FreeImageIO ptr, byval handle as fi_handle, byval flags as long = 0) as BOOL
declare function FreeImage_OpenMemory(byval data as UBYTE ptr = 0, byval size_in_bytes as DWORD = 0) as FIMEMORY ptr
declare sub FreeImage_CloseMemory(byval stream as FIMEMORY ptr)
declare function FreeImage_LoadFromMemory(byval fif as FREE_IMAGE_FORMAT, byval stream as FIMEMORY ptr, byval flags as long = 0) as FIBITMAP ptr
declare function FreeImage_SaveToMemory(byval fif as FREE_IMAGE_FORMAT, byval dib as FIBITMAP ptr, byval stream as FIMEMORY ptr, byval flags as long = 0) as BOOL
declare function FreeImage_TellMemory(byval stream as FIMEMORY ptr) as clong
declare function FreeImage_SeekMemory(byval stream as FIMEMORY ptr, byval offset as clong, byval origin as long) as BOOL
declare function FreeImage_AcquireMemory(byval stream as FIMEMORY ptr, byval data as UBYTE ptr ptr, byval size_in_bytes as DWORD ptr) as BOOL
declare function FreeImage_ReadMemory(byval buffer as any ptr, byval size as ulong, byval count as ulong, byval stream as FIMEMORY ptr) as ulong
declare function FreeImage_WriteMemory(byval buffer as const any ptr, byval size as ulong, byval count as ulong, byval stream as FIMEMORY ptr) as ulong
declare function FreeImage_LoadMultiBitmapFromMemory(byval fif as FREE_IMAGE_FORMAT, byval stream as FIMEMORY ptr, byval flags as long = 0) as FIMULTIBITMAP ptr
declare function FreeImage_SaveMultiBitmapToMemory(byval fif as FREE_IMAGE_FORMAT, byval bitmap as FIMULTIBITMAP ptr, byval stream as FIMEMORY ptr, byval flags as long) as BOOL
declare function FreeImage_RegisterLocalPlugin(byval proc_address as FI_InitProc, byval format as const zstring ptr = 0, byval description as const zstring ptr = 0, byval extension as const zstring ptr = 0, byval regexpr as const zstring ptr = 0) as FREE_IMAGE_FORMAT
declare function FreeImage_RegisterExternalPlugin(byval path as const zstring ptr, byval format as const zstring ptr = 0, byval description as const zstring ptr = 0, byval extension as const zstring ptr = 0, byval regexpr as const zstring ptr = 0) as FREE_IMAGE_FORMAT
declare function FreeImage_GetFIFCount() as long
declare function FreeImage_SetPluginEnabled(byval fif as FREE_IMAGE_FORMAT, byval enable as BOOL) as long
declare function FreeImage_IsPluginEnabled(byval fif as FREE_IMAGE_FORMAT) as long
declare function FreeImage_GetFIFFromFormat(byval format as const zstring ptr) as FREE_IMAGE_FORMAT
declare function FreeImage_GetFIFFromMime(byval mime as const zstring ptr) as FREE_IMAGE_FORMAT
declare function FreeImage_GetFormatFromFIF(byval fif as FREE_IMAGE_FORMAT) as const zstring ptr
declare function FreeImage_GetFIFExtensionList(byval fif as FREE_IMAGE_FORMAT) as const zstring ptr
declare function FreeImage_GetFIFDescription(byval fif as FREE_IMAGE_FORMAT) as const zstring ptr
declare function FreeImage_GetFIFRegExpr(byval fif as FREE_IMAGE_FORMAT) as const zstring ptr
declare function FreeImage_GetFIFMimeType(byval fif as FREE_IMAGE_FORMAT) as const zstring ptr
declare function FreeImage_GetFIFFromFilename(byval filename as const zstring ptr) as FREE_IMAGE_FORMAT
declare function FreeImage_GetFIFFromFilenameU(byval filename as const wstring ptr) as FREE_IMAGE_FORMAT
declare function FreeImage_FIFSupportsReading(byval fif as FREE_IMAGE_FORMAT) as BOOL
declare function FreeImage_FIFSupportsWriting(byval fif as FREE_IMAGE_FORMAT) as BOOL
declare function FreeImage_FIFSupportsExportBPP(byval fif as FREE_IMAGE_FORMAT, byval bpp as long) as BOOL
declare function FreeImage_FIFSupportsExportType(byval fif as FREE_IMAGE_FORMAT, byval type as FREE_IMAGE_TYPE) as BOOL
declare function FreeImage_FIFSupportsICCProfiles(byval fif as FREE_IMAGE_FORMAT) as BOOL
declare function FreeImage_FIFSupportsNoPixels(byval fif as FREE_IMAGE_FORMAT) as BOOL
declare function FreeImage_OpenMultiBitmap(byval fif as FREE_IMAGE_FORMAT, byval filename as const zstring ptr, byval create_new as BOOL, byval read_only as BOOL, byval keep_cache_in_memory as BOOL = 0, byval flags as long = 0) as FIMULTIBITMAP ptr
declare function FreeImage_OpenMultiBitmapFromHandle(byval fif as FREE_IMAGE_FORMAT, byval io as FreeImageIO ptr, byval handle as fi_handle, byval flags as long = 0) as FIMULTIBITMAP ptr
declare function FreeImage_SaveMultiBitmapToHandle(byval fif as FREE_IMAGE_FORMAT, byval bitmap as FIMULTIBITMAP ptr, byval io as FreeImageIO ptr, byval handle as fi_handle, byval flags as long = 0) as BOOL
declare function FreeImage_CloseMultiBitmap(byval bitmap as FIMULTIBITMAP ptr, byval flags as long = 0) as BOOL
declare function FreeImage_GetPageCount(byval bitmap as FIMULTIBITMAP ptr) as long
declare sub FreeImage_AppendPage(byval bitmap as FIMULTIBITMAP ptr, byval data as FIBITMAP ptr)
declare sub FreeImage_InsertPage(byval bitmap as FIMULTIBITMAP ptr, byval page as long, byval data as FIBITMAP ptr)
declare sub FreeImage_DeletePage(byval bitmap as FIMULTIBITMAP ptr, byval page as long)
declare function FreeImage_LockPage(byval bitmap as FIMULTIBITMAP ptr, byval page as long) as FIBITMAP ptr
declare sub FreeImage_UnlockPage(byval bitmap as FIMULTIBITMAP ptr, byval data as FIBITMAP ptr, byval changed as BOOL)
declare function FreeImage_MovePage(byval bitmap as FIMULTIBITMAP ptr, byval target as long, byval source as long) as BOOL
declare function FreeImage_GetLockedPageNumbers(byval bitmap as FIMULTIBITMAP ptr, byval pages as long ptr, byval count as long ptr) as BOOL
declare function FreeImage_GetFileType(byval filename as const zstring ptr, byval size as long = 0) as FREE_IMAGE_FORMAT
declare function FreeImage_GetFileTypeU(byval filename as const wstring ptr, byval size as long = 0) as FREE_IMAGE_FORMAT
declare function FreeImage_GetFileTypeFromHandle(byval io as FreeImageIO ptr, byval handle as fi_handle, byval size as long = 0) as FREE_IMAGE_FORMAT
declare function FreeImage_GetFileTypeFromMemory(byval stream as FIMEMORY ptr, byval size as long = 0) as FREE_IMAGE_FORMAT
declare function FreeImage_GetImageType(byval dib as FIBITMAP ptr) as FREE_IMAGE_TYPE
declare function FreeImage_IsLittleEndian() as BOOL
declare function FreeImage_LookupX11Color(byval szColor as const zstring ptr, byval nRed as UBYTE ptr, byval nGreen as UBYTE ptr, byval nBlue as UBYTE ptr) as BOOL
declare function FreeImage_LookupSVGColor(byval szColor as const zstring ptr, byval nRed as UBYTE ptr, byval nGreen as UBYTE ptr, byval nBlue as UBYTE ptr) as BOOL
declare function FreeImage_GetBits(byval dib as FIBITMAP ptr) as UBYTE ptr
declare function FreeImage_GetScanLine(byval dib as FIBITMAP ptr, byval scanline as long) as UBYTE ptr
declare function FreeImage_GetPixelIndex(byval dib as FIBITMAP ptr, byval x as ulong, byval y as ulong, byval value as UBYTE ptr) as BOOL
declare function FreeImage_GetPixelColor(byval dib as FIBITMAP ptr, byval x as ulong, byval y as ulong, byval value as RGBQUAD ptr) as BOOL
declare function FreeImage_SetPixelIndex(byval dib as FIBITMAP ptr, byval x as ulong, byval y as ulong, byval value as UBYTE ptr) as BOOL
declare function FreeImage_SetPixelColor(byval dib as FIBITMAP ptr, byval x as ulong, byval y as ulong, byval value as RGBQUAD ptr) as BOOL
declare function FreeImage_GetColorsUsed(byval dib as FIBITMAP ptr) as ulong
declare function FreeImage_GetBPP(byval dib as FIBITMAP ptr) as ulong
declare function FreeImage_GetWidth(byval dib as FIBITMAP ptr) as ulong
declare function FreeImage_GetHeight(byval dib as FIBITMAP ptr) as ulong
declare function FreeImage_GetLine(byval dib as FIBITMAP ptr) as ulong
declare function FreeImage_GetPitch(byval dib as FIBITMAP ptr) as ulong
declare function FreeImage_GetDIBSize(byval dib as FIBITMAP ptr) as ulong
declare function FreeImage_GetMemorySize(byval dib as FIBITMAP ptr) as ulong
declare function FreeImage_GetPalette(byval dib as FIBITMAP ptr) as RGBQUAD ptr
declare function FreeImage_GetDotsPerMeterX(byval dib as FIBITMAP ptr) as ulong
declare function FreeImage_GetDotsPerMeterY(byval dib as FIBITMAP ptr) as ulong
declare sub FreeImage_SetDotsPerMeterX(byval dib as FIBITMAP ptr, byval res as ulong)
declare sub FreeImage_SetDotsPerMeterY(byval dib as FIBITMAP ptr, byval res as ulong)
declare function FreeImage_GetInfoHeader(byval dib as FIBITMAP ptr) as BITMAPINFOHEADER ptr
declare function FreeImage_GetInfo(byval dib as FIBITMAP ptr) as BITMAPINFO ptr
declare function FreeImage_GetColorType(byval dib as FIBITMAP ptr) as FREE_IMAGE_COLOR_TYPE
declare function FreeImage_GetRedMask(byval dib as FIBITMAP ptr) as ulong
declare function FreeImage_GetGreenMask(byval dib as FIBITMAP ptr) as ulong
declare function FreeImage_GetBlueMask(byval dib as FIBITMAP ptr) as ulong
declare function FreeImage_GetTransparencyCount(byval dib as FIBITMAP ptr) as ulong
declare function FreeImage_GetTransparencyTable(byval dib as FIBITMAP ptr) as UBYTE ptr
declare sub FreeImage_SetTransparent(byval dib as FIBITMAP ptr, byval enabled as BOOL)
declare sub FreeImage_SetTransparencyTable(byval dib as FIBITMAP ptr, byval table as UBYTE ptr, byval count as long)
declare function FreeImage_IsTransparent(byval dib as FIBITMAP ptr) as BOOL
declare sub FreeImage_SetTransparentIndex(byval dib as FIBITMAP ptr, byval index as long)
declare function FreeImage_GetTransparentIndex(byval dib as FIBITMAP ptr) as long
declare function FreeImage_HasBackgroundColor(byval dib as FIBITMAP ptr) as BOOL
declare function FreeImage_GetBackgroundColor(byval dib as FIBITMAP ptr, byval bkcolor as RGBQUAD ptr) as BOOL
declare function FreeImage_SetBackgroundColor(byval dib as FIBITMAP ptr, byval bkcolor as RGBQUAD ptr) as BOOL
declare function FreeImage_GetThumbnail(byval dib as FIBITMAP ptr) as FIBITMAP ptr
declare function FreeImage_SetThumbnail(byval dib as FIBITMAP ptr, byval thumbnail as FIBITMAP ptr) as BOOL
declare function FreeImage_GetICCProfile(byval dib as FIBITMAP ptr) as FIICCPROFILE ptr
declare function FreeImage_CreateICCProfile(byval dib as FIBITMAP ptr, byval data as any ptr, byval size as clong) as FIICCPROFILE ptr
declare sub FreeImage_DestroyICCProfile(byval dib as FIBITMAP ptr)
declare sub FreeImage_ConvertLine1To4(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine8To4(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long, byval palette as RGBQUAD ptr)
declare sub FreeImage_ConvertLine16To4_555(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine16To4_565(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine24To4(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine32To4(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine1To8(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine4To8(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine16To8_555(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine16To8_565(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine24To8(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine32To8(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine1To16_555(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long, byval palette as RGBQUAD ptr)
declare sub FreeImage_ConvertLine4To16_555(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long, byval palette as RGBQUAD ptr)
declare sub FreeImage_ConvertLine8To16_555(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long, byval palette as RGBQUAD ptr)
declare sub FreeImage_ConvertLine16_565_To16_555(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine24To16_555(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine32To16_555(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine1To16_565(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long, byval palette as RGBQUAD ptr)
declare sub FreeImage_ConvertLine4To16_565(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long, byval palette as RGBQUAD ptr)
declare sub FreeImage_ConvertLine8To16_565(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long, byval palette as RGBQUAD ptr)
declare sub FreeImage_ConvertLine16_555_To16_565(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine24To16_565(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine32To16_565(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine1To24(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long, byval palette as RGBQUAD ptr)
declare sub FreeImage_ConvertLine4To24(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long, byval palette as RGBQUAD ptr)
declare sub FreeImage_ConvertLine8To24(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long, byval palette as RGBQUAD ptr)
declare sub FreeImage_ConvertLine16To24_555(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine16To24_565(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine32To24(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine1To32(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long, byval palette as RGBQUAD ptr)
declare sub FreeImage_ConvertLine4To32(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long, byval palette as RGBQUAD ptr)
declare sub FreeImage_ConvertLine8To32(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long, byval palette as RGBQUAD ptr)
declare sub FreeImage_ConvertLine16To32_555(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine16To32_565(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare sub FreeImage_ConvertLine24To32(byval target as UBYTE ptr, byval source as UBYTE ptr, byval width_in_pixels as long)
declare function FreeImage_ConvertTo4Bits(byval dib as FIBITMAP ptr) as FIBITMAP ptr
declare function FreeImage_ConvertTo8Bits(byval dib as FIBITMAP ptr) as FIBITMAP ptr
declare function FreeImage_ConvertToGreyscale(byval dib as FIBITMAP ptr) as FIBITMAP ptr
declare function FreeImage_ConvertTo16Bits555(byval dib as FIBITMAP ptr) as FIBITMAP ptr
declare function FreeImage_ConvertTo16Bits565(byval dib as FIBITMAP ptr) as FIBITMAP ptr
declare function FreeImage_ConvertTo24Bits(byval dib as FIBITMAP ptr) as FIBITMAP ptr
declare function FreeImage_ConvertTo32Bits(byval dib as FIBITMAP ptr) as FIBITMAP ptr
declare function FreeImage_ColorQuantize(byval dib as FIBITMAP ptr, byval quantize as FREE_IMAGE_QUANTIZE) as FIBITMAP ptr
declare function FreeImage_ColorQuantizeEx(byval dib as FIBITMAP ptr, byval quantize as FREE_IMAGE_QUANTIZE = FIQ_WUQUANT, byval PaletteSize as long = 256, byval ReserveSize as long = 0, byval ReservePalette as RGBQUAD ptr = 0) as FIBITMAP ptr
declare function FreeImage_Threshold(byval dib as FIBITMAP ptr, byval T as UBYTE) as FIBITMAP ptr
declare function FreeImage_Dither(byval dib as FIBITMAP ptr, byval algorithm as FREE_IMAGE_DITHER) as FIBITMAP ptr
declare function FreeImage_ConvertFromRawBits(byval bits as UBYTE ptr, byval width as long, byval height as long, byval pitch as long, byval bpp as ulong, byval red_mask as ulong, byval green_mask as ulong, byval blue_mask as ulong, byval topdown as BOOL = 0) as FIBITMAP ptr
declare function FreeImage_ConvertFromRawBitsEx(byval copySource as BOOL, byval bits as UBYTE ptr, byval type as FREE_IMAGE_TYPE, byval width as long, byval height as long, byval pitch as long, byval bpp as ulong, byval red_mask as ulong, byval green_mask as ulong, byval blue_mask as ulong, byval topdown as BOOL = 0) as FIBITMAP ptr
declare sub FreeImage_ConvertToRawBits(byval bits as UBYTE ptr, byval dib as FIBITMAP ptr, byval pitch as long, byval bpp as ulong, byval red_mask as ulong, byval green_mask as ulong, byval blue_mask as ulong, byval topdown as BOOL = 0)
declare function FreeImage_ConvertToFloat(byval dib as FIBITMAP ptr) as FIBITMAP ptr
declare function FreeImage_ConvertToRGBF(byval dib as FIBITMAP ptr) as FIBITMAP ptr
declare function FreeImage_ConvertToRGBAF(byval dib as FIBITMAP ptr) as FIBITMAP ptr
declare function FreeImage_ConvertToUINT16(byval dib as FIBITMAP ptr) as FIBITMAP ptr
declare function FreeImage_ConvertToRGB16(byval dib as FIBITMAP ptr) as FIBITMAP ptr
declare function FreeImage_ConvertToRGBA16(byval dib as FIBITMAP ptr) as FIBITMAP ptr
declare function FreeImage_ConvertToStandardType(byval src as FIBITMAP ptr, byval scale_linear as BOOL = 1) as FIBITMAP ptr
declare function FreeImage_ConvertToType(byval src as FIBITMAP ptr, byval dst_type as FREE_IMAGE_TYPE, byval scale_linear as BOOL = 1) as FIBITMAP ptr
declare function FreeImage_ToneMapping(byval dib as FIBITMAP ptr, byval tmo as FREE_IMAGE_TMO, byval first_param as double = 0, byval second_param as double = 0) as FIBITMAP ptr
declare function FreeImage_TmoDrago03(byval src as FIBITMAP ptr, byval gamma as double = 2.2, byval exposure as double = 0) as FIBITMAP ptr
declare function FreeImage_TmoReinhard05(byval src as FIBITMAP ptr, byval intensity as double = 0, byval contrast as double = 0) as FIBITMAP ptr
declare function FreeImage_TmoReinhard05Ex(byval src as FIBITMAP ptr, byval intensity as double = 0, byval contrast as double = 0, byval adaptation as double = 1, byval color_correction as double = 0) as FIBITMAP ptr
declare function FreeImage_TmoFattal02(byval src as FIBITMAP ptr, byval color_saturation as double = 0.5, byval attenuation as double = 0.85) as FIBITMAP ptr
declare function FreeImage_ZLibCompress(byval target as UBYTE ptr, byval target_size as DWORD, byval source as UBYTE ptr, byval source_size as DWORD) as DWORD
declare function FreeImage_ZLibUncompress(byval target as UBYTE ptr, byval target_size as DWORD, byval source as UBYTE ptr, byval source_size as DWORD) as DWORD
declare function FreeImage_ZLibGZip(byval target as UBYTE ptr, byval target_size as DWORD, byval source as UBYTE ptr, byval source_size as DWORD) as DWORD
declare function FreeImage_ZLibGUnzip(byval target as UBYTE ptr, byval target_size as DWORD, byval source as UBYTE ptr, byval source_size as DWORD) as DWORD
declare function FreeImage_ZLibCRC32(byval crc as DWORD, byval source as UBYTE ptr, byval source_size as DWORD) as DWORD
declare function FreeImage_CreateTag() as FITAG ptr
declare sub FreeImage_DeleteTag(byval tag as FITAG ptr)
declare function FreeImage_CloneTag(byval tag as FITAG ptr) as FITAG ptr
declare function FreeImage_GetTagKey(byval tag as FITAG ptr) as const zstring ptr
declare function FreeImage_GetTagDescription(byval tag as FITAG ptr) as const zstring ptr
declare function FreeImage_GetTagID(byval tag as FITAG ptr) as WORD
declare function FreeImage_GetTagType(byval tag as FITAG ptr) as FREE_IMAGE_MDTYPE
declare function FreeImage_GetTagCount(byval tag as FITAG ptr) as DWORD
declare function FreeImage_GetTagLength(byval tag as FITAG ptr) as DWORD
declare function FreeImage_GetTagValue(byval tag as FITAG ptr) as const any ptr
declare function FreeImage_SetTagKey(byval tag as FITAG ptr, byval key as const zstring ptr) as BOOL
declare function FreeImage_SetTagDescription(byval tag as FITAG ptr, byval description as const zstring ptr) as BOOL
declare function FreeImage_SetTagID(byval tag as FITAG ptr, byval id as WORD) as BOOL
declare function FreeImage_SetTagType(byval tag as FITAG ptr, byval type as FREE_IMAGE_MDTYPE) as BOOL
declare function FreeImage_SetTagCount(byval tag as FITAG ptr, byval count as DWORD) as BOOL
declare function FreeImage_SetTagLength(byval tag as FITAG ptr, byval length as DWORD) as BOOL
declare function FreeImage_SetTagValue(byval tag as FITAG ptr, byval value as const any ptr) as BOOL
declare function FreeImage_FindFirstMetadata(byval model as FREE_IMAGE_MDMODEL, byval dib as FIBITMAP ptr, byval tag as FITAG ptr ptr) as FIMETADATA ptr
declare function FreeImage_FindNextMetadata(byval mdhandle as FIMETADATA ptr, byval tag as FITAG ptr ptr) as BOOL
declare sub FreeImage_FindCloseMetadata(byval mdhandle as FIMETADATA ptr)
declare function FreeImage_SetMetadata(byval model as FREE_IMAGE_MDMODEL, byval dib as FIBITMAP ptr, byval key as const zstring ptr, byval tag as FITAG ptr) as BOOL
declare function FreeImage_GetMetadata(byval model as FREE_IMAGE_MDMODEL, byval dib as FIBITMAP ptr, byval key as const zstring ptr, byval tag as FITAG ptr ptr) as BOOL
declare function FreeImage_SetMetadataKeyValue(byval model as FREE_IMAGE_MDMODEL, byval dib as FIBITMAP ptr, byval key as const zstring ptr, byval value as const zstring ptr) as BOOL
declare function FreeImage_GetMetadataCount(byval model as FREE_IMAGE_MDMODEL, byval dib as FIBITMAP ptr) as ulong
declare function FreeImage_CloneMetadata(byval dst as FIBITMAP ptr, byval src as FIBITMAP ptr) as BOOL
declare function FreeImage_TagToString(byval model as FREE_IMAGE_MDMODEL, byval tag as FITAG ptr, byval Make as zstring ptr = 0) as const zstring ptr
declare function FreeImage_JPEGTransform(byval src_file as const zstring ptr, byval dst_file as const zstring ptr, byval operation as FREE_IMAGE_JPEG_OPERATION, byval perfect as BOOL = 1) as BOOL
declare function FreeImage_JPEGTransformU(byval src_file as const wstring ptr, byval dst_file as const wstring ptr, byval operation as FREE_IMAGE_JPEG_OPERATION, byval perfect as BOOL = 1) as BOOL
declare function FreeImage_JPEGCrop(byval src_file as const zstring ptr, byval dst_file as const zstring ptr, byval left as long, byval top as long, byval right as long, byval bottom as long) as BOOL
declare function FreeImage_JPEGCropU(byval src_file as const wstring ptr, byval dst_file as const wstring ptr, byval left as long, byval top as long, byval right as long, byval bottom as long) as BOOL
declare function FreeImage_JPEGTransformFromHandle(byval src_io as FreeImageIO ptr, byval src_handle as fi_handle, byval dst_io as FreeImageIO ptr, byval dst_handle as fi_handle, byval operation as FREE_IMAGE_JPEG_OPERATION, byval left as long ptr, byval top as long ptr, byval right as long ptr, byval bottom as long ptr, byval perfect as BOOL = 1) as BOOL
declare function FreeImage_JPEGTransformCombined(byval src_file as const zstring ptr, byval dst_file as const zstring ptr, byval operation as FREE_IMAGE_JPEG_OPERATION, byval left as long ptr, byval top as long ptr, byval right as long ptr, byval bottom as long ptr, byval perfect as BOOL = 1) as BOOL
declare function FreeImage_JPEGTransformCombinedU(byval src_file as const wstring ptr, byval dst_file as const wstring ptr, byval operation as FREE_IMAGE_JPEG_OPERATION, byval left as long ptr, byval top as long ptr, byval right as long ptr, byval bottom as long ptr, byval perfect as BOOL = 1) as BOOL
declare function FreeImage_JPEGTransformCombinedFromMemory(byval src_stream as FIMEMORY ptr, byval dst_stream as FIMEMORY ptr, byval operation as FREE_IMAGE_JPEG_OPERATION, byval left as long ptr, byval top as long ptr, byval right as long ptr, byval bottom as long ptr, byval perfect as BOOL = 1) as BOOL
declare function FreeImage_RotateClassic(byval dib as FIBITMAP ptr, byval angle as double) as FIBITMAP ptr
declare function FreeImage_Rotate(byval dib as FIBITMAP ptr, byval angle as double, byval bkcolor as const any ptr = 0) as FIBITMAP ptr
declare function FreeImage_RotateEx(byval dib as FIBITMAP ptr, byval angle as double, byval x_shift as double, byval y_shift as double, byval x_origin as double, byval y_origin as double, byval use_mask as BOOL) as FIBITMAP ptr
declare function FreeImage_FlipHorizontal(byval dib as FIBITMAP ptr) as BOOL
declare function FreeImage_FlipVertical(byval dib as FIBITMAP ptr) as BOOL
declare function FreeImage_Rescale(byval dib as FIBITMAP ptr, byval dst_width as long, byval dst_height as long, byval filter as FREE_IMAGE_FILTER = FILTER_CATMULLROM) as FIBITMAP ptr
declare function FreeImage_MakeThumbnail(byval dib as FIBITMAP ptr, byval max_pixel_size as long, byval convert as BOOL = 1) as FIBITMAP ptr
declare function FreeImage_RescaleRect(byval dib as FIBITMAP ptr, byval dst_width as long, byval dst_height as long, byval left as long, byval top as long, byval right as long, byval bottom as long, byval filter as FREE_IMAGE_FILTER = FILTER_CATMULLROM, byval flags as ulong = 0) as FIBITMAP ptr
declare function FreeImage_AdjustCurve(byval dib as FIBITMAP ptr, byval LUT as UBYTE ptr, byval channel as FREE_IMAGE_COLOR_CHANNEL) as BOOL
declare function FreeImage_AdjustGamma(byval dib as FIBITMAP ptr, byval gamma as double) as BOOL
declare function FreeImage_AdjustBrightness(byval dib as FIBITMAP ptr, byval percentage as double) as BOOL
declare function FreeImage_AdjustContrast(byval dib as FIBITMAP ptr, byval percentage as double) as BOOL
declare function FreeImage_Invert(byval dib as FIBITMAP ptr) as BOOL
declare function FreeImage_GetHistogram(byval dib as FIBITMAP ptr, byval histo as DWORD ptr, byval channel as FREE_IMAGE_COLOR_CHANNEL = FICC_BLACK) as BOOL
declare function FreeImage_GetAdjustColorsLookupTable(byval LUT as UBYTE ptr, byval brightness as double, byval contrast as double, byval gamma as double, byval invert as BOOL) as long
declare function FreeImage_AdjustColors(byval dib as FIBITMAP ptr, byval brightness as double, byval contrast as double, byval gamma as double, byval invert as BOOL = 0) as BOOL
declare function FreeImage_ApplyColorMapping(byval dib as FIBITMAP ptr, byval srccolors as RGBQUAD ptr, byval dstcolors as RGBQUAD ptr, byval count as ulong, byval ignore_alpha as BOOL, byval swap as BOOL) as ulong
declare function FreeImage_SwapColors(byval dib as FIBITMAP ptr, byval color_a as RGBQUAD ptr, byval color_b as RGBQUAD ptr, byval ignore_alpha as BOOL) as ulong
declare function FreeImage_ApplyPaletteIndexMapping(byval dib as FIBITMAP ptr, byval srcindices as UBYTE ptr, byval dstindices as UBYTE ptr, byval count as ulong, byval swap as BOOL) as ulong
declare function FreeImage_SwapPaletteIndices(byval dib as FIBITMAP ptr, byval index_a as UBYTE ptr, byval index_b as UBYTE ptr) as ulong
declare function FreeImage_GetChannel(byval dib as FIBITMAP ptr, byval channel as FREE_IMAGE_COLOR_CHANNEL) as FIBITMAP ptr
declare function FreeImage_SetChannel(byval dst as FIBITMAP ptr, byval src as FIBITMAP ptr, byval channel as FREE_IMAGE_COLOR_CHANNEL) as BOOL
declare function FreeImage_GetComplexChannel(byval src as FIBITMAP ptr, byval channel as FREE_IMAGE_COLOR_CHANNEL) as FIBITMAP ptr
declare function FreeImage_SetComplexChannel(byval dst as FIBITMAP ptr, byval src as FIBITMAP ptr, byval channel as FREE_IMAGE_COLOR_CHANNEL) as BOOL
declare function FreeImage_Copy(byval dib as FIBITMAP ptr, byval left as long, byval top as long, byval right as long, byval bottom as long) as FIBITMAP ptr
declare function FreeImage_Paste(byval dst as FIBITMAP ptr, byval src as FIBITMAP ptr, byval left as long, byval top as long, byval alpha as long) as BOOL
declare function FreeImage_CreateView(byval dib as FIBITMAP ptr, byval left as ulong, byval top as ulong, byval right as ulong, byval bottom as ulong) as FIBITMAP ptr
declare function FreeImage_Composite(byval fg as FIBITMAP ptr, byval useFileBkg as BOOL = 0, byval appBkColor as RGBQUAD ptr = 0, byval bg as FIBITMAP ptr = 0) as FIBITMAP ptr
declare function FreeImage_PreMultiplyWithAlpha(byval dib as FIBITMAP ptr) as BOOL
declare function FreeImage_FillBackground(byval dib as FIBITMAP ptr, byval color as const any ptr, byval options as long = 0) as BOOL
declare function FreeImage_EnlargeCanvas(byval src as FIBITMAP ptr, byval left as long, byval top as long, byval right as long, byval bottom as long, byval color as const any ptr, byval options as long = 0) as FIBITMAP ptr
declare function FreeImage_AllocateEx(byval width as long, byval height as long, byval bpp as long, byval color as const RGBQUAD ptr, byval options as long = 0, byval palette as const RGBQUAD ptr = 0, byval red_mask as ulong = 0, byval green_mask as ulong = 0, byval blue_mask as ulong = 0) as FIBITMAP ptr
declare function FreeImage_AllocateExT(byval type as FREE_IMAGE_TYPE, byval width as long, byval height as long, byval bpp as long, byval color as const any ptr, byval options as long = 0, byval palette as const RGBQUAD ptr = 0, byval red_mask as ulong = 0, byval green_mask as ulong = 0, byval blue_mask as ulong = 0) as FIBITMAP ptr
declare function FreeImage_MultigridPoissonSolver(byval Laplacian as FIBITMAP ptr, byval ncycle as long = 3) as FIBITMAP ptr

end extern
