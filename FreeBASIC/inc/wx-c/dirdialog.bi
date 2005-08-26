''
''
'' dirdialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __dirdialog_bi__
#define __dirdialog_bi__

#include once "wx-c/wx.bi"


declare function wxDirDialog cdecl alias "wxDirDialog_ctor" (byval parent as wxWindow ptr, byval message as zstring ptr, byval defaultPath as zstring ptr, byval style as integer, byval pos as wxPoint ptr, byval size as wxSize ptr, byval name as zstring ptr) as wxDirDialog ptr
declare function wxDirDialog_GetStyle cdecl alias "wxDirDialog_GetStyle" (byval self as wxDirDialog ptr) as integer
declare sub wxDirDialog_SetStyle cdecl alias "wxDirDialog_SetStyle" (byval self as wxDirDialog ptr, byval style as integer)
declare sub wxDirDialog_SetMessage cdecl alias "wxDirDialog_SetMessage" (byval self as wxDirDialog ptr, byval message as zstring ptr)
declare function wxDirDialog_GetMessage cdecl alias "wxDirDialog_GetMessage" (byval self as wxDirDialog ptr) as wxString ptr
declare function wxDirDialog_ShowModal cdecl alias "wxDirDialog_ShowModal" (byval self as wxDirDialog ptr) as integer
declare sub wxDirDialog_SetPath cdecl alias "wxDirDialog_SetPath" (byval self as wxDirDialog ptr, byval path as zstring ptr)
declare function wxDirDialog_GetPath cdecl alias "wxDirDialog_GetPath" (byval self as wxDirDialog ptr) as wxString ptr

#endif
