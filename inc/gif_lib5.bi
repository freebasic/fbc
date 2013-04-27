'' giflib 5.0.4 (note: ABI incompatible with giflib 4; use gif_lib4.bi for that)

''*****************************************************************************
''
''gif_lib.h - service library for decoding and encoding GIF images
''
''****************************************************************************

#pragma once
#inclib "gif"

extern "C"

type bool as byte

#define GIFLIB_MAJOR 5
#define GIFLIB_MINOR 0
#define GIFLIB_RELEASE 4

#define GIF_ERROR 0
#define GIF_OK 1

#define GIF_STAMP "GIFVER"
#define GIF_STAMP_LEN len(GIF_STAMP)
#define GIF_VERSION_POS 3
#define GIF87_STAMP "GIF87a"
#define GIF89_STAMP "GIF89a"

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
	SortFlag as bool
	Colors as GifColorType ptr '' on malloc(3) heap
end type

type GifImageDesc
	Left as GifWord
	Top as GifWord
	Width as GifWord
	Height as GifWord '' Current image dimensions.
	Interlace as bool '' Sequential/Interlaced lines.
	ColorMap as ColorMapObject ptr '' The local color map
end type

type ExtensionBlock
	ByteCount as long
	Bytes as GifByteType ptr '' on malloc(3) heap
	Function as long '' The block function code
end type

#define CONTINUE_EXT_FUNC_CODE &h00
#define COMMENT_EXT_FUNC_CODE &hFE
#define GRAPHICS_EXT_FUNC_CODE &hF9
#define PLAINTEXT_EXT_FUNC_CODE &h01
#define APPLICATION_EXT_FUNC_CODE &hFF

type SavedImage
	ImageDesc as GifImageDesc
	RasterBits as GifByteType ptr '' on malloc(3) heap
	ExtensionBlockCount as long '' Count of extensions before image
	ExtensionBlocks as ExtensionBlock ptr '' Extensions before image
end type

type GifFileType
	SWidth as GifWord
	SHeight as GifWord '' Size of virtual canvas
	SColorResolution as GifWord '' How many colors can we generate?
	SBackGroundColor as GifWord '' Background color for virtual canvas
	AspectByte as GifByteType '' Used to compute pixel aspect ratio
	SColorMap as ColorMapObject ptr '' Global colormap, NULL if nonexistent.
	ImageCount as long '' Number of current image (both APIs)
	Image as GifImageDesc '' Current image (low-level API)
	SavedImages as SavedImage ptr '' Image sequence (high-level API)
	ExtensionBlockCount as long '' Count extensions past last image
	ExtensionBlocks as ExtensionBlock ptr '' Extensions past last image
	Error as long '' Last error condition reported
	UserData as any ptr '' hook to attach user data (TVT)
	Private_ as any ptr '' Don't mess with this!
end type

#define GIF_ASPECT_RATIO(n)	((n)+15.0/64.0)

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
'' GIF89 structures
''*****************************************************************************
type GraphicsControlBlock
	DisposalMode as long
	UserInputFlag as bool '' User confirmation required before disposal
	DelayTime as long '' pre-display delay in 0.01sec units
	TransparentColor as long '' Palette index for transparency, -1 if none
end type

#define DISPOSAL_UNSPECIFIED 0
#define DISPOSE_DO_NOT 1
#define DISPOSE_BACKGROUND 2
#define DISPOSE_PREVIOUS 3

#define NO_TRANSPARENT_COLOR -1

''*****************************************************************************
'' GIF encoding routines
''*****************************************************************************

'' Main entry points
declare function EGifOpenFileName(byval GifFileName as const zstring ptr, byval GifTestExistence as const bool, byval Error as long ptr) as GifFileType ptr
declare function EGifOpenFileHandle(byval GifFileHandle as const long, byval Error as long ptr) as GifFileType ptr
declare function EGifOpen(byval userPtr as any ptr, byval writeFunc as OutputFunc, byval Error as long ptr) as GifFileType ptr
declare function EGifSpew(byval GifFile as GifFileType ptr) as long
declare function EGifGetGifVersion(byval GifFile as GifFileType ptr) as zstring ptr '' new in 5.x
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
declare function EGifPutScreenDesc(byval GifFile as GifFileType ptr, byval GifWidth as const long, byval GifHeight as const long, byval GifColorRes as const long, byval GifBackGround as const long, byval GifColorMap as const ColorMapObject ptr) as long
declare function EGifPutImageDesc(byval GifFile as GifFileType ptr, byval GifLeft as const long, byval GifTop as const long, byval GifWidth as const long, byval GifHeight as const long, byval GifInterlace as const bool, byval GifColorMap as const ColorMapObject ptr) as long
declare sub EGifSetGifVersion(byval GifFile as GifFileType ptr, byval gif89 as const bool)
declare function EGifPutLine(byval GifFile as GifFileType ptr, byval GifLine as GifPixelType ptr, byval GifLineLen as long) as long
declare function EGifPutPixel(byval GifFile as GifFileType ptr, byval GifPixel as const GifPixelType) as long
declare function EGifPutComment(byval GifFile as GifFileType ptr, byval GifComment as const zstring ptr) as long
declare function EGifPutExtensionLeader(byval GifFile as GifFileType ptr, byval GifExtCode as const long) as long
declare function EGifPutExtensionBlock(byval GifFile as GifFileType ptr, byval GifExtLen as const long, byval GifExtension as const any ptr) as long
declare function EGifPutExtensionTrailer(byval GifFile as GifFileType ptr) as long
declare function EGifPutExtension(byval GifFile as GifFileType ptr, byval GifExtCode as const long, byval GifExtLen as const long, byval GifExtension as const any ptr) as long
declare function EGifPutCode(byval GifFile as GifFileType ptr, byval GifCodeSize as long, byval GifCodeBlock as const GifByteType ptr) as long
declare function EGifPutCodeNext(byval GifFile as GifFileType ptr, byval GifCodeBlock as const GifByteType ptr) as long

''*****************************************************************************
'' GIF decoding routines
''*****************************************************************************

'' Main entry points
declare function DGifOpenFileName(byval GifFileName as const zstring ptr, byval Error as long ptr) as GifFileType ptr
declare function DGifOpenFileHandle(byval GifFileHandle as long, byval Error as long ptr) as GifFileType ptr
declare function DGifSlurp(byval GifFile as GifFileType ptr) as long
declare function DGifOpen(byval userPtr as any ptr, byval readFunc as InputFunc, byval Error as long ptr) as GifFileType ptr '' new one (TVT)
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
'' Color table quantization (deprecated)
''*****************************************************************************
declare function GifQuantizeBuffer(byval Width as ulong, byval Height as ulong, byval ColorMapSize as long ptr, byval RedInput as GifByteType ptr, byval GreenInput as GifByteType ptr, byval BlueInput as GifByteType ptr, byval OutputBuffer as GifByteType ptr, byval OutputColorMap as GifColorType ptr) as long

'' new in 2012 - ESR
''*****************************************************************************
'' Error handling and reporting.
''*****************************************************************************
declare function GifErrorString(byval ErrorCode as long) as zstring ptr

''****************************************************************************
'' Everything below this point is new after version 1.2, supporting `slurp
'' mode' for doing I/O in two big belts with all the image-bashing in core.
''*****************************************************************************

''*****************************************************************************
'' Color map handling from gif_alloc.c
''*****************************************************************************
declare function GifMakeMapObject(byval ColorCount as long, byval ColorMap as const GifColorType ptr) as ColorMapObject ptr
declare sub GifFreeMapObject(byval Object as ColorMapObject ptr)
declare function GifUnionColorMap(byval ColorIn1 as const ColorMapObject ptr, byval ColorIn2 as const ColorMapObject ptr, byval ColorTransIn2 as GifPixelType ptr) as ColorMapObject ptr
declare function GifBitSize(byval n as long) as long

''*****************************************************************************
'' Support for the in-core structures allocation (slurp mode).
''*****************************************************************************
declare sub GifApplyTranslation(byval Image as SavedImage ptr, byval Translation as GifPixelType ptr)
declare function GifAddExtensionBlock(byval ExtensionBlock_Count as long ptr, byval ExtensionBlocks as ExtensionBlock ptr ptr, byval Function as long, byval Len as ulong, byval ExtData as ubyte ptr) as long
declare sub GifFreeExtensions(byval ExtensionBlock_Count as long ptr, byval ExtensionBlocks as ExtensionBlock ptr ptr)
declare function GifMakeSavedImage(byval GifFile as GifFileType ptr, byval CopyFrom as const SavedImage ptr) as SavedImage ptr
declare sub GifFreeSavedImages(byval GifFile as GifFileType ptr)

''*****************************************************************************
'' 5.x functions for GIF89 graphics control blocks
''*****************************************************************************
declare function DGifExtensionToGCB(byval GifExtensionLength as const integer, byval GifExtension as const GifByteType ptr, byval GCB as GraphicsControlBlock ptr) as long
declare function EGifGCBToExtension(byval GCB as const GraphicsControlBlock ptr, byval GifExtension as GifByteType ptr) as integer
declare function DGifSavedExtensionToGCB(byval GifFile as GifFileType ptr, byval ImageIndex as long, byval GCB as GraphicsControlBlock ptr) as long
declare function EGifGCBToSavedExtension(byval GCB as const GraphicsControlBlock ptr, byval GifFile as GifFileType ptr, byval ImageIndex as long) as long

''*****************************************************************************
'' The library's internal utility font
''*****************************************************************************
#define GIF_FONT_WIDTH 8
#define GIF_FONT_HEIGHT 8

extern GifAsciiTable8x8(0 to 127, 0 to GIF_FONT_WIDTH-1) as const ubyte

declare sub GifDrawText8x8(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval legend as const zstring ptr, byval color as const long)
declare sub GifDrawBox(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval w as const long, byval d as const long, byval color as const long)
declare sub GifDrawRectangle(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval w as const long, byval d as const long, byval color as const long)
declare sub GifDrawBoxedText8x8(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval legend as const zstring ptr, byval border as const long, byval bg as const long, byval fg as const long)

end extern
