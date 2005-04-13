''
''
'' sizer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __sizer_bi__
#define __sizer_bi__

#include once "wx-c/wx.bi"

declare sub wxSizer_AddWindow cdecl alias "wxSizer_AddWindow" (byval self as wxSizer ptr, byval window as wxWindow ptr, byval proportion as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr)
declare sub wxSizer_AddSizer cdecl alias "wxSizer_AddSizer" (byval self as wxSizer ptr, byval sizer as wxSizer ptr, byval proportion as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr)
declare sub wxSizer_Add cdecl alias "wxSizer_Add" (byval self as wxSizer ptr, byval width as integer, byval height as integer, byval proportion as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr)
declare sub wxSizer_Fit cdecl alias "wxSizer_Fit" (byval self as wxSizer ptr, byval window as wxWindow ptr, byval size as wxSize ptr)
declare sub wxSizer_FitInside cdecl alias "wxSizer_FitInside" (byval self as wxSizer ptr, byval window as wxWindow ptr)
declare sub wxSizer_InsertWindow cdecl alias "wxSizer_InsertWindow" (byval self as wxSizer ptr, byval before as integer, byval window as wxWindow ptr, byval option as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr)
declare sub wxSizer_InsertSizer cdecl alias "wxSizer_InsertSizer" (byval self as wxSizer ptr, byval before as integer, byval sizer as wxSizer ptr, byval option as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr)
declare sub wxSizer_Insert cdecl alias "wxSizer_Insert" (byval self as wxSizer ptr, byval before as integer, byval width as integer, byval height as integer, byval option as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr)
declare sub wxSizer_PrependWindow cdecl alias "wxSizer_PrependWindow" (byval self as wxSizer ptr, byval window as wxWindow ptr, byval option as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr)
declare sub wxSizer_PrependSizer cdecl alias "wxSizer_PrependSizer" (byval self as wxSizer ptr, byval sizer as wxSizer ptr, byval option as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr)
declare sub wxSizer_Prepend cdecl alias "wxSizer_Prepend" (byval self as wxSizer ptr, byval width as integer, byval height as integer, byval option as integer, byval flag as integer, byval border as integer, byval userData as wxObject ptr)
declare function wxSizer_RemoveWindow cdecl alias "wxSizer_RemoveWindow" (byval self as wxSizer ptr, byval window as wxWindow ptr) as integer
declare function wxSizer_RemoveSizer cdecl alias "wxSizer_RemoveSizer" (byval self as wxSizer ptr, byval sizer as wxSizer ptr) as integer
declare function wxSizer_Remove cdecl alias "wxSizer_Remove" (byval self as wxSizer ptr, byval pos as integer) as integer
declare sub wxSizer_Clear cdecl alias "wxSizer_Clear" (byval self as wxSizer ptr, byval delete_windows as integer)
declare sub wxSizer_DeleteWindows cdecl alias "wxSizer_DeleteWindows" (byval self as wxSizer ptr)
declare sub wxSizer_SetMinSize cdecl alias "wxSizer_SetMinSize" (byval self as wxSizer ptr, byval size as wxSize ptr)
declare function wxSizer_SetItemMinSizeWindow cdecl alias "wxSizer_SetItemMinSizeWindow" (byval self as wxSizer ptr, byval window as wxWindow ptr, byval size as wxSize ptr) as integer
declare function wxSizer_SetItemMinSizeSizer cdecl alias "wxSizer_SetItemMinSizeSizer" (byval self as wxSizer ptr, byval sizer as wxSizer ptr, byval size as wxSize ptr) as integer
declare function wxSizer_SetItemMinSize cdecl alias "wxSizer_SetItemMinSize" (byval self as wxSizer ptr, byval pos as integer, byval size as wxSize ptr) as integer
declare sub wxSizer_GetSize cdecl alias "wxSizer_GetSize" (byval self as wxSizer ptr, byval size as wxSize ptr)
declare sub wxSizer_GetPosition cdecl alias "wxSizer_GetPosition" (byval self as wxSizer ptr, byval pt as wxPoint ptr)
declare sub wxSizer_GetMinSize cdecl alias "wxSizer_GetMinSize" (byval self as wxSizer ptr, byval size as wxSize ptr)
declare sub wxSizer_RecalcSizes cdecl alias "wxSizer_RecalcSizes" (byval self as wxSizer ptr)
declare sub wxSizer_CalcMin cdecl alias "wxSizer_CalcMin" (byval self as wxSizer ptr, byval size as wxSize ptr)
declare sub wxSizer_Layout cdecl alias "wxSizer_Layout" (byval self as wxSizer ptr)
declare sub wxSizer_SetSizeHints cdecl alias "wxSizer_SetSizeHints" (byval self as wxSizer ptr, byval window as wxWindow ptr)
declare sub wxSizer_SetVirtualSizeHints cdecl alias "wxSizer_SetVirtualSizeHints" (byval self as wxSizer ptr, byval window as wxWindow ptr)
declare sub wxSizer_SetDimension cdecl alias "wxSizer_SetDimension" (byval self as wxSizer ptr, byval x as integer, byval y as integer, byval width as integer, byval height as integer)
declare sub wxSizer_ShowWindow cdecl alias "wxSizer_ShowWindow" (byval self as wxSizer ptr, byval window as wxWindow ptr, byval show as integer)
declare sub wxSizer_HideWindow cdecl alias "wxSizer_HideWindow" (byval self as wxSizer ptr, byval window as wxWindow ptr)
declare sub wxSizer_ShowSizer cdecl alias "wxSizer_ShowSizer" (byval self as wxSizer ptr, byval sizer as wxSizer ptr, byval show as integer)
declare sub wxSizer_HideSizer cdecl alias "wxSizer_HideSizer" (byval self as wxSizer ptr, byval sizer as wxSizer ptr)
declare function wxSizer_IsShownWindow cdecl alias "wxSizer_IsShownWindow" (byval self as wxSizer ptr, byval window as wxWindow ptr) as integer
declare function wxSizer_IsShownSizer cdecl alias "wxSizer_IsShownSizer" (byval self as wxSizer ptr, byval sizer as wxSizer ptr) as integer
declare function wxSizer_Detach cdecl alias "wxSizer_Detach" (byval self as wxSizer ptr, byval window as wxWindow ptr) as integer
declare function wxSizer_Detach2 cdecl alias "wxSizer_Detach2" (byval self as wxSizer ptr, byval sizer as wxSizer ptr) as integer
declare function wxSizer_Detach3 cdecl alias "wxSizer_Detach3" (byval self as wxSizer ptr, byval index as integer) as integer

#endif
