'' FreeBASIC binding for iup-3.15
''
'' based on the C header files:
''   Copyright (C) 1994-2015 Tecgraf, PUC-Rio.
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

#inclib "iup_pplot"

extern "C"

#define __IUP_PPLOT_H
declare sub IupPPlotOpen()
declare function IupPPlot() as Ihandle ptr
declare sub IupPPlotBegin(byval ih as Ihandle ptr, byval strXdata as long)
declare sub IupPPlotAdd(byval ih as Ihandle ptr, byval x as single, byval y as single)
declare sub IupPPlotAddStr(byval ih as Ihandle ptr, byval x as const zstring ptr, byval y as single)
declare function IupPPlotEnd(byval ih as Ihandle ptr) as long
declare sub IupPPlotInsertStr(byval ih as Ihandle ptr, byval index as long, byval sample_index as long, byval x as const zstring ptr, byval y as single)
declare sub IupPPlotInsert(byval ih as Ihandle ptr, byval index as long, byval sample_index as long, byval x as single, byval y as single)
declare sub IupPPlotInsertStrPoints(byval ih as Ihandle ptr, byval index as long, byval sample_index as long, byval x as const zstring ptr ptr, byval y as single ptr, byval count as long)
declare sub IupPPlotInsertPoints(byval ih as Ihandle ptr, byval index as long, byval sample_index as long, byval x as single ptr, byval y as single ptr, byval count as long)
declare sub IupPPlotAddPoints(byval ih as Ihandle ptr, byval index as long, byval x as single ptr, byval y as single ptr, byval count as long)
declare sub IupPPlotAddStrPoints(byval ih as Ihandle ptr, byval index as long, byval x as const zstring ptr ptr, byval y as single ptr, byval count as long)
declare sub IupPPlotGetSample(byval ih as Ihandle ptr, byval index as long, byval sample_index as long, byval x as single ptr, byval y as single ptr)
declare sub IupPPlotGetSampleStr(byval ih as Ihandle ptr, byval index as long, byval sample_index as long, byval x as const zstring ptr ptr, byval y as single ptr)
declare sub IupPPlotTransform(byval ih as Ihandle ptr, byval x as single, byval y as single, byval ix as long ptr, byval iy as long ptr)
declare sub IupPPlotTransformTo(byval ih as Ihandle ptr, byval x as long, byval y as long, byval rx as single ptr, byval ry as single ptr)
declare sub IupPPlotPaintTo(byval ih as Ihandle ptr, byval cnv as any ptr)

end extern
