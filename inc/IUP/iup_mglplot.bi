''
''
'' iup_mglplot -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iup_mglplot_bi__
#define __iup_mglplot_bi__

declare sub IupMglPlotOpen cdecl alias "IupMglPlotOpen" ()
declare function IupMglPlot cdecl alias "IupMglPlot" () as Ihandle ptr
declare sub IupMglPlotBegin cdecl alias "IupMglPlotBegin" (byval ih as Ihandle ptr, byval dim as integer)
declare sub IupMglPlotAdd1D cdecl alias "IupMglPlotAdd1D" (byval ih as Ihandle ptr, byval name as zstring ptr, byval y as single)
declare sub IupMglPlotAdd2D cdecl alias "IupMglPlotAdd2D" (byval ih as Ihandle ptr, byval x as single, byval y as single)
declare sub IupMglPlotAdd3D cdecl alias "IupMglPlotAdd3D" (byval ih as Ihandle ptr, byval x as single, byval y as single, byval z as single)
declare function IupMglPlotEnd cdecl alias "IupMglPlotEnd" (byval ih as Ihandle ptr) as integer
declare function IupMglPlotNewDataSet cdecl alias "IupMglPlotNewDataSet" (byval ih as Ihandle ptr, byval dim as integer) as integer
declare sub IupMglPlotInsert1D cdecl alias "IupMglPlotInsert1D" (byval ih as Ihandle ptr, byval ds_index as integer, byval sample_index as integer, byval names as byte ptr ptr, byval y as single ptr, byval count as integer)
declare sub IupMglPlotInsert2D cdecl alias "IupMglPlotInsert2D" (byval ih as Ihandle ptr, byval ds_index as integer, byval sample_index as integer, byval x as single ptr, byval y as single ptr, byval count as integer)
declare sub IupMglPlotInsert3D cdecl alias "IupMglPlotInsert3D" (byval ih as Ihandle ptr, byval ds_index as integer, byval sample_index as integer, byval x as single ptr, byval y as single ptr, byval z as single ptr, byval count as integer)
declare sub IupMglPlotSet1D cdecl alias "IupMglPlotSet1D" (byval ih as Ihandle ptr, byval ds_index as integer, byval names as byte ptr ptr, byval y as single ptr, byval count as integer)
declare sub IupMglPlotSet2D cdecl alias "IupMglPlotSet2D" (byval ih as Ihandle ptr, byval ds_index as integer, byval x as single ptr, byval y as single ptr, byval count as integer)
declare sub IupMglPlotSet3D cdecl alias "IupMglPlotSet3D" (byval ih as Ihandle ptr, byval ds_index as integer, byval x as single ptr, byval y as single ptr, byval z as single ptr, byval count as integer)
declare sub IupMglPlotSetFormula cdecl alias "IupMglPlotSetFormula" (byval ih as Ihandle ptr, byval ds_index as integer, byval formulaX as zstring ptr, byval formulaY as zstring ptr, byval formulaZ as zstring ptr, byval count as integer)
declare sub IupMglPlotSetData cdecl alias "IupMglPlotSetData" (byval ih as Ihandle ptr, byval ds_index as integer, byval data as single ptr, byval count_x as integer, byval count_y as integer, byval count_z as integer)
declare sub IupMglPlotLoadData cdecl alias "IupMglPlotLoadData" (byval ih as Ihandle ptr, byval ds_index as integer, byval filename as zstring ptr, byval count_x as integer, byval count_y as integer, byval count_z as integer)
declare sub IupMglPlotSetFromFormula cdecl alias "IupMglPlotSetFromFormula" (byval ih as Ihandle ptr, byval ds_index as integer, byval formula as zstring ptr, byval count_x as integer, byval count_y as integer, byval count_z as integer)
declare sub IupMglPlotTransform cdecl alias "IupMglPlotTransform" (byval ih as Ihandle ptr, byval x as single, byval y as single, byval z as single, byval ix as integer ptr, byval iy as integer ptr)
declare sub IupMglPlotTransformXYZ cdecl alias "IupMglPlotTransformXYZ" (byval ih as Ihandle ptr, byval ix as integer, byval iy as integer, byval x as single ptr, byval y as single ptr, byval z as single ptr)
declare sub IupMglPlotDrawMark cdecl alias "IupMglPlotDrawMark" (byval ih as Ihandle ptr, byval x as single, byval y as single, byval z as single)
declare sub IupMglPlotDrawLine cdecl alias "IupMglPlotDrawLine" (byval ih as Ihandle ptr, byval x1 as single, byval y1 as single, byval z1 as single, byval x2 as single, byval y2 as single, byval z2 as single)
declare sub IupMglPlotDrawText cdecl alias "IupMglPlotDrawText" (byval ih as Ihandle ptr, byval text as zstring ptr, byval x as single, byval y as single, byval z as single)
declare sub IupMglPlotPaintTo cdecl alias "IupMglPlotPaintTo" (byval ih as Ihandle ptr, byval format as zstring ptr, byval w as integer, byval h as integer, byval dpi as single, byval data as any ptr)

#endif
