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

#inclib "iup_plot"

extern "C"

#define __IUP_PLOT_H
declare sub IupPlotOpen()
declare function IupPlot() as Ihandle ptr
declare sub IupPlotBegin(byval ih as Ihandle ptr, byval strXdata as long)
declare sub IupPlotAdd(byval ih as Ihandle ptr, byval x as double, byval y as double)
declare sub IupPlotAddStr(byval ih as Ihandle ptr, byval x as const zstring ptr, byval y as double)
declare sub IupPlotAddSegment(byval ih as Ihandle ptr, byval x as double, byval y as double)
declare function IupPlotEnd(byval ih as Ihandle ptr) as long
declare function IupPlotLoadData(byval ih as Ihandle ptr, byval filename as const zstring ptr, byval strXdata as long) as long
declare function IupPlotSetFormula(byval ih as Ihandle ptr, byval sample_count as long, byval formula as const zstring ptr, byval init as const zstring ptr) as long
declare sub IupPlotInsert(byval ih as Ihandle ptr, byval ds_index as long, byval sample_index as long, byval x as double, byval y as double)
declare sub IupPlotInsertStr(byval ih as Ihandle ptr, byval ds_index as long, byval sample_index as long, byval x as const zstring ptr, byval y as double)
declare sub IupPlotInsertSegment(byval ih as Ihandle ptr, byval ds_index as long, byval sample_index as long, byval x as double, byval y as double)
declare sub IupPlotInsertStrSamples(byval ih as Ihandle ptr, byval ds_index as long, byval sample_index as long, byval x as const zstring ptr ptr, byval y as double ptr, byval count as long)
declare sub IupPlotInsertSamples(byval ih as Ihandle ptr, byval ds_index as long, byval sample_index as long, byval x as double ptr, byval y as double ptr, byval count as long)
declare sub IupPlotAddSamples(byval ih as Ihandle ptr, byval ds_index as long, byval x as double ptr, byval y as double ptr, byval count as long)
declare sub IupPlotAddStrSamples(byval ih as Ihandle ptr, byval ds_index as long, byval x as const zstring ptr ptr, byval y as double ptr, byval count as long)
declare sub IupPlotGetSample(byval ih as Ihandle ptr, byval ds_index as long, byval sample_index as long, byval x as double ptr, byval y as double ptr)
declare sub IupPlotGetSampleStr(byval ih as Ihandle ptr, byval ds_index as long, byval sample_index as long, byval x as const zstring ptr ptr, byval y as double ptr)
declare function IupPlotGetSampleSelection(byval ih as Ihandle ptr, byval ds_index as long, byval sample_index as long) as long
declare sub IupPlotSetSample(byval ih as Ihandle ptr, byval ds_index as long, byval sample_index as long, byval x as double, byval y as double)
declare sub IupPlotSetSampleStr(byval ih as Ihandle ptr, byval ds_index as long, byval sample_index as long, byval x as const zstring ptr, byval y as double)
declare sub IupPlotSetSampleSelection(byval ih as Ihandle ptr, byval ds_index as long, byval sample_index as long, byval selected as long)
declare sub IupPlotTransform(byval ih as Ihandle ptr, byval x as double, byval y as double, byval cnv_x as double ptr, byval cnv_y as double ptr)
declare sub IupPlotTransformTo(byval ih as Ihandle ptr, byval cnv_x as double, byval cnv_y as double, byval x as double ptr, byval y as double ptr)
declare function IupPlotFindSample(byval ih as Ihandle ptr, byval cnv_x as double, byval cnv_y as double, byval ds_index as long ptr, byval sample_index as long ptr) as long
type _cdCanvas as _cdCanvas_
declare sub IupPlotPaintTo(byval ih as Ihandle ptr, byval cnv as _cdCanvas ptr)

end extern
