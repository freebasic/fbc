''
''
'' messagedialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_messagedialog_bi__
#define __wxc_messagedialog_bi__

#include once "wx.bi"


declare function wxMsgBox (byval parent as wxWindow ptr, byval msg as zstring ptr, byval cap as zstring ptr, byval style as integer, byval pos as wxPoint ptr) as integer

declare function wxMessageDialog alias "wxMessageDialog_ctor" (byval parent as wxWindow ptr, byval message as zstring ptr, byval caption as zstring ptr, byval style as integer, byval pos as wxPoint ptr) as wxMessageDialog ptr
declare function wxMessageDialog_ShowModal (byval self as wxMessageDialog ptr) as integer

#endif
