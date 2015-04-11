'' FreeBASIC binding for iup-3.13

#pragma once

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
