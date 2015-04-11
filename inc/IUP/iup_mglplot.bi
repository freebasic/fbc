'' FreeBASIC binding for iup-3.13

#pragma once

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
