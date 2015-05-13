''
''
'' im_colorhsi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_colorhsi_bi__
#define __im_colorhsi_bi__

declare function imColorHSI_ImaxS cdecl alias "imColorHSI_ImaxS" (byval h as single, byval cosh as double, byval sinh as double) as single
declare sub imColorRGB2HSI cdecl alias "imColorRGB2HSI" (byval r as single, byval g as single, byval b as single, byval h as single ptr, byval s as single ptr, byval i as single ptr)
declare sub imColorRGB2HSIbyte cdecl alias "imColorRGB2HSIbyte" (byval r as ubyte, byval g as ubyte, byval b as ubyte, byval h as single ptr, byval s as single ptr, byval i as single ptr)
declare sub imColorHSI2RGB cdecl alias "imColorHSI2RGB" (byval h as single, byval s as single, byval i as single, byval r as single ptr, byval g as single ptr, byval b as single ptr)
declare sub imColorHSI2RGBbyte cdecl alias "imColorHSI2RGBbyte" (byval h as single, byval s as single, byval i as single, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr)

#endif
