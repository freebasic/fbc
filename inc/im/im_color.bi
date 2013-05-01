''
''
'' im_color -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_color_bi__
#define __im_color_bi__

declare function imColorMax cdecl alias "imColorMax" (byval data_type as integer) as integer
declare function imColorMin cdecl alias "imColorMin" (byval data_type as integer) as integer
declare function imColorQuantize cdecl alias "imColorQuantize" (byval value as r.q(const).float, byval min as r.q(const).T, byval max as r.q(const).T) as T
declare function imColorReconstruct cdecl alias "imColorReconstruct" (byval value as r.q(const).T, byval min as r.q(const).T, byval max as r.q(const).T) as single
declare sub imColorYCbCr2RGB cdecl alias "imColorYCbCr2RGB" (byval Y as T, byval Cb as T, byval Cr as T, byval R as r.T, byval G as r.T, byval B as r.T, byval zero as r.q(const).T, byval min as r.q(const).T, byval max as r.q(const).T)
declare sub imColorRGB2YCbCr cdecl alias "imColorRGB2YCbCr" (byval R as T, byval G as T, byval B as T, byval Y as r.T, byval Cb as r.T, byval Cr as r.T, byval zero as r.q(const).T)
declare sub imColorCMYK2RGB cdecl alias "imColorCMYK2RGB" (byval C as T, byval M as T, byval Y as T, byval K as T, byval R as r.T, byval G as r.T, byval B as r.T, byval max as r.q(const).T)
declare sub imColorXYZ2RGB cdecl alias "imColorXYZ2RGB" (byval X as T, byval Y as T, byval Z as T, byval R as r.T, byval G as r.T, byval B as r.T)
declare sub imColorRGB2XYZ cdecl alias "imColorRGB2XYZ" (byval R as T, byval G as T, byval B as T, byval X as r.T, byval Y as r.T, byval Z as r.T)
declare sub imColorXYZ2Lab cdecl alias "imColorXYZ2Lab" (byval X as single, byval Y as single, byval Z as single, byval L as r.float, byval a as r.float, byval b as r.float)
declare sub imColorLab2XYZ cdecl alias "imColorLab2XYZ" (byval L as single, byval a as single, byval b as single, byval X as r.float, byval Y as r.float, byval Z as r.float)
declare sub imColorXYZ2Luv cdecl alias "imColorXYZ2Luv" (byval X as single, byval Y as single, byval Z as single, byval L as r.float, byval u as r.float, byval v as r.float)
declare sub imColorLuv2XYZ cdecl alias "imColorLuv2XYZ" (byval L as single, byval u as single, byval v as single, byval X as r.float, byval Y as r.float, byval Z as r.float)
declare function imColorTransfer2Linear cdecl alias "imColorTransfer2Linear" (byval nonlinear_value as r.q(const).float) as single
declare function imColorTransfer2Nonlinear cdecl alias "imColorTransfer2Nonlinear" (byval value as r.q(const).float) as single
declare sub imColorRGB2RGBNonlinear cdecl alias "imColorRGB2RGBNonlinear" (byval RL as single, byval GL as single, byval BL as single, byval R as r.float, byval G as r.float, byval B as r.float)
declare function imColorRGB2Luma cdecl alias "imColorRGB2Luma" (byval R as T, byval G as T, byval B as T) as T
declare function imColorLuminance2Lightness cdecl alias "imColorLuminance2Lightness" (byval Y as r.q(const).float) as single
declare function imColorLightness2Luminance cdecl alias "imColorLightness2Luminance" (byval L as r.q(const).float) as single

#endif
