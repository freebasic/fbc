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

#include once "im_image.bi"

extern "C"

#define __IM_PROCESS_LOC_H
declare function imProcessReduce(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval order as long) as long
declare function imProcessResize(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval order as long) as long
declare sub imProcessReduceBy4(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessCrop(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval xmin as long, byval ymin as long)
declare sub imProcessInsert(byval src_image as const imImage ptr, byval region_image as const imImage ptr, byval dst_image as imImage ptr, byval xmin as long, byval ymin as long)
declare sub imProcessAddMargins(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval xmin as long, byval ymin as long)
declare sub imProcessCalcRotateSize(byval width as long, byval height as long, byval new_width as long ptr, byval new_height as long ptr, byval cos0 as double, byval sin0 as double)
declare function imProcessRotate(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval cos0 as double, byval sin0 as double, byval order as long) as long
declare function imProcessRotateRef(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval cos0 as double, byval sin0 as double, byval x as long, byval y as long, byval to_origin as long, byval order as long) as long
declare sub imProcessRotate90(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval dir_clockwise as long)
declare sub imProcessRotate180(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessMirror(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessFlip(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare function imProcessRadial(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval k1 as single, byval order as long) as long
declare function imProcessSwirl(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval k1 as single, byval order as long) as long
declare sub imProcessInterlaceSplit(byval src_image as const imImage ptr, byval dst_image1 as imImage ptr, byval dst_image2 as imImage ptr)
declare function imProcessGrayMorphConvolve(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel as const imImage ptr, byval ismax as long) as long
declare function imProcessGrayMorphErode(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long) as long
declare function imProcessGrayMorphDilate(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long) as long
declare function imProcessGrayMorphOpen(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long) as long
declare function imProcessGrayMorphClose(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long) as long
declare function imProcessGrayMorphTopHat(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long) as long
declare function imProcessGrayMorphWell(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long) as long
declare function imProcessGrayMorphGradient(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long) as long
declare function imProcessBinMorphConvolve(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel as const imImage ptr, byval hit_white as long, byval iter as long) as long
declare function imProcessBinMorphErode(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long, byval iter as long) as long
declare function imProcessBinMorphDilate(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long, byval iter as long) as long
declare function imProcessBinMorphOpen(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long, byval iter as long) as long
declare function imProcessBinMorphClose(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long, byval iter as long) as long
declare function imProcessBinMorphOutline(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long, byval iter as long) as long
declare sub imProcessBinMorphThin(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare function imProcessMedianConvolve(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long) as long
declare function imProcessRangeConvolve(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long) as long
declare function imProcessRankClosestConvolve(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long) as long
declare function imProcessRankMaxConvolve(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long) as long
declare function imProcessRankMinConvolve(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long) as long
declare function imProcessRangeContrastThreshold(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long, byval min_range as long) as long
declare function imProcessLocalMaxThreshold(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long, byval min_level as long) as long
declare function imProcessConvolve(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel as const imImage ptr) as long
declare function imProcessConvolveSep(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel as const imImage ptr) as long
declare function imProcessConvolveDual(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel1 as const imImage ptr, byval kernel2 as const imImage ptr) as long
declare function imProcessConvolveRep(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel as const imImage ptr, byval count as long) as long
declare function imProcessCompassConvolve(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel as imImage ptr) as long
declare sub imProcessRotateKernel(byval kernel as imImage ptr)
declare function imProcessDiffOfGaussianConvolve(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval stddev1 as single, byval stddev2 as single) as long
declare function imProcessLapOfGaussianConvolve(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval stddev as single) as long
declare function imProcessMeanConvolve(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long) as long
declare function imProcessGaussianConvolve(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval stddev as single) as long
declare function imProcessBarlettConvolve(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval kernel_size as long) as long
declare function imProcessSobelConvolve(byval src_image as const imImage ptr, byval dst_image as imImage ptr) as long
declare function imProcessPrewittConvolve(byval src_image as const imImage ptr, byval dst_image as imImage ptr) as long
declare function imProcessSplineEdgeConvolve(byval src_image as const imImage ptr, byval dst_image as imImage ptr) as long
declare sub imProcessZeroCrossing(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessCanny(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval stddev as single)
declare function imGaussianStdDev2KernelSize(byval stddev as single) as long
declare function imGaussianKernelSize2StdDev(byval kernel_size as long) as single
declare function imProcessUnsharp(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval stddev as single, byval amount as single, byval threshold as single) as long
declare function imProcessSharp(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval amount as single, byval threshold as single) as long
declare function imProcessSharpKernel(byval src_image as const imImage ptr, byval kernel as const imImage ptr, byval dst_image as imImage ptr, byval amount as single, byval threshold as single) as long

end extern
