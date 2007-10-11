''
''
'' choicedialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_choicedialog_bi__
#define __wxc_choicedialog_bi__

#include once "wx.bi"


declare function wxSingleChoiceDialog alias "wxSingleChoiceDialog_ctor" (byval parent as wxWindow ptr, byval message as zstring ptr, byval caption as zstring ptr, byval n as integer, byval choices as byte ptr ptr, byval clientData as any ptr, byval style as integer, byval pos as wxPoint ptr) as wxSingleChoiceDialog ptr
declare sub wxSingleChoiceDialog_dtor (byval self as wxSingleChoiceDialog ptr)
declare sub wxSingleChoiceDialog_SetSelection (byval self as wxSingleChoiceDialog ptr, byval sel as integer)
declare function wxSingleChoiceDialog_GetSelection (byval self as wxSingleChoiceDialog ptr) as integer
declare function wxSingleChoiceDialog_GetStringSelection (byval self as wxSingleChoiceDialog ptr) as wxString ptr
declare function wxSingleChoiceDialog_GetSelectionClientData (byval self as wxSingleChoiceDialog ptr) as any ptr

declare function wxMultiChoiceDialog alias "wxMultiChoiceDialog_ctor" (byval parent as wxWindow ptr, byval message as zstring ptr, byval caption as zstring ptr, byval n as integer, byval choices as byte ptr ptr, byval style as integer, byval pos as wxPoint ptr) as wxMultiChoiceDialog ptr
declare sub wxMultiChoiceDialog_dtor (byval self as wxMultiChoiceDialog ptr)
declare sub wxMultiChoiceDialog_SetSelections (byval self as wxMultiChoiceDialog ptr, byval sel as integer ptr ptr, byval numsel as integer)
declare function wxMultiChoiceDialog_GetSelections (byval self as wxMultiChoiceDialog ptr) as wxArrayInt ptr
declare function wxGetSingleChoice_func (byval message as zstring ptr, byval caption as zstring ptr, byval n as integer, byval choices as byte ptr ptr, byval parent as wxWindow ptr, byval x as integer, byval y as integer, byval centre as integer, byval width as integer, byval height as integer) as wxString ptr
declare function wxGetSingleChoiceIndex_func (byval message as zstring ptr, byval caption as zstring ptr, byval n as integer, byval choices as byte ptr ptr, byval parent as wxWindow ptr, byval x as integer, byval y as integer, byval centre as integer, byval width as integer, byval height as integer) as integer

#endif
