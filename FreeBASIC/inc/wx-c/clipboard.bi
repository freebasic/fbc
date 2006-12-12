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

#include once "wx.bi"

declare function wxClipboard alias "wxClipboard_ctor" () as wxClipboard ptr
declare function wxClipboard_Open (byval self as wxClipboard ptr) as integer
declare sub wxClipboard_Close (byval self as wxClipboard ptr)
declare function wxClipboard_IsOpened (byval self as wxClipboard ptr) as integer
declare function wxClipboard_AddData (byval self as wxClipboard ptr, byval data as wxDataObject ptr) as integer
declare function wxClipboard_SetData (byval self as wxClipboard ptr, byval data as wxDataObject ptr) as integer
declare function wxClipboard_IsSupported (byval self as wxClipboard ptr, byval format as wxDataFormat ptr) as integer
declare function wxClipboard_GetData (byval self as wxClipboard ptr, byval data as wxDataObject ptr) as integer
declare sub wxClipboard_Clear (byval self as wxClipboard ptr)
declare function wxClipboard_Flush (byval self as wxClipboard ptr) as integer
declare sub wxClipboard_UsePrimarySelection (byval self as wxClipboard ptr, byval primary as integer)
declare function wxTheClipboard_static () as wxClipboard ptr
declare function wxClipBoardLocker (byval clipboard as wxClipboard ptr) as wxClipboardLocker ptr
declare sub wxClipBoardLocker_dtor (byval self as wxClipboardLocker ptr)
declare function wxClipboardLocker_IsOpen (byval self as wxClipboardLocker ptr) as integer

#endif
