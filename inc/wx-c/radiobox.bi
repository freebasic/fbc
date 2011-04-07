''
''
'' radiobox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_radiobox_bi__
#define __wxc_radiobox_bi__

#include once "wx.bi"


declare function wxRadioBox alias "wxRadioBox_ctor" () as wxRadioBox ptr
declare function wxRadioBox_Create (byval self as wxRadioBox ptr, byval parent as wxWindow ptr, byval id as integer, byval label as zstring ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval n as integer, byval choices as byte ptr ptr, byval majorDimension as integer, byval style as integer, byval val as wxValidator ptr, byval name as zstring ptr) as integer
declare sub wxRadioBox_SetSelection (byval self as wxRadioBox ptr, byval n as integer)
declare function wxRadioBox_GetSelection (byval self as wxRadioBox ptr) as integer
declare function wxRadioBox_GetStringSelection (byval self as wxRadioBox ptr) as wxString ptr
declare function wxRadioBox_SetStringSelection (byval self as wxRadioBox ptr, byval s as zstring ptr) as integer
declare function wxRadioBox_GetCount (byval self as wxRadioBox ptr) as integer
declare function wxRadioBox_FindString (byval self as wxRadioBox ptr, byval s as zstring ptr) as integer
declare function wxRadioBox_GetString (byval self as wxRadioBox ptr, byval n as integer) as wxString ptr
declare sub wxRadioBox_SetString (byval self as wxRadioBox ptr, byval n as integer, byval label as zstring ptr)
declare sub wxRadioBox_Enable (byval self as wxRadioBox ptr, byval n as integer, byval enable as integer)
declare sub wxRadioBox_Show (byval self as wxRadioBox ptr, byval n as integer, byval show as integer)
declare function wxRadioBox_GetLabel (byval self as wxRadioBox ptr) as wxString ptr
declare sub wxRadioBox_SetLabel (byval self as wxRadioBox ptr, byval label as zstring ptr)

#endif
