''
''
'' gauge -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_gauge_bi__
#define __wxc_gauge_bi__

#include once "wx.bi"


declare function wxGauge alias "wxGauge_ctor" () as wxGauge ptr
declare sub wxGauge_dtor (byval self as wxGauge ptr)
declare function wxGauge_Create (byval self as wxGauge ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval range as integer, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as integer
declare sub wxGauge_SetRange (byval self as wxGauge ptr, byval range as integer)
declare function wxGauge_GetRange (byval self as wxGauge ptr) as integer
declare sub wxGauge_SetValue (byval self as wxGauge ptr, byval pos as integer)
declare function wxGauge_GetValue (byval self as wxGauge ptr) as integer
declare sub wxGauge_SetShadowWidth (byval self as wxGauge ptr, byval w as integer)
declare function wxGauge_GetShadowWidth (byval self as wxGauge ptr) as integer
declare sub wxGauge_SetBezelFace (byval self as wxGauge ptr, byval w as integer)
declare function wxGauge_GetBezelFace (byval self as wxGauge ptr) as integer
declare function wxGauge_AcceptsFocus (byval self as wxGauge ptr) as integer
declare function wxGauge_IsVertical (byval self as wxGauge ptr) as integer

#endif
