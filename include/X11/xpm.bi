''
''
'' xpm -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xpm_bi__
#define __xpm_bi__

#define XpmFormat 3
#define XpmVersion 4
#define XpmRevision 11
#define XpmIncludeVersion ((3*100+4)*100+11)

type Pixel as uinteger

#define XpmColorError 1
#define XpmSuccess 0
#define XpmOpenFailed -1
#define XpmFileInvalid -2
#define XpmNoMemory -3
#define XpmColorFailed -4

type XpmColorSymbol
	name as zstring ptr
	value as zstring ptr
	pixel as Pixel
end type

type XpmExtension
	name as zstring ptr
	nlines as uinteger
	lines as byte ptr ptr
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
	width as uinteger
	height as uinteger
	cpp as uinteger
	ncolors as uinteger
	colorTable as XpmColor ptr
	data as uinteger ptr
end type

type XpmInfo
	valuemask as uinteger
	hints_cmt as zstring ptr
	colors_cmt as zstring ptr
	pixels_cmt as zstring ptr
	x_hotspot as uinteger
	y_hotspot as uinteger
	nextensions as uinteger
	extensions as XpmExtension ptr
end type

type XpmAllocColorFunc as function cdecl(byval as Display ptr, byval as Colormap, byval as zstring ptr, byval as XColor ptr, byval as any ptr) as integer
type XpmFreeColorsFunc as function cdecl(byval as Display ptr, byval as Colormap, byval as Pixel ptr, byval as integer, byval as any ptr) as integer

type XpmAttributes
	valuemask as uinteger
	visual as Visual ptr
	colormap as Colormap
	depth as uinteger
	width as uinteger
	height as uinteger
	x_hotspot as uinteger
	y_hotspot as uinteger
	cpp as uinteger
	pixels as Pixel ptr
	npixels as uinteger
	colorsymbols as XpmColorSymbol ptr
	numsymbols as uinteger
	rgb_fname as zstring ptr
	nextensions as uinteger
	extensions as XpmExtension ptr
	ncolors as uinteger
	colorTable as XpmColor ptr
	hints_cmt as zstring ptr
	colors_cmt as zstring ptr
	pixels_cmt as zstring ptr
	mask_pixel as uinteger
	exactColors as Bool
	closeness as uinteger
	red_closeness as uinteger
	green_closeness as uinteger
	blue_closeness as uinteger
	color_key as integer
	alloc_pixels as Pixel ptr
	nalloc_pixels as integer
	alloc_close_colors as Bool
	bitmap_format as integer
	alloc_color as XpmAllocColorFunc
	free_colors as XpmFreeColorsFunc
	color_closure as any ptr
end type

#define XpmVisual (1L shl 0)
#define XpmColormap (1L shl 1)
#define XpmDepth (1L shl 2)
#define XpmSize (1L shl 3)
#define XpmHotspot (1L shl 4)
#define XpmCharsPerPixel (1L shl 5)
#define XpmColorSymbols (1L shl 6)
#define XpmRgbFilename (1L shl 7)
#define XpmInfos (1L shl 8)
#define XpmReturnInfos (1L shl 8)
#define XpmReturnPixels (1L shl 9)
#define XpmExtensions (1L shl 10)
#define XpmReturnExtensions (1L shl 10)
#define XpmExactColors (1L shl 11)
#define XpmCloseness (1L shl 12)
#define XpmRGBCloseness (1L shl 13)
#define XpmColorKey (1L shl 14)
#define XpmColorTable (1L shl 15)
#define XpmReturnColorTable (1L shl 15)
#define XpmReturnAllocPixels (1L shl 16)
#define XpmAllocCloseColors (1L shl 17)
#define XpmBitmapFormat (1L shl 18)
#define XpmAllocColor (1L shl 19)
#define XpmFreeColors (1L shl 20)
#define XpmColorClosure (1L shl 21)
#define XpmComments (1L shl 8)
#define XpmReturnComments (1L shl 8)
#define XpmUndefPixel &h80000000
#define XPM_MONO 2
#define XPM_GREY4 3
#define XPM_GRAY4 3
#define XPM_GREY 4
#define XPM_GRAY 4
#define XPM_COLOR 5

declare function XpmCreateDataFromPixmap cdecl alias "XpmCreateDataFromPixmap" (byval display as Display ptr, byval data_return as byte ptr ptr ptr, byval pixmap as Pixmap, byval shapemask as Pixmap, byval attributes as XpmAttributes ptr) as integer
declare function XpmReadFileToPixmap cdecl alias "XpmReadFileToPixmap" (byval display as Display ptr, byval d as Drawable, byval filename as zstring ptr, byval pixmap_return as Pixmap ptr, byval shapemask_return as Pixmap ptr, byval attributes as XpmAttributes ptr) as integer
declare function XpmWriteFileFromPixmap cdecl alias "XpmWriteFileFromPixmap" (byval display as Display ptr, byval filename as zstring ptr, byval pixmap as Pixmap, byval shapemask as Pixmap, byval attributes as XpmAttributes ptr) as integer
declare function XpmCreateImageFromData cdecl alias "XpmCreateImageFromData" (byval display as Display ptr, byval data as byte ptr ptr, byval image_return as XImage ptr ptr, byval shapemask_return as XImage ptr ptr, byval attributes as XpmAttributes ptr) as integer
declare function XpmCreateDataFromImage cdecl alias "XpmCreateDataFromImage" (byval display as Display ptr, byval data_return as byte ptr ptr ptr, byval image as XImage ptr, byval shapeimage as XImage ptr, byval attributes as XpmAttributes ptr) as integer
declare function XpmReadFileToImage cdecl alias "XpmReadFileToImage" (byval display as Display ptr, byval filename as zstring ptr, byval image_return as XImage ptr ptr, byval shapeimage_return as XImage ptr ptr, byval attributes as XpmAttributes ptr) as integer
declare function XpmWriteFileFromImage cdecl alias "XpmWriteFileFromImage" (byval display as Display ptr, byval filename as zstring ptr, byval image as XImage ptr, byval shapeimage as XImage ptr, byval attributes as XpmAttributes ptr) as integer
declare function XpmCreateImageFromBuffer cdecl alias "XpmCreateImageFromBuffer" (byval display as Display ptr, byval buffer as zstring ptr, byval image_return as XImage ptr ptr, byval shapemask_return as XImage ptr ptr, byval attributes as XpmAttributes ptr) as integer
declare function XpmCreatePixmapFromBuffer cdecl alias "XpmCreatePixmapFromBuffer" (byval display as Display ptr, byval d as Drawable, byval buffer as zstring ptr, byval pixmap_return as Pixmap ptr, byval shapemask_return as Pixmap ptr, byval attributes as XpmAttributes ptr) as integer
declare function XpmCreateBufferFromImage cdecl alias "XpmCreateBufferFromImage" (byval display as Display ptr, byval buffer_return as byte ptr ptr, byval image as XImage ptr, byval shapeimage as XImage ptr, byval attributes as XpmAttributes ptr) as integer
declare function XpmCreateBufferFromPixmap cdecl alias "XpmCreateBufferFromPixmap" (byval display as Display ptr, byval buffer_return as byte ptr ptr, byval pixmap as Pixmap, byval shapemask as Pixmap, byval attributes as XpmAttributes ptr) as integer
declare function XpmReadFileToBuffer cdecl alias "XpmReadFileToBuffer" (byval filename as zstring ptr, byval buffer_return as byte ptr ptr) as integer
declare function XpmWriteFileFromBuffer cdecl alias "XpmWriteFileFromBuffer" (byval filename as zstring ptr, byval buffer as zstring ptr) as integer
declare function XpmReadFileToData cdecl alias "XpmReadFileToData" (byval filename as zstring ptr, byval data_return as byte ptr ptr ptr) as integer
declare function XpmWriteFileFromData cdecl alias "XpmWriteFileFromData" (byval filename as zstring ptr, byval data as byte ptr ptr) as integer
declare function XpmAttributesSize cdecl alias "XpmAttributesSize" () as integer
declare sub XpmFreeAttributes cdecl alias "XpmFreeAttributes" (byval attributes as XpmAttributes ptr)
declare sub XpmFreeExtensions cdecl alias "XpmFreeExtensions" (byval extensions as XpmExtension ptr, byval nextensions as integer)
declare sub XpmFreeXpmImage cdecl alias "XpmFreeXpmImage" (byval image as XpmImage ptr)
declare sub XpmFreeXpmInfo cdecl alias "XpmFreeXpmInfo" (byval info as XpmInfo ptr)
declare function XpmGetErrorString cdecl alias "XpmGetErrorString" (byval errcode as integer) as zstring ptr
declare function XpmLibraryVersion cdecl alias "XpmLibraryVersion" () as integer
declare function XpmReadFileToXpmImage cdecl alias "XpmReadFileToXpmImage" (byval filename as zstring ptr, byval image as XpmImage ptr, byval info as XpmInfo ptr) as integer
declare function XpmWriteFileFromXpmImage cdecl alias "XpmWriteFileFromXpmImage" (byval filename as zstring ptr, byval image as XpmImage ptr, byval info as XpmInfo ptr) as integer
declare function XpmCreatePixmapFromXpmImage cdecl alias "XpmCreatePixmapFromXpmImage" (byval display as Display ptr, byval d as Drawable, byval image as XpmImage ptr, byval pixmap_return as Pixmap ptr, byval shapemask_return as Pixmap ptr, byval attributes as XpmAttributes ptr) as integer
declare function XpmCreateImageFromXpmImage cdecl alias "XpmCreateImageFromXpmImage" (byval display as Display ptr, byval image as XpmImage ptr, byval image_return as XImage ptr ptr, byval shapeimage_return as XImage ptr ptr, byval attributes as XpmAttributes ptr) as integer
declare function XpmCreateXpmImageFromImage cdecl alias "XpmCreateXpmImageFromImage" (byval display as Display ptr, byval image as XImage ptr, byval shapeimage as XImage ptr, byval xpmimage as XpmImage ptr, byval attributes as XpmAttributes ptr) as integer
declare function XpmCreateXpmImageFromPixmap cdecl alias "XpmCreateXpmImageFromPixmap" (byval display as Display ptr, byval pixmap as Pixmap, byval shapemask as Pixmap, byval xpmimage as XpmImage ptr, byval attributes as XpmAttributes ptr) as integer
declare function XpmCreateDataFromXpmImage cdecl alias "XpmCreateDataFromXpmImage" (byval data_return as byte ptr ptr ptr, byval image as XpmImage ptr, byval info as XpmInfo ptr) as integer
declare function XpmCreateXpmImageFromData cdecl alias "XpmCreateXpmImageFromData" (byval data as byte ptr ptr, byval image as XpmImage ptr, byval info as XpmInfo ptr) as integer
declare function XpmCreateXpmImageFromBuffer cdecl alias "XpmCreateXpmImageFromBuffer" (byval buffer as zstring ptr, byval image as XpmImage ptr, byval info as XpmInfo ptr) as integer
declare function XpmCreateBufferFromXpmImage cdecl alias "XpmCreateBufferFromXpmImage" (byval buffer_return as byte ptr ptr, byval image as XpmImage ptr, byval info as XpmInfo ptr) as integer
declare function XpmGetParseError cdecl alias "XpmGetParseError" (byval filename as zstring ptr, byval linenum_return as integer ptr, byval charnum_return as integer ptr) as integer
declare sub XpmFree cdecl alias "XpmFree" (byval ptr as any ptr)

#define XpmPixmapColorError 1
#define XpmPixmapSuccess 0
#define XpmPixmapOpenFailed -1
#define XpmPixmapFileInvalid -2
#define XpmPixmapNoMemory -3
#define XpmPixmapColorFailed -4
#define PixmapColorError 1
#define PixmapSuccess 0
#define PixmapOpenFailed -1
#define PixmapFileInvalid -2
#define PixmapNoMemory -3
#define PixmapColorFailed -4

#endif
