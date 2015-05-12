''
''
'' Xge -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xge_bi__
#define __Xge_bi__

declare function XGEQueryExtension cdecl alias "XGEQueryExtension" (byval dpy as Display ptr, byval event_basep as integer ptr, byval err_basep as integer ptr) as Bool
declare function XGEQueryVersion cdecl alias "XGEQueryVersion" (byval dpy as Display ptr, byval major as integer ptr, byval minor as integer ptr) as Bool

#endif
