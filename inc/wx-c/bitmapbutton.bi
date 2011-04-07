''
''
'' bitmapbutton -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_bitmapbutton_bi__
#define __wxc_bitmapbutton_bi__

#include once "wx.bi"


type Virtual_OnSetBitmap as sub WXCALL ( )

declare function wxBitmapButton alias "wxBitmapButton_ctor" () as wxBitmapButton ptr
declare sub wxBitmapButton_RegisterVirtual (byval self as _BitmapButton ptr, byval onSetBitmap as Virtual_OnSetBitmap)
declare function wxBitmapButton_Create (byval self as _BitmapButton ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval bitmap as wxBitmap ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as integer
declare sub wxBitmapButton_OnSetBitmap (byval self as _BitmapButton ptr)
declare sub wxBitmapButton_SetLabel (byval self as _BitmapButton ptr, byval label as zstring ptr)
declare function wxBitmapButton_GetLabel (byval self as _BitmapButton ptr) as wxString ptr
declare function wxBitmapButton_Enable (byval self as _BitmapButton ptr, byval enable as integer) as integer
declare sub wxBitmapButton_SetBitmapLabel (byval self as _BitmapButton ptr, byval bitmap as wxBitmap ptr)
declare function wxBitmapButton_GetBitmapLabel (byval self as _BitmapButton ptr) as wxBitmap ptr
declare sub wxBitmapButton_SetBitmapSelected (byval self as _BitmapButton ptr, byval sel as wxBitmap ptr)
declare function wxBitmapButton_GetBitmapSelected (byval self as _BitmapButton ptr) as wxBitmap ptr
declare sub wxBitmapButton_SetBitmapDisabled (byval self as _BitmapButton ptr, byval disabled as wxBitmap ptr)
declare function wxBitmapButton_GetBitmapDisabled (byval self as _BitmapButton ptr) as wxBitmap ptr
declare sub wxBitmapButton_SetBitmapFocus (byval self as _BitmapButton ptr, byval focus as wxBitmap ptr)
declare function wxBitmapButton_GetBitmapFocus (byval self as _BitmapButton ptr) as wxBitmap ptr
declare sub wxBitmapButton_SetDefault (byval self as _BitmapButton ptr)
declare sub wxBitmapButton_SetMargins (byval self as _BitmapButton ptr, byval x as integer, byval y as integer)
declare function wxBitmapButton_GetMarginX (byval self as _BitmapButton ptr) as integer
declare function wxBitmapButton_GetMarginY (byval self as _BitmapButton ptr) as integer
declare sub wxBitmapButton_ApplyParentThemeBackground (byval self as _BitmapButton ptr, byval colour as wxColour ptr)

#endif
