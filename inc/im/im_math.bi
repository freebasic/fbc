''
''
'' im_math -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_math_bi__
#define __im_math_bi__

declare function imRound cdecl alias "imRound" (byval x as double) as integer
declare function imAbs cdecl alias "imAbs" (byval v as r.q(const).T) as T
declare function imResampleInt cdecl alias "imResampleInt" (byval x as integer, byval factor as single) as integer
declare function imZeroOrderDecimation cdecl alias "imZeroOrderDecimation" (byval width as integer, byval height as integer, byval map as T ptr, byval xl as single, byval yl as single, byval box_width as single, byval box_height as single, byval Dummy as TU) as T
declare function imBilinearDecimation cdecl alias "imBilinearDecimation" (byval width as integer, byval height as integer, byval map as T ptr, byval xl as single, byval yl as single, byval box_width as single, byval box_height as single, byval Dummy as TU) as T
declare function imZeroOrderInterpolation cdecl alias "imZeroOrderInterpolation" (byval width as integer, byval height as integer, byval map as T ptr, byval xl as single, byval yl as single) as T
declare function imBilinearInterpolation cdecl alias "imBilinearInterpolation" (byval width as integer, byval height as integer, byval map as T ptr, byval xl as single, byval yl as single) as T
declare function imBicubicInterpolation cdecl alias "imBicubicInterpolation" (byval width as integer, byval height as integer, byval map as T ptr, byval xl as single, byval yl as single, byval Dummy as TU) as T
declare sub imMinMax cdecl alias "imMinMax" (byval map as T ptr, byval count as integer, byval min as r.T, byval max as r.T, byval abssolute as integer)
declare sub imMinMaxType cdecl alias "imMinMaxType" (byval map as T ptr, byval count as integer, byval min as r.T, byval max as r.T, byval abssolute as integer)

#endif
