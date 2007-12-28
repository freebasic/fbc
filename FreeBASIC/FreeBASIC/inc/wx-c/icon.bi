''
''
'' icon -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_icon_bi__
#define __wxc_icon_bi__

#include once "wx.bi"

declare function wxIcon alias "wxIcon_ctor" () as wxIcon ptr
declare sub wxIcon_CopyFromBitmap (byval self as wxIcon ptr, byval bitmap as wxBitmap ptr)
declare function wxIcon_LoadFile (byval self as wxIcon ptr, byval name as zstring ptr, byval type as wxBitmapType) as integer

#endif
