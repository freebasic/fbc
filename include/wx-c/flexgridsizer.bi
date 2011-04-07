''
''
'' flexgridsizer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_flexgridsizer_bi__
#define __wxc_flexgridsizer_bi__

#include once "wx.bi"
#include once "sizer.bi"

declare function wxFlexGridSizer alias "wxFlexGridSizer_ctor" (byval rows as integer, byval cols as integer, byval vgap as integer, byval hgap as integer) as wxFlexGridSizer ptr
declare sub wxFlexGridSizer_dtor (byval self as wxFlexGridSizer ptr)
declare sub wxFlexGridSizer_RecalcSizes (byval self as wxFlexGridSizer ptr)
declare sub wxFlexGridSizer_CalcMin (byval self as wxFlexGridSizer ptr, byval size as wxSize ptr)
declare sub wxFlexGridSizer_AddGrowableRow (byval self as wxFlexGridSizer ptr, byval idx as integer)
declare sub wxFlexGridSizer_RemoveGrowableRow (byval self as wxFlexGridSizer ptr, byval idx as integer)
declare sub wxFlexGridSizer_AddGrowableCol (byval self as wxFlexGridSizer ptr, byval idx as integer)
declare sub wxFlexGridSizer_RemoveGrowableCol (byval self as wxFlexGridSizer ptr, byval idx as integer)

#endif
