''
''
'' imagelist -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_imagelist_bi__
#define __wxc_imagelist_bi__

#include once "wx.bi"

declare function wxImageList alias "wxImageList_ctor" (byval width as integer, byval height as integer, byval mask as integer, byval initialCount as integer) as wxImageList ptr
declare function wxImageList_ctor2 () as wxImageList ptr
declare function wxImageList_AddBitmap1 (byval self as wxImageList ptr, byval bmp as wxBitmap ptr, byval mask as wxBitmap ptr) as integer
declare function wxImageList_AddBitmap (byval self as wxImageList ptr, byval bmp as wxBitmap ptr, byval maskColour as wxColour ptr) as integer
declare function wxImageList_AddIcon (byval self as wxImageList ptr, byval icon as wxIcon ptr) as integer
declare function wxImageList_GetImageCount (byval self as wxImageList ptr) as integer
declare function wxImageList_Draw (byval self as wxImageList ptr, byval index as integer, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval flags as integer, byval solidBackground as integer) as integer
declare function wxImageList_Create (byval self as wxImageList ptr, byval width as integer, byval height as integer, byval mask as integer, byval initialCount as integer) as integer
declare function wxImageList_Replace (byval self as wxImageList ptr, byval index as integer, byval bitmap as wxBitmap ptr) as integer
declare function wxImageList_Remove (byval self as wxImageList ptr, byval index as integer) as integer
declare function wxImageList_RemoveAll (byval self as wxImageList ptr) as integer
declare function wxImageList_GetSize (byval self as wxImageList ptr, byval index as integer, byval width as integer ptr, byval height as integer ptr) as integer

#endif
