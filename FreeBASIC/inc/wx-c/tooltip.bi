''
''
'' tooltip -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __tooltip_bi__
#define __tooltip_bi__

#include once "wx-c/wx.bi"

declare sub wxToolTip_Enable cdecl alias "wxToolTip_Enable" (byval flag as integer)
declare sub wxToolTip_SetDelay cdecl alias "wxToolTip_SetDelay" (byval msecs as integer)
declare function wxToolTip cdecl alias "wxToolTip_ctor" (byval tip as zstring ptr) as wxToolTip ptr
declare sub wxToolTip_SetTip cdecl alias "wxToolTip_SetTip" (byval self as wxToolTip ptr, byval tip as zstring ptr)
declare function wxToolTip_GetTip cdecl alias "wxToolTip_GetTip" (byval self as wxToolTip ptr) as wxString ptr
declare function wxToolTip_GetWindow cdecl alias "wxToolTip_GetWindow" (byval self as wxToolTip ptr) as wxWindow ptr

#endif
