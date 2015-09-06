'' FreeBASIC binding for im-3.9.1
''
'' based on the C header files:
''   Copyright (C) 1994-2014 Tecgraf, PUC-Rio.                                
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

#include once "crt/long.bi"
#include once "im_image.bi"

extern "C"

#define __IM_PROC_ANA_H
declare function imCalcRMSError(byval image1 as const imImage ptr, byval image2 as const imImage ptr) as single
declare function imCalcSNR(byval src_image as const imImage ptr, byval noise_image as const imImage ptr) as single
declare function imCalcCountColors(byval image as const imImage ptr) as culong
declare sub imCalcGrayHistogram(byval image as const imImage ptr, byval histo as culong ptr, byval cumulative as long)
declare sub imCalcHistogram(byval image as const imImage ptr, byval histo as culong ptr, byval plane as long, byval cumulative as long)
declare sub imCalcByteHistogram(byval data as const ubyte ptr, byval count as long, byval histo as culong ptr, byval cumulative as long)
declare sub imCalcUShortHistogram(byval data as const ushort ptr, byval count as long, byval histo as culong ptr, byval cumulative as long)
declare sub imCalcShortHistogram(byval data as const short ptr, byval count as long, byval histo as culong ptr, byval cumulative as long)
declare function imHistogramNew(byval data_type as long, byval hcount as long ptr) as culong ptr
declare sub imHistogramRelease(byval histo as culong ptr)
declare function imHistogramShift(byval data_type as long) as long
declare function imHistogramCount(byval data_type as long) as long

type _imStats
	max as single
	min as single
	positive as culong
	negative as culong
	zeros as culong
	mean as single
	stddev as single
end type

type imStats as _imStats
declare sub imCalcImageStatistics(byval image as const imImage ptr, byval stats as imStats ptr)
declare sub imCalcHistogramStatistics(byval image as const imImage ptr, byval stats as imStats ptr)
declare sub imCalcHistoImageStatistics(byval image as const imImage ptr, byval median as long ptr, byval mode as long ptr)
declare sub imCalcPercentMinMax(byval image as const imImage ptr, byval percent as single, byval ignore_zero as long, byval min as long ptr, byval max as long ptr)
declare function imAnalyzeFindRegions(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval connect as long, byval touch_border as long) as long
declare sub imAnalyzeMeasureArea(byval image as const imImage ptr, byval area as long ptr, byval region_count as long)
declare sub imAnalyzeMeasurePerimArea(byval image as const imImage ptr, byval perimarea as single ptr)
declare sub imAnalyzeMeasureCentroid(byval image as const imImage ptr, byval area as const long ptr, byval region_count as long, byval cx as single ptr, byval cy as single ptr)
declare sub imAnalyzeMeasurePrincipalAxis(byval image as const imImage ptr, byval area as const long ptr, byval cx as const single ptr, byval cy as const single ptr, byval region_count as const long, byval major_slope as single ptr, byval major_length as single ptr, byval minor_slope as single ptr, byval minor_length as single ptr)
declare sub imAnalyzeMeasureHoles(byval image as const imImage ptr, byval connect as long, byval holes_count as long ptr, byval area as long ptr, byval perim as single ptr)
declare sub imAnalyzeMeasurePerimeter(byval image as const imImage ptr, byval perim as single ptr, byval region_count as long)
declare sub imProcessPerimeterLine(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessRemoveByArea(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval connect as long, byval start_size as long, byval end_size as long, byval inside as long)
declare sub imProcessFillHoles(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval connect as long)

end extern
