''
''
'' filedialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_filedialog_bi__
#define __wxc_filedialog_bi__

#include once "wx.bi"

declare function wxFileDialog alias "wxFileDialog_ctor" (byval parent as wxWindow ptr, byval message as zstring ptr, byval defaultDir as zstring ptr, byval defaultFile as zstring ptr, byval wildcard as zstring ptr, byval style as integer, byval pos as wxPoint ptr) as wxFileDialog ptr
declare sub wxFileDialog_dtor (byval self as wxFileDialog ptr)
declare function wxFileDialog_ShowModal (byval self as wxFileDialog ptr) as integer
declare function wxFileDialog_GetDirectory (byval self as wxFileDialog ptr) as wxString ptr
declare sub wxFileDialog_SetDirectory (byval self as wxFileDialog ptr, byval dir as zstring ptr)
declare function wxFileDialog_GetFilename (byval self as wxFileDialog ptr) as wxString ptr
declare sub wxFileDialog_SetFilename (byval self as wxFileDialog ptr, byval filename as zstring ptr)
declare function wxFileDialog_GetPath (byval self as wxFileDialog ptr) as wxString ptr
declare sub wxFileDialog_SetPath (byval self as wxFileDialog ptr, byval path as zstring ptr)
declare sub wxFileDialog_SetFilterIndex (byval self as wxFileDialog ptr, byval filterindex as integer)
declare function wxFileDialog_GetFilterIndex (byval self as wxFileDialog ptr) as integer
declare sub wxFileDialog_SetMessage (byval self as wxFileDialog ptr, byval message as zstring ptr)
declare function wxFileDialog_GetMessage (byval self as wxFileDialog ptr) as wxString ptr
declare function wxFileDialog_GetWildcard (byval self as wxFileDialog ptr) as wxString ptr
declare sub wxFileDialog_SetWildcard (byval self as wxFileDialog ptr, byval wildcard as zstring ptr)
declare sub wxFileDialog_SetStyle (byval self as wxFileDialog ptr, byval style as integer)
declare function wxFileDialog_GetStyle (byval self as wxFileDialog ptr) as integer
declare function wxFileDialog_GetPaths (byval self as wxFileDialog ptr) as wxArrayString ptr
declare function wxFileDialog_GetFilenames (byval self as wxFileDialog ptr) as wxArrayString ptr

#endif
