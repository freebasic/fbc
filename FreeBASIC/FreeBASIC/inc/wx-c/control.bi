''
''
'' control -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_control_bi__
#define __wxc_control_bi__

#include once "wx.bi"

declare sub wxControl_Command (byval self as wxControl ptr, byval event as wxCommandEvent ptr)
declare sub wxControl_SetLabel (byval self as wxControl ptr, byval label as zstring ptr)
declare function wxControl_GetLabel (byval self as wxControl ptr) as wxString ptr
declare function wxControl_GetAlignment (byval self as wxControl ptr) as integer
declare function wxControl_SetFont (byval self as wxControl ptr, byval font as wxFont ptr) as integer

#endif
