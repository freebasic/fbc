''
''
'' checkbox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_checkbox_bi__
#define __wxc_checkbox_bi__

#include once "wx.bi"


declare function wxCheckBox alias "wxCheckBox_ctor" () as wxCheckBox ptr
declare function wxCheckBox_Create (byval self as wxCheckBox ptr, byval parent as wxWindow ptr, byval id as integer, byval label as zstring ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval val as wxValidator ptr, byval name as zstring ptr) as integer
declare function wxCheckBox_GetValue (byval self as wxCheckBox ptr) as integer
declare sub wxCheckBox_SetValue (byval self as wxCheckBox ptr, byval state as integer)
declare function wxCheckBox_IsChecked (byval self as wxCheckBox ptr) as integer
declare function wxCheckBox_Get3StateValue (byval self as wxCheckBox ptr) as wxCheckBoxState
declare sub wxCheckBox_Set3StateValue (byval self as wxCheckBox ptr, byval state as wxCheckBoxState)
declare function wxCheckBox_Is3State (byval self as wxCheckBox ptr) as integer
declare function wxCheckBox_Is3rdStateAllowedForUser (byval self as wxCheckBox ptr) as integer

#endif
