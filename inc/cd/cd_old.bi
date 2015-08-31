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

#include once "crt/long.bi"

extern "C"

#define __CD_OLD_H
declare function cdActivate(byval canvas as cdCanvas ptr) as long
declare function cdActiveCanvas() as cdCanvas ptr
declare function cdSimulate(byval mode as long) as long
declare sub cdFlush()
declare sub cdClear()
declare function cdSaveState() as cdState ptr
declare sub cdRestoreState(byval state as cdState ptr)
declare sub cdSetAttribute(byval name as const zstring ptr, byval data as zstring ptr)
declare sub cdSetfAttribute(byval name as const zstring ptr, byval format as const zstring ptr, ...)
declare function cdGetAttribute(byval name as const zstring ptr) as zstring ptr
declare function cdGetContext(byval canvas as cdCanvas ptr) as cdContext ptr
declare function cdRegisterCallback(byval context as cdContext ptr, byval cb as long, byval func as cdCallback) as long
declare function cdPlay(byval context as cdContext ptr, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long, byval data as any ptr) as long
declare sub cdGetCanvasSize(byval width as long ptr, byval height as long ptr, byval width_mm as double ptr, byval height_mm as double ptr)
declare function cdUpdateYAxis(byval y as long ptr) as long
declare sub cdMM2Pixel(byval mm_dx as double, byval mm_dy as double, byval dx as long ptr, byval dy as long ptr)
declare sub cdPixel2MM(byval dx as long, byval dy as long, byval mm_dx as double ptr, byval mm_dy as double ptr)
declare sub cdOrigin(byval x as long, byval y as long)
declare function cdClip(byval mode as long) as long
declare function cdGetClipPoly(byval n as long ptr) as long ptr
declare sub cdClipArea(byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare function cdGetClipArea(byval xmin as long ptr, byval xmax as long ptr, byval ymin as long ptr, byval ymax as long ptr) as long
declare function cdPointInRegion(byval x as long, byval y as long) as long
declare sub cdOffsetRegion(byval x as long, byval y as long)
declare sub cdRegionBox(byval xmin as long ptr, byval xmax as long ptr, byval ymin as long ptr, byval ymax as long ptr)
declare function cdRegionCombineMode(byval mode as long) as long
declare sub cdPixel(byval x as long, byval y as long, byval color as clong)
declare sub cdMark(byval x as long, byval y as long)
declare sub cdLine(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long)
declare sub cdBegin(byval mode as long)
declare sub cdVertex(byval x as long, byval y as long)
declare sub cdEnd()
declare sub cdRect(byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub cdBox(byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub cdArc(byval xc as long, byval yc as long, byval w as long, byval h as long, byval angle1 as double, byval angle2 as double)
declare sub cdSector(byval xc as long, byval yc as long, byval w as long, byval h as long, byval angle1 as double, byval angle2 as double)
declare sub cdChord(byval xc as long, byval yc as long, byval w as long, byval h as long, byval angle1 as double, byval angle2 as double)
declare sub cdText(byval x as long, byval y as long, byval s as const zstring ptr)
declare function cdBackground(byval color as clong) as clong
declare function cdForeground(byval color as clong) as clong
declare function cdBackOpacity(byval opacity as long) as long
declare function cdWriteMode(byval mode as long) as long
declare function cdLineStyle(byval style as long) as long
declare sub cdLineStyleDashes(byval dashes as const long ptr, byval count as long)
declare function cdLineWidth(byval width as long) as long
declare function cdLineJoin(byval join as long) as long
declare function cdLineCap(byval cap as long) as long
declare function cdInteriorStyle(byval style as long) as long
declare function cdHatch(byval style as long) as long
declare sub cdStipple(byval w as long, byval h as long, byval stipple as const ubyte ptr)
declare function cdGetStipple(byval n as long ptr, byval m as long ptr) as ubyte ptr
declare sub cdPattern(byval w as long, byval h as long, byval pattern as const clong ptr)
declare function cdGetPattern(byval n as long ptr, byval m as long ptr) as clong ptr
declare function cdFillMode(byval mode as long) as long
declare sub cdFont(byval type_face as long, byval style as long, byval size as long)
declare sub cdGetFont(byval type_face as long ptr, byval style as long ptr, byval size as long ptr)
declare function cdNativeFont(byval font as const zstring ptr) as zstring ptr
declare function cdTextAlignment(byval alignment as long) as long
declare function cdTextOrientation(byval angle as double) as double
declare function cdMarkType(byval type as long) as long
declare function cdMarkSize(byval size as long) as long
declare sub cdVectorText(byval x as long, byval y as long, byval s as const zstring ptr)
declare sub cdMultiLineVectorText(byval x as long, byval y as long, byval s as const zstring ptr)
declare function cdVectorFont(byval filename as const zstring ptr) as zstring ptr
declare sub cdVectorTextDirection(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long)
declare function cdVectorTextTransform(byval matrix as const double ptr) as double ptr
declare sub cdVectorTextSize(byval size_x as long, byval size_y as long, byval s as const zstring ptr)
declare function cdVectorCharSize(byval size as long) as long
declare sub cdGetVectorTextSize(byval s as const zstring ptr, byval x as long ptr, byval y as long ptr)
declare sub cdGetVectorTextBounds(byval s as const zstring ptr, byval x as long, byval y as long, byval rect as long ptr)
declare sub cdFontDim(byval max_width as long ptr, byval height as long ptr, byval ascent as long ptr, byval descent as long ptr)
declare sub cdTextSize(byval s as const zstring ptr, byval width as long ptr, byval height as long ptr)
declare sub cdTextBox(byval x as long, byval y as long, byval s as const zstring ptr, byval xmin as long ptr, byval xmax as long ptr, byval ymin as long ptr, byval ymax as long ptr)
declare sub cdTextBounds(byval x as long, byval y as long, byval s as const zstring ptr, byval rect as long ptr)
declare function cdGetColorPlanes() as long
declare sub cdPalette(byval n as long, byval palette as const clong ptr, byval mode as long)
declare sub cdGetImageRGB(byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval x as long, byval y as long, byval w as long, byval h as long)
declare sub cdPutImageRectRGB(byval iw as long, byval ih as long, byval r as const ubyte ptr, byval g as const ubyte ptr, byval b as const ubyte ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub cdPutImageRectRGBA(byval iw as long, byval ih as long, byval r as const ubyte ptr, byval g as const ubyte ptr, byval b as const ubyte ptr, byval a as const ubyte ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub cdPutImageRectMap(byval iw as long, byval ih as long, byval index as const ubyte ptr, byval colors as const clong ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)

#define cdPutImageRGB(iw, ih, r, g, b, x, y, w, h) cdPutImageRectRGB((iw), (ih), (r), (g), (b), (x), (y), (w), (h), 0, 0, 0, 0)
#define cdPutImageRGBA(iw, ih, r, g, b, a, x, y, w, h) cdPutImageRectRGBA((iw), (ih), (r), (g), (b), (a), (x), (y), (w), (h), 0, 0, 0, 0)
#define cdPutImageMap(iw, ih, index, colors, x, y, w, h) cdPutImageRectMap((iw), (ih), (index), (colors), (x), (y), (w), (h), 0, 0, 0, 0)
#define cdPutImage(image, x, y) cdPutImageRect((image), (x), (y), 0, 0, 0, 0)

declare function cdCreateImage(byval w as long, byval h as long) as cdImage ptr
declare sub cdGetImage(byval image as cdImage ptr, byval x as long, byval y as long)
declare sub cdPutImageRect(byval image as cdImage ptr, byval x as long, byval y as long, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub cdScrollArea(byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long, byval dx as long, byval dy as long)
declare sub cdPutBitmap(byval bitmap as cdBitmap ptr, byval x as long, byval y as long, byval w as long, byval h as long)
declare sub cdGetBitmap(byval bitmap as cdBitmap ptr, byval x as long, byval y as long)

enum
	CD_SYSTEM
	CD_COURIER
	CD_TIMES_ROMAN
	CD_HELVETICA
	CD_NATIVE
end enum

const CD_CLIPON = CD_CLIPAREA
const CD_CENTER_BASE = CD_BASE_CENTER
const CD_LEFT_BASE = CD_BASE_LEFT
const CD_RIGHT_BASE = CD_BASE_RIGHT
const CD_ITALIC_BOLD = CD_BOLD_ITALIC
declare sub cdScrollImage alias "cdScrollArea"(byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long, byval dx as long, byval dy as long)
#define cdCanvas2Raster(x, y) scope : cdUpdateYAxis(y) : end scope

end extern
