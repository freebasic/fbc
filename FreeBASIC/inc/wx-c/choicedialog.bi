''
''
'' choicedialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __choicedialog_bi__
#define __choicedialog_bi__

#include once "wx-c/wx.bi"


declare function wxSingleChoiceDialog cdecl alias "wxSingleChoiceDialog_ctor" (byval parent as wxWindow ptr, byval message as string, byval caption as string, byval n as integer, byval choices as byte ptr ptr, byval clientData as any ptr, byval style as integer, byval pos as wxPoint ptr) as wxSingleChoiceDialog ptr
declare sub wxSingleChoiceDialog_dtor cdecl alias "wxSingleChoiceDialog_dtor" (byval self as wxSingleChoiceDialog ptr)
declare sub wxSingleChoiceDialog_SetSelection cdecl alias "wxSingleChoiceDialog_SetSelection" (byval self as wxSingleChoiceDialog ptr, byval sel as integer)
declare function wxSingleChoiceDialog_GetSelection cdecl alias "wxSingleChoiceDialog_GetSelection" (byval self as wxSingleChoiceDialog ptr) as integer
declare function wxSingleChoiceDialog_GetStringSelection cdecl alias "wxSingleChoiceDialog_GetStringSelection" (byval self as wxSingleChoiceDialog ptr) as wxString ptr
declare function wxSingleChoiceDialog_GetSelectionClientData cdecl alias "wxSingleChoiceDialog_GetSelectionClientData" (byval self as wxSingleChoiceDialog ptr) as any ptr

declare function wxMultiChoiceDialog cdecl alias "wxMultiChoiceDialog_ctor" (byval parent as wxWindow ptr, byval message as string, byval caption as string, byval n as integer, byval choices as byte ptr ptr, byval style as integer, byval pos as wxPoint ptr) as wxMultiChoiceDialog ptr
declare sub wxMultiChoiceDialog_dtor cdecl alias "wxMultiChoiceDialog_dtor" (byval self as wxMultiChoiceDialog ptr)
declare sub wxMultiChoiceDialog_SetSelections cdecl alias "wxMultiChoiceDialog_SetSelections" (byval self as wxMultiChoiceDialog ptr, byval sel as integer ptr ptr, byval numsel as integer)
declare function wxMultiChoiceDialog_GetSelections cdecl alias "wxMultiChoiceDialog_GetSelections" (byval self as wxMultiChoiceDialog ptr) as wxArrayInt ptr
declare function wxGetSingleChoice_func cdecl alias "wxGetSingleChoice_func" (byval message as string, byval caption as string, byval n as integer, byval choices as byte ptr ptr, byval parent as wxWindow ptr, byval x as integer, byval y as integer, byval centre as integer, byval width as integer, byval height as integer) as wxString ptr
declare function wxGetSingleChoiceIndex_func cdecl alias "wxGetSingleChoiceIndex_func" (byval message as string, byval caption as string, byval n as integer, byval choices as byte ptr ptr, byval parent as wxWindow ptr, byval x as integer, byval y as integer, byval centre as integer, byval width as integer, byval height as integer) as integer

#endif
