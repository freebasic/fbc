''
''
'' clientdata -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __clientdata_bi__
#define __clientdata_bi__

#include once "wx-c/wx.bi"


declare function wxClientData cdecl alias "wxClientData_ctor" () as wxClientData ptr
declare sub wxClientData_dtor cdecl alias "wxClientData_dtor" (byval self as wxClientData ptr)
declare sub wxClientData_RegisterDisposable cdecl alias "wxClientData_RegisterDisposable" (byval self as _ClientData ptr, byval onDispose as Virtual_Dispose)
declare function wxStringClientData cdecl alias "wxStringClientData_ctor" (byval data as zstring ptr) as wxStringClientData ptr
declare sub wxStringClientData_dtor cdecl alias "wxStringClientData_dtor" (byval self as wxStringClientData ptr)
declare sub wxStringClientData_SetData cdecl alias "wxStringClientData_SetData" (byval self as wxStringClientData ptr, byval data as zstring ptr)
declare function wxStringClientData_GetData cdecl alias "wxStringClientData_GetData" (byval self as wxStringClientData ptr) as wxString ptr

#endif
