'' FreeBASIC binding for iup-3.11.2

#pragma once

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
