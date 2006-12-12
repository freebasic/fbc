''
''
'' dataformat -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_dataformat_bi__
#define __wxc_dataformat_bi__

#include once "wx.bi"

declare function wxDataFormat alias "wxDataFormat_ctor" () as wxDataFormat ptr
declare sub wxDataFormat_dtor (byval self as wxDataFormat ptr)
declare function wxDataFormat_ctorByType (byval type as wxDataFormatId) as wxDataFormat ptr
declare function wxDataFormat_ctorById (byval id as zstring ptr) as wxDataFormat ptr
declare function wxDataFormat_GetId (byval self as wxDataFormat ptr) as wxString ptr
declare sub wxDataFormat_SetId (byval self as wxDataFormat ptr, byval id as zstring ptr)
declare function wxDataFormat_GetType (byval self as wxDataFormat ptr) as wxDataFormatId
declare sub wxDataFormat_SetType (byval self as wxDataFormat ptr, byval type as wxDataFormatId)

#endif
