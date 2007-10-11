''
''
'' slider -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_slider_bi__
#define __wxc_slider_bi__

#include once "wx.bi"


declare function wxSlider alias "wxSlider_ctor" () as wxSlider ptr
declare function wxSlider_Create (byval self as wxSlider ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval value as integer, byval minValue as integer, byval maxValue as integer, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as integer
declare function wxSlider_GetValue (byval self as wxSlider ptr) as integer
declare sub wxSlider_SetValue (byval self as wxSlider ptr, byval value as integer)
declare sub wxSlider_SetRange (byval self as wxSlider ptr, byval minValue as integer, byval maxValue as integer)
declare function wxSlider_GetMin (byval self as wxSlider ptr) as integer
declare function wxSlider_GetMax (byval self as wxSlider ptr) as integer
declare sub wxSlider_SetLineSize (byval self as wxSlider ptr, byval lineSize as integer)
declare sub wxSlider_SetPageSize (byval self as wxSlider ptr, byval pageSize as integer)
declare function wxSlider_GetLineSize (byval self as wxSlider ptr) as integer
declare function wxSlider_GetPageSize (byval self as wxSlider ptr) as integer
declare sub wxSlider_SetThumbLength (byval self as wxSlider ptr, byval lenPixels as integer)
declare function wxSlider_GetThumbLength (byval self as wxSlider ptr) as integer
declare sub wxSlider_SetTickFreq (byval self as wxSlider ptr, byval n as integer, byval pos as integer)
declare function wxSlider_GetTickFreq (byval self as wxSlider ptr) as integer
declare sub wxSlider_ClearTicks (byval self as wxSlider ptr)
declare sub wxSlider_SetTick (byval self as wxSlider ptr, byval tickPos as integer)
declare sub wxSlider_ClearSel (byval self as wxSlider ptr)
declare function wxSlider_GetSelEnd (byval self as wxSlider ptr) as integer
declare function wxSlider_GetSelStart (byval self as wxSlider ptr) as integer
declare sub wxSlider_SetSelection (byval self as wxSlider ptr, byval min as integer, byval max as integer)

#endif
