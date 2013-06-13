''
''
'' iupcontrols -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iupcontrols_bi__
#define __iupcontrols_bi__

declare function IupControlsOpen cdecl alias "IupControlsOpen" () as integer
declare sub IupControlsClose cdecl alias "IupControlsClose" ()
declare function IupColorbar cdecl alias "IupColorbar" () as Ihandle ptr
declare function IupCells cdecl alias "IupCells" () as Ihandle ptr
declare function IupColorBrowser cdecl alias "IupColorBrowser" () as Ihandle ptr
declare function IupColorBrowser cdecl alias "IupColorBrowser" () as Ihandle ptr
declare function IupGauge cdecl alias "IupGauge" () as Ihandle ptr
declare function IupDial cdecl alias "IupDial" (byval type as zstring ptr) as Ihandle ptr
declare function IupMatrix cdecl alias "IupMatrix" (byval action as zstring ptr) as Ihandle ptr
declare sub IupMatSetAttribute cdecl alias "IupMatSetAttribute" (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer, byval value as zstring ptr)
declare sub IupMatStoreAttribute cdecl alias "IupMatStoreAttribute" (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer, byval value as zstring ptr)
declare function IupMatGetAttribute cdecl alias "IupMatGetAttribute" (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer) as zstring ptr
declare function IupMatGetInt cdecl alias "IupMatGetInt" (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer) as integer
declare function IupMatGetFloat cdecl alias "IupMatGetFloat" (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer) as single
declare sub IupMatSetfAttribute cdecl alias "IupMatSetfAttribute" (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer, byval format as zstring ptr, ...)

#define IUP_PRIMARY -1
#define IUP_SECONDARY -2

#endif
