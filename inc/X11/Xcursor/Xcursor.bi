'' FreeBASIC binding for libXcursor-1.1.14
''
'' based on the C header files:
''   Copyright © 2002 Keith Packard
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation, and that the name of Keith Packard not be used in
''   advertising or publicity pertaining to distribution of the software without
''   specific, written prior permission.  Keith Packard makes no
''   representations about the suitability of this software for any purpose.  It
''   is provided "as is" without express or implied warranty.
''
''   KEITH PACKARD DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
''   INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
''   EVENT SHALL KEITH PACKARD BE LIABLE FOR ANY SPECIAL, INDIRECT OR
''   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
''   DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
''   TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
''   PERFORMANCE OF THIS SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "crt/stdio.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/Xlib.bi"

extern "C"

#define _XCURSOR_H_
type XcursorBool as long
type XcursorUInt as ulong
type XcursorDim as XcursorUInt
type XcursorPixel as XcursorUInt

const XcursorTrue = 1
const XcursorFalse = 0
const XCURSOR_MAGIC = &h72756358
const XCURSOR_LIB_MAJOR = 1
const XCURSOR_LIB_MINOR = 1
const XCURSOR_LIB_REVISION = 14
const XCURSOR_LIB_VERSION = ((XCURSOR_LIB_MAJOR * 10000) + (XCURSOR_LIB_MINOR * 100)) + XCURSOR_LIB_REVISION
const XCURSOR_FILE_MAJOR = 1
const XCURSOR_FILE_MINOR = 0
const XCURSOR_FILE_VERSION = (XCURSOR_FILE_MAJOR shl 16) or XCURSOR_FILE_MINOR
const XCURSOR_FILE_HEADER_LEN = 4 * 4
const XCURSOR_FILE_TOC_LEN = 3 * 4

type _XcursorFileToc
	as XcursorUInt type
	subtype as XcursorUInt
	position as XcursorUInt
end type

type XcursorFileToc as _XcursorFileToc

type _XcursorFileHeader
	magic as XcursorUInt
	header as XcursorUInt
	version as XcursorUInt
	ntoc as XcursorUInt
	tocs as XcursorFileToc ptr
end type

type XcursorFileHeader as _XcursorFileHeader
const XCURSOR_CHUNK_HEADER_LEN = 4 * 4

type _XcursorChunkHeader
	header as XcursorUInt
	as XcursorUInt type
	subtype as XcursorUInt
	version as XcursorUInt
end type

type XcursorChunkHeader as _XcursorChunkHeader
const XCURSOR_COMMENT_TYPE = &hfffe0001
const XCURSOR_COMMENT_VERSION = 1
const XCURSOR_COMMENT_HEADER_LEN = XCURSOR_CHUNK_HEADER_LEN + (1 * 4)
const XCURSOR_COMMENT_COPYRIGHT = 1
const XCURSOR_COMMENT_LICENSE = 2
const XCURSOR_COMMENT_OTHER = 3
const XCURSOR_COMMENT_MAX_LEN = &h100000

type _XcursorComment
	version as XcursorUInt
	comment_type as XcursorUInt
	comment as zstring ptr
end type

type XcursorComment as _XcursorComment
const XCURSOR_IMAGE_TYPE = &hfffd0002
const XCURSOR_IMAGE_VERSION = 1
const XCURSOR_IMAGE_HEADER_LEN = XCURSOR_CHUNK_HEADER_LEN + (5 * 4)
const XCURSOR_IMAGE_MAX_SIZE = &h7fff

type _XcursorImage
	version as XcursorUInt
	size as XcursorDim
	width as XcursorDim
	height as XcursorDim
	xhot as XcursorDim
	yhot as XcursorDim
	delay as XcursorUInt
	pixels as XcursorPixel ptr
end type

type XcursorImage as _XcursorImage

type _XcursorImages
	nimage as long
	images as XcursorImage ptr ptr
	name as zstring ptr
end type

type XcursorImages as _XcursorImages

type _XcursorCursors
	dpy as Display ptr
	ref as long
	ncursor as long
	cursors as Cursor ptr
end type

type XcursorCursors as _XcursorCursors

type _XcursorAnimate
	cursors as XcursorCursors ptr
	sequence as long
end type

type XcursorAnimate as _XcursorAnimate
type XcursorFile as _XcursorFile

type _XcursorFile
	closure as any ptr
	read as function(byval file as XcursorFile ptr, byval buf as ubyte ptr, byval len as long) as long
	write as function(byval file as XcursorFile ptr, byval buf as ubyte ptr, byval len as long) as long
	seek as function(byval file as XcursorFile ptr, byval offset as clong, byval whence as long) as long
end type

type _XcursorComments
	ncomment as long
	comments as XcursorComment ptr ptr
end type

type XcursorComments as _XcursorComments
#define XCURSOR_CORE_THEME "core"
declare function XcursorImageCreate(byval width as long, byval height as long) as XcursorImage ptr
declare sub XcursorImageDestroy(byval image as XcursorImage ptr)
declare function XcursorImagesCreate(byval size as long) as XcursorImages ptr
declare sub XcursorImagesDestroy(byval images as XcursorImages ptr)
declare sub XcursorImagesSetName(byval images as XcursorImages ptr, byval name as const zstring ptr)
declare function XcursorCursorsCreate(byval dpy as Display ptr, byval size as long) as XcursorCursors ptr
declare sub XcursorCursorsDestroy(byval cursors as XcursorCursors ptr)
declare function XcursorAnimateCreate(byval cursors as XcursorCursors ptr) as XcursorAnimate ptr
declare sub XcursorAnimateDestroy(byval animate as XcursorAnimate ptr)
declare function XcursorAnimateNext(byval animate as XcursorAnimate ptr) as Cursor
declare function XcursorCommentCreate(byval comment_type as XcursorUInt, byval length as long) as XcursorComment ptr
declare sub XcursorCommentDestroy(byval comment as XcursorComment ptr)
declare function XcursorCommentsCreate(byval size as long) as XcursorComments ptr
declare sub XcursorCommentsDestroy(byval comments as XcursorComments ptr)
declare function XcursorXcFileLoadImage(byval file as XcursorFile ptr, byval size as long) as XcursorImage ptr
declare function XcursorXcFileLoadImages(byval file as XcursorFile ptr, byval size as long) as XcursorImages ptr
declare function XcursorXcFileLoadAllImages(byval file as XcursorFile ptr) as XcursorImages ptr
declare function XcursorXcFileLoad(byval file as XcursorFile ptr, byval commentsp as XcursorComments ptr ptr, byval imagesp as XcursorImages ptr ptr) as XcursorBool
declare function XcursorXcFileSave(byval file as XcursorFile ptr, byval comments as const XcursorComments ptr, byval images as const XcursorImages ptr) as XcursorBool
declare function XcursorFileLoadImage(byval file as FILE ptr, byval size as long) as XcursorImage ptr
declare function XcursorFileLoadImages(byval file as FILE ptr, byval size as long) as XcursorImages ptr
declare function XcursorFileLoadAllImages(byval file as FILE ptr) as XcursorImages ptr
declare function XcursorFileLoad(byval file as FILE ptr, byval commentsp as XcursorComments ptr ptr, byval imagesp as XcursorImages ptr ptr) as XcursorBool
declare function XcursorFileSaveImages(byval file as FILE ptr, byval images as const XcursorImages ptr) as XcursorBool
declare function XcursorFileSave(byval file as FILE ptr, byval comments as const XcursorComments ptr, byval images as const XcursorImages ptr) as XcursorBool
declare function XcursorFilenameLoadImage(byval filename as const zstring ptr, byval size as long) as XcursorImage ptr
declare function XcursorFilenameLoadImages(byval filename as const zstring ptr, byval size as long) as XcursorImages ptr
declare function XcursorFilenameLoadAllImages(byval filename as const zstring ptr) as XcursorImages ptr
declare function XcursorFilenameLoad(byval file as const zstring ptr, byval commentsp as XcursorComments ptr ptr, byval imagesp as XcursorImages ptr ptr) as XcursorBool
declare function XcursorFilenameSaveImages(byval filename as const zstring ptr, byval images as const XcursorImages ptr) as XcursorBool
declare function XcursorFilenameSave(byval file as const zstring ptr, byval comments as const XcursorComments ptr, byval images as const XcursorImages ptr) as XcursorBool
declare function XcursorLibraryLoadImage(byval library as const zstring ptr, byval theme as const zstring ptr, byval size as long) as XcursorImage ptr
declare function XcursorLibraryLoadImages(byval library as const zstring ptr, byval theme as const zstring ptr, byval size as long) as XcursorImages ptr
declare function XcursorLibraryPath() as const zstring ptr
declare function XcursorLibraryShape(byval library as const zstring ptr) as long
declare function XcursorImageLoadCursor(byval dpy as Display ptr, byval image as const XcursorImage ptr) as Cursor
declare function XcursorImagesLoadCursors(byval dpy as Display ptr, byval images as const XcursorImages ptr) as XcursorCursors ptr
declare function XcursorImagesLoadCursor(byval dpy as Display ptr, byval images as const XcursorImages ptr) as Cursor
declare function XcursorFilenameLoadCursor(byval dpy as Display ptr, byval file as const zstring ptr) as Cursor
declare function XcursorFilenameLoadCursors(byval dpy as Display ptr, byval file as const zstring ptr) as XcursorCursors ptr
declare function XcursorLibraryLoadCursor(byval dpy as Display ptr, byval file as const zstring ptr) as Cursor
declare function XcursorLibraryLoadCursors(byval dpy as Display ptr, byval file as const zstring ptr) as XcursorCursors ptr
declare function XcursorShapeLoadImage(byval shape as ulong, byval theme as const zstring ptr, byval size as long) as XcursorImage ptr
declare function XcursorShapeLoadImages(byval shape as ulong, byval theme as const zstring ptr, byval size as long) as XcursorImages ptr
declare function XcursorShapeLoadCursor(byval dpy as Display ptr, byval shape as ulong) as Cursor
declare function XcursorShapeLoadCursors(byval dpy as Display ptr, byval shape as ulong) as XcursorCursors ptr
declare function XcursorTryShapeCursor(byval dpy as Display ptr, byval source_font as Font, byval mask_font as Font, byval source_char as ulong, byval mask_char as ulong, byval foreground as const XColor ptr, byval background as const XColor ptr) as Cursor
declare sub XcursorNoticeCreateBitmap(byval dpy as Display ptr, byval pid as Pixmap, byval width as ulong, byval height as ulong)
declare sub XcursorNoticePutBitmap(byval dpy as Display ptr, byval draw as Drawable, byval image as XImage ptr)
declare function XcursorTryShapeBitmapCursor(byval dpy as Display ptr, byval source as Pixmap, byval mask as Pixmap, byval foreground as XColor ptr, byval background as XColor ptr, byval x as ulong, byval y as ulong) as Cursor
const XCURSOR_BITMAP_HASH_SIZE = 16
declare sub XcursorImageHash(byval image as XImage ptr, byval hash as ubyte ptr)
declare function XcursorSupportsARGB(byval dpy as Display ptr) as XcursorBool
declare function XcursorSupportsAnim(byval dpy as Display ptr) as XcursorBool
declare function XcursorSetDefaultSize(byval dpy as Display ptr, byval size as long) as XcursorBool
declare function XcursorGetDefaultSize(byval dpy as Display ptr) as long
declare function XcursorSetTheme(byval dpy as Display ptr, byval theme as const zstring ptr) as XcursorBool
declare function XcursorGetTheme(byval dpy as Display ptr) as zstring ptr
declare function XcursorGetThemeCore(byval dpy as Display ptr) as XcursorBool
declare function XcursorSetThemeCore(byval dpy as Display ptr, byval theme_core as XcursorBool) as XcursorBool

end extern
