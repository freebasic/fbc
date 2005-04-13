''
''
'' gridsizer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gridsizer_bi__
#define __gridsizer_bi__

#include once "wx-c/wx.bi"
#include once "wx-c/sizer.bi"

declare function wxGridSizer cdecl alias "wxGridSizer_ctor" (byval rows as integer, byval cols as integer, byval vgap as integer, byval hgap as integer) as wxGridSizer ptr
declare sub wxGridSizer_RecalcSizes cdecl alias "wxGridSizer_RecalcSizes" (byval self as wxGridSizer ptr)
declare sub wxGridSizer_CalcMin cdecl alias "wxGridSizer_CalcMin" (byval self as wxGridSizer ptr, byval size as wxSize ptr)
declare sub wxGridSizer_SetCols cdecl alias "wxGridSizer_SetCols" (byval self as wxGridSizer ptr, byval cols as integer)
declare sub wxGridSizer_SetRows cdecl alias "wxGridSizer_SetRows" (byval self as wxGridSizer ptr, byval rows as integer)
declare sub wxGridSizer_SetVGap cdecl alias "wxGridSizer_SetVGap" (byval self as wxGridSizer ptr, byval gap as integer)
declare sub wxGridSizer_SetHGap cdecl alias "wxGridSizer_SetHGap" (byval self as wxGridSizer ptr, byval gap as integer)
declare function wxGridSizer_GetCols cdecl alias "wxGridSizer_GetCols" (byval self as wxGridSizer ptr) as integer
declare function wxGridSizer_GetRows cdecl alias "wxGridSizer_GetRows" (byval self as wxGridSizer ptr) as integer
declare function wxGridSizer_GetVGap cdecl alias "wxGridSizer_GetVGap" (byval self as wxGridSizer ptr) as integer
declare function wxGridSizer_GetHGap cdecl alias "wxGridSizer_GetHGap" (byval self as wxGridSizer ptr) as integer

#endif
