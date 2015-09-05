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

#define __IM_PROCESS_GLO_H
declare function imProcessHoughLines(byval src_image as const imImage ptr, byval dst_image as imImage ptr) as long
declare function imProcessHoughLinesDraw(byval src_image as const imImage ptr, byval hough as const imImage ptr, byval hough_points as const imImage ptr, byval dst_image as imImage ptr) as long
declare sub imProcessCrossCorrelation(byval src_image1 as const imImage ptr, byval src_image2 as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessAutoCorrelation(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessDistanceTransform(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessRegionalMaximum(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessFFT(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessIFFT(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessFFTraw(byval image as imImage ptr, byval inverse as long, byval center as long, byval normalize as long)
declare sub imProcessSwapQuadrants(byval image as imImage ptr, byval center2origin as long)
declare function imProcessOpenMPSetMinCount(byval min_count as long) as long
declare function imProcessOpenMPSetNumThreads(byval count as long) as long

end extern
