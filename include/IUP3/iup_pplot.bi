/'** \file
 * \brief PPlot component for Iup.
 *
 * See Copyright Notice in "iup.bi"
 *'/
#ifndef __iup_pplot_bi__
#define __iup_pplot_bi__

extern "C"

'/* Initialize PPlot widget class */
declare sub IupPPlotOpen ()

'/* Create an PPlot widget instance */
declare function IupPPlot () as Ihandle ptr

#ifndef IUP_PLOT_API
#define IUP_PLOT_API

declare sub IupPlotBegin (byval ih as Ihandle ptr, byval strXdata as integer)
declare sub IupPlotAdd (byval ih as Ihandle ptr, byval x as single, byval y as single)
declare sub IupPlotAddStr (byval ih as Ihandle ptr, byval x as zstring ptr, byval y as single)
declare function IupPlotEnd (byval ih as Ihandle ptr) as integer
declare sub IupPlotInsertStr (byval ih as Ihandle ptr, byval index as integer, byval sample_index as integer, byval x as zstring ptr, byval y as single)
declare sub IupPlotInsert (byval ih as Ihandle ptr, byval index as integer, byval sample_index as integer, byval x as single, byval y as single)
declare sub IupPlotInsertStrPoints (byval ih as Ihandle ptr, byval index as integer, byval sample_index as integer, byval x as byte ptr ptr, byval y as single ptr, byval count as integer)
declare sub IupPlotInsertPoints (byval ih as Ihandle ptr, byval index as integer, byval sample_index as integer, byval x as single ptr, byval y as single ptr, byval count as integer)
declare sub IupPlotAddPoints (byval ih as Ihandle ptr, byval index as integer, byval x as single ptr, byval y as single ptr, byval count as integer)
declare sub IupPlotAddStrPoints (byval ih as Ihandle ptr, byval index as integer, byval x as byte ptr ptr, byval y as single ptr, byval count as integer)
declare sub IupPlotTransform (byval ih as Ihandle ptr, byval x as single, byval y as single, byval ix as integer ptr, byval iy as integer ptr)
declare sub IupPlotPaintTo (byval ih as Ihandle ptr, byval cnv as any ptr)

#endif

'/***********************************************/
'/*              Deprecated                    */
declare sub IupPPlotBegin (byval ih as Ihandle ptr, byval strXdata as integer)
declare sub IupPPlotAdd (byval ih as Ihandle ptr, byval x as single, byval y as single)
declare sub IupPPlotAddStr (byval ih as Ihandle ptr, byval x as zstring ptr, byval y as single)
declare function IupPPlotEnd (byval ih as Ihandle ptr) as integer
declare sub IupPPlotInsertStr (byval ih as Ihandle ptr, byval index as integer, byval sample_index as integer, byval x as zstring ptr, byval y as single)
declare sub IupPPlotInsert (byval ih as Ihandle ptr, byval index as integer, byval sample_index as integer, byval x as single, byval y as single)
declare sub IupPPlotInsertStrPoints (byval ih as Ihandle ptr, byval index as integer, byval sample_index as integer, byval x as byte ptr ptr, byval y as single ptr, byval count as integer)
declare sub IupPPlotInsertPoints (byval ih as Ihandle ptr, byval index as integer, byval sample_index as integer, byval x as single ptr, byval y as single ptr, byval count as integer)
declare sub IupPPlotAddPoints (byval ih as Ihandle ptr, byval index as integer, byval x as single ptr, byval y as single ptr, byval count as integer)
declare sub IupPPlotAddStrPoints (byval ih as Ihandle ptr, byval index as integer, byval x as byte ptr ptr, byval y as single ptr, byval count as integer)
declare sub IupPPlotTransform (byval ih as Ihandle ptr, byval x as single, byval y as single, byval ix as integer ptr, byval iy as integer ptr)
declare sub IupPPlotPaintTo (byval ih as Ihandle ptr, byval cnv as any ptr)
'/***********************************************/

end extern

#endif
