''
''
'' paintevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __paintevent_bi__
#define __paintevent_bi__

#include once "wx-c/wx.bi"

declare function wxPaintEvent cdecl alias "wxPaintEvent_ctor" (byval Id as integer) as wxPaintEvent ptr

#endif
