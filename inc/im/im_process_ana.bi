''
''
'' im_process_ana -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_process_ana_bi__
#define __im_process_ana_bi__

declare function imCalcRMSError cdecl alias "imCalcRMSError" (byval image1 as imImage ptr, byval image2 as imImage ptr) as single
declare function imCalcSNR cdecl alias "imCalcSNR" (byval src_image as imImage ptr, byval noise_image as imImage ptr) as single
declare function imCalcCountColors cdecl alias "imCalcCountColors" (byval image as imImage ptr) as uinteger
declare sub imCalcGrayHistogram cdecl alias "imCalcGrayHistogram" (byval image as imImage ptr, byval histo as uinteger ptr, byval cumulative as integer)
declare sub imCalcHistogram cdecl alias "imCalcHistogram" (byval image as imImage ptr, byval histo as uinteger ptr, byval plane as integer, byval cumulative as integer)
declare sub imCalcByteHistogram cdecl alias "imCalcByteHistogram" (byval data as ubyte ptr, byval count as integer, byval histo as uinteger ptr, byval cumulative as integer)
declare sub imCalcUShortHistogram cdecl alias "imCalcUShortHistogram" (byval data as ushort ptr, byval count as integer, byval histo as uinteger ptr, byval cumulative as integer)
declare sub imCalcShortHistogram cdecl alias "imCalcShortHistogram" (byval data as short ptr, byval count as integer, byval histo as uinteger ptr, byval cumulative as integer)
declare function imHistogramNew cdecl alias "imHistogramNew" (byval data_type as integer, byval hcount as integer ptr) as uinteger ptr
declare sub imHistogramRelease cdecl alias "imHistogramRelease" (byval histo as uinteger ptr)
declare function imHistogramShift cdecl alias "imHistogramShift" (byval data_type as integer) as integer
declare function imHistogramCount cdecl alias "imHistogramCount" (byval data_type as integer) as integer

type _imStats
	max as single
	min as single
	positive as uinteger
	negative as uinteger
	zeros as uinteger
	mean as single
	stddev as single
end type

type imStats as _imStats

declare sub imCalcImageStatistics cdecl alias "imCalcImageStatistics" (byval image as imImage ptr, byval stats as imStats ptr)
declare sub imCalcHistogramStatistics cdecl alias "imCalcHistogramStatistics" (byval image as imImage ptr, byval stats as imStats ptr)
declare sub imCalcHistoImageStatistics cdecl alias "imCalcHistoImageStatistics" (byval image as imImage ptr, byval median as integer ptr, byval mode as integer ptr)
declare sub imCalcPercentMinMax cdecl alias "imCalcPercentMinMax" (byval image as imImage ptr, byval percent as single, byval ignore_zero as integer, byval min as integer ptr, byval max as integer ptr)
declare function imAnalyzeFindRegions cdecl alias "imAnalyzeFindRegions" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval connect as integer, byval touch_border as integer) as integer
declare sub imAnalyzeMeasureArea cdecl alias "imAnalyzeMeasureArea" (byval image as imImage ptr, byval area as integer ptr, byval region_count as integer)
declare sub imAnalyzeMeasurePerimArea cdecl alias "imAnalyzeMeasurePerimArea" (byval image as imImage ptr, byval perimarea as single ptr)
declare sub imAnalyzeMeasureCentroid cdecl alias "imAnalyzeMeasureCentroid" (byval image as imImage ptr, byval area as integer ptr, byval region_count as integer, byval cx as single ptr, byval cy as single ptr)
declare sub imAnalyzeMeasurePrincipalAxis cdecl alias "imAnalyzeMeasurePrincipalAxis" (byval image as imImage ptr, byval area as integer ptr, byval cx as single ptr, byval cy as single ptr, byval region_count as integer, byval major_slope as single ptr, byval major_length as single ptr, byval minor_slope as single ptr, byval minor_length as single ptr)
declare sub imAnalyzeMeasureHoles cdecl alias "imAnalyzeMeasureHoles" (byval image as imImage ptr, byval connect as integer, byval holes_count as integer ptr, byval area as integer ptr, byval perim as single ptr)
declare sub imAnalyzeMeasurePerimeter cdecl alias "imAnalyzeMeasurePerimeter" (byval image as imImage ptr, byval perim as single ptr, byval region_count as integer)
declare sub imProcessPerimeterLine cdecl alias "imProcessPerimeterLine" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessRemoveByArea cdecl alias "imProcessRemoveByArea" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval connect as integer, byval start_size as integer, byval end_size as integer, byval inside as integer)
declare sub imProcessFillHoles cdecl alias "imProcessFillHoles" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval connect as integer)

#endif
