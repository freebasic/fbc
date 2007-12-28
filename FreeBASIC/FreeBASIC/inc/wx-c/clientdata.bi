''
''
'' clientdata -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_clientdata_bi__
#define __wxc_clientdata_bi__

#include once "wx.bi"


declare function wxClientData alias "wxClientData_ctor" () as wxClientData ptr
declare sub wxClientData_dtor (byval self as wxClientData ptr)
declare sub wxClientData_RegisterDisposable (byval self as _ClientData ptr, byval onDispose as Virtual_Dispose)
declare function wxStringClientData alias "wxStringClientData_ctor" (byval data as zstring ptr) as wxStringClientData ptr
declare sub wxStringClientData_dtor (byval self as wxStringClientData ptr)
declare sub wxStringClientData_SetData (byval self as wxStringClientData ptr, byval data as zstring ptr)
declare function wxStringClientData_GetData (byval self as wxStringClientData ptr) as wxString ptr

#endif
