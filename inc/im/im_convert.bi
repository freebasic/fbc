''
''
'' im_convert -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_convert_bi__
#define __im_convert_bi__

enum imComplex2Real
	IM_CPX_REAL
	IM_CPX_IMAG
	IM_CPX_MAG
	IM_CPX_PHASE
end enum

enum imGammaFactor
	IM_GAMMA_LINEAR = 0
	IM_GAMMA_LOGLITE = -10
	IM_GAMMA_LOGHEAVY = -1000
	IM_GAMMA_EXPLITE = 2
	IM_GAMMA_EXPHEAVY = 7
end enum

enum imCastMode
	IM_CAST_MINMAX
	IM_CAST_FIXED
	IM_CAST_DIRECT
	IM_CAST_USER
end enum

declare function imConvertDataType cdecl alias "imConvertDataType" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval cpx2real as integer, byval gamma as single, byval abssolute as integer, byval cast_mode as integer) as integer
declare function imConvertColorSpace cdecl alias "imConvertColorSpace" (byval src_image as imImage ptr, byval dst_image as imImage ptr) as integer
declare function imConvertToBitmap cdecl alias "imConvertToBitmap" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval cpx2real as integer, byval gamma as single, byval abssolute as integer, byval cast_mode as integer) as integer
declare function imImageGetOpenGLData cdecl alias "imImageGetOpenGLData" (byval image as imImage ptr, byval glformat as integer ptr) as any ptr
declare function imImageCreateFromOpenGLData cdecl alias "imImageCreateFromOpenGLData" (byval width as integer, byval height as integer, byval glformat as integer, byval gldata as any ptr) as imImage ptr
declare sub imConvertPacking cdecl alias "imConvertPacking" (byval src_data as any ptr, byval dst_data as any ptr, byval width as integer, byval height as integer, byval src_depth as integer, byval dst_depth as integer, byval data_type as integer, byval src_is_packed as integer)
declare sub imConvertMapToRGB cdecl alias "imConvertMapToRGB" (byval data as ubyte ptr, byval count as integer, byval depth as integer, byval packed as integer, byval palette as integer ptr, byval palette_count as integer)
declare function imConvertRGB2Map cdecl alias "imConvertRGB2Map" (byval width as integer, byval height as integer, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval map as ubyte ptr, byval palette as integer ptr, byval palette_count as integer ptr) as integer

#endif
