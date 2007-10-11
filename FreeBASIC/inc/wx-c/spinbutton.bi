''
''
'' spinbutton -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_spinbutton_bi__
#define __wxc_spinbutton_bi__

#include once "wx.bi"


declare function wxSpinButton alias "wxSpinButton_ctor" () as wxSpinButton ptr
declare function wxSpinButton_Create (byval self as wxSpinButton ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer
declare function wxSpinButton_GetValue (byval self as wxSpinButton ptr) as integer
declare function wxSpinButton_GetMin (byval self as wxSpinButton ptr) as integer
declare function wxSpinButton_GetMax (byval self as wxSpinButton ptr) as integer
declare sub wxSpinButton_SetValue (byval self as wxSpinButton ptr, byval val as integer)
declare sub wxSpinButton_SetRange (byval self as wxSpinButton ptr, byval minVal as integer, byval maxVal as integer)
declare function wxSpinEvent alias "wxSpinEvent_ctor" (byval commandType as wxEventType, byval id as integer) as wxSpinEvent ptr
declare function wxSpinEvent_GetPosition (byval self as wxSpinEvent ptr) as integer
declare sub wxSpinEvent_SetPosition (byval self as wxSpinEvent ptr, byval pos as integer)
declare sub wxSpinEvent_Veto (byval self as wxSpinEvent ptr)
declare sub wxSpinEvent_Allow (byval self as wxSpinEvent ptr)
declare function wxSpinEvent_IsAllowed (byval self as wxSpinEvent ptr) as integer

#endif
