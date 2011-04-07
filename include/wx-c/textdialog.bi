''
''
'' textdialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_textdialog_bi__
#define __wxc_textdialog_bi__

#include once "wx.bi"


declare function wxTextEntryDialog alias "wxTextEntryDialog_ctor" (byval parent as wxWindow ptr, byval message as zstring ptr, byval caption as zstring ptr, byval value as zstring ptr, byval style as integer, byval pos as wxPoint ptr) as wxTextEntryDialog ptr
declare sub wxTextEntryDialog_dtor (byval self as wxTextEntryDialog ptr)
declare function wxTextEntryDialog_ShowModal (byval self as wxTextEntryDialog ptr) as integer
declare sub wxTextEntryDialog_SetValue (byval self as wxTextEntryDialog ptr, byval val as zstring ptr)
declare function wxTextEntryDialog_GetValue (byval self as wxTextEntryDialog ptr) as wxString ptr
declare function wxGetPasswordFromUser_func (byval message as zstring ptr, byval caption as zstring ptr, byval defaultValue as zstring ptr, byval parent as wxWindow ptr) as wxString ptr
declare function wxGetTextFromUser_func (byval message as zstring ptr, byval caption as zstring ptr, byval defaultValue as zstring ptr, byval parent as wxWindow ptr, byval x as integer, byval y as integer, byval centre as integer) as wxString ptr

#endif
