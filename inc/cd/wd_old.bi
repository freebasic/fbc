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

#define WD_OLD_H
declare sub wdWindow(byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub wdGetWindow(byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr)
declare sub wdViewport(byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub wdGetViewport(byval xmin as long ptr, byval xmax as long ptr, byval ymin as long ptr, byval ymax as long ptr)
declare sub wdWorld2Canvas(byval xw as double, byval yw as double, byval xv as long ptr, byval yv as long ptr)
declare sub wdWorld2CanvasSize(byval hw as double, byval vw as double, byval hv as long ptr, byval vv as long ptr)
declare sub wdCanvas2World(byval xv as long, byval yv as long, byval xw as double ptr, byval yw as double ptr)
declare sub wdClipArea(byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare function wdGetClipArea(byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr) as long
declare function wdGetClipPoly(byval n as long ptr) as double ptr
declare function wdPointInRegion(byval x as double, byval y as double) as long
declare sub wdOffsetRegion(byval x as double, byval y as double)
declare sub wdRegionBox(byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr)
declare sub wdHardcopy(byval ctx as cdContext ptr, byval data as any ptr, byval cnv as cdCanvas ptr, byval draw_func as sub())
declare sub wdPixel(byval x as double, byval y as double, byval color as clong)
declare sub wdMark(byval x as double, byval y as double)
declare sub wdLine(byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double)
declare sub wdVertex(byval x as double, byval y as double)
declare sub wdRect(byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub wdBox(byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub wdArc(byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
declare sub wdSector(byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
declare sub wdChord(byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
declare sub wdText(byval x as double, byval y as double, byval s as const zstring ptr)
declare sub wdPutImageRect(byval image as cdImage ptr, byval x as double, byval y as double, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub wdPutImageRectRGB(byval iw as long, byval ih as long, byval r as const ubyte ptr, byval g as const ubyte ptr, byval b as const ubyte ptr, byval x as double, byval y as double, byval w as double, byval h as double, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub wdPutImageRectRGBA(byval iw as long, byval ih as long, byval r as const ubyte ptr, byval g as const ubyte ptr, byval b as const ubyte ptr, byval a as const ubyte ptr, byval x as double, byval y as double, byval w as double, byval h as double, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub wdPutImageRectMap(byval iw as long, byval ih as long, byval index as const ubyte ptr, byval colors as const clong ptr, byval x as double, byval y as double, byval w as double, byval h as double, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub wdPutBitmap(byval bitmap as cdBitmap ptr, byval x as double, byval y as double, byval w as double, byval h as double)
declare function wdLineWidth(byval width as double) as double
declare sub wdFont(byval type_face as long, byval style as long, byval size as double)
declare sub wdGetFont(byval type_face as long ptr, byval style as long ptr, byval size as double ptr)
declare function wdMarkSize(byval size as double) as double
declare sub wdFontDim(byval max_width as double ptr, byval height as double ptr, byval ascent as double ptr, byval descent as double ptr)
declare sub wdTextSize(byval s as const zstring ptr, byval width as double ptr, byval height as double ptr)
declare sub wdTextBox(byval x as double, byval y as double, byval s as const zstring ptr, byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr)
declare sub wdTextBounds(byval x as double, byval y as double, byval s as const zstring ptr, byval rect as double ptr)
declare sub wdStipple(byval w as long, byval h as long, byval stipple as const ubyte ptr, byval w_mm as double, byval h_mm as double)
declare sub wdPattern(byval w as long, byval h as long, byval pattern as const clong ptr, byval w_mm as double, byval h_mm as double)
declare sub wdVectorTextDirection(byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double)
declare sub wdVectorTextSize(byval size_x as double, byval size_y as double, byval s as const zstring ptr)
declare sub wdGetVectorTextSize(byval s as const zstring ptr, byval x as double ptr, byval y as double ptr)
declare function wdVectorCharSize(byval size as double) as double
declare sub wdVectorText(byval x as double, byval y as double, byval s as const zstring ptr)
declare sub wdMultiLineVectorText(byval x as double, byval y as double, byval s as const zstring ptr)
declare sub wdGetVectorTextBounds(byval s as const zstring ptr, byval x as double, byval y as double, byval rect as double ptr)
type wdVectorFont as cdVectorFont
declare function wdVectorTextTransform alias "cdVectorTextTransform"(byval matrix as const double ptr) as double ptr
declare function wdActivate alias "cdActivate"(byval canvas as cdCanvas ptr) as long

#define wdClip(mode) cdClip(mode)
#define wdBegin(mode) cdBegin(mode)
#define wdEnd() cdEnd()
#define wdMM2Pixel(mm_dx, mm_dy, dx, dy) cdMM2Pixel(mm_dx, mm_dy, dx, dy)
#define wdPixel2MM(dx, dy, mm_dx, mm_dy) cdPixel2MM(dx, dy, mm_dx, mm_dy)

end extern
