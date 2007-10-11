''
''
'' colourdialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_colourdialog_bi__
#define __wxc_colourdialog_bi__

#include once "wx.bi"


declare function wxColourDialog alias "wxColourDialog_ctor" () as wxColourDialog ptr
declare function wxColourDialog_Create (byval self as wxColourDialog ptr, byval parent as wxWindow ptr, byval data as wxColourData ptr) as integer
declare function wxColourDialog_GetColourData (byval self as wxColourDialog ptr) as wxColourData ptr
declare function wxColourDialog_ShowModal (byval self as wxColourDialog ptr) as integer
declare function wxColourDialog_GetColourFromUser (byval parent as wxWindow ptr, byval colInit as wxColour ptr) as wxColour ptr
declare function wxColourData alias "wxColourData_ctor" () as wxColourData ptr
declare sub wxColourData_SetChooseFull (byval self as wxColourData ptr, byval flag as integer)
declare function wxColourData_GetChooseFull (byval self as wxColourData ptr) as integer
declare sub wxColourData_SetColour (byval self as wxColourData ptr, byval colour as wxColour ptr)
declare function wxColourData_GetColour (byval self as wxColourData ptr) as wxColour ptr
declare sub wxColourData_SetCustomColour (byval self as wxColourData ptr, byval i as integer, byval colour as wxColour ptr)
declare function wxColourData_GetCustomColour (byval self as wxColourData ptr, byval i as integer) as wxColour ptr

#endif
