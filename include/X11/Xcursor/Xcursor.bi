''
''
'' Xcursor -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xcursor_bi__
#define __Xcursor_bi__

type XcursorBool as integer
type XcursorUInt as uinteger
type XcursorDim as XcursorUInt
type XcursorPixel as XcursorUInt

#define XcursorTrue 1
#define XcursorFalse 0
#define XCURSOR_MAGIC &h72756358
#define XCURSOR_LIB_MAJOR 1
#define XCURSOR_LIB_MINOR 1
#define XCURSOR_LIB_REVISION 9
#define XCURSOR_LIB_VERSION ((1*10000) +(1*100) +(9))
#define XCURSOR_FILE_MAJOR 1
#define XCURSOR_FILE_MINOR 0
#define XCURSOR_FILE_VERSION ((1 shl 16) or (0))
#define XCURSOR_FILE_HEADER_LEN (4*4)
#define XCURSOR_FILE_TOC_LEN (3*4)

type _XcursorFileToc
	type as XcursorUInt
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

#define XCURSOR_CHUNK_HEADER_LEN (4*4)

type _XcursorChunkHeader
	header as XcursorUInt
	type as XcursorUInt
	subtype as XcursorUInt
	version as XcursorUInt
end type

type XcursorChunkHeader as _XcursorChunkHeader

#define XCURSOR_COMMENT_TYPE &hfffe0001
#define XCURSOR_COMMENT_VERSION 1
#define XCURSOR_COMMENT_HEADER_LEN ((4*4) +(1*4))
#define XCURSOR_COMMENT_COPYRIGHT 1
#define XCURSOR_COMMENT_LICENSE 2
#define XCURSOR_COMMENT_OTHER 3
#define XCURSOR_COMMENT_MAX_LEN &h100000

type _XcursorComment
	version as XcursorUInt
	comment_type as XcursorUInt
	comment as zstring ptr
end type

type XcursorComment as _XcursorComment

#define XCURSOR_IMAGE_TYPE &hfffd0002
#define XCURSOR_IMAGE_VERSION 1
#define XCURSOR_IMAGE_HEADER_LEN ((4*4) +(5*4))
#define XCURSOR_IMAGE_MAX_SIZE &h7fff

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
	nimage as integer
	images as XcursorImage ptr ptr
	name as zstring ptr
end type

type XcursorImages as _XcursorImages

type _XcursorCursors
	dpy as Display ptr
	ref as integer
	ncursor as integer
	cursors as Cursor ptr
end type

type XcursorCursors as _XcursorCursors

type _XcursorAnimate
	cursors as XcursorCursors ptr
	sequence as integer
end type

type XcursorAnimate as _XcursorAnimate
type XcursorFile as _XcursorFile

type _XcursorFile
	closure as any ptr
	read as function cdecl(byval as XcursorFile ptr, byval as ubyte ptr, byval as integer) as integer
	write as function cdecl(byval as XcursorFile ptr, byval as ubyte ptr, byval as integer) as integer
	seek as function cdecl(byval as XcursorFile ptr, byval as integer, byval as integer) as integer
end type

type _XcursorComments
	ncomment as integer
	comments as XcursorComment ptr ptr
end type

type XcursorComments as _XcursorComments

#define XCURSOR_CORE_THEME "core"

declare sub XcursorImageDestroy cdecl alias "XcursorImageDestroy" (byval image as XcursorImage ptr)
declare function XcursorImagesCreate cdecl alias "XcursorImagesCreate" (byval size as integer) as XcursorImages ptr
declare sub XcursorImagesDestroy cdecl alias "XcursorImagesDestroy" (byval images as XcursorImages ptr)
declare sub XcursorImagesSetName cdecl alias "XcursorImagesSetName" (byval images as XcursorImages ptr, byval name as zstring ptr)
declare function XcursorCursorsCreate cdecl alias "XcursorCursorsCreate" (byval dpy as Display ptr, byval size as integer) as XcursorCursors ptr
declare sub XcursorCursorsDestroy cdecl alias "XcursorCursorsDestroy" (byval cursors as XcursorCursors ptr)
declare function XcursorAnimateCreate cdecl alias "XcursorAnimateCreate" (byval cursors as XcursorCursors ptr) as XcursorAnimate ptr
declare sub XcursorAnimateDestroy cdecl alias "XcursorAnimateDestroy" (byval animate as XcursorAnimate ptr)
declare function XcursorAnimateNext cdecl alias "XcursorAnimateNext" (byval animate as XcursorAnimate ptr) as Cursor
declare function XcursorCommentCreate cdecl alias "XcursorCommentCreate" (byval comment_type as XcursorUInt, byval length as integer) as XcursorComment ptr
declare sub XcursorCommentDestroy cdecl alias "XcursorCommentDestroy" (byval comment as XcursorComment ptr)
declare function XcursorCommentsCreate cdecl alias "XcursorCommentsCreate" (byval size as integer) as XcursorComments ptr
declare sub XcursorCommentsDestroy cdecl alias "XcursorCommentsDestroy" (byval comments as XcursorComments ptr)
declare function XcursorXcFileLoadImage cdecl alias "XcursorXcFileLoadImage" (byval file as XcursorFile ptr, byval size as integer) as XcursorImage ptr
declare function XcursorXcFileLoadImages cdecl alias "XcursorXcFileLoadImages" (byval file as XcursorFile ptr, byval size as integer) as XcursorImages ptr
declare function XcursorXcFileLoadAllImages cdecl alias "XcursorXcFileLoadAllImages" (byval file as XcursorFile ptr) as XcursorImages ptr
declare function XcursorXcFileLoad cdecl alias "XcursorXcFileLoad" (byval file as XcursorFile ptr, byval commentsp as XcursorComments ptr ptr, byval imagesp as XcursorImages ptr ptr) as XcursorBool
declare function XcursorXcFileSave cdecl alias "XcursorXcFileSave" (byval file as XcursorFile ptr, byval comments as XcursorComments ptr, byval images as XcursorImages ptr) as XcursorBool
declare function XcursorFileLoadImage cdecl alias "XcursorFileLoadImage" (byval file as FILE ptr, byval size as integer) as XcursorImage ptr
declare function XcursorFileLoadImages cdecl alias "XcursorFileLoadImages" (byval file as FILE ptr, byval size as integer) as XcursorImages ptr
declare function XcursorFileLoadAllImages cdecl alias "XcursorFileLoadAllImages" (byval file as FILE ptr) as XcursorImages ptr
declare function XcursorFileLoad cdecl alias "XcursorFileLoad" (byval file as FILE ptr, byval commentsp as XcursorComments ptr ptr, byval imagesp as XcursorImages ptr ptr) as XcursorBool
declare function XcursorFileSaveImages cdecl alias "XcursorFileSaveImages" (byval file as FILE ptr, byval images as XcursorImages ptr) as XcursorBool
declare function XcursorFileSave cdecl alias "XcursorFileSave" (byval file as FILE ptr, byval comments as XcursorComments ptr, byval images as XcursorImages ptr) as XcursorBool
declare function XcursorFilenameLoadImage cdecl alias "XcursorFilenameLoadImage" (byval filename as zstring ptr, byval size as integer) as XcursorImage ptr
declare function XcursorFilenameLoadImages cdecl alias "XcursorFilenameLoadImages" (byval filename as zstring ptr, byval size as integer) as XcursorImages ptr
declare function XcursorFilenameLoadAllImages cdecl alias "XcursorFilenameLoadAllImages" (byval filename as zstring ptr) as XcursorImages ptr
declare function XcursorFilenameLoad cdecl alias "XcursorFilenameLoad" (byval file as zstring ptr, byval commentsp as XcursorComments ptr ptr, byval imagesp as XcursorImages ptr ptr) as XcursorBool
declare function XcursorFilenameSaveImages cdecl alias "XcursorFilenameSaveImages" (byval filename as zstring ptr, byval images as XcursorImages ptr) as XcursorBool
declare function XcursorFilenameSave cdecl alias "XcursorFilenameSave" (byval file as zstring ptr, byval comments as XcursorComments ptr, byval images as XcursorImages ptr) as XcursorBool
declare function XcursorLibraryLoadImage cdecl alias "XcursorLibraryLoadImage" (byval library as zstring ptr, byval theme as zstring ptr, byval size as integer) as XcursorImage ptr
declare function XcursorLibraryLoadImages cdecl alias "XcursorLibraryLoadImages" (byval library as zstring ptr, byval theme as zstring ptr, byval size as integer) as XcursorImages ptr
declare function XcursorLibraryPath cdecl alias "XcursorLibraryPath" () as zstring ptr
declare function XcursorLibraryShape cdecl alias "XcursorLibraryShape" (byval library as zstring ptr) as integer
declare function XcursorImageLoadCursor cdecl alias "XcursorImageLoadCursor" (byval dpy as Display ptr, byval image as XcursorImage ptr) as Cursor
declare function XcursorImagesLoadCursors cdecl alias "XcursorImagesLoadCursors" (byval dpy as Display ptr, byval images as XcursorImages ptr) as XcursorCursors ptr
declare function XcursorImagesLoadCursor cdecl alias "XcursorImagesLoadCursor" (byval dpy as Display ptr, byval images as XcursorImages ptr) as Cursor
declare function XcursorFilenameLoadCursor cdecl alias "XcursorFilenameLoadCursor" (byval dpy as Display ptr, byval file as zstring ptr) as Cursor
declare function XcursorFilenameLoadCursors cdecl alias "XcursorFilenameLoadCursors" (byval dpy as Display ptr, byval file as zstring ptr) as XcursorCursors ptr
declare function XcursorLibraryLoadCursor cdecl alias "XcursorLibraryLoadCursor" (byval dpy as Display ptr, byval file as zstring ptr) as Cursor
declare function XcursorLibraryLoadCursors cdecl alias "XcursorLibraryLoadCursors" (byval dpy as Display ptr, byval file as zstring ptr) as XcursorCursors ptr
declare function XcursorShapeLoadImage cdecl alias "XcursorShapeLoadImage" (byval shape as uinteger, byval theme as zstring ptr, byval size as integer) as XcursorImage ptr
declare function XcursorShapeLoadImages cdecl alias "XcursorShapeLoadImages" (byval shape as uinteger, byval theme as zstring ptr, byval size as integer) as XcursorImages ptr
declare function XcursorShapeLoadCursor cdecl alias "XcursorShapeLoadCursor" (byval dpy as Display ptr, byval shape as uinteger) as Cursor
declare function XcursorShapeLoadCursors cdecl alias "XcursorShapeLoadCursors" (byval dpy as Display ptr, byval shape as uinteger) as XcursorCursors ptr
declare sub XcursorNoticeCreateBitmap cdecl alias "XcursorNoticeCreateBitmap" (byval dpy as Display ptr, byval pid as Pixmap, byval width as uinteger, byval height as uinteger)
declare sub XcursorNoticePutBitmap cdecl alias "XcursorNoticePutBitmap" (byval dpy as Display ptr, byval draw as Drawable, byval image as XImage ptr)
declare function XcursorTryShapeBitmapCursor cdecl alias "XcursorTryShapeBitmapCursor" (byval dpy as Display ptr, byval source as Pixmap, byval mask as Pixmap, byval foreground as XColor ptr, byval background as XColor ptr, byval x as uinteger, byval y as uinteger) as Cursor

#define XCURSOR_BITMAP_HASH_SIZE 16

declare sub XcursorImageHash cdecl alias "XcursorImageHash" (byval image as XImage ptr, byval hash as ubyte ptr)
declare function XcursorSupportsARGB cdecl alias "XcursorSupportsARGB" (byval dpy as Display ptr) as XcursorBool
declare function XcursorSupportsAnim cdecl alias "XcursorSupportsAnim" (byval dpy as Display ptr) as XcursorBool
declare function XcursorSetDefaultSize cdecl alias "XcursorSetDefaultSize" (byval dpy as Display ptr, byval size as integer) as XcursorBool
declare function XcursorGetDefaultSize cdecl alias "XcursorGetDefaultSize" (byval dpy as Display ptr) as integer
declare function XcursorSetTheme cdecl alias "XcursorSetTheme" (byval dpy as Display ptr, byval theme as zstring ptr) as XcursorBool
declare function XcursorGetTheme cdecl alias "XcursorGetTheme" (byval dpy as Display ptr) as zstring ptr
declare function XcursorGetThemeCore cdecl alias "XcursorGetThemeCore" (byval dpy as Display ptr) as XcursorBool
declare function XcursorSetThemeCore cdecl alias "XcursorSetThemeCore" (byval dpy as Display ptr, byval theme_core as XcursorBool) as XcursorBool

#endif
