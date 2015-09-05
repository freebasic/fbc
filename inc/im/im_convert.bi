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

#define __IM_CONVERT_H

type imComplex2Real as long
enum
	IM_CPX_REAL
	IM_CPX_IMAG
	IM_CPX_MAG
	IM_CPX_PHASE
end enum

type imGammaFactor as long
enum
	IM_GAMMA_LINEAR = 0
	IM_GAMMA_LOGLITE = -10
	IM_GAMMA_LOGHEAVY = -1000
	IM_GAMMA_EXPLITE = 2
	IM_GAMMA_EXPHEAVY = 7
end enum

type imCastMode as long
enum
	IM_CAST_MINMAX
	IM_CAST_FIXED
	IM_CAST_DIRECT
	IM_CAST_USER
end enum

declare function imConvertDataType(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval cpx2real as long, byval gamma as single, byval abssolute as long, byval cast_mode as long) as long
declare function imConvertColorSpace(byval src_image as const imImage ptr, byval dst_image as imImage ptr) as long
declare function imConvertToBitmap(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval cpx2real as long, byval gamma as single, byval abssolute as long, byval cast_mode as long) as long
declare function imImageGetOpenGLData(byval image as const imImage ptr, byval glformat as long ptr) as any ptr
declare function imImageCreateFromOpenGLData(byval width as long, byval height as long, byval glformat as long, byval gldata as const any ptr) as imImage ptr
declare sub imConvertPacking(byval src_data as const any ptr, byval dst_data as any ptr, byval width as long, byval height as long, byval src_depth as long, byval dst_depth as long, byval data_type as long, byval src_is_packed as long)
declare sub imConvertMapToRGB(byval data as ubyte ptr, byval count as long, byval depth as long, byval packed as long, byval palette as clong ptr, byval palette_count as long)
declare function imConvertRGB2Map(byval width as long, byval height as long, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval map as ubyte ptr, byval palette as clong ptr, byval palette_count as long ptr) as long

end extern
