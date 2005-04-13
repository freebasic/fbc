''
''
'' dataformat -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __dataformat_bi__
#define __dataformat_bi__

#include once "wx-c/wx.bi"

declare function wxDataFormat cdecl alias "wxDataFormat_ctor" () as wxDataFormat ptr
declare sub wxDataFormat_dtor cdecl alias "wxDataFormat_dtor" (byval self as wxDataFormat ptr)
declare function wxDataFormat_ctorByType cdecl alias "wxDataFormat_ctorByType" (byval type as wxDataFormatId) as wxDataFormat ptr
declare function wxDataFormat_ctorById cdecl alias "wxDataFormat_ctorById" (byval id as string) as wxDataFormat ptr
declare function wxDataFormat_GetId cdecl alias "wxDataFormat_GetId" (byval self as wxDataFormat ptr) as wxString ptr
declare sub wxDataFormat_SetId cdecl alias "wxDataFormat_SetId" (byval self as wxDataFormat ptr, byval id as string)
declare function wxDataFormat_GetType cdecl alias "wxDataFormat_GetType" (byval self as wxDataFormat ptr) as wxDataFormatId
declare sub wxDataFormat_SetType cdecl alias "wxDataFormat_SetType" (byval self as wxDataFormat ptr, byval type as wxDataFormatId)

#endif
