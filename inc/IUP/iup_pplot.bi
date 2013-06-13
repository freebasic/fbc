''
''
'' iup_pplot -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iup_pplot_bi__
#define __iup_pplot_bi__

declare sub IupPPlotOpen cdecl alias "IupPPlotOpen" ()
declare function IupPPlot cdecl alias "IupPPlot" () as Ihandle ptr
declare sub IupPPlotBegin cdecl alias "IupPPlotBegin" (byval ih as Ihandle ptr, byval strXdata as integer)
declare sub IupPPlotAdd cdecl alias "IupPPlotAdd" (byval ih as Ihandle ptr, byval x as single, byval y as single)
declare sub IupPPlotAddStr cdecl alias "IupPPlotAddStr" (byval ih as Ihandle ptr, byval x as zstring ptr, byval y as single)
declare function IupPPlotEnd cdecl alias "IupPPlotEnd" (byval ih as Ihandle ptr) as integer
declare sub IupPPlotInsertStr cdecl alias "IupPPlotInsertStr" (byval ih as Ihandle ptr, byval index as integer, byval sample_index as integer, byval x as zstring ptr, byval y as single)
declare sub IupPPlotInsert cdecl alias "IupPPlotInsert" (byval ih as Ihandle ptr, byval index as integer, byval sample_index as integer, byval x as single, byval y as single)
declare sub IupPPlotInsertStrPoints cdecl alias "IupPPlotInsertStrPoints" (byval ih as Ihandle ptr, byval index as integer, byval sample_index as integer, byval x as byte ptr ptr, byval y as single ptr, byval count as integer)
declare sub IupPPlotInsertPoints cdecl alias "IupPPlotInsertPoints" (byval ih as Ihandle ptr, byval index as integer, byval sample_index as integer, byval x as single ptr, byval y as single ptr, byval count as integer)
declare sub IupPPlotAddPoints cdecl alias "IupPPlotAddPoints" (byval ih as Ihandle ptr, byval index as integer, byval x as single ptr, byval y as single ptr, byval count as integer)
declare sub IupPPlotAddStrPoints cdecl alias "IupPPlotAddStrPoints" (byval ih as Ihandle ptr, byval index as integer, byval x as byte ptr ptr, byval y as single ptr, byval count as integer)
declare sub IupPPlotTransform cdecl alias "IupPPlotTransform" (byval ih as Ihandle ptr, byval x as single, byval y as single, byval ix as integer ptr, byval iy as integer ptr)
declare sub IupPPlotPaintTo cdecl alias "IupPPlotPaintTo" (byval ih as Ihandle ptr, byval cnv as any ptr)

#endif
