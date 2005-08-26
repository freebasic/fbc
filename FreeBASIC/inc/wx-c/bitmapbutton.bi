''
''
'' bitmapbutton -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __bitmapbutton_bi__
#define __bitmapbutton_bi__

#include once "wx-c/wx.bi"


type Virtual_OnSetBitmap as sub ( )

declare function wxBitmapButton cdecl alias "wxBitmapButton_ctor" () as wxBitmapButton ptr
declare sub wxBitmapButton_RegisterVirtual cdecl alias "wxBitmapButton_RegisterVirtual" (byval self as _BitmapButton ptr, byval onSetBitmap as Virtual_OnSetBitmap)
declare function wxBitmapButton_Create cdecl alias "wxBitmapButton_Create" (byval self as _BitmapButton ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval bitmap as wxBitmap ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as integer
declare sub wxBitmapButton_OnSetBitmap cdecl alias "wxBitmapButton_OnSetBitmap" (byval self as _BitmapButton ptr)
declare sub wxBitmapButton_SetLabel cdecl alias "wxBitmapButton_SetLabel" (byval self as _BitmapButton ptr, byval label as zstring ptr)
declare function wxBitmapButton_GetLabel cdecl alias "wxBitmapButton_GetLabel" (byval self as _BitmapButton ptr) as wxString ptr
declare function wxBitmapButton_Enable cdecl alias "wxBitmapButton_Enable" (byval self as _BitmapButton ptr, byval enable as integer) as integer
declare sub wxBitmapButton_SetBitmapLabel cdecl alias "wxBitmapButton_SetBitmapLabel" (byval self as _BitmapButton ptr, byval bitmap as wxBitmap ptr)
declare function wxBitmapButton_GetBitmapLabel cdecl alias "wxBitmapButton_GetBitmapLabel" (byval self as _BitmapButton ptr) as wxBitmap ptr
declare sub wxBitmapButton_SetBitmapSelected cdecl alias "wxBitmapButton_SetBitmapSelected" (byval self as _BitmapButton ptr, byval sel as wxBitmap ptr)
declare function wxBitmapButton_GetBitmapSelected cdecl alias "wxBitmapButton_GetBitmapSelected" (byval self as _BitmapButton ptr) as wxBitmap ptr
declare sub wxBitmapButton_SetBitmapDisabled cdecl alias "wxBitmapButton_SetBitmapDisabled" (byval self as _BitmapButton ptr, byval disabled as wxBitmap ptr)
declare function wxBitmapButton_GetBitmapDisabled cdecl alias "wxBitmapButton_GetBitmapDisabled" (byval self as _BitmapButton ptr) as wxBitmap ptr
declare sub wxBitmapButton_SetBitmapFocus cdecl alias "wxBitmapButton_SetBitmapFocus" (byval self as _BitmapButton ptr, byval focus as wxBitmap ptr)
declare function wxBitmapButton_GetBitmapFocus cdecl alias "wxBitmapButton_GetBitmapFocus" (byval self as _BitmapButton ptr) as wxBitmap ptr
declare sub wxBitmapButton_SetDefault cdecl alias "wxBitmapButton_SetDefault" (byval self as _BitmapButton ptr)
declare sub wxBitmapButton_SetMargins cdecl alias "wxBitmapButton_SetMargins" (byval self as _BitmapButton ptr, byval x as integer, byval y as integer)
declare function wxBitmapButton_GetMarginX cdecl alias "wxBitmapButton_GetMarginX" (byval self as _BitmapButton ptr) as integer
declare function wxBitmapButton_GetMarginY cdecl alias "wxBitmapButton_GetMarginY" (byval self as _BitmapButton ptr) as integer
declare sub wxBitmapButton_ApplyParentThemeBackground cdecl alias "wxBitmapButton_ApplyParentThemeBackground" (byval self as _BitmapButton ptr, byval colour as wxColour ptr)

#endif
