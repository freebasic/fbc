''
''
'' imagelist -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __imagelist_bi__
#define __imagelist_bi__

#include once "wx-c/wx.bi"

declare function wxImageList cdecl alias "wxImageList_ctor" (byval width as integer, byval height as integer, byval mask as integer, byval initialCount as integer) as wxImageList ptr
declare function wxImageList_ctor2 cdecl alias "wxImageList_ctor2" () as wxImageList ptr
declare function wxImageList_AddBitmap1 cdecl alias "wxImageList_AddBitmap1" (byval self as wxImageList ptr, byval bmp as wxBitmap ptr, byval mask as wxBitmap ptr) as integer
declare function wxImageList_AddBitmap cdecl alias "wxImageList_AddBitmap" (byval self as wxImageList ptr, byval bmp as wxBitmap ptr, byval maskColour as wxColour ptr) as integer
declare function wxImageList_AddIcon cdecl alias "wxImageList_AddIcon" (byval self as wxImageList ptr, byval icon as wxIcon ptr) as integer
declare function wxImageList_GetImageCount cdecl alias "wxImageList_GetImageCount" (byval self as wxImageList ptr) as integer
declare function wxImageList_Draw cdecl alias "wxImageList_Draw" (byval self as wxImageList ptr, byval index as integer, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval flags as integer, byval solidBackground as integer) as integer
declare function wxImageList_Create cdecl alias "wxImageList_Create" (byval self as wxImageList ptr, byval width as integer, byval height as integer, byval mask as integer, byval initialCount as integer) as integer
declare function wxImageList_Replace cdecl alias "wxImageList_Replace" (byval self as wxImageList ptr, byval index as integer, byval bitmap as wxBitmap ptr) as integer
declare function wxImageList_Remove cdecl alias "wxImageList_Remove" (byval self as wxImageList ptr, byval index as integer) as integer
declare function wxImageList_RemoveAll cdecl alias "wxImageList_RemoveAll" (byval self as wxImageList ptr) as integer
declare function wxImageList_GetSize cdecl alias "wxImageList_GetSize" (byval self as wxImageList ptr, byval index as integer, byval width as integer ptr, byval height as integer ptr) as integer

#endif
