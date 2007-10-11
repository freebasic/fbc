''
''
'' gridsizer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_gridsizer_bi__
#define __wxc_gridsizer_bi__

#include once "wx.bi"
#include once "sizer.bi"

declare function wxGridSizer alias "wxGridSizer_ctor" (byval rows as integer, byval cols as integer, byval vgap as integer, byval hgap as integer) as wxGridSizer ptr
declare sub wxGridSizer_RecalcSizes (byval self as wxGridSizer ptr)
declare sub wxGridSizer_CalcMin (byval self as wxGridSizer ptr, byval size as wxSize ptr)
declare sub wxGridSizer_SetCols (byval self as wxGridSizer ptr, byval cols as integer)
declare sub wxGridSizer_SetRows (byval self as wxGridSizer ptr, byval rows as integer)
declare sub wxGridSizer_SetVGap (byval self as wxGridSizer ptr, byval gap as integer)
declare sub wxGridSizer_SetHGap (byval self as wxGridSizer ptr, byval gap as integer)
declare function wxGridSizer_GetCols (byval self as wxGridSizer ptr) as integer
declare function wxGridSizer_GetRows (byval self as wxGridSizer ptr) as integer
declare function wxGridSizer_GetVGap (byval self as wxGridSizer ptr) as integer
declare function wxGridSizer_GetHGap (byval self as wxGridSizer ptr) as integer

#endif
