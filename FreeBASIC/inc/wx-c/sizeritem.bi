''
''
'' sizeritem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __sizeritem_bi__
#define __sizeritem_bi__

#include once "wx-c/wx.bi"


declare function wxSizerItem_ctorSpace cdecl alias "wxSizerItem_ctorSpace" (byval width as integer, byval height as integer, byval proportion as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr) as wxSizerItem ptr
declare function wxSizerItem_ctorWindow cdecl alias "wxSizerItem_ctorWindow" (byval window as wxWindow ptr, byval proportion as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr) as wxSizerItem ptr
declare function wxSizerItem_ctorSizer cdecl alias "wxSizerItem_ctorSizer" (byval sizer as wxSizer ptr, byval proportion as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr) as wxSizerItem ptr
declare function wxSizerItem cdecl alias "wxSizerItem_ctor" () as wxSizerItem ptr
declare sub wxSizerItem_DeleteWindows cdecl alias "wxSizerItem_DeleteWindows" (byval self as wxSizerItem ptr)
declare sub wxSizerItem_DetachSizer cdecl alias "wxSizerItem_DetachSizer" (byval self as wxSizerItem ptr)
declare sub wxSizerItem_GetSize cdecl alias "wxSizerItem_GetSize" (byval self as wxSizerItem ptr, byval size as wxSize ptr)
declare sub wxSizerItem_CalcMin cdecl alias "wxSizerItem_CalcMin" (byval self as wxSizerItem ptr, byval min as wxSize ptr)
declare sub wxSizerItem_SetDimension cdecl alias "wxSizerItem_SetDimension" (byval self as wxSizerItem ptr, byval pos as wxPoint, byval size as wxSize)
declare sub wxSizerItem_GetMinSize cdecl alias "wxSizerItem_GetMinSize" (byval self as wxSizerItem ptr, byval size as wxSize ptr)
declare sub wxSizerItem_SetInitSize cdecl alias "wxSizerItem_SetInitSize" (byval self as wxSizerItem ptr, byval x as integer, byval y as integer)
declare sub wxSizerItem_SetRatio cdecl alias "wxSizerItem_SetRatio" (byval self as wxSizerItem ptr, byval width as integer, byval height as integer)
declare sub wxSizerItem_SetRatioFloat cdecl alias "wxSizerItem_SetRatioFloat" (byval self as wxSizerItem ptr, byval ratio as single)
declare function wxSizerItem_GetRatioFloat cdecl alias "wxSizerItem_GetRatioFloat" (byval self as wxSizerItem ptr) as single
declare function wxSizerItem_IsWindow cdecl alias "wxSizerItem_IsWindow" (byval self as wxSizerItem ptr) as integer
declare function wxSizerItem_IsSizer cdecl alias "wxSizerItem_IsSizer" (byval self as wxSizerItem ptr) as integer
declare function wxSizerItem_IsSpacer cdecl alias "wxSizerItem_IsSpacer" (byval self as wxSizerItem ptr) as integer
declare sub wxSizerItem_SetProportion cdecl alias "wxSizerItem_SetProportion" (byval self as wxSizerItem ptr, byval proportion as integer)
declare function wxSizerItem_GetProportion cdecl alias "wxSizerItem_GetProportion" (byval self as wxSizerItem ptr) as integer
declare sub wxSizerItem_SetFlag cdecl alias "wxSizerItem_SetFlag" (byval self as wxSizerItem ptr, byval flag as integer)
declare function wxSizerItem_GetFlag cdecl alias "wxSizerItem_GetFlag" (byval self as wxSizerItem ptr) as integer
declare sub wxSizerItem_SetBorder cdecl alias "wxSizerItem_SetBorder" (byval self as wxSizerItem ptr, byval border as integer)
declare function wxSizerItem_GetBorder cdecl alias "wxSizerItem_GetBorder" (byval self as wxSizerItem ptr) as integer
declare function wxSizerItem_GetWindow cdecl alias "wxSizerItem_GetWindow" (byval self as wxSizerItem ptr) as wxWindow ptr
declare sub wxSizerItem_SetWindow cdecl alias "wxSizerItem_SetWindow" (byval self as wxSizerItem ptr, byval window as wxWindow ptr)
declare function wxSizerItem_GetSizer cdecl alias "wxSizerItem_GetSizer" (byval self as wxSizerItem ptr) as wxSizer ptr
declare sub wxSizerItem_SetSizer cdecl alias "wxSizerItem_SetSizer" (byval self as wxSizerItem ptr, byval sizer as wxSizer ptr)
declare sub wxSizerItem_GetSpacer cdecl alias "wxSizerItem_GetSpacer" (byval self as wxSizerItem ptr, byval size as wxSize ptr)
declare sub wxSizerItem_SetSpacer cdecl alias "wxSizerItem_SetSpacer" (byval self as wxSizerItem ptr, byval size as wxSize ptr)
declare sub wxSizerItem_Show cdecl alias "wxSizerItem_Show" (byval self as wxSizerItem ptr, byval show as integer)
declare function wxSizerItem_IsShown cdecl alias "wxSizerItem_IsShown" (byval self as wxSizerItem ptr) as integer
declare function wxSizerItem_GetUserData cdecl alias "wxSizerItem_GetUserData" (byval self as wxSizerItem ptr) as wxObject ptr
declare sub wxSizerItem_GetPosition cdecl alias "wxSizerItem_GetPosition" (byval self as wxSizerItem ptr, byval pos as wxPoint ptr)

#endif
