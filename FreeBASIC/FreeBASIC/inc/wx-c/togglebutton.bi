''
''
'' togglebutton -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_togglebutton_bi__
#define __wxc_togglebutton_bi__

#include once "wx.bi"


declare function wxToggleButton alias "wxToggleButton_ctor" () as wxToggleButton ptr
declare function wxToggleButton_Create (byval self as wxToggleButton ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval label as zstring ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as integer
declare function wxToggleButton_GetValue (byval self as wxToggleButton ptr) as integer
declare sub wxToggleButton_SetValue (byval self as wxToggleButton ptr, byval state as integer)

#endif
