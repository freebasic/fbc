''
''
'' gif_lib -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gif_lib_bi__
#define __gif_lib_bi__

#include once "crt.bi"

#inclib "gif"

#ifndef TRUE
#define TRUE 1
#define FALSE 0
#endif

#ifndef NULL
#define NULL 0
#endif

#define GIF_LIB_VERSION " Version 4.1, "
#define GIF_ERROR 0
#define GIF_OK 1
#define GIF_STAMP "GIFVER"
#define GIF_VERSION_POS 3
#define GIF87_STAMP "GIF87a"
#define GIF89_STAMP "GIF89a"
#define GIF_FILE_BUFFER_SIZE 16384

type GifBooleanType as integer
type GifPixelType as ubyte
type GifRowType as ubyte ptr
type GifByteType as ubyte
type GifPrefixType as uinteger
type GifWord as integer

type GifColorType as GifColorType_
type ColorMapObject as ColorMapObject_
type GifImageDesc as GifImageDesc_
type GifFileType as GifFileType_
type ExtensionBlock as ExtensionBlock_
type SavedImage as SavedImage_


type GifColorType_ field=1
	Red as GifByteType
	Green as GifByteType
	Blue as GifByteType
end type

type ColorMapObject_
	ColorCount as integer
	BitsPerPixel as integer
	Colors as GifColorType ptr
end type

type GifImageDesc_
	Left as GifWord
	Top as GifWord
	Width as GifWord
	Height as GifWord
	Interlace as GifWord
	ColorMap as ColorMapObject ptr
end type

type GifFileType_
	SWidth as GifWord
	SHeight as GifWord
	SColorResolution as GifWord
	SBackGroundColor as GifWord
	SColorMap as ColorMapObject ptr
	ImageCount as integer
	Image as GifImageDesc
	SavedImages as SavedImage ptr
	UserData as any ptr
	Private_ as any ptr
end type

enum GifRecordType
	UNDEFINED_RECORD_TYPE
	SCREEN_DESC_RECORD_TYPE
	IMAGE_DESC_RECORD_TYPE
	EXTENSION_RECORD_TYPE
	TERMINATE_RECORD_TYPE
end enum


enum GifScreenDumpType
	GIF_DUMP_SGI_WINDOW = 1000
	GIF_DUMP_X_WINDOW = 1001
end enum

type InputFunc as function cdecl(byval as GifFileType ptr, byval as GifByteType ptr, byval as integer) as integer
type OutputFunc as function cdecl(byval as GifFileType ptr, byval as GifByteType ptr, byval as integer) as integer

#define COMMENT_EXT_FUNC_CODE &hfe
#define GRAPHICS_EXT_FUNC_CODE &hf9
#define PLAINTEXT_EXT_FUNC_CODE &h01
#define APPLICATION_EXT_FUNC_CODE &hff

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

type ExtensionBlock_
	ByteCount as integer
	Bytes as zstring ptr
	Function as integer
end type

type SavedImage_
	ImageDesc as GifImageDesc
	RasterBits as ubyte ptr
	Function as integer
	ExtensionBlockCount as integer
	ExtensionBlocks as ExtensionBlock ptr
end type

extern "c"
declare function EGifOpenFileName (byval GifFileName as zstring ptr, byval GifTestExistance as integer) as GifFileType ptr
declare function EGifOpenFileHandle (byval GifFileHandle as integer) as GifFileType ptr
declare function EGifOpen (byval userPtr as any ptr, byval writeFunc as OutputFunc) as GifFileType ptr
declare function EGifSpew (byval GifFile as GifFileType ptr) as integer
declare sub EGifSetGifVersion (byval Version as zstring ptr)
declare function EGifPutScreenDesc (byval GifFile as GifFileType ptr, byval GifWidth as integer, byval GifHeight as integer, byval GifColorRes as integer, byval GifBackGround as integer, byval GifColorMap as ColorMapObject ptr) as integer
declare function EGifPutImageDesc (byval GifFile as GifFileType ptr, byval GifLeft as integer, byval GifTop as integer, byval Width as integer, byval GifHeight as integer, byval GifInterlace as integer, byval GifColorMap as ColorMapObject ptr) as integer
declare function EGifPutLine (byval GifFile as GifFileType ptr, byval GifLine as GifPixelType ptr, byval GifLineLen as integer) as integer
declare function EGifPutPixel (byval GifFile as GifFileType ptr, byval GifPixel as GifPixelType) as integer
declare function EGifPutComment (byval GifFile as GifFileType ptr, byval GifComment as zstring ptr) as integer
declare function EGifPutExtensionFirst (byval GifFile as GifFileType ptr, byval GifExtCode as integer, byval GifExtLen as integer, byval GifExtension as any ptr) as integer
declare function EGifPutExtensionNext (byval GifFile as GifFileType ptr, byval GifExtCode as integer, byval GifExtLen as integer, byval GifExtension as any ptr) as integer
declare function EGifPutExtensionLast (byval GifFile as GifFileType ptr, byval GifExtCode as integer, byval GifExtLen as integer, byval GifExtension as any ptr) as integer
declare function EGifPutExtension (byval GifFile as GifFileType ptr, byval GifExtCode as integer, byval GifExtLen as integer, byval GifExtension as any ptr) as integer
declare function EGifPutCode (byval GifFile as GifFileType ptr, byval GifCodeSize as integer, byval GifCodeBlock as GifByteType ptr) as integer
declare function EGifPutCodeNext (byval GifFile as GifFileType ptr, byval GifCodeBlock as GifByteType ptr) as integer
declare function EGifCloseFile (byval GifFile as GifFileType ptr) as integer
declare function DGifOpenFileName (byval GifFileName as zstring ptr) as GifFileType ptr
declare function DGifOpenFileHandle (byval GifFileHandle as integer) as GifFileType ptr
declare function DGifSlurp (byval GifFile as GifFileType ptr) as integer
declare function DGifOpen (byval userPtr as any ptr, byval readFunc as InputFunc) as GifFileType ptr
declare function DGifGetScreenDesc (byval GifFile as GifFileType ptr) as integer
declare function DGifGetRecordType (byval GifFile as GifFileType ptr, byval GifType as GifRecordType ptr) as integer
declare function DGifGetImageDesc (byval GifFile as GifFileType ptr) as integer
declare function DGifGetLine (byval GifFile as GifFileType ptr, byval GifLine as GifPixelType ptr, byval GifLineLen as integer) as integer
declare function DGifGetPixel (byval GifFile as GifFileType ptr, byval GifPixel as GifPixelType) as integer
declare function DGifGetComment (byval GifFile as GifFileType ptr, byval GifComment as zstring ptr) as integer
declare function DGifGetExtension (byval GifFile as GifFileType ptr, byval GifExtCode as integer ptr, byval GifExtension as GifByteType ptr ptr) as integer
declare function DGifGetExtensionNext (byval GifFile as GifFileType ptr, byval GifExtension as GifByteType ptr ptr) as integer
declare function DGifGetCode (byval GifFile as GifFileType ptr, byval GifCodeSize as integer ptr, byval GifCodeBlock as GifByteType ptr ptr) as integer
declare function DGifGetCodeNext (byval GifFile as GifFileType ptr, byval GifCodeBlock as GifByteType ptr ptr) as integer
declare function DGifGetLZCodes (byval GifFile as GifFileType ptr, byval GifCode as integer ptr) as integer
declare function DGifCloseFile (byval GifFile as GifFileType ptr) as integer
declare function QuantizeBuffer (byval Width as uinteger, byval Height as uinteger, byval ColorMapSize as integer ptr, byval RedInput as GifByteType ptr, byval GreenInput as GifByteType ptr, byval BlueInput as GifByteType ptr, byval OutputBuffer as GifByteType ptr, byval OutputColorMap as GifColorType ptr) as integer
declare sub PrintGifError ()
declare function GifLastError () as integer
declare function DumpScreen2Gif (byval FileName as zstring ptr, byval ReqGraphDriver as integer, byval ReqGraphMode1 as integer, byval ReqGraphMode2 as integer, byval ReqGraphMode3 as integer) as integer
declare function MakeMapObject (byval ColorCount as integer, byval ColorMap as GifColorType ptr) as ColorMapObject ptr
declare sub FreeMapObject (byval Object as ColorMapObject ptr)
declare function UnionColorMap (byval ColorIn1 as ColorMapObject ptr, byval ColorIn2 as ColorMapObject ptr, byval ColorTransIn2 as GifPixelType ptr) as ColorMapObject ptr
declare function BitSize (byval n as integer) as integer
declare sub ApplyTranslation (byval Image as SavedImage ptr, byval Translation as GifPixelType ptr)
declare sub MakeExtension (byval New_ as SavedImage ptr, byval Function as integer)
declare function AddExtensionBlock (byval New_ as SavedImage ptr, byval Len as integer, byval ExtData as ubyte ptr) as integer
declare sub FreeExtension (byval Image as SavedImage ptr)
declare function MakeSavedImage (byval GifFile as GifFileType ptr, byval CopyFrom as SavedImage ptr) as SavedImage ptr
declare sub FreeSavedImages (byval GifFile as GifFileType ptr)
declare sub DrawText (byval Image as SavedImage ptr, byval x as integer, byval y as integer, byval legend as zstring ptr, byval color as integer)
declare sub DrawBox (byval Image as SavedImage ptr, byval x as integer, byval y as integer, byval w as integer, byval d as integer, byval color as integer)
declare sub DrawRectangle (byval Image as SavedImage ptr, byval x as integer, byval y as integer, byval w as integer, byval d as integer, byval color as integer)
declare sub DrawBoxedText (byval Image as SavedImage ptr, byval x as integer, byval y as integer, byval legend as zstring ptr, byval border as integer, byval bg as integer, byval fg as integer)
end extern

#define GIF_FONT_WIDTH 8
#define GIF_FONT_HEIGHT 8

#endif
