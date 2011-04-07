''
''
'' sizer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_sizer_bi__
#define __wxc_sizer_bi__

#include once "wx.bi"

declare sub wxSizer_AddWindow (byval self as wxSizer ptr, byval window as wxWindow ptr, byval proportion as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr)
declare sub wxSizer_AddSizer (byval self as wxSizer ptr, byval sizer as wxSizer ptr, byval proportion as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr)
declare sub wxSizer_Add (byval self as wxSizer ptr, byval width as integer, byval height as integer, byval proportion as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr)
declare sub wxSizer_Fit (byval self as wxSizer ptr, byval window as wxWindow ptr, byval size as wxSize ptr)
declare sub wxSizer_FitInside (byval self as wxSizer ptr, byval window as wxWindow ptr)
declare sub wxSizer_InsertWindow (byval self as wxSizer ptr, byval before as integer, byval window as wxWindow ptr, byval option as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr)
declare sub wxSizer_InsertSizer (byval self as wxSizer ptr, byval before as integer, byval sizer as wxSizer ptr, byval option as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr)
declare sub wxSizer_Insert (byval self as wxSizer ptr, byval before as integer, byval width as integer, byval height as integer, byval option as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr)
declare sub wxSizer_PrependWindow (byval self as wxSizer ptr, byval window as wxWindow ptr, byval option as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr)
declare sub wxSizer_PrependSizer (byval self as wxSizer ptr, byval sizer as wxSizer ptr, byval option as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr)
declare sub wxSizer_Prepend (byval self as wxSizer ptr, byval width as integer, byval height as integer, byval option as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr)
declare function wxSizer_RemoveWindow (byval self as wxSizer ptr, byval window as wxWindow ptr) as integer
declare function wxSizer_RemoveSizer (byval self as wxSizer ptr, byval sizer as wxSizer ptr) as integer
declare function wxSizer_Remove (byval self as wxSizer ptr, byval pos as integer) as integer
declare sub wxSizer_Clear (byval self as wxSizer ptr, byval delete_windows as integer)
declare sub wxSizer_DeleteWindows (byval self as wxSizer ptr)
declare sub wxSizer_SetMinSize (byval self as wxSizer ptr, byval size as wxSize ptr)
declare function wxSizer_SetItemMinSizeWindow (byval self as wxSizer ptr, byval window as wxWindow ptr, byval size as wxSize ptr) as integer
declare function wxSizer_SetItemMinSizeSizer (byval self as wxSizer ptr, byval sizer as wxSizer ptr, byval size as wxSize ptr) as integer
declare function wxSizer_SetItemMinSize (byval self as wxSizer ptr, byval pos as integer, byval size as wxSize ptr) as integer
declare sub wxSizer_GetSize (byval self as wxSizer ptr, byval size as wxSize ptr)
declare sub wxSizer_GetPosition (byval self as wxSizer ptr, byval pt as wxPoint ptr)
declare sub wxSizer_GetMinSize (byval self as wxSizer ptr, byval size as wxSize ptr)
declare sub wxSizer_RecalcSizes (byval self as wxSizer ptr)
declare sub wxSizer_CalcMin (byval self as wxSizer ptr, byval size as wxSize ptr)
declare sub wxSizer_Layout (byval self as wxSizer ptr)
declare sub wxSizer_SetSizeHints (byval self as wxSizer ptr, byval window as wxWindow ptr)
declare sub wxSizer_SetVirtualSizeHints (byval self as wxSizer ptr, byval window as wxWindow ptr)
declare sub wxSizer_SetDimension (byval self as wxSizer ptr, byval x as integer, byval y as integer, byval width as integer, byval height as integer)
declare sub wxSizer_ShowWindow (byval self as wxSizer ptr, byval window as wxWindow ptr, byval show as integer)
declare sub wxSizer_HideWindow (byval self as wxSizer ptr, byval window as wxWindow ptr)
declare sub wxSizer_ShowSizer (byval self as wxSizer ptr, byval sizer as wxSizer ptr, byval show as integer)
declare sub wxSizer_HideSizer (byval self as wxSizer ptr, byval sizer as wxSizer ptr)
declare function wxSizer_IsShownWindow (byval self as wxSizer ptr, byval window as wxWindow ptr) as integer
declare function wxSizer_IsShownSizer (byval self as wxSizer ptr, byval sizer as wxSizer ptr) as integer
declare function wxSizer_Detach (byval self as wxSizer ptr, byval window as wxWindow ptr) as integer
declare function wxSizer_Detach2 (byval self as wxSizer ptr, byval sizer as wxSizer ptr) as integer
declare function wxSizer_Detach3 (byval self as wxSizer ptr, byval index as integer) as integer

#endif
