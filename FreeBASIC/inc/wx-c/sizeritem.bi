''
''
'' sizeritem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_sizeritem_bi__
#define __wxc_sizeritem_bi__

#include once "wx.bi"


declare function wxSizerItem_ctorSpace (byval width as integer, byval height as integer, byval proportion as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr) as wxSizerItem ptr
declare function wxSizerItem_ctorWindow (byval window as wxWindow ptr, byval proportion as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr) as wxSizerItem ptr
declare function wxSizerItem_ctorSizer (byval sizer as wxSizer ptr, byval proportion as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr) as wxSizerItem ptr
declare function wxSizerItem alias "wxSizerItem_ctor" () as wxSizerItem ptr
declare sub wxSizerItem_DeleteWindows (byval self as wxSizerItem ptr)
declare sub wxSizerItem_DetachSizer (byval self as wxSizerItem ptr)
declare sub wxSizerItem_GetSize (byval self as wxSizerItem ptr, byval size as wxSize ptr)
declare sub wxSizerItem_CalcMin (byval self as wxSizerItem ptr, byval min as wxSize ptr)
''''''' declare sub wxSizerItem_SetDimension (byval self as wxSizerItem ptr, byval pos as wxPoint, byval size as wxSize)
declare sub wxSizerItem_GetMinSize (byval self as wxSizerItem ptr, byval size as wxSize ptr)
declare sub wxSizerItem_SetInitSize (byval self as wxSizerItem ptr, byval x as integer, byval y as integer)
declare sub wxSizerItem_SetRatio (byval self as wxSizerItem ptr, byval width as integer, byval height as integer)
declare sub wxSizerItem_SetRatioFloat (byval self as wxSizerItem ptr, byval ratio as single)
declare function wxSizerItem_GetRatioFloat (byval self as wxSizerItem ptr) as single
declare function wxSizerItem_IsWindow (byval self as wxSizerItem ptr) as integer
declare function wxSizerItem_IsSizer (byval self as wxSizerItem ptr) as integer
declare function wxSizerItem_IsSpacer (byval self as wxSizerItem ptr) as integer
declare sub wxSizerItem_SetProportion (byval self as wxSizerItem ptr, byval proportion as integer)
declare function wxSizerItem_GetProportion (byval self as wxSizerItem ptr) as integer
declare sub wxSizerItem_SetFlag (byval self as wxSizerItem ptr, byval flag as integer)
declare function wxSizerItem_GetFlag (byval self as wxSizerItem ptr) as integer
declare sub wxSizerItem_SetBorder (byval self as wxSizerItem ptr, byval border as integer)
declare function wxSizerItem_GetBorder (byval self as wxSizerItem ptr) as integer
declare function wxSizerItem_GetWindow (byval self as wxSizerItem ptr) as wxWindow ptr
declare sub wxSizerItem_SetWindow (byval self as wxSizerItem ptr, byval window as wxWindow ptr)
declare function wxSizerItem_GetSizer (byval self as wxSizerItem ptr) as wxSizer ptr
declare sub wxSizerItem_SetSizer (byval self as wxSizerItem ptr, byval sizer as wxSizer ptr)
declare sub wxSizerItem_GetSpacer (byval self as wxSizerItem ptr, byval size as wxSize ptr)
declare sub wxSizerItem_SetSpacer (byval self as wxSizerItem ptr, byval size as wxSize ptr)
declare sub wxSizerItem_Show (byval self as wxSizerItem ptr, byval show as integer)
declare function wxSizerItem_IsShown (byval self as wxSizerItem ptr) as integer
declare function wxSizerItem_GetUserData (byval self as wxSizerItem ptr) as wxObject ptr
declare sub wxSizerItem_GetPosition (byval self as wxSizerItem ptr, byval pos as wxPoint ptr)

#endif
