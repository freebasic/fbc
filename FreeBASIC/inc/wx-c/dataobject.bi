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

#include once "wx.bi"


declare sub wxDataObject_dtor (byval self as wxDataObject ptr)
declare sub wxDataObject_GetPreferredFormat (byval self as wxDataObject ptr, byval dir as integer, byval dataFormat as wxDataFormat ptr)
declare function wxDataObject_GetFormatCount (byval self as wxDataObject ptr, byval dir as integer) as integer
declare sub wxDataObject_GetAllFormats (byval self as wxDataObject ptr, byval formats as wxDataFormat ptr, byval dir as integer)
declare function wxDataObject_GetDataSize (byval self as wxDataObject ptr, byval format as wxDataFormat ptr) as integer
declare function wxDataObject_GetDataHere (byval self as wxDataObject ptr, byval format as wxDataFormat ptr, byval buf as any ptr) as integer
declare function wxDataObject_SetData (byval self as wxDataObject ptr, byval format as wxDataFormat ptr, byval len as integer, byval buf as any ptr) as integer
declare function wxDataObject_IsSupported (byval self as wxDataObject ptr, byval format as wxDataFormat ptr, byval dir as integer) as integer
declare function wxDataObjectSimple alias "wxDataObjectSimple_ctor" (byval format as wxDataFormat ptr) as wxDataObjectSimple ptr
declare sub wxDataObjectSimple_dtor (byval self as wxDataObjectSimple ptr)
declare sub wxDataObjectSimple_SetFormat (byval self as wxDataObjectSimple ptr, byval format as wxDataFormat ptr)
declare function wxDataObjectSimple_GetDataSize (byval self as wxDataObjectSimple ptr) as integer
declare function wxDataObjectSimple_GetDataHere (byval self as wxDataObjectSimple ptr, byval buf as any ptr) as integer
declare function wxDataObjectSimple_SetData (byval self as wxDataObjectSimple ptr, byval len as integer, byval buf as any ptr) as integer

declare function wxTextDataObject alias "wxTextDataObject_ctor" (byval text as zstring ptr) as wxTextDataObject ptr
declare sub wxTextDataObject_dtor (byval self as wxTextDataObject ptr)
declare sub wxTextDataObject_RegisterDisposable (byval self as _TextDataObject ptr, byval onDispose as Virtual_Dispose)
declare function wxTextDataObject_GetTextLength (byval self as wxTextDataObject ptr) as integer
declare function wxTextDataObject_GetText (byval self as wxTextDataObject ptr) as wxString ptr
declare sub wxTextDataObject_SetText (byval self as wxTextDataObject ptr, byval text as zstring ptr)

declare function wxFileDataObject alias "wxFileDataObject_ctor" () as wxFileDataObject ptr
declare sub wxFileDataObject_dtor (byval self as wxFileDataObject ptr)
declare sub wxFileDataObject_RegisterDisposable (byval self as _FileDataObject ptr, byval onDispose as Virtual_Dispose)
declare sub wxFileDataObject_AddFile (byval self as wxFileDataObject ptr, byval filename as zstring ptr)
declare function wxFileDataObject_GetFilenames (byval self as wxFileDataObject ptr) as wxArrayString ptr

#endif
