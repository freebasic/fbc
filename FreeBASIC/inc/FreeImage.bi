#ifndef FREEIMAGE_BI
#define FREEIMAGE_BI

'' COVERED CODE IS PROVIDED UNDER THIS LICENSE ON AN "AS IS" BASIS, WITHOUT WARRANTY
'' OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, WITHOUT LIMITATION, WARRANTIES
'' THAT THE COVERED CODE IS FREE OF DEFECTS, MERCHANTABLE, FIT FOR A PARTICULAR PURPOSE
'' OR NON-INFRINGING. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE COVERED
'' CODE IS WITH YOU. SHOULD ANY COVERED CODE PROVE DEFECTIVE IN ANY RESPECT, YOU (NOT
'' THE INITIAL DEVELOPER OR ANY OTHER CONTRIBUTOR) ASSUME THE COST OF ANY NECESSARY
'' SERVICING, REPAIR OR CORRECTION. THIS DISCLAIMER OF WARRANTY CONSTITUTES AN ESSENTIAL
'' PART OF THIS LICENSE. NO USE OF ANY COVERED CODE IS AUTHORIZED HEREUNDER EXCEPT UNDER
'' THIS DISCLAIMER.

'$inclib: "FreeImage"


#define FREEIMAGE_MAJOR_VERSION  3
#define FREEIMAGE_MINOR_VERSION  5
#define FREEIMAGE_RELEASE_SERIAL  0


#if not defined(__FB_WIN32__) or not defined(WINGDIAPI)

#ifndef FALSE
#define FALSE 0
#endif
#ifndef TRUE
#define TRUE 1
#endif
#ifndef NULL
#define NULL 0
#endif

#ifndef SEEK_SET
#define SEEK_SET  0
#define SEEK_CUR  1
#define SEEK_END  2
#endif


Type RGBQUAD field=1
#ifdef __FB_BIGENDIAN__
		rgbRed As Byte
		rgbGreen As Byte
		rgbBlue As Byte
#else
		rgbBlue As Byte
		rgbGreen As Byte
		rgbRed As Byte
#endif
  		rgbReserved as byte
end type

Type RGBTRIPLE field=1
#ifdef __FB_BIGENDIAN__
		rgbtRed As Byte
		rgbtGreen As Byte
		rgbtBlue As Byte
#else
		rgbtBlue As Byte
		rgbtGreen As Byte
		rgbtRed As Byte
#endif
End Type

type BITMAPINFOHEADER field=1
  	biSize	as uinteger
  	biWidth	as uinteger
  	biHeight	as uinteger
  	biPlanes	as ushort
  	biBitCount as ushort
  	biCompression as uinteger
  	biSizeImage as uinteger
  	biXPelsPerMeter as uinteger
  	biYPelsPerMeter as uinteger
  	biClrUsed as uinteger
  	biClrImportant as uinteger
end type

type BITMAPINFO 
	bmiHeader		as BITMAPINFOHEADER
	bmiColors		as RGBQUAD
end type

#endif '' __FB_WIN32__


#ifndef __FB_BIGENDIAN__
'' Little Endian (x86 / MS Windows, Linux) : BGR(A) order
#define FI_RGBA_RED  2
#define FI_RGBA_GREEN  1
#define FI_RGBA_BLUE  0
#define FI_RGBA_ALPHA  3
#define FI_RGBA_RED_MASK  &H00FF0000
#define FI_RGBA_GREEN_MASK  &H0000FF00
#define FI_RGBA_BLUE_MASK  &H000000FF
#define FI_RGBA_ALPHA_MASK  &HFF000000
#define FI_RGBA_RED_SHIFT  16
#define FI_RGBA_GREEN_SHIFT  8
#define FI_RGBA_BLUE_SHIFT  0
#define FI_RGBA_ALPHA_SHIFT  24
#else
'' Big Endian (PPC / Linux, MaxOSX) : RGB(A) order
#define FI_RGBA_RED 		0
#define FI_RGBA_GREEN 	1
#define FI_RGBA_BLUE 	2
#define FI_RGBA_ALPHA 	3
#define FI_RGBA_RED_MASK 	&hFF000000
Const FI_RGBA_GREEN_MASK=		&h00FF0000
#define FI_RGBA_BLUE_MASK &h0000FF00
#define FI_RGBA_ALPHA_MASK 	&h000000FF
#define FI_RGBA_RED_SHIFT 24
Const FI_RGBA_GREEN_SHIFT=		16
Const FI_RGBA_BLUE_SHIFT=		8
#define FI_RGBA_ALPHA_SHIFT 	0
#endif '' __FB_BIGENDIAN__

#define FI_RGBA_RGB_MASK  (FI_RGBA_RED_MASK or FI_RGBA_GREEN_MASK or FI_RGBA_BLUE_MASK)

'' The 16bit macros only include masks and shifts, since each color element is not byte aligned

#define FI16_555_RED_MASK  &H7C00
#define FI16_555_GREEN_MASK  &H03E0
#define FI16_555_BLUE_MASK  &H001F
#define FI16_555_RED_SHIFT  10
#define FI16_555_GREEN_SHIFT  5
#define FI16_555_BLUE_SHIFT  0
#define FI16_565_RED_MASK  &HF800
#define FI16_565_GREEN_MASK  &H07E0
#define FI16_565_BLUE_MASK  &H001F
#define FI16_565_RED_SHIFT  11
#define FI16_565_GREEN_SHIFT  5
#define FI16_565_BLUE_SHIFT  0

#define FIICC_DEFAULT  &H00
#define FIICC_COLOR_IS_CMYK  &H01

'' Load / Save flag constants -----------------------------------------------

#define BMP_DEFAULT  0
#define BMP_SAVE_RLE  1
#define CUT_DEFAULT  0
#define DDS_DEFAULT  0
#define GIF_DEFAULT  0
#define ICO_DEFAULT  0
#define ICO_MAKEALPHA  1
#define IFF_DEFAULT  0
#define JPEG_DEFAULT  0
#define JPEG_FAST  1
#define JPEG_ACCURATE  2
#define JPEG_QUALITYSUPERB  &H80
#define JPEG_QUALITYGOOD  &H100
#define JPEG_QUALITYNORMAL  &H200
#define JPEG_QUALITYAVERAGE  &H400
#define JPEG_QUALITYBAD  &H800
#define KOALA_DEFAULT  0
#define LBM_DEFAULT  0
#define MNG_DEFAULT  0
#define PCD_DEFAULT  0
#define PCD_BASE  1
#define PCD_BASEDIV4  2
#define PCD_BASEDIV16  3
#define PCX_DEFAULT  0
#define PNG_DEFAULT  0
#define PNG_IGNOREGAMMA  1
#define PNM_DEFAULT  0
#define PNM_SAVE_RAW  0
#define PNM_SAVE_ASCII  1
#define PSD_DEFAULT  0
#define RAS_DEFAULT  0
#define TARGA_DEFAULT  0
#define TARGA_LOAD_RGB888  1
#define TIFF_DEFAULT  0
#define TIFF_CMYK  &H0001
#define TIFF_PACKBITS  &H0100
#define TIFF_DEFLATE  &H0200
#define TIFF_ADOBE_DEFLATE  &H0400
#define TIFF_NONE  &H0800
#define TIFF_CCITTFAX3  &H1000
#define TIFF_CCITTFAX4  &H2000
#define TIFF_LZW  &H4000
#define WBMP_DEFAULT  0
#define XBM_DEFAULT  0
#define XPM_DEFAULT  0

Enum FREE_IMAGE_FORMAT
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
End Enum

Enum FREE_IMAGE_TYPE
	FIT_UNKNOWN = 0
	FIT_BITMAP = 1
	FIT_UINT16 = 2
	FIT_INT16 = 3
	FIT_UINT32 = 4
	FIT_INT32 = 5
	FIT_FLOAT = 6
	FIT_DOUBLE = 7
	FIT_COMPLEX = 8
End Enum

Enum FREE_IMAGE_COLOR_TYPE
	FIC_MINISWHITE = 0
	FIC_MINISBLACK = 1
	FIC_RGB = 2
	FIC_PALETTE = 3
	FIC_RGBALPHA = 4
	FIC_CMYK = 5
End Enum

Enum FREE_IMAGE_QUANTIZE
	FIQ_WUQUANT = 0
	FIQ_NNQUANT = 1
End Enum

Enum FREE_IMAGE_DITHER
	FID_FS = 0
	FID_BAYER4x4 = 1
	FID_BAYER8x8 = 2
	FID_CLUSTER6x6 = 3
	FID_CLUSTER8x8 = 4
	FID_CLUSTER16x16 = 5
End Enum

Enum FREE_IMAGE_FILTER
	FILTER_BOX = 0
	FILTER_BICUBIC = 1
	FILTER_BILINEAR = 2
	FILTER_BSPLINE = 3
	FILTER_CATMULLROM = 4
	FILTER_LANCZOS3 = 5
End Enum

Enum FREE_IMAGE_COLOR_CHANNEL
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
End Enum

Enum FREE_IMAGE_MDTYPE
	FIDT_NOTYPE = 0
	FIDT_BYTE = 1
	FIDT_ASCII = 2
	FIDT_SHORT = 3
	FIDT_Integer = 4
	FIDT_RATIONAL = 5
	FIDT_SBYTE = 6
	FIDT_UNDEFINED = 7
	FIDT_SSHORT = 8
	FIDT_SInteger = 9
	FIDT_SRATIONAL = 10
	FIDT_FLOAT = 11
	FIDT_DOUBLE = 12
	FIDT_IFD = 13
End Enum

Enum FREE_IMAGE_MDMODEL
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
	FIMD_CUSTOM = 9
End Enum

Type FIBITMAP
	data As Integer
End Type

Type FIMULTIBITMAP
	data As Integer
End Type


Type FIICCPROFILE
	flags As Short
	size As Integer
	data As any ptr
End Type

Type FICOMPLEX
	r As double
	i As double
End Type

Type FIMETADATA
	data As any ptr 
End Type

Type FITAG
	key As byte ptr
	description As byte ptr
	id As Short
	type As Short
	count As Integer
	length As Integer
	value As any ptr
End Type

Type FreeImageIO
	read_proc As function (byval buffer as any ptr, byval size as uinteger, byval count as uinteger, byval handle as any ptr) as uinteger
	write_proc As function (byval buffer as any ptr, byval size as uinteger, byval count as uinteger, byval handle as any ptr) as uinteger
	seek_proc As function (byval handle as any ptr, byval offset as integer, byval origin as integer) as integer
	tell_proc As function (byval handle as any ptr) as integer
End Type

Type FIMEMORY
	data As any ptr
End Type

Type Plugin
	format_proc As Integer
	description_proc As Integer
	extension_proc As Integer
	regexpr_proc As Integer
	open_proc As Integer
	close_proc As Integer
	pagecount_proc As Integer
	pagecapability_proc As Integer
	load_proc As Integer
	save_proc As Integer
	validate_proc As Integer
	mime_proc As Integer
	supports_export_bpp_proc As Integer
	supports_export_type_proc As Integer
	supports_icc_profiles_proc As Integer
End Type

Declare Sub FreeImage_Initialise Alias "FreeImage_Initialise" (ByVal load_local_plugins_only As Integer = 0)
Declare Sub FreeImage_DeInitialise Alias "FreeImage_DeInitialise" ()
Declare Function FreeImage_GetVersion Alias "FreeImage_GetVersion" () as zstring ptr
Declare Function FreeImage_GetCopyrightMessage Alias "FreeImage_GetCopyrightMessage" () as zstring ptr
Declare Sub FreeImage_OutputMessageProc CDECL Alias "FreeImage_OutputMessageProc" (ByVal fif As Integer, ByVal fmt As String, ...)
Declare Sub FreeImage_SetOutputMessage Alias "FreeImage_SetOutputMessage" (ByVal omf As Integer)
Declare Function FreeImage_Allocate Alias "FreeImage_Allocate" (ByVal width As Integer, ByVal height As Integer, ByVal bpp As Integer, ByVal red_mask As Integer = 0, ByVal green_mask As Integer = 0, ByVal blue_mask As Integer = 0) As FIBITMAP ptr
Declare Function FreeImage_AllocateT Alias "FreeImage_AllocateT" (ByVal type As FREE_IMAGE_TYPE, ByVal width As Integer, ByVal height As Integer, ByVal bpp As Integer = 8, ByVal red_mask As Integer = 0, ByVal green_mask As Integer = 0, ByVal blue_mask As Integer = 0) As FIBITMAP ptr
Declare Function FreeImage_Clone Alias "FreeImage_Clone" (byval dib as FIBITMAP ptr) As FIBITMAP ptr
Declare Sub FreeImage_Unload Alias "FreeImage_Unload" (byval dib as FIBITMAP ptr)
Declare Function FreeImage_Load Alias "FreeImage_Load" (ByVal fif As FREE_IMAGE_FORMAT, ByVal filename As String, ByVal flags As Integer = 0) As FIBITMAP ptr
Declare Function FreeImage_LoadFromHandle Alias "FreeImage_LoadFromHandle" (ByVal fif As FREE_IMAGE_FORMAT, ByVal io As Integer, ByVal handle As Integer, ByVal flags As Integer = 0) As FIBITMAP ptr
Declare Function FreeImage_Save Alias "FreeImage_Save" (ByVal fif As FREE_IMAGE_FORMAT, byval dib as FIBITMAP ptr, ByVal filename As String, ByVal flags As Integer = 0) As Integer
Declare Function FreeImage_SaveToHandle Alias "FreeImage_SaveToHandle" (ByVal fif As FREE_IMAGE_FORMAT, byval dib as FIBITMAP ptr, ByVal io As Integer, ByVal handle As Integer, ByVal flags As Integer = 0) As Integer
Declare Function FreeImage_OpenMemory Alias "FreeImage_OpenMemory" (Byval data As byte ptr = NULL, ByVal size_in_bytes As Integer = 0) As FIMEMORY Ptr
Declare Sub FreeImage_CloseMemory Alias "FreeImage_CloseMemory" (byval stream As FIMEMORY Ptr)
Declare Function FreeImage_LoadFromMemory Alias "FreeImage_LoadFromMemory" (ByVal fif As FREE_IMAGE_FORMAT, byval stream As FIMEMORY Ptr, ByVal flags As Integer = 0) As FIBITMAP ptr
Declare Function FreeImage_SaveToMemory Alias "FreeImage_SaveToMemory" (ByVal fif As FREE_IMAGE_FORMAT, byval dib as FIBITMAP ptr, byval stream As FIMEMORY Ptr, ByVal flags As Integer = 0) As Integer
Declare Function FreeImage_TellMemory Alias "FreeImage_TellMemory" (byval stream As FIMEMORY Ptr) As Integer
Declare Function FreeImage_SeekMemory Alias "FreeImage_SeekMemory" (byval stream As FIMEMORY Ptr, ByVal offset As Integer, ByVal origin As Integer) As Integer
Declare Function FreeImage_AcquireMemory Alias "FreeImage_AcquireMemory" (byval stream As FIMEMORY Ptr, byval data As BYTE Ptr ptr, Byval size_in_bytes As Integer ptr) As Integer
Declare Function FreeImage_RegisterLocalPlugin Alias "FreeImage_RegisterLocalPlugin" (ByVal proc_address As Integer, ByVal format As String, ByVal description As String, ByVal extension As String, ByVal regexpr As String) As FREE_IMAGE_FORMAT
Declare Function FreeImage_RegisterExternalPlugin Alias "FreeImage_RegisterExternalPlugin" (ByVal path As String, ByVal format As String, ByVal description As String, ByVal extension As String, ByVal regexpr As String) As FREE_IMAGE_FORMAT
Declare Function FreeImage_GetFIFCount Alias "FreeImage_GetFIFCount" () As Integer
Declare Function FreeImage_SetPluginEnabled Alias "FreeImage_SetPluginEnabled" (ByVal fif As FREE_IMAGE_FORMAT, ByVal enable As Integer) As Integer
Declare Function FreeImage_IsPluginEnabled Alias "FreeImage_IsPluginEnabled" (ByVal fif As FREE_IMAGE_FORMAT) As Integer
Declare Function FreeImage_GetFIFFromFormat Alias "FreeImage_GetFIFFromFormat" (ByVal format As String) As FREE_IMAGE_FORMAT
Declare Function FreeImage_GetFIFFromMime Alias "FreeImage_GetFIFFromMime" (ByVal mime As String) As FREE_IMAGE_FORMAT
Declare Function FreeImage_GetFormatFromFIF Alias "FreeImage_GetFormatFromFIF" (ByVal fif As FREE_IMAGE_FORMAT) as zstring ptr
Declare Function FreeImage_GetFIFExtensionList Alias "FreeImage_GetFIFExtensionList" (ByVal fif As FREE_IMAGE_FORMAT) as zstring ptr
Declare Function FreeImage_GetFIFDescription Alias "FreeImage_GetFIFDescription" (ByVal fif As FREE_IMAGE_FORMAT) as zstring ptr
Declare Function FreeImage_GetFIFRegExpr Alias "FreeImage_GetFIFRegExpr" (ByVal fif As FREE_IMAGE_FORMAT) as zstring ptr
Declare Function FreeImage_GetFIFMimeType Alias "FreeImage_GetFIFMimeType" (ByVal fif As FREE_IMAGE_FORMAT) as zstring ptr
Declare Function FreeImage_GetFIFFromFilename Alias "FreeImage_GetFIFFromFilename" (ByVal filename As String) As FREE_IMAGE_FORMAT
Declare Function FreeImage_FIFSupportsReading Alias "FreeImage_FIFSupportsReading" (ByVal fif As FREE_IMAGE_FORMAT) As Integer
Declare Function FreeImage_FIFSupportsWriting Alias "FreeImage_FIFSupportsWriting" (ByVal fif As FREE_IMAGE_FORMAT) As Integer
Declare Function FreeImage_FIFSupportsExportBPP Alias "FreeImage_FIFSupportsExportBPP" (ByVal fif As FREE_IMAGE_FORMAT, ByVal bpp As Integer) As Integer
Declare Function FreeImage_FIFSupportsExportType Alias "FreeImage_FIFSupportsExportType" (ByVal fif As FREE_IMAGE_FORMAT, ByVal type_ As FREE_IMAGE_TYPE) As Integer
Declare Function FreeImage_FIFSupportsICCProfiles Alias "FreeImage_FIFSupportsICCProfiles" (ByVal fif As FREE_IMAGE_FORMAT) As Integer
Declare Function FreeImage_OpenMultiBitmap Alias "FreeImage_OpenMultiBitmap" (ByVal fif As FREE_IMAGE_FORMAT, ByVal filename As String, ByVal create_new As Integer, ByVal read_only As Integer, ByVal keep_cache_in_memory As Integer = 0) As FIMULTIBITMAP ptr
Declare Function FreeImage_CloseMultiBitmap Alias "FreeImage_CloseMultiBitmap" (byval bitmap as FIMULTIBITMAP ptr, ByVal flags As Integer = 0) As Integer
Declare Function FreeImage_GetPageCount Alias "FreeImage_GetPageCount" (byval bitmap as FIMULTIBITMAP ptr) As Integer
Declare Sub FreeImage_AppendPage Alias "FreeImage_AppendPage" (byval bitmap as FIMULTIBITMAP ptr, ByVal data As FIBITMAP ptr)
Declare Sub FreeImage_InsertPage Alias "FreeImage_InsertPage" (byval bitmap as FIMULTIBITMAP ptr, ByVal page As Integer, ByVal data As FIBITMAP ptr)
Declare Sub FreeImage_DeletePage Alias "FreeImage_DeletePage" (byval bitmap as FIMULTIBITMAP ptr, ByVal page As Integer)
Declare Function FreeImage_LockPage Alias "FreeImage_LockPage" (byval bitmap as FIMULTIBITMAP ptr, ByVal page As Integer) As FIBITMAP ptr
Declare Sub FreeImage_UnlockPage Alias "FreeImage_UnlockPage" (byval bitmap as FIMULTIBITMAP ptr, ByVal page As FIBITMAP ptr, ByVal changed As Integer)
Declare Function FreeImage_MovePage Alias "FreeImage_MovePage" (byval bitmap as FIMULTIBITMAP ptr, ByVal target As Integer, ByVal source As Integer) As Integer
Declare Function FreeImage_GetLockedPageNumbers Alias "FreeImage_GetLockedPageNumbers" (byval bitmap as FIMULTIBITMAP ptr, Byval pages As Integer ptr, Byval count As Integer ptr) As Integer
Declare Function FreeImage_GetFileType Alias "FreeImage_GetFileType" (ByVal filename As String, ByVal size As Integer = 0) As FREE_IMAGE_FORMAT
Declare Function FreeImage_GetFileTypeFromHandle Alias "FreeImage_GetFileTypeFromHandle" (ByVal io As Integer, ByVal handle As Integer, ByVal size As Integer = 0) As FREE_IMAGE_FORMAT
Declare Function FreeImage_GetFileTypeFromMemory Alias "FreeImage_GetFileTypeFromMemory" (byval stream As FIMEMORY Ptr, ByVal size As Integer = 0) As FREE_IMAGE_FORMAT
Declare Function FreeImage_GetImageType Alias "FreeImage_GetImageType" (byval dib as FIBITMAP ptr) As FREE_IMAGE_TYPE
Declare Function FreeImage_IsLittleEndian Alias "FreeImage_IsLittleEndian" () As Integer
Declare Function FreeImage_LookupX11Color Alias "FreeImage_LookupX11Color" (ByVal szColor As String, Byval nRed As Integer ptr, Byval nGreen As Integer ptr, Byval nBlue As Integer ptr) As Integer
Declare Function FreeImage_LookupSVGColor Alias "FreeImage_LookupSVGColor" (ByVal szColor As String, Byval nRed As Integer ptr, Byval nGreen As Integer ptr, Byval nBlue As Integer ptr) As Integer
Declare Function FreeImage_GetBits Alias "FreeImage_GetBits" (byval dib as FIBITMAP ptr) as zstring ptr
Declare Function FreeImage_GetScanLine Alias "FreeImage_GetScanLine" (byval dib as FIBITMAP ptr, ByVal scanline As Integer) as zstring ptr
Declare Function FreeImage_GetPixelIndex Alias "FreeImage_GetPixelIndex" (byval dib as FIBITMAP ptr, ByVal x As Integer, ByVal y As Integer, Byval value As Byte ptr) As Integer
Declare Function FreeImage_GetPixelColor Alias "FreeImage_GetPixelColor" (byval dib as FIBITMAP ptr, ByVal x As Integer, ByVal y As Integer, Byval value As RGBQUAD ptr) As Integer
Declare Function FreeImage_SetPixelIndex Alias "FreeImage_SetPixelIndex" (byval dib as FIBITMAP ptr, ByVal x As Integer, ByVal y As Integer, Byval Value As Byte ptr) As Integer
Declare Function FreeImage_SetPixelColor Alias "FreeImage_SetPixelColor" (byval dib as FIBITMAP ptr, ByVal x As Integer, ByVal y As Integer, Byval Value As RGBQUAD ptr) As Integer
Declare Function FreeImage_GetColorsUsed Alias "FreeImage_GetColorsUsed" (byval dib as FIBITMAP ptr) As Integer
Declare Function FreeImage_GetBPP Alias "FreeImage_GetBPP" (byval dib as FIBITMAP ptr) As Integer
Declare Function FreeImage_GetWidth Alias "FreeImage_GetWidth" (byval dib as FIBITMAP ptr) As Integer
Declare Function FreeImage_GetHeight Alias "FreeImage_GetHeight" (byval dib as FIBITMAP ptr) As Integer
Declare Function FreeImage_GetLine Alias "FreeImage_GetLine" (byval dib as FIBITMAP ptr) As Integer
Declare Function FreeImage_GetPitch Alias "FreeImage_GetPitch" (byval dib as FIBITMAP ptr) As Integer
Declare Function FreeImage_GetDIBSize Alias "FreeImage_GetDIBSize" (byval dib as FIBITMAP ptr) As Integer
Declare Function FreeImage_GetPalette Alias "FreeImage_GetPalette" (byval dib as FIBITMAP ptr) As RGBQUAD ptr
Declare Function FreeImage_GetDotsPerMeterX Alias "FreeImage_GetDotsPerMeterX" (byval dib as FIBITMAP ptr) As Integer
Declare Function FreeImage_GetDotsPerMeterY Alias "FreeImage_GetDotsPerMeterY" (byval dib as FIBITMAP ptr) As Integer
Declare Function FreeImage_GetInfoHeader Alias "FreeImage_GetInfoHeader" (byval dib as FIBITMAP ptr) As BITMAPINFOHEADER Ptr
Declare Function FreeImage_GetInfo Alias "FreeImage_GetInfo" (byval dib as FIBITMAP ptr) As BITMAPINFO Ptr
Declare Function FreeImage_GetColorType Alias "FreeImage_GetColorType" (byval dib as FIBITMAP ptr) As FREE_IMAGE_COLOR_TYPE
Declare Function FreeImage_GetRedMask Alias "FreeImage_GetRedMask" (byval dib as FIBITMAP ptr) As Integer
Declare Function FreeImage_GetGreenMask Alias "FreeImage_GetGreenMask" (byval dib as FIBITMAP ptr) As Integer
Declare Function FreeImage_GetBlueMask Alias "FreeImage_GetBlueMask" (byval dib as FIBITMAP ptr) As Integer
Declare Function FreeImage_GetTransparencyCount Alias "FreeImage_GetTransparencyCount" (byval dib as FIBITMAP ptr) As Integer
Declare Function FreeImage_GetTransparencyTable Alias "FreeImage_GetTransparencyTable" (byval dib as FIBITMAP ptr) as zstring ptr
Declare Sub FreeImage_SetTransparent Alias "FreeImage_SetTransparent" (byval dib as FIBITMAP ptr, ByVal enabled As Integer)
Declare Sub FreeImage_SetTransparencyTable Alias "FreeImage_SetTransparencyTable" (byval dib as FIBITMAP ptr, Byval table As byte ptr, ByVal count As Integer)
Declare Function FreeImage_IsTransparent Alias "FreeImage_IsTransparent" (byval dib as FIBITMAP ptr) As Integer
Declare Function FreeImage_HasBackgroundColor Alias "FreeImage_HasBackgroundColor" (byval dib as FIBITMAP ptr) As Integer
Declare Function FreeImage_GetBackgroundColor Alias "FreeImage_GetBackgroundColor" (byval dib as FIBITMAP ptr, ByVal bkcolor As Integer) As Integer
Declare Function FreeImage_SetBackgroundColor Alias "FreeImage_SetBackgroundColor" (byval dib as FIBITMAP ptr, ByVal bkcolor As Integer) As Integer
Declare Function FreeImage_GetICCProfile Alias "FreeImage_GetICCProfile" (byval dib as FIBITMAP ptr) As FIICCPROFILE ptr
Declare Function FreeImage_CreateICCProfile Alias "FreeImage_CreateICCProfile" (byval dib as FIBITMAP ptr, Byval data As any ptr, ByVal size As Integer) As FIICCPROFILE ptr
Declare Sub FreeImage_DestroyICCProfile Alias "FreeImage_DestroyICCProfile" (byval dib as FIBITMAP ptr)
Declare Sub FreeImage_ConvertLine1To8 Alias "FreeImage_ConvertLine1To8" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer)
Declare Sub FreeImage_ConvertLine4To8 Alias "FreeImage_ConvertLine4To8" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer)
Declare Sub FreeImage_ConvertLine16To8_555 Alias "FreeImage_ConvertLine16To8_555" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer)
Declare Sub FreeImage_ConvertLine16To8_565 Alias "FreeImage_ConvertLine16To8_565" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer)
Declare Sub FreeImage_ConvertLine24To8 Alias "FreeImage_ConvertLine24To8" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer)
Declare Sub FreeImage_ConvertLine32To8 Alias "FreeImage_ConvertLine32To8" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer)
Declare Sub FreeImage_ConvertLine1To16_555 Alias "FreeImage_ConvertLine1To16_555" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer, ByVal pal As Integer)
Declare Sub FreeImage_ConvertLine4To16_555 Alias "FreeImage_ConvertLine4To16_555" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer, ByVal pal As Integer)
Declare Sub FreeImage_ConvertLine8To16_555 Alias "FreeImage_ConvertLine8To16_555" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer, ByVal pal As Integer)
Declare Sub FreeImage_ConvertLine16_565_To16_555 Alias "FreeImage_ConvertLine16_565_To16_555" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer)
Declare Sub FreeImage_ConvertLine24To16_555 Alias "FreeImage_ConvertLine24To16_555" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer)
Declare Sub FreeImage_ConvertLine32To16_555 Alias "FreeImage_ConvertLine32To16_555" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer)
Declare Sub FreeImage_ConvertLine1To16_565 Alias "FreeImage_ConvertLine1To16_565" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer, ByVal pal As Integer)
Declare Sub FreeImage_ConvertLine4To16_565 Alias "FreeImage_ConvertLine4To16_565" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer, ByVal pal As Integer)
Declare Sub FreeImage_ConvertLine8To16_565 Alias "FreeImage_ConvertLine8To16_565" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer, ByVal pal As Integer)
Declare Sub FreeImage_ConvertLine16_555_To16_565 Alias "FreeImage_ConvertLine16_555_To16_565" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer)
Declare Sub FreeImage_ConvertLine24To16_565 Alias "FreeImage_ConvertLine24To16_565" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer)
Declare Sub FreeImage_ConvertLine32To16_565 Alias "FreeImage_ConvertLine32To16_565" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer)
Declare Sub FreeImage_ConvertLine1To24 Alias "FreeImage_ConvertLine1To24" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer, ByVal pal As Integer)
Declare Sub FreeImage_ConvertLine4To24 Alias "FreeImage_ConvertLine4To24" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer, ByVal pal As Integer)
Declare Sub FreeImage_ConvertLine8To24 Alias "FreeImage_ConvertLine8To24" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer, ByVal pal As Integer)
Declare Sub FreeImage_ConvertLine16To24_555 Alias "FreeImage_ConvertLine16To24_555" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer)
Declare Sub FreeImage_ConvertLine16To24_565 Alias "FreeImage_ConvertLine16To24_565" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer)
Declare Sub FreeImage_ConvertLine32To24 Alias "FreeImage_ConvertLine32To24" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer)
Declare Sub FreeImage_ConvertLine1To32 Alias "FreeImage_ConvertLine1To32" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer, ByVal pal As Integer)
Declare Sub FreeImage_ConvertLine4To32 Alias "FreeImage_ConvertLine4To32" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer, ByVal pal As Integer)
Declare Sub FreeImage_ConvertLine8To32 Alias "FreeImage_ConvertLine8To32" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer, ByVal pal As Integer)
Declare Sub FreeImage_ConvertLine16To32_555 Alias "FreeImage_ConvertLine16To32_555" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer)
Declare Sub FreeImage_ConvertLine16To32_565 Alias "FreeImage_ConvertLine16To32_565" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer)
Declare Sub FreeImage_ConvertLine24To32 Alias "FreeImage_ConvertLine24To32" (byval target as byte ptr, byval source as byte ptr, ByVal width_in_pixels As Integer)
Declare Function FreeImage_ConvertTo4Bits alias "FreeImage_ConvertTo4Bits" (byval dib as FIBITMAP ptr) As FIBITMAP ptr
Declare Function FreeImage_ConvertTo8Bits Alias "FreeImage_ConvertTo8Bits" (byval dib as FIBITMAP ptr) As FIBITMAP ptr
Declare Function FreeImage_ConvertTo16Bits555 Alias "FreeImage_ConvertTo16Bits555" (byval dib as FIBITMAP ptr) As FIBITMAP ptr
Declare Function FreeImage_ConvertTo16Bits565 Alias "FreeImage_ConvertTo16Bits565" (byval dib as FIBITMAP ptr) As FIBITMAP ptr
Declare Function FreeImage_ConvertTo24Bits Alias "FreeImage_ConvertTo24Bits" (byval dib as FIBITMAP ptr) As FIBITMAP ptr
Declare Function FreeImage_ConvertTo32Bits Alias "FreeImage_ConvertTo32Bits" (byval dib as FIBITMAP ptr) As FIBITMAP ptr
Declare Function FreeImage_ColorQuantize Alias "FreeImage_ColorQuantize" (byval dib as FIBITMAP ptr, ByVal quantize As FREE_IMAGE_QUANTIZE) As FIBITMAP ptr
Declare Function FreeImage_Threshold Alias "FreeImage_Threshold" (byval dib as FIBITMAP ptr, ByVal T As Byte) As FIBITMAP ptr
Declare Function FreeImage_Dither Alias "FreeImage_Dither" (byval dib as FIBITMAP ptr, ByVal algorithm As FREE_IMAGE_DITHER) As FIBITMAP ptr
Declare Function FreeImage_ConvertFromRawBits Alias "FreeImage_ConvertFromRawBits" (ByRef bits As Integer, ByVal width As Integer, ByVal height As Integer, ByVal pitch As Integer, ByVal bpp As Integer, ByVal red_mask As Integer, ByVal green_mask As Integer, ByVal blue_mask As Integer, ByVal topdown As Integer = 0) As FIBITMAP ptr
Declare Sub FreeImage_ConvertToRawBits Alias "FreeImage_ConvertToRawBits" (ByRef bits As Integer, byval dib as FIBITMAP ptr, ByVal pitch As Integer, ByVal bpp As Integer, ByVal red_mask As Integer, ByVal green_mask As Integer, ByVal blue_mask As Integer, ByVal topdown As Integer = 0)
Declare Function FreeImage_ConvertToStandardType Alias "FreeImage_ConvertToStandardType" (ByVal src As Integer, ByVal scale_linear As Integer = 1) As FIBITMAP ptr
Declare Function FreeImage_ConvertToType Alias "FreeImage_ConvertToType" (ByVal src As Integer, ByVal dst_type As FREE_IMAGE_TYPE, ByVal scale_linear As Integer = 1) As FIBITMAP ptr
Declare Function FreeImage_ZLibCompress Alias "FreeImage_ZLibCompress" (byval target as byte ptr, ByVal target_size As Integer, byval source as byte ptr, ByVal source_size As Integer) As Integer
Declare Function FreeImage_ZLibUncompress Alias "FreeImage_ZLibUncompress" (byval target as byte ptr, ByVal target_size As Integer, byval source as byte ptr, ByVal source_size As Integer) As Integer
Declare Function FreeImage_RotateClassic Alias "FreeImage_RotateClassic" (byval dib as FIBITMAP ptr, ByVal angle As Single) As FIBITMAP ptr
Declare Function FreeImage_RotateEx Alias "FreeImage_RotateEx" (byval dib as FIBITMAP ptr, ByVal angle As Single, ByVal x_shift As Single, ByVal y_shift As Single, ByVal x_origin As Single, ByVal y_origin As Single, ByVal use_mask As Integer) As FIBITMAP ptr
Declare Function FreeImage_FlipHorizontal Alias "FreeImage_FlipHorizontal" (byval dib as FIBITMAP ptr) As Integer
Declare Function FreeImage_FlipVertical Alias "FreeImage_FlipVertical" (byval dib as FIBITMAP ptr) As Integer
Declare Function FreeImage_Rescale Alias "FreeImage_Rescale" (byval dib as FIBITMAP ptr, ByVal dst_width As Integer, ByVal dst_height As Integer, ByVal filter As FREE_IMAGE_FILTER) As FIBITMAP ptr
Declare Function FreeImage_AdjustCurve Alias "FreeImage_AdjustCurve" (byval dib as FIBITMAP ptr, ByRef LUT As Integer, ByVal channel As FREE_IMAGE_COLOR_CHANNEL) As Integer
Declare Function FreeImage_AdjustGamma Alias "FreeImage_AdjustGamma" (byval dib as FIBITMAP ptr, ByVal gamma As Single) As Integer
Declare Function FreeImage_AdjustBrightness Alias "FreeImage_AdjustBrightness" (byval dib as FIBITMAP ptr, ByVal percentage As Single) As Integer
Declare Function FreeImage_AdjustContrast Alias "FreeImage_AdjustContrast" (byval dib as FIBITMAP ptr, ByVal percentage As Single) As Integer
Declare Function FreeImage_Invert Alias "FreeImage_Invert" (byval dib as FIBITMAP ptr) As Integer
Declare Function FreeImage_GetHistogram Alias "FreeImage_GetHistogram" (byval dib as FIBITMAP ptr, ByRef histo As Integer, ByVal channel As FREE_IMAGE_COLOR_CHANNEL = FICC_BLACK) As Integer
Declare Function FreeImage_GetChannel Alias "FreeImage_GetChannel" (byval dib as FIBITMAP ptr, ByVal channel As FREE_IMAGE_COLOR_CHANNEL) As Integer
Declare Function FreeImage_SetChannel Alias "FreeImage_SetChannel" (byval dib as FIBITMAP ptr, ByVal dib8 As Integer, ByVal channel As FREE_IMAGE_COLOR_CHANNEL) As Integer
Declare Function FreeImage_GetComplexChannel Alias "FreeImage_GetComplexChannel" (ByVal src As Integer, ByVal channel As FREE_IMAGE_COLOR_CHANNEL) As Integer
Declare Function FreeImage_SetComplexChannel Alias "FreeImage_SetComplexChannel" (ByVal dst As Integer, ByVal src As Integer, ByVal channel As FREE_IMAGE_COLOR_CHANNEL) As Integer
Declare Function FreeImage_Copy Alias "FreeImage_Copy" (byval dib as FIBITMAP ptr, ByVal left As Integer, ByVal top As Integer, ByVal right As Integer, ByVal bottom As Integer) As FIBITMAP ptr
Declare Function FreeImage_Paste Alias "FreeImage_Paste" (ByVal dst As Integer, ByVal src As Integer, ByVal left As Integer, ByVal top As Integer, ByVal alpha As Integer) As Integer
Declare Function FreeImage_Composite Alias "FreeImage_Composite" (ByVal fg As Integer, ByVal useFileBkg As Integer = 0, ByVal appBkColor As Integer = 0, ByVal bg As Integer = 0) As FIBITMAP ptr

#endif
