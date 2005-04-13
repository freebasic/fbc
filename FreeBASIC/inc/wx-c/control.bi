''
''
'' control -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __control_bi__
#define __control_bi__

#include once "wx-c/wx.bi"

declare sub wxControl_Command cdecl alias "wxControl_Command" (byval self as wxControl ptr, byval event as wxCommandEvent ptr)
declare sub wxControl_SetLabel cdecl alias "wxControl_SetLabel" (byval self as wxControl ptr, byval label as string)
declare function wxControl_GetLabel cdecl alias "wxControl_GetLabel" (byval self as wxControl ptr) as wxString ptr
declare function wxControl_GetAlignment cdecl alias "wxControl_GetAlignment" (byval self as wxControl ptr) as integer
declare function wxControl_SetFont cdecl alias "wxControl_SetFont" (byval self as wxControl ptr, byval font as wxFont ptr) as integer

#endif
