''
''
'' icon -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __icon_bi__
#define __icon_bi__

#include once "wx-c/wx.bi"

declare function wxIcon cdecl alias "wxIcon_ctor" () as wxIcon ptr
declare sub wxIcon_CopyFromBitmap cdecl alias "wxIcon_CopyFromBitmap" (byval self as wxIcon ptr, byval bitmap as wxBitmap ptr)
declare function wxIcon_LoadFile cdecl alias "wxIcon_LoadFile" (byval self as wxIcon ptr, byval name as string, byval type as wxBitmapType) as integer

#endif
