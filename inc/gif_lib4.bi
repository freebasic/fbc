'' FreeBASIC binding for giflib-4.2.3
''
'' based on the C header files:
''   The GIFLIB distribution is Copyright (c) 1997  Eric S. Raymond
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software, and to permit persons to whom the Software is
''   furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
''   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
''   THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "gif"

extern "C"

const _GIF_LIB_H_ = 1
const GIFLIB_MAJOR = 4
const GIFLIB_MINOR = 2
const GIFLIB_RELEASE = 3
const GIF_ERROR = 0
const GIF_OK = 1
#define GIF_STAMP "GIFVER"
#define GIF_STAMP_LEN (sizeof(GIF_STAMP) - 1)
const GIF_VERSION_POS = 3
#define GIF87_STAMP "GIF87a"
#define GIF89_STAMP "GIF89a"
const GIF_FILE_BUFFER_SIZE = 16384

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
	Colors as GifColorType ptr
end type

type GifImageDesc
	Left as GifWord
	Top as GifWord
	Width as GifWord
	Height as GifWord
	Interlace as GifWord
	ColorMap as ColorMapObject ptr
end type

type SavedImage as SavedImage_

type GifFileType
	SWidth as GifWord
	SHeight as GifWord
	SColorResolution as GifWord
	SBackGroundColor as GifWord
	SColorMap as ColorMapObject ptr
	ImageCount as long
	Image as GifImageDesc
	SavedImages as SavedImage ptr
	UserData as any ptr
	as any ptr Private
end type

type GifRecordType as long
enum
	UNDEFINED_RECORD_TYPE
	SCREEN_DESC_RECORD_TYPE
	IMAGE_DESC_RECORD_TYPE
	EXTENSION_RECORD_TYPE
	TERMINATE_RECORD_TYPE
end enum

type InputFunc as function(byval as GifFileType ptr, byval as GifByteType ptr, byval as long) as long
type OutputFunc as function(byval as GifFileType ptr, byval as const GifByteType ptr, byval as long) as long
const COMMENT_EXT_FUNC_CODE = &hfe
const GRAPHICS_EXT_FUNC_CODE = &hf9
const PLAINTEXT_EXT_FUNC_CODE = &h01
const APPLICATION_EXT_FUNC_CODE = &hff

declare function EGifOpenFileName(byval GifFileName as const zstring ptr, byval GifTestExistance as byte) as GifFileType ptr
declare function EGifOpenFileHandle(byval GifFileHandle as long) as GifFileType ptr
declare function EGifOpen(byval userPtr as any ptr, byval writeFunc as OutputFunc) as GifFileType ptr
declare function EGifSpew(byval GifFile as GifFileType ptr) as long
declare sub EGifSetGifVersion(byval Version as const zstring ptr)
declare function EGifCloseFile(byval GifFile as GifFileType ptr) as long

const E_GIF_ERR_OPEN_FAILED = 1
const E_GIF_ERR_WRITE_FAILED = 2
const E_GIF_ERR_HAS_SCRN_DSCR = 3
const E_GIF_ERR_HAS_IMAG_DSCR = 4
const E_GIF_ERR_NO_COLOR_MAP = 5
const E_GIF_ERR_DATA_TOO_BIG = 6
const E_GIF_ERR_NOT_ENOUGH_MEM = 7
const E_GIF_ERR_DISK_IS_FULL = 8
const E_GIF_ERR_CLOSE_FAILED = 9
const E_GIF_ERR_NOT_WRITEABLE = 10

declare function EGifPutScreenDesc(byval GifFile as GifFileType ptr, byval GifWidth as long, byval GifHeight as long, byval GifColorRes as long, byval GifBackGround as long, byval GifColorMap as const ColorMapObject ptr) as long
declare function EGifPutImageDesc(byval GifFile as GifFileType ptr, byval GifLeft as long, byval GifTop as long, byval Width as long, byval GifHeight as long, byval GifInterlace as byte, byval GifColorMap as const ColorMapObject ptr) as long
declare function EGifPutLine(byval GifFile as GifFileType ptr, byval GifLine as GifPixelType ptr, byval GifLineLen as long) as long
declare function EGifPutPixel(byval GifFile as GifFileType ptr, byval GifPixel as GifPixelType) as long
declare function EGifPutComment(byval GifFile as GifFileType ptr, byval GifComment as const zstring ptr) as long
declare function EGifPutExtensionFirst(byval GifFile as GifFileType ptr, byval GifExtCode as long, byval GifExtLen as long, byval GifExtension as const any ptr) as long
declare function EGifPutExtensionNext(byval GifFile as GifFileType ptr, byval GifExtCode as long, byval GifExtLen as long, byval GifExtension as const any ptr) as long
declare function EGifPutExtensionLast(byval GifFile as GifFileType ptr, byval GifExtCode as long, byval GifExtLen as long, byval GifExtension as const any ptr) as long
declare function EGifPutExtension(byval GifFile as GifFileType ptr, byval GifExtCode as long, byval GifExtLen as long, byval GifExtension as const any ptr) as long
declare function EGifPutCode(byval GifFile as GifFileType ptr, byval GifCodeSize as long, byval GifCodeBlock as const GifByteType ptr) as long
declare function EGifPutCodeNext(byval GifFile as GifFileType ptr, byval GifCodeBlock as const GifByteType ptr) as long
declare function DGifOpenFileName(byval GifFileName as const zstring ptr) as GifFileType ptr
declare function DGifOpenFileHandle(byval GifFileHandle as long) as GifFileType ptr
declare function DGifSlurp(byval GifFile as GifFileType ptr) as long
declare function DGifOpen(byval userPtr as any ptr, byval readFunc as InputFunc) as GifFileType ptr
declare function DGifCloseFile(byval GifFile as GifFileType ptr) as long

const D_GIF_ERR_OPEN_FAILED = 101
const D_GIF_ERR_READ_FAILED = 102
const D_GIF_ERR_NOT_GIF_FILE = 103
const D_GIF_ERR_NO_SCRN_DSCR = 104
const D_GIF_ERR_NO_IMAG_DSCR = 105
const D_GIF_ERR_NO_COLOR_MAP = 106
const D_GIF_ERR_WRONG_RECORD = 107
const D_GIF_ERR_DATA_TOO_BIG = 108
const D_GIF_ERR_NOT_ENOUGH_MEM = 109
const D_GIF_ERR_CLOSE_FAILED = 110
const D_GIF_ERR_NOT_READABLE = 111
const D_GIF_ERR_IMAGE_DEFECT = 112
const D_GIF_ERR_EOF_TOO_SOON = 113

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
declare function GifError() as long
declare function GifErrorString() as zstring ptr
declare function GifLastError() as long
declare function MakeMapObject(byval ColorCount as long, byval ColorMap as const GifColorType ptr) as ColorMapObject ptr
declare sub FreeMapObject(byval Object as ColorMapObject ptr)
declare function UnionColorMap(byval ColorIn1 as const ColorMapObject ptr, byval ColorIn2 as const ColorMapObject ptr, byval ColorTransIn2 as GifPixelType ptr) as ColorMapObject ptr
declare function BitSize(byval n as long) as long

type ExtensionBlock
	ByteCount as long
	Bytes as zstring ptr
	Function as long
end type

type SavedImage_
	ImageDesc as GifImageDesc
	RasterBits as ubyte ptr
	Function as long
	ExtensionBlockCount as long
	ExtensionBlocks as ExtensionBlock ptr
end type

declare sub ApplyTranslation(byval Image as SavedImage ptr, byval Translation as GifPixelType ptr)
declare sub MakeExtension(byval New_ as SavedImage ptr, byval Function as long)
declare function AddExtensionBlock(byval New_ as SavedImage ptr, byval Len as long, byval ExtData as ubyte ptr) as long
declare sub FreeExtension(byval Image as SavedImage ptr)
declare function MakeSavedImage(byval GifFile as GifFileType ptr, byval CopyFrom as const SavedImage ptr) as SavedImage ptr
declare sub FreeSavedImages(byval GifFile as GifFileType ptr)
const GIF_FONT_WIDTH = 8
const GIF_FONT_HEIGHT = 8
extern AsciiTable(0 to 128 - 1, 0 to 7) as const ubyte

#ifdef __FB_WIN32__
	declare sub DrawGifText(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval legend as const zstring ptr, byval color as const long)
#else
	declare sub DrawText(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval legend as const zstring ptr, byval color as const long)
#endif

declare sub DrawBox(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval w as const long, byval d as const long, byval color as const long)
declare sub DrawRectangle(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval w as const long, byval d as const long, byval color as const long)
declare sub DrawBoxedText(byval Image as SavedImage ptr, byval x as const long, byval y as const long, byval legend as const zstring ptr, byval border as const long, byval bg as const long, byval fg as const long)
type VoidPtr as any ptr
type GifBooleanType as long

end extern
