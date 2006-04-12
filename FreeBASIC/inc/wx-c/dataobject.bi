''
''
'' dataobject -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_dataobject_bi__
#define __wxc_dataobject_bi__

#include once "wx-c/wx.bi"


declare sub wxDataObject_dtor cdecl alias "wxDataObject_dtor" (byval self as wxDataObject ptr)
declare sub wxDataObject_GetPreferredFormat cdecl alias "wxDataObject_GetPreferredFormat" (byval self as wxDataObject ptr, byval dir as integer, byval dataFormat as wxDataFormat ptr)
declare function wxDataObject_GetFormatCount cdecl alias "wxDataObject_GetFormatCount" (byval self as wxDataObject ptr, byval dir as integer) as integer
declare sub wxDataObject_GetAllFormats cdecl alias "wxDataObject_GetAllFormats" (byval self as wxDataObject ptr, byval formats as wxDataFormat ptr, byval dir as integer)
declare function wxDataObject_GetDataSize cdecl alias "wxDataObject_GetDataSize" (byval self as wxDataObject ptr, byval format as wxDataFormat ptr) as integer
declare function wxDataObject_GetDataHere cdecl alias "wxDataObject_GetDataHere" (byval self as wxDataObject ptr, byval format as wxDataFormat ptr, byval buf as any ptr) as integer
declare function wxDataObject_SetData cdecl alias "wxDataObject_SetData" (byval self as wxDataObject ptr, byval format as wxDataFormat ptr, byval len as integer, byval buf as any ptr) as integer
declare function wxDataObject_IsSupported cdecl alias "wxDataObject_IsSupported" (byval self as wxDataObject ptr, byval format as wxDataFormat ptr, byval dir as integer) as integer
declare function wxDataObjectSimple cdecl alias "wxDataObjectSimple_ctor" (byval format as wxDataFormat ptr) as wxDataObjectSimple ptr
declare sub wxDataObjectSimple_dtor cdecl alias "wxDataObjectSimple_dtor" (byval self as wxDataObjectSimple ptr)
declare sub wxDataObjectSimple_SetFormat cdecl alias "wxDataObjectSimple_SetFormat" (byval self as wxDataObjectSimple ptr, byval format as wxDataFormat ptr)
declare function wxDataObjectSimple_GetDataSize cdecl alias "wxDataObjectSimple_GetDataSize" (byval self as wxDataObjectSimple ptr) as integer
declare function wxDataObjectSimple_GetDataHere cdecl alias "wxDataObjectSimple_GetDataHere" (byval self as wxDataObjectSimple ptr, byval buf as any ptr) as integer
declare function wxDataObjectSimple_SetData cdecl alias "wxDataObjectSimple_SetData" (byval self as wxDataObjectSimple ptr, byval len as integer, byval buf as any ptr) as integer

declare function wxTextDataObject cdecl alias "wxTextDataObject_ctor" (byval text as zstring ptr) as wxTextDataObject ptr
declare sub wxTextDataObject_dtor cdecl alias "wxTextDataObject_dtor" (byval self as wxTextDataObject ptr)
declare sub wxTextDataObject_RegisterDisposable cdecl alias "wxTextDataObject_RegisterDisposable" (byval self as _TextDataObject ptr, byval onDispose as Virtual_Dispose)
declare function wxTextDataObject_GetTextLength cdecl alias "wxTextDataObject_GetTextLength" (byval self as wxTextDataObject ptr) as integer
declare function wxTextDataObject_GetText cdecl alias "wxTextDataObject_GetText" (byval self as wxTextDataObject ptr) as wxString ptr
declare sub wxTextDataObject_SetText cdecl alias "wxTextDataObject_SetText" (byval self as wxTextDataObject ptr, byval text as zstring ptr)

declare function wxFileDataObject cdecl alias "wxFileDataObject_ctor" () as wxFileDataObject ptr
declare sub wxFileDataObject_dtor cdecl alias "wxFileDataObject_dtor" (byval self as wxFileDataObject ptr)
declare sub wxFileDataObject_RegisterDisposable cdecl alias "wxFileDataObject_RegisterDisposable" (byval self as _FileDataObject ptr, byval onDispose as Virtual_Dispose)
declare sub wxFileDataObject_AddFile cdecl alias "wxFileDataObject_AddFile" (byval self as wxFileDataObject ptr, byval filename as zstring ptr)
declare function wxFileDataObject_GetFilenames cdecl alias "wxFileDataObject_GetFilenames" (byval self as wxFileDataObject ptr) as wxArrayString ptr

#endif
