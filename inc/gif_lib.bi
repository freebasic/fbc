'' giflib 4.2.1 and 5.0.4
''
'' By default, the giflib 5 API is used, but __GIFLIB_VER__ can be #defined to
'' 4 or 5 to select a specific version, should that be necessary to match the
'' version of the libgif binary.

#ifndef __GIFLIB_VER__
#define __GIFLIB_VER__ 5
#endif

#pragma once
#inclib "gif"

extern "C"

type bool as byte

#if __GIFLIB_VER__ = 4
	#define GIFLIB_MAJOR 4
	#define GIFLIB_MINOR 2
	#define GIFLIB_RELEASE 1
#elseif __GIFLIB_VER__ = 5
	#define GIFLIB_MAJOR 5
	#define GIFLIB_MINOR 0
	#define GIFLIB_RELEASE 4
#else
	#error "unsupported __GIFLIB_VER__ value (it can be 4 or 5)"
#endif

#define GIF_ERROR 0
#define GIF_OK 1

#define GIF_STAMP "GIFVER"
#define GIF_STAMP_LEN len(GIF_STAMP)
#define GIF_VERSION_POS 3
#define GIF87_STAMP "GIF87a"
#define GIF89_STAMP "GIF89a"

#if __GIFLIB_VER__ <= 4
#define GIF_FILE_BUFFER_SIZE 16384
#endif

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
#if __GIFLIB_VER__ >= 5
	SortFlag as bool
#endif
	Colors as GifColorType ptr
end type

type GifImageDesc
	Left as GifWord
	Top as GifWord
	Width as GifWord
	Height as GifWord
#if __GIFLIB_VER__ <= 4
	Interlace as GifWord
#else
	Interlace as bool
#endif
	ColorMap as ColorMapObject ptr
end type

type ExtensionBlock
	ByteCount as long
#if __GIFLIB_VER__ <= 4
	Bytes as byte ptr
#else
	Bytes as GifByteType ptr
#endif
	Function as long
end type

#define CONTINUE_EXT_FUNC_CODE &h00
#define COMMENT_EXT_FUNC_CODE &hFE
#define GRAPHICS_EXT_FUNC_CODE &hF9
#define PLAINTEXT_EXT_FUNC_CODE &h01
#define APPLICATION_EXT_FUNC_CODE &hFF

type SavedImage
	ImageDesc as GifImageDesc
#if __GIFLIB_VER__ <= 4
	RasterBits as ubyte ptr
	Function as long
#else
	RasterBits as GifByteType ptr
#endif
	ExtensionBlockCount as long
	ExtensionBlocks as ExtensionBlock ptr
end type

type GifFileType
	SWidth as GifWord
	SHeight as GifWord
	SColorResolution as GifWord
	SBackGroundColor as GifWord
#if __GIFLIB_VER__ >= 5
	AspectByte as GifByteType
#endif
	SColorMap as ColorMapObject ptr
	ImageCount as long
	Image as GifImageDesc
	SavedImages as SavedImage ptr
#if __GIFLIB_VER__ >= 5
	ExtensionBlockCount as long
	ExtensionBlocks as ExtensionBlock ptr
	Error as long
#endif
	UserData as any ptr
	Private_ as any ptr
end type

#if __GIFLIB_VER__ >= 5
#define GIF_ASPECT_RATIO(n)	((n)+15.0/64.0)
#endif

enum GifRecordType
	UNDEFINED_RECORD_TYPE
	SCREEN_DESC_RECORD_TYPE
	IMAGE_DESC_RECORD_TYPE
	EXTENSION_RECORD_TYPE
	TERMINATE_RECORD_TYPE
end enum

type InputFunc as function(byval as GifFileType ptr, byval as GifByteType ptr, byval as long) as long
type OutputFunc as function(byval as GifFileType ptr, byval as const GifByteType ptr, byval as long) as long

#if __GIFLIB_VER__ <= 4
#define COMMENT_EXT_FUNC_CODE &hFE
#define GRAPHICS_EXT_FUNC_CODE &hF9
#define PLAINTEXT_EXT_FUNC_CODE &h01
#define APPLICATION_EXT_FUNC_CODE &hFF
#else
type GraphicsControlBlock
	DisposalMode as long
	UserInputFlag as bool
	DelayTime as long
	TransparentColor as long
end type

#define DISPOSAL_UNSPECIFIED 0
#define DISPOSE_DO_NOT 1
#define DISPOSE_BACKGROUND 2
#define DISPOSE_PREVIOUS 3

#define NO_TRANSPARENT_COLOR -1
#endif

#if __GIFLIB_VER__ <= 4
declare function EGifOpenFileName(byval GifFileName as const zstring ptr, byval GifTestExistance as bool) as GifFileType ptr
declare function EGifOpenFileHandle(byval GifFileHandle as long) as GifFileType ptr
declare function EGifOpen(byval userPtr as any ptr, byval writeFunc as OutputFunc) as GifFileType ptr
#else
declare function EGifOpenFileName(byval GifFileName as const zstring ptr, byval GifTestExistence as const bool, byval Error as long ptr) as GifFileType ptr
declare function EGifOpenFileHandle(byval GifFileHandle as const long, byval Error as long ptr) as GifFileType ptr
declare function EGifOpen(byval userPtr as any ptr, byval writeFunc as OutputFunc, byval Error as long ptr) as GifFileType ptr
#endif

declare function EGifSpew(byval GifFile as GifFileType ptr) as long

#if __GIFLIB_VER__ <= 4
declare sub EGifSetGifVersion(byval Version as const zstring ptr)
#else
declare function EGifGetGifVersion(byval GifFile as GifFileType ptr) as zstring ptr
#endif

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

#if __GIFLIB_VER__ <= 4
declare function EGifPutScreenDesc(byval GifFile as GifFileType ptr, byval GifWidth as long, byval GifHeight as long, byval GifColorRes as long, byval GifBackGround as long, byval GifColorMap as const ColorMapObject ptr) as long
declare function EGifPutImageDesc(byval GifFile as GifFileType ptr, byval GifLeft as long, byval GifTop as long, byval Width as long, byval GifHeight as long, byval GifInterlace as bool, byval GifColorMap as const ColorMapObject ptr) as long
#else
declare function EGifPutScreenDesc(byval GifFile as GifFileType ptr, byval GifWidth as const long, byval GifHeight as const long, byval GifColorRes as const long, byval GifBackGround as const long, byval GifColorMap as const ColorMapObject ptr) as long
declare function EGifPutImageDesc(byval GifFile as GifFileType ptr, byval GifLeft as const long, byval GifTop as const long, byval GifWidth as const long, byval GifHeight as const long, byval GifInterlace as const bool, byval GifColorMap as const ColorMapObject ptr) as long
declare sub EGifSetGifVersion(byval GifFile as GifFileType ptr, byval gif89 as const bool)
#endif

declare function EGifPutLine(byval GifFile as GifFileType ptr, byval GifLine as GifPixelType ptr, byval GifLineLen as long) as long

#if __GIFLIB_VER__ <= 4
declare function EGifPutPixel(byval GifFile as GifFileType ptr, byval GifPixel as GifPixelType) as long
#else
declare function EGifPutPixel(byval GifFile as GifFileType ptr, byval GifPixel as const GifPixelType) as long
#endif

declare function EGifPutComment(byval GifFile as GifFileType ptr, byval GifComment as const zstring ptr) as long

#if __GIFLIB_VER__ <= 4
declare function EGifPutExtensionFirst(byval GifFile as GifFileType ptr, byval GifExtCode as long, byval GifExtLen as long, byval GifExtension as const any ptr) as long
declare function EGifPutExtensionNext(byval GifFile as GifFileType ptr, byval GifExtCode as long, byval GifExtLen as long, byval GifExtension as const any ptr) as long
declare function EGifPutExtensionLast(byval GifFile as GifFileType ptr, byval GifExtCode as long, byval GifExtLen as long, byval GifExtension as const any ptr) as long
declare function EGifPutExtension(byval GifFile as GifFileType ptr, byval GifExtCode as long, byval GifExtLen as long, byval GifExtension as const any ptr) as long
#else
declare function EGifPutExtensionLeader(byval GifFile as GifFileType ptr, byval GifExtCode as const long) as long
declare function EGifPutExtensionBlock(byval GifFile as GifFileType ptr, byval GifExtLen as const long, byval GifExtension as const any ptr) as long
declare function EGifPutExtensionTrailer(byval GifFile as GifFileType ptr) as long
declare function EGifPutExtension(byval GifFile as GifFileType ptr, byval GifExtCode as const long, byval GifExtLen as const long, byval GifExtension as const any ptr) as long
#endif

declare function EGifPutCode(byval GifFile as GifFileType ptr, byval GifCodeSize as long, byval GifCodeBlock as const GifByteType ptr) as long
declare function EGifPutCodeNext(byval GifFile as GifFileType ptr, byval GifCodeBlock as const GifByteType ptr) as long

#if __GIFLIB_VER__ <= 4
declare function DGifOpenFileName(byval GifFileName as const zstring ptr) as GifFileType ptr
declare function DGifOpenFileHandle(byval GifFileHandle as long) as GifFileType ptr
#else
declare function DGifOpenFileName(byval GifFileName as const zstring ptr, byval Error as long ptr) as GifFileType ptr
declare function DGifOpenFileHandle(byval GifFileHandle as long, byval Error as long ptr) as GifFileType ptr
#endif

declare function DGifSlurp(byval GifFile as GifFileType ptr) as long

#if __GIFLIB_VER__ <= 4
declare function DGifOpen(byval userPtr as any ptr, byval readFunc as InputFunc) as GifFileType ptr
#else
declare function DGifOpen(byval userPtr as any ptr, byval readFunc as InputFunc, byval Error as long ptr) as GifFileType ptr
#endif

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

#if __GIFLIB_VER__ <= 4
declare function GifError() as long
declare function GifErrorString() as zstring ptr
declare function GifLastError() as long
declare function MakeMapObject(byval ColorCount as long, byval ColorMap as const GifColorType ptr) as ColorMapObject ptr
declare sub FreeMapObject(byval Object as ColorMapObject ptr)
declare function UnionColorMap(byval ColorIn1 as const ColorMapObject ptr, byval ColorIn2 as const ColorMapObject ptr, byval ColorTransIn2 as GifPixelType ptr) as ColorMapObject ptr
declare function BitSize(byval n as long) as long
declare sub ApplyTranslation(byval Image as SavedImage ptr, byval Translation as GifPixelType ptr)
declare sub MakeExtension(byval as SavedImage ptr, byval as long)
declare function AddExtensionBlock(byval as SavedImage ptr, byval as long, byval ExtData as ubyte ptr) as long
declare sub FreeExtension(byval Image as SavedImage ptr)
declare function MakeSavedImage(byval GifFile as GifFileType ptr, byval CopyFrom as const SavedImage ptr) as SavedImage ptr
declare sub FreeSavedImages(byval GifFile as GifFileType ptr)
#else
declare function GifQuantizeBuffer(byval Width as ulong, byval Height as ulong, byval ColorMapSize as long ptr, byval RedInput as GifByteType ptr, byval GreenInput as GifByteType ptr, byval BlueInput as GifByteType ptr, byval OutputBuffer as GifByteType ptr, byval OutputColorMap as GifColorType ptr) as long
declare function GifErrorString(byval ErrorCode as long) as zstring ptr
declare function GifMakeMapObject(byval ColorCount as long, byval ColorMap as const GifColorType ptr) as ColorMapObject ptr
declare sub GifFreeMapObject(byval Object as ColorMapObject ptr)
declare function GifUnionColorMap(byval ColorIn1 as const ColorMapObject ptr, byval ColorIn2 as const ColorMapObject ptr, byval ColorTransIn2 as GifPixelType ptr) as ColorMapObject ptr
declare function GifBitSize(byval n as long) as long
declare sub GifApplyTranslation(byval Image as SavedImage ptr, byval Translation as GifPixelType ptr)
declare function GifAddExtensionBlock(byval ExtensionBlock_Count as long ptr, byval ExtensionBlocks as ExtensionBlock ptr ptr, byval Function as long, byval Len as ulong, byval ExtData as ubyte ptr) as long
declare sub GifFreeExtensions(byval ExtensionBlock_Count as long ptr, byval ExtensionBlocks as ExtensionBlock ptr ptr)
declare function GifMakeSavedImage(byval GifFile as GifFileType ptr, byval CopyFrom as const SavedImage ptr) as SavedImage ptr
declare sub GifFreeSavedImages(byval GifFile as GifFileType ptr)
declare function DGifExtensionToGCB(byval GifExtensionLength as const integer, byval GifExtension as const GifByteType ptr, byval GCB as GraphicsControlBlock ptr) as long
declare function EGifGCBToExtension(byval GCB as const GraphicsControlBlock ptr, byval GifExtension as GifByteType ptr) as integer
declare function DGifSavedExtensionToGCB(byval GifFile as GifFileType ptr, byval ImageIndex as long, byval GCB as GraphicsControlBlock ptr) as long
declare function EGifGCBToSavedExtension(byval GCB as const GraphicsControlBlock ptr, byval GifFile as GifFileType ptr, byval ImageIndex as long) as long
#endif

#define GIF_FONT_WIDTH 8
#define GIF_FONT_HEIGHT 8

#if __GIFLIB_VER__ <= 4
extern AsciiTable(0 to 127, 0 to GIF_FONT_WIDTH-1) as const ubyte
#ifdef __FB_WIN32__
declare sub DrawGifText(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval legend as const zstring ptr, byval color as const long)
#else
declare sub DrawText(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval legend as const zstring ptr, byval color as const long)
#endif
declare sub DrawBox(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval w as const long, byval d as const long, byval color as const long)
declare sub DrawRectangle(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval w as const long, byval d as const long, byval color as const long)
declare sub DrawBoxedText(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval legend as const zstring ptr, byval border as const long, byval bg as const long, byval fg as const long)
#else
extern GifAsciiTable8x8(0 to 127, 0 to GIF_FONT_WIDTH-1) as const ubyte
declare sub GifDrawText8x8(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval legend as const zstring ptr, byval color as const long)
declare sub GifDrawBox(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval w as const long, byval d as const long, byval color as const long)
declare sub GifDrawRectangle(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval w as const long, byval d as const long, byval color as const long)
declare sub GifDrawBoxedText8x8(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval legend as const zstring ptr, byval border as const long, byval bg as const long, byval fg as const long)
#endif

end extern
