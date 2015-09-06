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

extern "C"

#define __IM_UTIL_H
#define IM_MIN(_a, _b) iif(_a < _b, _a, _b)
#define IM_MAX(_a, _b) iif(_a > _b, _a, _b)

declare function imStrEqual(byval str1 as const zstring ptr, byval str2 as const zstring ptr) as long
declare function imStrNLen(byval str as const zstring ptr, byval max_len as long) as long
declare function imStrCheck(byval data as const any ptr, byval count as long) as long
declare function imImageDataSize(byval width as long, byval height as long, byval color_mode as long, byval data_type as long) as long
declare function imImageLineSize(byval width as long, byval color_mode as long, byval data_type as long) as long
declare function imImageLineCount(byval width as long, byval color_mode as long) as long
declare function imImageCheckFormat(byval color_mode as long, byval data_type as long) as long
declare function imColorEncode(byval red as ubyte, byval green as ubyte, byval blue as ubyte) as clong
declare sub imColorDecode(byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval color as clong)
declare function imColorModeSpaceName(byval color_mode as long) as const zstring ptr
declare function imColorModeDepth(byval color_mode as long) as long

#define imColorModeSpace(_cm) (_cm and &hFF)
#define imColorModeMatch(_cm1, _cm2) (imColorModeSpace(_cm1) = imColorModeSpace(_cm2))
#define imColorModeHasAlpha(_cm) (_cm and IM_ALPHA)
#define imColorModeIsPacked(_cm) (_cm and IM_PACKED)
#define imColorModeIsTopDown(_cm) (_cm and IM_TOPDOWN)
declare function imColorModeToBitmap(byval color_mode as long) as long
declare function imColorModeIsBitmap(byval color_mode as long, byval data_type as long) as long
const IM_MAXDEPTH = 5
type imbyte as ubyte
type imushort as ushort
#define IM_BYTECROP(_v) iif(_v < 0, 0, iif(_v > 255, 255, _v))
#define IM_FLOATCROP(_v) iif(_v < 0, 0, iif(_v > 1.0f, 1.0f, _v))
#define IM_CROPMAX(_v, _max) iif(_v < 0, 0, iif(_v > _max, _max, _v))
#define IM_CROPMINMAX(_v, _min, _max) iif(_v < _min, _min, iif(_v > _max, _max, _v))

declare function imDataTypeSize(byval data_type as long) as long
declare function imDataTypeName(byval data_type as long) as const zstring ptr
declare function imDataTypeIntMax(byval data_type as long) as culong
declare function imDataTypeIntMin(byval data_type as long) as clong

type imByteOrder as long
enum
	IM_LITTLEENDIAN
	IM_BIGENDIAN
end enum

declare function imBinCPUByteOrder() as long
declare sub imBinSwapBytes(byval data as any ptr, byval count as long, byval size as long)
declare sub imBinSwapBytes2(byval data as any ptr, byval count as long)
declare sub imBinSwapBytes4(byval data as any ptr, byval count as long)
declare sub imBinSwapBytes8(byval data as any ptr, byval count as long)
declare function imCompressDataZ(byval src_data as const any ptr, byval src_size as long, byval dst_data as any ptr, byval dst_size as long, byval zip_quality as long) as long
declare function imCompressDataUnZ(byval src_data as const any ptr, byval src_size as long, byval dst_data as any ptr, byval dst_size as long) as long
declare function imCompressDataLZF(byval src_data as const any ptr, byval src_size as long, byval dst_data as any ptr, byval dst_size as long) as long
declare function imCompressDataUnLZF(byval src_data as const any ptr, byval src_size as long, byval dst_data as any ptr, byval dst_size as long) as long
declare function imCompressDataLZO(byval src_data as const any ptr, byval src_size as long, byval dst_data as any ptr, byval dst_size as long) as long
declare function imCompressDataUnLZO(byval src_data as const any ptr, byval src_size as long, byval dst_data as any ptr, byval dst_size as long) as long

end extern
