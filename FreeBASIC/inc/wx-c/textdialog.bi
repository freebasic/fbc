''
''
'' textdialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __textdialog_bi__
#define __textdialog_bi__

#include once "wx-c/wx.bi"


declare function wxTextEntryDialog cdecl alias "wxTextEntryDialog_ctor" (byval parent as wxWindow ptr, byval message as string, byval caption as string, byval value as string, byval style as integer, byval pos as wxPoint ptr) as wxTextEntryDialog ptr
declare sub wxTextEntryDialog_dtor cdecl alias "wxTextEntryDialog_dtor" (byval self as wxTextEntryDialog ptr)
declare function wxTextEntryDialog_ShowModal cdecl alias "wxTextEntryDialog_ShowModal" (byval self as wxTextEntryDialog ptr) as integer
declare sub wxTextEntryDialog_SetValue cdecl alias "wxTextEntryDialog_SetValue" (byval self as wxTextEntryDialog ptr, byval val as string)
declare function wxTextEntryDialog_GetValue cdecl alias "wxTextEntryDialog_GetValue" (byval self as wxTextEntryDialog ptr) as wxString ptr
declare function wxGetPasswordFromUser_func cdecl alias "wxGetPasswordFromUser_func" (byval message as string, byval caption as string, byval defaultValue as string, byval parent as wxWindow ptr) as wxString ptr
declare function wxGetTextFromUser_func cdecl alias "wxGetTextFromUser_func" (byval message as string, byval caption as string, byval defaultValue as string, byval parent as wxWindow ptr, byval x as integer, byval y as integer, byval centre as integer) as wxString ptr

#endif
