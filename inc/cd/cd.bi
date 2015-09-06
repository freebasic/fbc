'' FreeBASIC binding for cd-5.8.2
''
'' based on the C header files:
''   Copyright (C) 1994-2014 Tecgraf, PUC-Rio.
''
''   Permission is hereby granted, free of charge, to any person obtaining
''   a copy of this software and associated documentation files (the
''   "Software"), to deal in the Software without restriction, including
''   without limitation the rights to use, copy, modify, merge, publish,
''   distribute, sublicense, and/or sell copies of the Software, and to
''   permit persons to whom the Software is furnished to do so, subject to
''   the following conditions:
''
''   The above copyright notice and this permission notice shall be
''   included in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
''   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
''   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
''   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
''   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "cd"

#include once "crt/long.bi"

extern "C"

#define __CD_H
#define CD_NAME "CD - Canvas Draw"
#define CD_DESCRIPTION "A 2D Graphics Library"
#define CD_COPYRIGHT "Copyright (C) 1994-2014 Tecgraf, PUC-Rio."
#define CD_VERSION "5.8"
const CD_VERSION_NUMBER = 508000
#define CD_VERSION_DATE "2014/07/25"

type cdContext as _cdContext
type cdCanvas as _cdCanvas
type cdState as _cdCanvas
type cdImage as _cdImage

type _cdBitmap
	w as long
	h as long
	as long type
	data as any ptr
end type

type cdBitmap as _cdBitmap
declare function cdVersion() as zstring ptr
declare function cdVersionDate() as zstring ptr
declare function cdVersionNumber() as long
declare function cdCreateCanvas(byval context as cdContext ptr, byval data as any ptr) as cdCanvas ptr
declare function cdCreateCanvasf(byval context as cdContext ptr, byval format as const zstring ptr, ...) as cdCanvas ptr
declare sub cdKillCanvas(byval canvas as cdCanvas ptr)
declare function cdCanvasGetContext(byval canvas as cdCanvas ptr) as cdContext ptr
declare function cdCanvasActivate(byval canvas as cdCanvas ptr) as long
declare sub cdCanvasDeactivate(byval canvas as cdCanvas ptr)
declare function cdUseContextPlus(byval use as long) as long
declare sub cdInitContextPlus()
declare sub cdFinishContextPlus()
type cdCallback as function(byval canvas as cdCanvas ptr, ...) as long
declare function cdContextRegisterCallback(byval context as cdContext ptr, byval cb as long, byval func as cdCallback) as long
declare function cdContextCaps(byval context as cdContext ptr) as culong
declare function cdContextIsPlus(byval context as cdContext ptr) as long
declare function cdContextType(byval context as cdContext ptr) as long
declare function cdCanvasSimulate(byval canvas as cdCanvas ptr, byval mode as long) as long
declare sub cdCanvasFlush(byval canvas as cdCanvas ptr)
declare sub cdCanvasClear(byval canvas as cdCanvas ptr)
declare function cdCanvasSaveState(byval canvas as cdCanvas ptr) as cdState ptr
declare sub cdCanvasRestoreState(byval canvas as cdCanvas ptr, byval state as cdState ptr)
declare sub cdReleaseState(byval state as cdState ptr)
declare sub cdCanvasSetAttribute(byval canvas as cdCanvas ptr, byval name as const zstring ptr, byval data as zstring ptr)
declare sub cdCanvasSetfAttribute(byval canvas as cdCanvas ptr, byval name as const zstring ptr, byval format as const zstring ptr, ...)
declare function cdCanvasGetAttribute(byval canvas as cdCanvas ptr, byval name as const zstring ptr) as zstring ptr
declare function cdCanvasPlay(byval canvas as cdCanvas ptr, byval context as cdContext ptr, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long, byval data as any ptr) as long
declare sub cdCanvasGetSize(byval canvas as cdCanvas ptr, byval width as long ptr, byval height as long ptr, byval width_mm as double ptr, byval height_mm as double ptr)
declare function cdCanvasUpdateYAxis(byval canvas as cdCanvas ptr, byval y as long ptr) as long
declare function cdfCanvasUpdateYAxis(byval canvas as cdCanvas ptr, byval y as double ptr) as double
declare function cdCanvasInvertYAxis(byval canvas as cdCanvas ptr, byval y as long) as long
declare function cdfCanvasInvertYAxis(byval canvas as cdCanvas ptr, byval y as double) as double
declare sub cdCanvasMM2Pixel(byval canvas as cdCanvas ptr, byval mm_dx as double, byval mm_dy as double, byval dx as long ptr, byval dy as long ptr)
declare sub cdCanvasPixel2MM(byval canvas as cdCanvas ptr, byval dx as long, byval dy as long, byval mm_dx as double ptr, byval mm_dy as double ptr)
declare sub cdfCanvasMM2Pixel(byval canvas as cdCanvas ptr, byval mm_dx as double, byval mm_dy as double, byval dx as double ptr, byval dy as double ptr)
declare sub cdfCanvasPixel2MM(byval canvas as cdCanvas ptr, byval dx as double, byval dy as double, byval mm_dx as double ptr, byval mm_dy as double ptr)
declare sub cdCanvasOrigin(byval canvas as cdCanvas ptr, byval x as long, byval y as long)
declare sub cdfCanvasOrigin(byval canvas as cdCanvas ptr, byval x as double, byval y as double)
declare sub cdCanvasGetOrigin(byval canvas as cdCanvas ptr, byval x as long ptr, byval y as long ptr)
declare sub cdfCanvasGetOrigin(byval canvas as cdCanvas ptr, byval x as double ptr, byval y as double ptr)
declare sub cdCanvasTransform(byval canvas as cdCanvas ptr, byval matrix as const double ptr)
declare function cdCanvasGetTransform(byval canvas as cdCanvas ptr) as double ptr
declare sub cdCanvasTransformMultiply(byval canvas as cdCanvas ptr, byval matrix as const double ptr)
declare sub cdCanvasTransformRotate(byval canvas as cdCanvas ptr, byval angle as double)
declare sub cdCanvasTransformScale(byval canvas as cdCanvas ptr, byval sx as double, byval sy as double)
declare sub cdCanvasTransformTranslate(byval canvas as cdCanvas ptr, byval dx as double, byval dy as double)
declare sub cdCanvasTransformPoint(byval canvas as cdCanvas ptr, byval x as long, byval y as long, byval tx as long ptr, byval ty as long ptr)
declare sub cdfCanvasTransformPoint(byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval tx as double ptr, byval ty as double ptr)
declare function cdCanvasClip(byval canvas as cdCanvas ptr, byval mode as long) as long
declare sub cdCanvasClipArea(byval canvas as cdCanvas ptr, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare function cdCanvasGetClipArea(byval canvas as cdCanvas ptr, byval xmin as long ptr, byval xmax as long ptr, byval ymin as long ptr, byval ymax as long ptr) as long
declare sub cdfCanvasClipArea(byval canvas as cdCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare function cdfCanvasGetClipArea(byval canvas as cdCanvas ptr, byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr) as long
declare function cdCanvasIsPointInRegion(byval canvas as cdCanvas ptr, byval x as long, byval y as long) as long
declare sub cdCanvasOffsetRegion(byval canvas as cdCanvas ptr, byval x as long, byval y as long)
declare sub cdCanvasGetRegionBox(byval canvas as cdCanvas ptr, byval xmin as long ptr, byval xmax as long ptr, byval ymin as long ptr, byval ymax as long ptr)
declare function cdCanvasRegionCombineMode(byval canvas as cdCanvas ptr, byval mode as long) as long
declare sub cdCanvasPixel(byval canvas as cdCanvas ptr, byval x as long, byval y as long, byval color as clong)
declare sub cdCanvasMark(byval canvas as cdCanvas ptr, byval x as long, byval y as long)
declare sub cdCanvasBegin(byval canvas as cdCanvas ptr, byval mode as long)
declare sub cdCanvasPathSet(byval canvas as cdCanvas ptr, byval action as long)
declare sub cdCanvasEnd(byval canvas as cdCanvas ptr)
declare sub cdCanvasLine(byval canvas as cdCanvas ptr, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long)
declare sub cdCanvasVertex(byval canvas as cdCanvas ptr, byval x as long, byval y as long)
declare sub cdCanvasRect(byval canvas as cdCanvas ptr, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub cdCanvasBox(byval canvas as cdCanvas ptr, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub cdCanvasArc(byval canvas as cdCanvas ptr, byval xc as long, byval yc as long, byval w as long, byval h as long, byval angle1 as double, byval angle2 as double)
declare sub cdCanvasSector(byval canvas as cdCanvas ptr, byval xc as long, byval yc as long, byval w as long, byval h as long, byval angle1 as double, byval angle2 as double)
declare sub cdCanvasChord(byval canvas as cdCanvas ptr, byval xc as long, byval yc as long, byval w as long, byval h as long, byval angle1 as double, byval angle2 as double)
declare sub cdCanvasText(byval canvas as cdCanvas ptr, byval x as long, byval y as long, byval s as const zstring ptr)
declare sub cdfCanvasLine(byval canvas as cdCanvas ptr, byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double)
declare sub cdfCanvasVertex(byval canvas as cdCanvas ptr, byval x as double, byval y as double)
declare sub cdfCanvasRect(byval canvas as cdCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub cdfCanvasBox(byval canvas as cdCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub cdfCanvasArc(byval canvas as cdCanvas ptr, byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
declare sub cdfCanvasSector(byval canvas as cdCanvas ptr, byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
declare sub cdfCanvasChord(byval canvas as cdCanvas ptr, byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
declare sub cdfCanvasText(byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval s as const zstring ptr)
declare sub cdCanvasSetBackground(byval canvas as cdCanvas ptr, byval color as clong)
declare sub cdCanvasSetForeground(byval canvas as cdCanvas ptr, byval color as clong)
declare function cdCanvasBackground(byval canvas as cdCanvas ptr, byval color as clong) as clong
declare function cdCanvasForeground(byval canvas as cdCanvas ptr, byval color as clong) as clong
declare function cdCanvasBackOpacity(byval canvas as cdCanvas ptr, byval opacity as long) as long
declare function cdCanvasWriteMode(byval canvas as cdCanvas ptr, byval mode as long) as long
declare function cdCanvasLineStyle(byval canvas as cdCanvas ptr, byval style as long) as long
declare sub cdCanvasLineStyleDashes(byval canvas as cdCanvas ptr, byval dashes as const long ptr, byval count as long)
declare function cdCanvasLineWidth(byval canvas as cdCanvas ptr, byval width as long) as long
declare function cdCanvasLineJoin(byval canvas as cdCanvas ptr, byval join as long) as long
declare function cdCanvasLineCap(byval canvas as cdCanvas ptr, byval cap as long) as long
declare function cdCanvasInteriorStyle(byval canvas as cdCanvas ptr, byval style as long) as long
declare function cdCanvasHatch(byval canvas as cdCanvas ptr, byval style as long) as long
declare sub cdCanvasStipple(byval canvas as cdCanvas ptr, byval w as long, byval h as long, byval stipple as const ubyte ptr)
declare function cdCanvasGetStipple(byval canvas as cdCanvas ptr, byval n as long ptr, byval m as long ptr) as ubyte ptr
declare sub cdCanvasPattern(byval canvas as cdCanvas ptr, byval w as long, byval h as long, byval pattern as const clong ptr)
declare function cdCanvasGetPattern(byval canvas as cdCanvas ptr, byval n as long ptr, byval m as long ptr) as clong ptr
declare function cdCanvasFillMode(byval canvas as cdCanvas ptr, byval mode as long) as long
declare function cdCanvasFont(byval canvas as cdCanvas ptr, byval type_face as const zstring ptr, byval style as long, byval size as long) as long
declare sub cdCanvasGetFont(byval canvas as cdCanvas ptr, byval type_face as zstring ptr, byval style as long ptr, byval size as long ptr)
declare function cdCanvasNativeFont(byval canvas as cdCanvas ptr, byval font as const zstring ptr) as zstring ptr
declare function cdCanvasTextAlignment(byval canvas as cdCanvas ptr, byval alignment as long) as long
declare function cdCanvasTextOrientation(byval canvas as cdCanvas ptr, byval angle as double) as double
declare function cdCanvasMarkType(byval canvas as cdCanvas ptr, byval type as long) as long
declare function cdCanvasMarkSize(byval canvas as cdCanvas ptr, byval size as long) as long
declare sub cdCanvasVectorText(byval canvas as cdCanvas ptr, byval x as long, byval y as long, byval s as const zstring ptr)
declare sub cdCanvasMultiLineVectorText(byval canvas as cdCanvas ptr, byval x as long, byval y as long, byval s as const zstring ptr)
declare function cdCanvasVectorFont(byval canvas as cdCanvas ptr, byval filename as const zstring ptr) as zstring ptr
declare sub cdCanvasVectorTextDirection(byval canvas as cdCanvas ptr, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long)
declare function cdCanvasVectorTextTransform(byval canvas as cdCanvas ptr, byval matrix as const double ptr) as double ptr
declare sub cdCanvasVectorTextSize(byval canvas as cdCanvas ptr, byval size_x as long, byval size_y as long, byval s as const zstring ptr)
declare function cdCanvasVectorCharSize(byval canvas as cdCanvas ptr, byval size as long) as long
declare sub cdCanvasVectorFontSize(byval canvas as cdCanvas ptr, byval size_x as double, byval size_y as double)
declare sub cdCanvasGetVectorFontSize(byval canvas as cdCanvas ptr, byval size_x as double ptr, byval size_y as double ptr)
declare sub cdCanvasGetVectorTextSize(byval canvas as cdCanvas ptr, byval s as const zstring ptr, byval x as long ptr, byval y as long ptr)
declare sub cdCanvasGetVectorTextBounds(byval canvas as cdCanvas ptr, byval s as const zstring ptr, byval x as long, byval y as long, byval rect as long ptr)
declare sub cdCanvasGetVectorTextBox(byval canvas as cdCanvas ptr, byval x as long, byval y as long, byval s as const zstring ptr, byval xmin as long ptr, byval xmax as long ptr, byval ymin as long ptr, byval ymax as long ptr)
declare sub cdfCanvasVectorTextDirection(byval canvas as cdCanvas ptr, byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double)
declare sub cdfCanvasVectorTextSize(byval canvas as cdCanvas ptr, byval size_x as double, byval size_y as double, byval s as const zstring ptr)
declare sub cdfCanvasGetVectorTextSize(byval canvas as cdCanvas ptr, byval s as const zstring ptr, byval x as double ptr, byval y as double ptr)
declare function cdfCanvasVectorCharSize(byval canvas as cdCanvas ptr, byval size as double) as double
declare sub cdfCanvasVectorText(byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval s as const zstring ptr)
declare sub cdfCanvasMultiLineVectorText(byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval s as const zstring ptr)
declare sub cdfCanvasGetVectorTextBounds(byval canvas as cdCanvas ptr, byval s as const zstring ptr, byval x as double, byval y as double, byval rect as double ptr)
declare sub cdfCanvasGetVectorTextBox(byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval s as const zstring ptr, byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr)
declare sub cdCanvasGetFontDim(byval canvas as cdCanvas ptr, byval max_width as long ptr, byval height as long ptr, byval ascent as long ptr, byval descent as long ptr)
declare sub cdCanvasGetTextSize(byval canvas as cdCanvas ptr, byval s as const zstring ptr, byval width as long ptr, byval height as long ptr)
declare sub cdCanvasGetTextBox(byval canvas as cdCanvas ptr, byval x as long, byval y as long, byval s as const zstring ptr, byval xmin as long ptr, byval xmax as long ptr, byval ymin as long ptr, byval ymax as long ptr)
declare sub cdCanvasGetTextBounds(byval canvas as cdCanvas ptr, byval x as long, byval y as long, byval s as const zstring ptr, byval rect as long ptr)
declare function cdCanvasGetColorPlanes(byval canvas as cdCanvas ptr) as long
declare sub cdCanvasPalette(byval canvas as cdCanvas ptr, byval n as long, byval palette as const clong ptr, byval mode as long)
declare sub cdCanvasGetImageRGB(byval canvas as cdCanvas ptr, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval x as long, byval y as long, byval w as long, byval h as long)
declare sub cdCanvasPutImageRectRGB(byval canvas as cdCanvas ptr, byval iw as long, byval ih as long, byval r as const ubyte ptr, byval g as const ubyte ptr, byval b as const ubyte ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub cdCanvasPutImageRectRGBA(byval canvas as cdCanvas ptr, byval iw as long, byval ih as long, byval r as const ubyte ptr, byval g as const ubyte ptr, byval b as const ubyte ptr, byval a as const ubyte ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub cdCanvasPutImageRectMap(byval canvas as cdCanvas ptr, byval iw as long, byval ih as long, byval index as const ubyte ptr, byval colors as const clong ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare function cdCanvasCreateImage(byval canvas as cdCanvas ptr, byval w as long, byval h as long) as cdImage ptr
declare sub cdKillImage(byval image as cdImage ptr)
declare sub cdCanvasGetImage(byval canvas as cdCanvas ptr, byval image as cdImage ptr, byval x as long, byval y as long)
declare sub cdCanvasPutImageRect(byval canvas as cdCanvas ptr, byval image as cdImage ptr, byval x as long, byval y as long, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub cdCanvasScrollArea(byval canvas as cdCanvas ptr, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long, byval dx as long, byval dy as long)
declare function cdCreateBitmap(byval w as long, byval h as long, byval type as long) as cdBitmap ptr
declare function cdInitBitmap(byval w as long, byval h as long, byval type as long, ...) as cdBitmap ptr
declare sub cdKillBitmap(byval bitmap as cdBitmap ptr)
declare function cdBitmapGetData(byval bitmap as cdBitmap ptr, byval dataptr as long) as ubyte ptr
declare sub cdBitmapSetRect(byval bitmap as cdBitmap ptr, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub cdCanvasPutBitmap(byval canvas as cdCanvas ptr, byval bitmap as cdBitmap ptr, byval x as long, byval y as long, byval w as long, byval h as long)
declare sub cdCanvasGetBitmap(byval canvas as cdCanvas ptr, byval bitmap as cdBitmap ptr, byval x as long, byval y as long)
declare sub cdBitmapRGB2Map(byval bitmap_rgb as cdBitmap ptr, byval bitmap_map as cdBitmap ptr)
declare function cdEncodeColor(byval red as ubyte, byval green as ubyte, byval blue as ubyte) as clong
declare sub cdDecodeColor(byval color as clong, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr)
declare function cdDecodeAlpha(byval color as clong) as ubyte
declare function cdEncodeAlpha(byval color as clong, byval alpha as ubyte) as clong

#define cdAlpha(x) cubyte(not (((x) shr 24) and &hFF))
#define cdReserved(x) cubyte(((x) shr 24) and &hFF)
#define cdRed(x) cubyte(((x) shr 16) and &hFF)
#define cdGreen(x) cubyte(((x) shr 8) and &hFF)
#define cdBlue(x) cubyte(((x) shr 0) and &hFF)
declare sub cdRGB2Map(byval width as long, byval height as long, byval red as const ubyte ptr, byval green as const ubyte ptr, byval blue as const ubyte ptr, byval index as ubyte ptr, byval pal_size as long, byval color as clong ptr)
const CD_QUERY = -1

enum
	CD_RGB
	CD_MAP
	CD_RGBA = &h100
end enum

enum
	CD_IRED
	CD_IGREEN
	CD_IBLUE
	CD_IALPHA
	CD_INDEX
	CD_COLORS
end enum

enum
	CD_ERROR = -1
	CD_OK = 0
end enum

enum
	CD_CLIPOFF
	CD_CLIPAREA
	CD_CLIPPOLYGON
	CD_CLIPREGION
end enum

enum
	CD_UNION
	CD_INTERSECT
	CD_DIFFERENCE
	CD_NOTINTERSECT
end enum

enum
	CD_FILL
	CD_OPEN_LINES
	CD_CLOSED_LINES
	CD_CLIP
	CD_BEZIER
	CD_REGION
	CD_PATH
end enum

const CD_POLYCUSTOM = 10

enum
	CD_PATH_NEW
	CD_PATH_MOVETO
	CD_PATH_LINETO
	CD_PATH_ARC
	CD_PATH_CURVETO
	CD_PATH_CLOSE
	CD_PATH_FILL
	CD_PATH_STROKE
	CD_PATH_FILLSTROKE
	CD_PATH_CLIP
end enum

enum
	CD_EVENODD
	CD_WINDING
end enum

enum
	CD_MITER
	CD_BEVEL
	CD_ROUND
end enum

enum
	CD_CAPFLAT
	CD_CAPSQUARE
	CD_CAPROUND
end enum

enum
	CD_OPAQUE
	CD_TRANSPARENT
end enum

enum
	CD_REPLACE
	CD_XOR
	CD_NOT_XOR
end enum

enum
	CD_POLITE
	CD_FORCE
end enum

enum
	CD_CONTINUOUS
	CD_DASHED
	CD_DOTTED
	CD_DASH_DOT
	CD_DASH_DOT_DOT
	CD_CUSTOM
end enum

enum
	CD_PLUS
	CD_STAR
	CD_CIRCLE
	CD_X
	CD_BOX
	CD_DIAMOND
	CD_HOLLOW_CIRCLE
	CD_HOLLOW_BOX
	CD_HOLLOW_DIAMOND
end enum

enum
	CD_HORIZONTAL
	CD_VERTICAL
	CD_FDIAGONAL
	CD_BDIAGONAL
	CD_CROSS
	CD_DIAGCROSS
end enum

enum
	CD_SOLID
	CD_HATCH
	CD_STIPPLE
	CD_PATTERN
	CD_HOLLOW
end enum

enum
	CD_NORTH
	CD_SOUTH
	CD_EAST
	CD_WEST
	CD_NORTH_EAST
	CD_NORTH_WEST
	CD_SOUTH_EAST
	CD_SOUTH_WEST
	CD_CENTER
	CD_BASE_LEFT
	CD_BASE_CENTER
	CD_BASE_RIGHT
end enum

enum
	CD_PLAIN = 0
	CD_BOLD = 1
	CD_ITALIC = 2
	CD_UNDERLINE = 4
	CD_STRIKEOUT = 8
end enum

const CD_BOLD_ITALIC = CD_BOLD or CD_ITALIC

enum
	CD_SMALL = 8
	CD_STANDARD = 12
	CD_LARGE = 18
end enum

const CD_CAP_NONE = &h00000000
const CD_CAP_FLUSH = &h00000001
const CD_CAP_CLEAR = &h00000002
const CD_CAP_PLAY = &h00000004
const CD_CAP_YAXIS = &h00000008
const CD_CAP_CLIPAREA = &h00000010
const CD_CAP_CLIPPOLY = &h00000020
const CD_CAP_REGION = &h00000040
const CD_CAP_RECT = &h00000080
const CD_CAP_CHORD = &h00000100
const CD_CAP_IMAGERGB = &h00000200
const CD_CAP_IMAGERGBA = &h00000400
const CD_CAP_IMAGEMAP = &h00000800
const CD_CAP_GETIMAGERGB = &h00001000
const CD_CAP_IMAGESRV = &h00002000
const CD_CAP_BACKGROUND = &h00004000
const CD_CAP_BACKOPACITY = &h00008000
const CD_CAP_WRITEMODE = &h00010000
const CD_CAP_LINESTYLE = &h00020000
const CD_CAP_LINEWITH = &h00040000
const CD_CAP_FPRIMTIVES = &h00080000
const CD_CAP_HATCH = &h00100000
const CD_CAP_STIPPLE = &h00200000
const CD_CAP_PATTERN = &h00400000
const CD_CAP_FONT = &h00800000
const CD_CAP_FONTDIM = &h01000000
const CD_CAP_TEXTSIZE = &h02000000
const CD_CAP_TEXTORIENTATION = &h04000000
const CD_CAP_PALETTE = &h08000000
const CD_CAP_LINECAP = &h10000000
const CD_CAP_LINEJOIN = &h20000000
const CD_CAP_PATH = &h40000000
const CD_CAP_BEZIER = &h80000000
const CD_CAP_ALL = &hFFFFFFFF

enum
	CD_CTX_WINDOW
	CD_CTX_DEVICE
	CD_CTX_IMAGE
	CD_CTX_FILE
end enum

const CD_SIZECB = 0
type cdSizeCB as function(byval canvas as cdCanvas ptr, byval w as long, byval h as long, byval w_mm as double, byval h_mm as double) as long
const CD_ABORT = 1
const CD_CONTINUE = 0
const CD_SIM_NONE = &h0000
const CD_SIM_LINE = &h0001
const CD_SIM_RECT = &h0002
const CD_SIM_BOX = &h0004
const CD_SIM_ARC = &h0008
const CD_SIM_SECTOR = &h0010
const CD_SIM_CHORD = &h0020
const CD_SIM_POLYLINE = &h0040
const CD_SIM_POLYGON = &h0080
const CD_SIM_TEXT = &h0100
const CD_SIM_ALL = &hFFFF
const CD_SIM_LINES = ((CD_SIM_LINE or CD_SIM_RECT) or CD_SIM_ARC) or CD_SIM_POLYLINE
const CD_SIM_FILLS = ((CD_SIM_BOX or CD_SIM_SECTOR) or CD_SIM_CHORD) or CD_SIM_POLYGON
const CD_RED = cast(clong, &hFF0000)
const CD_DARK_RED = cast(clong, &h800000)
const CD_GREEN = cast(clong, &h00FF00)
const CD_DARK_GREEN = cast(clong, &h008000)
const CD_BLUE = cast(clong, &h0000FF)
const CD_DARK_BLUE = cast(clong, &h000080)
const CD_YELLOW = cast(clong, &hFFFF00)
const CD_DARK_YELLOW = cast(clong, &h808000)
const CD_MAGENTA = cast(clong, &hFF00FF)
const CD_DARK_MAGENTA = cast(clong, &h800080)
const CD_CYAN = cast(clong, &h00FFFF)
const CD_DARK_CYAN = cast(clong, &h008080)
const CD_WHITE = cast(clong, &hFFFFFF)
const CD_BLACK = cast(clong, &h000000)
const CD_DARK_GRAY = cast(clong, &h808080)
const CD_GRAY = cast(clong, &hC0C0C0)
const CD_MM2PT = 2.834645669
const CD_RAD2DEG = 57.295779513
const CD_DEG2RAD = 0.01745329252

enum
	CD_A0
	CD_A1
	CD_A2
	CD_A3
	CD_A4
	CD_A5
	CD_LETTER
	CD_LEGAL
end enum

end extern

#include once "cd_old.bi"
