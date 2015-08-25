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
#include once "wd_old.bi"

extern "C"

#define __WD_H
declare sub wdCanvasWindow(byval canvas as cdCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub wdCanvasGetWindow(byval canvas as cdCanvas ptr, byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr)
declare sub wdCanvasViewport(byval canvas as cdCanvas ptr, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub wdCanvasGetViewport(byval canvas as cdCanvas ptr, byval xmin as long ptr, byval xmax as long ptr, byval ymin as long ptr, byval ymax as long ptr)
declare sub wdCanvasWorld2Canvas(byval canvas as cdCanvas ptr, byval xw as double, byval yw as double, byval xv as long ptr, byval yv as long ptr)
declare sub wdCanvasWorld2CanvasSize(byval canvas as cdCanvas ptr, byval hw as double, byval vw as double, byval hv as long ptr, byval vv as long ptr)
declare sub wdCanvasCanvas2World(byval canvas as cdCanvas ptr, byval xv as long, byval yv as long, byval xw as double ptr, byval yw as double ptr)
declare sub wdCanvasSetTransform(byval canvas as cdCanvas ptr, byval sx as double, byval sy as double, byval tx as double, byval ty as double)
declare sub wdCanvasGetTransform(byval canvas as cdCanvas ptr, byval sx as double ptr, byval sy as double ptr, byval tx as double ptr, byval ty as double ptr)
declare sub wdCanvasTranslate(byval canvas as cdCanvas ptr, byval dtx as double, byval dty as double)
declare sub wdCanvasScale(byval canvas as cdCanvas ptr, byval dsx as double, byval dsy as double)
declare sub wdCanvasClipArea(byval canvas as cdCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare function wdCanvasGetClipArea(byval canvas as cdCanvas ptr, byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr) as long
declare function wdCanvasIsPointInRegion(byval canvas as cdCanvas ptr, byval x as double, byval y as double) as long
declare sub wdCanvasOffsetRegion(byval canvas as cdCanvas ptr, byval x as double, byval y as double)
declare sub wdCanvasGetRegionBox(byval canvas as cdCanvas ptr, byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr)
declare sub wdCanvasHardcopy(byval canvas as cdCanvas ptr, byval ctx as cdContext ptr, byval data as any ptr, byval draw_func as sub(byval canvas_copy as cdCanvas ptr))
declare sub wdCanvasPixel(byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval color as clong)
declare sub wdCanvasMark(byval canvas as cdCanvas ptr, byval x as double, byval y as double)
declare sub wdCanvasLine(byval canvas as cdCanvas ptr, byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double)
declare sub wdCanvasVertex(byval canvas as cdCanvas ptr, byval x as double, byval y as double)
declare sub wdCanvasRect(byval canvas as cdCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub wdCanvasBox(byval canvas as cdCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub wdCanvasArc(byval canvas as cdCanvas ptr, byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
declare sub wdCanvasSector(byval canvas as cdCanvas ptr, byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
declare sub wdCanvasChord(byval canvas as cdCanvas ptr, byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
declare sub wdCanvasText(byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval s as const zstring ptr)
declare sub wdCanvasPutImageRect(byval canvas as cdCanvas ptr, byval image as cdImage ptr, byval x as double, byval y as double, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub wdCanvasPutImageRectRGB(byval canvas as cdCanvas ptr, byval iw as long, byval ih as long, byval r as const ubyte ptr, byval g as const ubyte ptr, byval b as const ubyte ptr, byval x as double, byval y as double, byval w as double, byval h as double, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub wdCanvasPutImageRectRGBA(byval canvas as cdCanvas ptr, byval iw as long, byval ih as long, byval r as const ubyte ptr, byval g as const ubyte ptr, byval b as const ubyte ptr, byval a as const ubyte ptr, byval x as double, byval y as double, byval w as double, byval h as double, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub wdCanvasPutImageRectMap(byval canvas as cdCanvas ptr, byval iw as long, byval ih as long, byval index as const ubyte ptr, byval colors as const clong ptr, byval x as double, byval y as double, byval w as double, byval h as double, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub wdCanvasPutBitmap(byval canvas as cdCanvas ptr, byval bitmap as cdBitmap ptr, byval x as double, byval y as double, byval w as double, byval h as double)
declare function wdCanvasLineWidth(byval canvas as cdCanvas ptr, byval width as double) as double
declare function wdCanvasFont(byval canvas as cdCanvas ptr, byval type_face as const zstring ptr, byval style as long, byval size as double) as long
declare sub wdCanvasGetFont(byval canvas as cdCanvas ptr, byval type_face as zstring ptr, byval style as long ptr, byval size as double ptr)
declare function wdCanvasMarkSize(byval canvas as cdCanvas ptr, byval size as double) as double
declare sub wdCanvasGetFontDim(byval canvas as cdCanvas ptr, byval max_width as double ptr, byval height as double ptr, byval ascent as double ptr, byval descent as double ptr)
declare sub wdCanvasGetTextSize(byval canvas as cdCanvas ptr, byval s as const zstring ptr, byval width as double ptr, byval height as double ptr)
declare sub wdCanvasGetTextBox(byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval s as const zstring ptr, byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr)
declare sub wdCanvasGetTextBounds(byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval s as const zstring ptr, byval rect as double ptr)
declare sub wdCanvasStipple(byval canvas as cdCanvas ptr, byval w as long, byval h as long, byval fgbg as const ubyte ptr, byval w_mm as double, byval h_mm as double)
declare sub wdCanvasPattern(byval canvas as cdCanvas ptr, byval w as long, byval h as long, byval color as const clong ptr, byval w_mm as double, byval h_mm as double)
declare sub wdCanvasVectorTextDirection(byval canvas as cdCanvas ptr, byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double)
declare sub wdCanvasVectorTextSize(byval canvas as cdCanvas ptr, byval size_x as double, byval size_y as double, byval s as const zstring ptr)
declare sub wdCanvasGetVectorTextSize(byval canvas as cdCanvas ptr, byval s as const zstring ptr, byval x as double ptr, byval y as double ptr)
declare function wdCanvasVectorCharSize(byval canvas as cdCanvas ptr, byval size as double) as double
declare sub wdCanvasVectorText(byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval s as const zstring ptr)
declare sub wdCanvasMultiLineVectorText(byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval s as const zstring ptr)
declare sub wdCanvasGetVectorTextBounds(byval canvas as cdCanvas ptr, byval s as const zstring ptr, byval x as double, byval y as double, byval rect as double ptr)
declare sub wdCanvasGetVectorTextBox(byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval s as const zstring ptr, byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr)

end extern
