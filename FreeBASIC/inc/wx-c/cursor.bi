''
''
'' cursor -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_cursor_bi__
#define __wxc_cursor_bi__

#include once "wx-c/wx.bi"

declare function wxCursor_ctorImage cdecl alias "wxCursor_ctorImage" (byval image as wxImage ptr) as wxCursor ptr
declare function wxCursor_ctorCopy cdecl alias "wxCursor_ctorCopy" (byval cursor as wxCursor ptr) as wxCursor ptr
declare function wxCursor_ctorById cdecl alias "wxCursor_ctorById" (byval id as integer) as wxCursor ptr
declare function wxCursor_Ok cdecl alias "wxCursor_Ok" (byval self as wxCursor ptr) as integer
declare sub wxCursor_SetCursor cdecl alias "wxCursor_SetCursor" (byval cursor as wxCursor ptr)

#endif
