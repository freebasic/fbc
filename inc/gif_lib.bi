'' giflib 4.2.1

#pragma once
#inclib "gif"

extern "C"

type bool as byte

#define GIFLIB_MAJOR 4
#define GIFLIB_MINOR 2
#define GIFLIB_RELEASE 1

#define GIF_ERROR 0
#define GIF_OK 1

#define GIF_STAMP "GIFVER"
#define GIF_STAMP_LEN len(GIF_STAMP)
#define GIF_VERSION_POS 3
#define GIF87_STAMP "GIF87a"
#define GIF89_STAMP "GIF89a"

#define GIF_FILE_BUFFER_SIZE 16384

type GifPixelType as ubyte
type GifRowType as ubyte ptr
type GifByteType as ubyte
type GifPrefixType as ulong
type GifWord as long

type GifColorType
	Red as GifByteType
	Green as GifByteType
	Blue as GifByteType
end type

type ColorMapObject
	ColorCount as long
	BitsPerPixel as long
	Colors as GifColorType ptr '' on malloc(3) heap
end type

type GifImageDesc
	Left as GifWord
	Top as GifWord
	Width as GifWord
	Height as GifWord
	Interlace as GifWord '' Sequential/Interlaced lines.
	ColorMap as ColorMapObject ptr '' The local color map
end type

type ExtensionBlock '' This is the in-core version of an extension record
	ByteCount as long
	Bytes as zstring ptr '' on malloc(3) heap
	Function as long '' Holds the type of the Extension block.
end type

type SavedImage '' This holds an image header, its unpacked raster bits, and extensions
	ImageDesc as GifImageDesc
	RasterBits as ubyte ptr '' on malloc(3) heap
	Function as long '' DEPRECATED: Use ExtensionBlocks[x].Function instead
	ExtensionBlockCount as long
	ExtensionBlocks as ExtensionBlock ptr '' on malloc(3) heap
end type

type GifFileType
	SWidth as GifWord
	SHeight as GifWord
	SColorResolution as GifWord
	SBackGroundColor as GifWord '' I hope you understand this one...
	SColorMap as ColorMapObject ptr '' NULL if not exists.
	ImageCount as long '' Number of current image
	Image as GifImageDesc '' Block describing current image
	SavedImages as SavedImage ptr '' Use this to accumulate file state
	UserData as any ptr '' hook to attach user data (TVT)
	Private_ as any ptr '' Don't mess with this!
end type

enum GifRecordType
	UNDEFINED_RECORD_TYPE
	SCREEN_DESC_RECORD_TYPE
	IMAGE_DESC_RECORD_TYPE
	EXTENSION_RECORD_TYPE
	TERMINATE_RECORD_TYPE
end enum

type InputFunc as function(byval as GifFileType ptr, byval as GifByteType ptr, byval as long) as long
type OutputFunc as function(byval as GifFileType ptr, byval as const GifByteType ptr, byval as long) as long

''*****************************************************************************
'' *  GIF89 extension function codes
''*****************************************************************************
#define COMMENT_EXT_FUNC_CODE &hFE
#define GRAPHICS_EXT_FUNC_CODE &hF9
#define PLAINTEXT_EXT_FUNC_CODE &h01
#define APPLICATION_EXT_FUNC_CODE &hFF

''*****************************************************************************
'' * O.K., here are the routines one can access in order to encode GIF file:
'' * (GIF_LIB file EGIF_LIB.C).
''*****************************************************************************

'' Main entry points
declare function EGifOpenFileName(byval GifFileName as const zstring ptr, byval GifTestExistance as bool) as GifFileType ptr
declare function EGifOpenFileHandle(byval GifFileHandle as long) as GifFileType ptr
declare function EGifOpen(byval userPtr as any ptr, byval writeFunc as OutputFunc) as GifFileType ptr
declare function EGifSpew(byval GifFile as GifFileType ptr) as long
declare sub EGifSetGifVersion(byval Version as const zstring ptr)
declare function EGifCloseFile(byval GifFile as GifFileType ptr) as long

#define E_GIF_ERR_OPEN_FAILED 1
#define E_GIF_ERR_WRITE_FAILED 2
#define E_GIF_ERR_HAS_SCRN_DSCR 3
#define E_GIF_ERR_HAS_IMAG_DSCR 4
#define E_GIF_ERR_NO_COLOR_MAP 5
#define E_GIF_ERR_DATA_TOO_BIG 6
#define E_GIF_ERR_NOT_ENOUGH_MEM 7
#define E_GIF_ERR_DISK_IS_FULL 8
#define E_GIF_ERR_CLOSE_FAILED 9
#define E_GIF_ERR_NOT_WRITEABLE 10

'' These are legacy.  You probably do not want to call them directly
declare function EGifPutScreenDesc(byval GifFile as GifFileType ptr, byval GifWidth as long, byval GifHeight as long, byval GifColorRes as long, byval GifBackGround as long, byval GifColorMap as const ColorMapObject ptr) as long
declare function EGifPutImageDesc(byval GifFile as GifFileType ptr, byval GifLeft as long, byval GifTop as long, byval Width as long, byval GifHeight as long, byval GifInterlace as bool, byval GifColorMap as const ColorMapObject ptr) as long
declare function EGifPutLine(byval GifFile as GifFileType ptr, byval GifLine as GifPixelType ptr, byval GifLineLen as long) as long
declare function EGifPutPixel(byval GifFile as GifFileType ptr, byval GifPixel as GifPixelType) as long
declare function EGifPutComment(byval GifFile as GifFileType ptr, byval GifComment as const zstring ptr) as long
declare function EGifPutExtensionFirst(byval GifFile as GifFileType ptr, byval GifExtCode as long, byval GifExtLen as long, byval GifExtension as const any ptr) as long
declare function EGifPutExtensionNext(byval GifFile as GifFileType ptr, byval GifExtCode as long, byval GifExtLen as long, byval GifExtension as const any ptr) as long
declare function EGifPutExtensionLast(byval GifFile as GifFileType ptr, byval GifExtCode as long, byval GifExtLen as long, byval GifExtension as const any ptr) as long
declare function EGifPutExtension(byval GifFile as GifFileType ptr, byval GifExtCode as long, byval GifExtLen as long, byval GifExtension as const any ptr) as long
declare function EGifPutCode(byval GifFile as GifFileType ptr, byval GifCodeSize as long, byval GifCodeBlock as const GifByteType ptr) as long
declare function EGifPutCodeNext(byval GifFile as GifFileType ptr, byval GifCodeBlock as const GifByteType ptr) as long

''*****************************************************************************
'' * O.K., here are the routines one can access in order to decode GIF file:
'' * (GIF_LIB file DGIF_LIB.C).
'' ****************************************************************************

'' Main entry points
declare function DGifOpenFileName(byval GifFileName as const zstring ptr) as GifFileType ptr
declare function DGifOpenFileHandle(byval GifFileHandle as long) as GifFileType ptr
declare function DGifSlurp(byval GifFile as GifFileType ptr) as long
declare function DGifOpen(byval userPtr as any ptr, byval readFunc as InputFunc) as GifFileType ptr '' new one (TVT)
declare function DGifCloseFile(byval GifFile as GifFileType ptr) as long

#define D_GIF_ERR_OPEN_FAILED 101
#define D_GIF_ERR_READ_FAILED 102
#define D_GIF_ERR_NOT_GIF_FILE 103
#define D_GIF_ERR_NO_SCRN_DSCR 104
#define D_GIF_ERR_NO_IMAG_DSCR 105
#define D_GIF_ERR_NO_COLOR_MAP 106
#define D_GIF_ERR_WRONG_RECORD 107
#define D_GIF_ERR_DATA_TOO_BIG 108
#define D_GIF_ERR_NOT_ENOUGH_MEM 109
#define D_GIF_ERR_CLOSE_FAILED 110
#define D_GIF_ERR_NOT_READABLE 111
#define D_GIF_ERR_IMAGE_DEFECT 112
#define D_GIF_ERR_EOF_TOO_SOON 113

'' These are legacy.  You probably do not want to call them directly
declare function DGifGetScreenDesc(byval GifFile as GifFileType ptr) as long
declare function DGifGetRecordType(byval GifFile as GifFileType ptr, byval GifType as GifRecordType ptr) as long
declare function DGifGetImageDesc(byval GifFile as GifFileType ptr) as long
declare function DGifGetLine(byval GifFile as GifFileType ptr, byval GifLine as GifPixelType ptr, byval GifLineLen as long) as long
declare function DGifGetPixel(byval GifFile as GifFileType ptr, byval GifPixel as GifPixelType) as long
declare function DGifGetComment(byval GifFile as GifFileType ptr, byval GifComment as zstring ptr) as long
declare function DGifGetExtension(byval GifFile as GifFileType ptr, byval GifExtCode as long ptr, byval GifExtension as GifByteType ptr ptr) as long
declare function DGifGetExtensionNext(byval GifFile as GifFileType ptr, byval GifExtension as GifByteType ptr ptr) as long
declare function DGifGetCode(byval GifFile as GifFileType ptr, byval GifCodeSize as long ptr, byval GifCodeBlock as GifByteType ptr ptr) as long
declare function DGifGetCodeNext(byval GifFile as GifFileType ptr, byval GifCodeBlock as GifByteType ptr ptr) as long
declare function DGifGetLZCodes(byval GifFile as GifFileType ptr, byval GifCode as long ptr) as long

''*****************************************************************************
'' * O.K., here are the routines from GIF_LIB file GIF_ERR.C.
''*****************************************************************************
declare function GifError() as long '' new in 2012 - ESR
declare function GifErrorString() as zstring ptr '' new in 2012 - ESR
declare function GifLastError() as long

''****************************************************************************
'' *
'' * Everything below this point is new after version 1.2, supporting `slurp
'' * mode' for doing I/O in two big belts with all the image-bashing in core.
'' *
'' ****************************************************************************

''*****************************************************************************
'' * Color Map handling from ALLOCGIF.C
'' ****************************************************************************
declare function MakeMapObject(byval ColorCount as long, byval ColorMap as const GifColorType ptr) as ColorMapObject ptr
declare sub FreeMapObject(byval Object as ColorMapObject ptr)
declare function UnionColorMap(byval ColorIn1 as const ColorMapObject ptr, byval ColorIn2 as const ColorMapObject ptr, byval ColorTransIn2 as GifPixelType ptr) as ColorMapObject ptr
declare function BitSize(byval n as long) as long

''*****************************************************************************
'' * Support for the in-core structures allocation (slurp mode).
'' ****************************************************************************

declare sub ApplyTranslation(byval Image as SavedImage ptr, byval Translation as GifPixelType ptr)
declare sub MakeExtension(byval as SavedImage ptr, byval as long)
declare function AddExtensionBlock(byval as SavedImage ptr, byval as long, byval ExtData as ubyte ptr) as long
declare sub FreeExtension(byval Image as SavedImage ptr)
declare function MakeSavedImage(byval GifFile as GifFileType ptr, byval CopyFrom as const SavedImage ptr) as SavedImage ptr
declare sub FreeSavedImages(byval GifFile as GifFileType ptr)

''*****************************************************************************
'' * The library's internal utility font
'' ****************************************************************************
#define GIF_FONT_WIDTH 8
#define GIF_FONT_HEIGHT 8

extern AsciiTable(0 to 127, 0 to GIF_FONT_WIDTH-1) as const ubyte

#ifdef __FB_WIN32__
declare sub DrawGifText(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval legend as const zstring ptr, byval color as const long)
#else
declare sub DrawText(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval legend as const zstring ptr, byval color as const long)
#endif
declare sub DrawBox(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval w as const long, byval d as const long, byval color as const long)
declare sub DrawRectangle(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval w as const long, byval d as const long, byval color as const long)
declare sub DrawBoxedText(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval legend as const zstring ptr, byval border as const long, byval bg as const long, byval fg as const long)

end extern
