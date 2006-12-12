''
''
'' radiobutton -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_radiobutton_bi__
#define __wxc_radiobutton_bi__

#include once "wx.bi"


declare function wxRadioButton alias "wxRadioButton_ctor" () as wxRadioButton ptr
declare function wxRadioButton_Create (byval self as wxRadioButton ptr, byval parent as wxWindow ptr, byval id as integer, byval label as zstring ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval val as wxValidator ptr, byval name as zstring ptr) as integer
declare function wxRadioButton_GetValue (byval self as wxRadioButton ptr) as integer
declare sub wxRadioButton_SetValue (byval self as wxRadioButton ptr, byval state as integer)

#endif
