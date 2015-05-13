''
''
'' cdirgb -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cdirgb_bi__
#define __cdirgb_bi__

declare function cdContextImageRGB cdecl alias "cdContextImageRGB" () as cdContext ptr
declare function cdContextDBufferRGB cdecl alias "cdContextDBufferRGB" () as cdContext ptr
declare function cdRedImage cdecl alias "cdRedImage" (byval cnv as cdCanvas ptr) as ubyte ptr
declare function cdGreenImage cdecl alias "cdGreenImage" (byval cnv as cdCanvas ptr) as ubyte ptr
declare function cdBlueImage cdecl alias "cdBlueImage" (byval cnv as cdCanvas ptr) as ubyte ptr
declare function cdAlphaImage cdecl alias "cdAlphaImage" (byval cnv as cdCanvas ptr) as ubyte ptr

#endif
