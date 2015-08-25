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

#inclib "iup_mglplot"

extern "C"

#define __IUP_MGLPLOT_H
declare sub IupMglPlotOpen()
declare function IupMglPlot() as Ihandle ptr
declare sub IupMglPlotBegin(byval ih as Ihandle ptr, byval dim as long)
declare sub IupMglPlotAdd1D(byval ih as Ihandle ptr, byval name as const zstring ptr, byval y as double)
declare sub IupMglPlotAdd2D(byval ih as Ihandle ptr, byval x as double, byval y as double)
declare sub IupMglPlotAdd3D(byval ih as Ihandle ptr, byval x as double, byval y as double, byval z as double)
declare function IupMglPlotEnd(byval ih as Ihandle ptr) as long
declare function IupMglPlotNewDataSet(byval ih as Ihandle ptr, byval dim as long) as long
declare sub IupMglPlotInsert1D(byval ih as Ihandle ptr, byval ds_index as long, byval sample_index as long, byval names as const zstring ptr ptr, byval y as const double ptr, byval count as long)
declare sub IupMglPlotInsert2D(byval ih as Ihandle ptr, byval ds_index as long, byval sample_index as long, byval x as const double ptr, byval y as const double ptr, byval count as long)
declare sub IupMglPlotInsert3D(byval ih as Ihandle ptr, byval ds_index as long, byval sample_index as long, byval x as const double ptr, byval y as const double ptr, byval z as const double ptr, byval count as long)
declare sub IupMglPlotSet1D(byval ih as Ihandle ptr, byval ds_index as long, byval names as const zstring ptr ptr, byval y as const double ptr, byval count as long)
declare sub IupMglPlotSet2D(byval ih as Ihandle ptr, byval ds_index as long, byval x as const double ptr, byval y as const double ptr, byval count as long)
declare sub IupMglPlotSet3D(byval ih as Ihandle ptr, byval ds_index as long, byval x as const double ptr, byval y as const double ptr, byval z as const double ptr, byval count as long)
declare sub IupMglPlotSetFormula(byval ih as Ihandle ptr, byval ds_index as long, byval formulaX as const zstring ptr, byval formulaY as const zstring ptr, byval formulaZ as const zstring ptr, byval count as long)
declare sub IupMglPlotSetData(byval ih as Ihandle ptr, byval ds_index as long, byval data as const double ptr, byval count_x as long, byval count_y as long, byval count_z as long)
declare sub IupMglPlotLoadData(byval ih as Ihandle ptr, byval ds_index as long, byval filename as const zstring ptr, byval count_x as long, byval count_y as long, byval count_z as long)
declare sub IupMglPlotSetFromFormula(byval ih as Ihandle ptr, byval ds_index as long, byval formula as const zstring ptr, byval count_x as long, byval count_y as long, byval count_z as long)
declare sub IupMglPlotTransform(byval ih as Ihandle ptr, byval x as double, byval y as double, byval z as double, byval ix as long ptr, byval iy as long ptr)
declare sub IupMglPlotTransformTo(byval ih as Ihandle ptr, byval ix as long, byval iy as long, byval x as double ptr, byval y as double ptr, byval z as double ptr)
declare sub IupMglPlotDrawMark(byval ih as Ihandle ptr, byval x as double, byval y as double, byval z as double)
declare sub IupMglPlotDrawLine(byval ih as Ihandle ptr, byval x1 as double, byval y1 as double, byval z1 as double, byval x2 as double, byval y2 as double, byval z2 as double)
declare sub IupMglPlotDrawText(byval ih as Ihandle ptr, byval text as const zstring ptr, byval x as double, byval y as double, byval z as double)
declare sub IupMglPlotPaintTo(byval ih as Ihandle ptr, byval format as const zstring ptr, byval w as long, byval h as long, byval dpi as double, byval data as any ptr)
declare function IupMglLabel(byval title as const zstring ptr) as Ihandle ptr

end extern
