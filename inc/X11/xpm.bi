'' FreeBASIC binding for libXpm-3.5.11
''
'' based on the C header files:
''   Copyright (C) 1989-95 GROUPE BULL
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to
''   deal in the Software without restriction, including without limitation the
''   rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
''   sell copies of the Software, and to permit persons to whom the Software is
''   furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
''   GROUPE BULL BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
''   AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of GROUPE BULL shall not be
''   used in advertising or otherwise to promote the sale, use or other dealings
''   in this Software without prior written authorization from GROUPE BULL.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Xlib.bi"
#include once "X11/Xutil.bi"

extern "C"

#define XPM_h
const XpmFormat = 3
const XpmVersion = 4
const XpmRevision = 11
const XpmIncludeVersion = (((XpmFormat * 100) + XpmVersion) * 100) + XpmRevision
const XpmColorError = 1
const XpmSuccess = 0
const XpmOpenFailed = -1
const XpmFileInvalid = -2
const XpmNoMemory = -3
const XpmColorFailed = -4

type XpmColorSymbol
	name as zstring ptr
	value as zstring ptr
	pixel as Pixel
end type

type XpmExtension
	name as zstring ptr
	nlines as ulong
	lines as zstring ptr ptr
end type

type XpmColor
	string as zstring ptr
	symbolic as zstring ptr
	m_color as zstring ptr
	g4_color as zstring ptr
	g_color as zstring ptr
	c_color as zstring ptr
end type

type XpmImage
	width as ulong
	height as ulong
	cpp as ulong
	ncolors as ulong
	colorTable as XpmColor ptr
	data as ulong ptr
end type

type XpmInfo
	valuemask as culong
	hints_cmt as zstring ptr
	colors_cmt as zstring ptr
	pixels_cmt as zstring ptr
	x_hotspot as ulong
	y_hotspot as ulong
	nextensions as ulong
	extensions as XpmExtension ptr
end type

type XpmAllocColorFunc as function(byval as Display ptr, byval as Colormap, byval as zstring ptr, byval as XColor ptr, byval as any ptr) as long
type XpmFreeColorsFunc as function(byval as Display ptr, byval as Colormap, byval as Pixel ptr, byval as long, byval as any ptr) as long

type XpmAttributes
	valuemask as culong
	visual as Visual ptr
	colormap as Colormap
	depth as ulong
	width as ulong
	height as ulong
	x_hotspot as ulong
	y_hotspot as ulong
	cpp as ulong
	pixels as Pixel ptr
	npixels as ulong
	colorsymbols as XpmColorSymbol ptr
	numsymbols as ulong
	rgb_fname as zstring ptr
	nextensions as ulong
	extensions as XpmExtension ptr
	ncolors as ulong
	colorTable as XpmColor ptr
	hints_cmt as zstring ptr
	colors_cmt as zstring ptr
	pixels_cmt as zstring ptr
	mask_pixel as ulong
	exactColors as long
	closeness as ulong
	red_closeness as ulong
	green_closeness as ulong
	blue_closeness as ulong
	color_key as long
	alloc_pixels as Pixel ptr
	nalloc_pixels as long
	alloc_close_colors as long
	bitmap_format as long
	alloc_color as XpmAllocColorFunc
	free_colors as XpmFreeColorsFunc
	color_closure as any ptr
end type

const XpmVisual = cast(clong, 1) shl 0
const XpmColormap = cast(clong, 1) shl 1
const XpmDepth = cast(clong, 1) shl 2
const XpmSize = cast(clong, 1) shl 3
const XpmHotspot = cast(clong, 1) shl 4
const XpmCharsPerPixel = cast(clong, 1) shl 5
const XpmColorSymbols = cast(clong, 1) shl 6
const XpmRgbFilename = cast(clong, 1) shl 7
const XpmInfos = cast(clong, 1) shl 8
const XpmReturnInfos = XpmInfos
const XpmReturnPixels = cast(clong, 1) shl 9
const XpmExtensions = cast(clong, 1) shl 10
const XpmReturnExtensions = XpmExtensions
const XpmExactColors = cast(clong, 1) shl 11
const XpmCloseness = cast(clong, 1) shl 12
const XpmRGBCloseness = cast(clong, 1) shl 13
const XpmColorKey = cast(clong, 1) shl 14
const XpmColorTable = cast(clong, 1) shl 15
const XpmReturnColorTable = XpmColorTable
const XpmReturnAllocPixels = cast(clong, 1) shl 16
const XpmAllocCloseColors = cast(clong, 1) shl 17
const XpmBitmapFormat = cast(clong, 1) shl 18
const XpmAllocColor = cast(clong, 1) shl 19
const XpmFreeColors = cast(clong, 1) shl 20
const XpmColorClosure = cast(clong, 1) shl 21
const XpmComments = XpmInfos
const XpmReturnComments = XpmComments
const XpmUndefPixel = &h80000000
const XPM_MONO = 2
const XPM_GREY4 = 3
const XPM_GRAY4 = 3
const XPM_GREY = 4
const XPM_GRAY = 4
const XPM_COLOR = 5

declare function XpmCreatePixmapFromData(byval display as Display ptr, byval d as Drawable, byval data as zstring ptr ptr, byval pixmap_return as Pixmap ptr, byval shapemask_return as Pixmap ptr, byval attributes as XpmAttributes ptr) as long
declare function XpmCreateDataFromPixmap(byval display as Display ptr, byval data_return as zstring ptr ptr ptr, byval pixmap as Pixmap, byval shapemask as Pixmap, byval attributes as XpmAttributes ptr) as long
declare function XpmReadFileToPixmap(byval display as Display ptr, byval d as Drawable, byval filename as const zstring ptr, byval pixmap_return as Pixmap ptr, byval shapemask_return as Pixmap ptr, byval attributes as XpmAttributes ptr) as long
declare function XpmWriteFileFromPixmap(byval display as Display ptr, byval filename as const zstring ptr, byval pixmap as Pixmap, byval shapemask as Pixmap, byval attributes as XpmAttributes ptr) as long
declare function XpmCreateImageFromData(byval display as Display ptr, byval data as zstring ptr ptr, byval image_return as XImage ptr ptr, byval shapemask_return as XImage ptr ptr, byval attributes as XpmAttributes ptr) as long
declare function XpmCreateDataFromImage(byval display as Display ptr, byval data_return as zstring ptr ptr ptr, byval image as XImage ptr, byval shapeimage as XImage ptr, byval attributes as XpmAttributes ptr) as long
declare function XpmReadFileToImage(byval display as Display ptr, byval filename as const zstring ptr, byval image_return as XImage ptr ptr, byval shapeimage_return as XImage ptr ptr, byval attributes as XpmAttributes ptr) as long
declare function XpmWriteFileFromImage(byval display as Display ptr, byval filename as const zstring ptr, byval image as XImage ptr, byval shapeimage as XImage ptr, byval attributes as XpmAttributes ptr) as long
declare function XpmCreateImageFromBuffer(byval display as Display ptr, byval buffer as zstring ptr, byval image_return as XImage ptr ptr, byval shapemask_return as XImage ptr ptr, byval attributes as XpmAttributes ptr) as long
declare function XpmCreatePixmapFromBuffer(byval display as Display ptr, byval d as Drawable, byval buffer as zstring ptr, byval pixmap_return as Pixmap ptr, byval shapemask_return as Pixmap ptr, byval attributes as XpmAttributes ptr) as long
declare function XpmCreateBufferFromImage(byval display as Display ptr, byval buffer_return as zstring ptr ptr, byval image as XImage ptr, byval shapeimage as XImage ptr, byval attributes as XpmAttributes ptr) as long
declare function XpmCreateBufferFromPixmap(byval display as Display ptr, byval buffer_return as zstring ptr ptr, byval pixmap as Pixmap, byval shapemask as Pixmap, byval attributes as XpmAttributes ptr) as long
declare function XpmReadFileToBuffer(byval filename as const zstring ptr, byval buffer_return as zstring ptr ptr) as long
declare function XpmWriteFileFromBuffer(byval filename as const zstring ptr, byval buffer as zstring ptr) as long
declare function XpmReadFileToData(byval filename as const zstring ptr, byval data_return as zstring ptr ptr ptr) as long
declare function XpmWriteFileFromData(byval filename as const zstring ptr, byval data as zstring ptr ptr) as long
declare function XpmAttributesSize() as long
declare sub XpmFreeAttributes(byval attributes as XpmAttributes ptr)
declare sub XpmFreeExtensions(byval extensions as XpmExtension ptr, byval nextensions as long)
declare sub XpmFreeXpmImage(byval image as XpmImage ptr)
declare sub XpmFreeXpmInfo(byval info as XpmInfo ptr)
declare function XpmGetErrorString(byval errcode as long) as zstring ptr
declare function XpmLibraryVersion() as long
declare function XpmReadFileToXpmImage(byval filename as const zstring ptr, byval image as XpmImage ptr, byval info as XpmInfo ptr) as long
declare function XpmWriteFileFromXpmImage(byval filename as const zstring ptr, byval image as XpmImage ptr, byval info as XpmInfo ptr) as long
declare function XpmCreatePixmapFromXpmImage(byval display as Display ptr, byval d as Drawable, byval image as XpmImage ptr, byval pixmap_return as Pixmap ptr, byval shapemask_return as Pixmap ptr, byval attributes as XpmAttributes ptr) as long
declare function XpmCreateImageFromXpmImage(byval display as Display ptr, byval image as XpmImage ptr, byval image_return as XImage ptr ptr, byval shapeimage_return as XImage ptr ptr, byval attributes as XpmAttributes ptr) as long
declare function XpmCreateXpmImageFromImage(byval display as Display ptr, byval image as XImage ptr, byval shapeimage as XImage ptr, byval xpmimage as XpmImage ptr, byval attributes as XpmAttributes ptr) as long
declare function XpmCreateXpmImageFromPixmap(byval display as Display ptr, byval pixmap as Pixmap, byval shapemask as Pixmap, byval xpmimage as XpmImage ptr, byval attributes as XpmAttributes ptr) as long
declare function XpmCreateDataFromXpmImage(byval data_return as zstring ptr ptr ptr, byval image as XpmImage ptr, byval info as XpmInfo ptr) as long
declare function XpmCreateXpmImageFromData(byval data as zstring ptr ptr, byval image as XpmImage ptr, byval info as XpmInfo ptr) as long
declare function XpmCreateXpmImageFromBuffer(byval buffer as zstring ptr, byval image as XpmImage ptr, byval info as XpmInfo ptr) as long
declare function XpmCreateBufferFromXpmImage(byval buffer_return as zstring ptr ptr, byval image as XpmImage ptr, byval info as XpmInfo ptr) as long
declare function XpmGetParseError(byval filename as zstring ptr, byval linenum_return as long ptr, byval charnum_return as long ptr) as long
declare sub XpmFree(byval ptr as any ptr)

const XpmPixmapColorError = XpmColorError
const XpmPixmapSuccess = XpmSuccess
const XpmPixmapOpenFailed = XpmOpenFailed
const XpmPixmapFileInvalid = XpmFileInvalid
const XpmPixmapNoMemory = XpmNoMemory
const XpmPixmapColorFailed = XpmColorFailed
#define XpmReadPixmapFile(dpy, d, file, pix, mask, att) XpmReadFileToPixmap(dpy, d, file, pix, mask, att)
#define XpmWritePixmapFile(dpy, file, pix, mask, att) XpmWriteFileFromPixmap(dpy, file, pix, mask, att)
const PixmapColorError = XpmColorError
const PixmapSuccess = XpmSuccess
const PixmapOpenFailed = XpmOpenFailed
const PixmapFileInvalid = XpmFileInvalid
const PixmapNoMemory = XpmNoMemory
const PixmapColorFailed = XpmColorFailed
type ColorSymbol as XpmColorSymbol
#define XReadPixmapFile(dpy, d, file, pix, mask, att) XpmReadFileToPixmap(dpy, d, file, pix, mask, att)
#define XWritePixmapFile(dpy, file, pix, mask, att) XpmWriteFileFromPixmap(dpy, file, pix, mask, att)
#define XCreatePixmapFromData(dpy, d, data, pix, mask, att) XpmCreatePixmapFromData(dpy, d, data, pix, mask, att)
#define XCreateDataFromPixmap(dpy, data, pix, mask, att) XpmCreateDataFromPixmap(dpy, data, pix, mask, att)

end extern
