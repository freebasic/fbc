''
''
'' cdnative -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cdnative_bi__
#define __cdnative_bi__

declare function cdContextNativeWindow cdecl alias "cdContextNativeWindow" () as cdContext ptr
declare sub cdGetScreenSize cdecl alias "cdGetScreenSize" (byval width as integer ptr, byval height as integer ptr, byval width_mm as double ptr, byval height_mm as double ptr)
declare function cdGetScreenColorPlanes cdecl alias "cdGetScreenColorPlanes" () as integer

#endif
