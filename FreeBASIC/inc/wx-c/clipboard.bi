''
''
'' clipboard -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_clipboard_bi__
#define __wxc_clipboard_bi__

#include once "wx-c/wx.bi"

declare function wxClipboard cdecl alias "wxClipboard_ctor" () as wxClipboard ptr
declare function wxClipboard_Open cdecl alias "wxClipboard_Open" (byval self as wxClipboard ptr) as integer
declare sub wxClipboard_Close cdecl alias "wxClipboard_Close" (byval self as wxClipboard ptr)
declare function wxClipboard_IsOpened cdecl alias "wxClipboard_IsOpened" (byval self as wxClipboard ptr) as integer
declare function wxClipboard_AddData cdecl alias "wxClipboard_AddData" (byval self as wxClipboard ptr, byval data as wxDataObject ptr) as integer
declare function wxClipboard_SetData cdecl alias "wxClipboard_SetData" (byval self as wxClipboard ptr, byval data as wxDataObject ptr) as integer
declare function wxClipboard_IsSupported cdecl alias "wxClipboard_IsSupported" (byval self as wxClipboard ptr, byval format as wxDataFormat ptr) as integer
declare function wxClipboard_GetData cdecl alias "wxClipboard_GetData" (byval self as wxClipboard ptr, byval data as wxDataObject ptr) as integer
declare sub wxClipboard_Clear cdecl alias "wxClipboard_Clear" (byval self as wxClipboard ptr)
declare function wxClipboard_Flush cdecl alias "wxClipboard_Flush" (byval self as wxClipboard ptr) as integer
declare sub wxClipboard_UsePrimarySelection cdecl alias "wxClipboard_UsePrimarySelection" (byval self as wxClipboard ptr, byval primary as integer)
declare function wxTheClipboard_static cdecl alias "wxTheClipboard_static" () as wxClipboard ptr
declare function wxClipBoardLocker cdecl alias "wxClipBoardLocker_ctor" (byval clipboard as wxClipboard ptr) as wxClipboardLocker ptr
declare sub wxClipBoardLocker_dtor cdecl alias "wxClipBoardLocker_dtor" (byval self as wxClipboardLocker ptr)
declare function wxClipboardLocker_IsOpen cdecl alias "wxClipboardLocker_IsOpen" (byval self as wxClipboardLocker ptr) as integer

#endif
