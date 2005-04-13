''
''
'' messagedialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __messagedialog_bi__
#define __messagedialog_bi__

#include once "wx-c/wx.bi"


declare function wxMsgBox cdecl alias "wxMsgBox" (byval parent as wxWindow ptr, byval msg as string, byval cap as string, byval style as integer, byval pos as wxPoint ptr) as integer

declare function wxMessageDialog cdecl alias "wxMessageDialog_ctor" (byval parent as wxWindow ptr, byval message as string, byval caption as string, byval style as integer, byval pos as wxPoint ptr) as wxMessageDialog ptr
declare function wxMessageDialog_ShowModal cdecl alias "wxMessageDialog_ShowModal" (byval self as wxMessageDialog ptr) as integer

#endif
