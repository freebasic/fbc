''
''
'' wxdatetime -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_wxdatetime_bi__
#define __wxc_wxdatetime_bi__

#include once "wx.bi"

declare function wxDateTime alias "wxDateTime_ctor" () as wxDateTime ptr
declare sub wxDateTime_dtor (byval self as wxDateTime ptr)
declare sub wxDateTime_Set (byval self as wxDateTime ptr, byval day as ushort, byval month as integer, byval year as integer, byval hour as ushort, byval minute as ushort, byval second as ushort, byval millisec as ushort)
declare function wxDateTime_GetYear (byval self as wxDateTime ptr) as ushort
declare function wxDateTime_GetMonth (byval self as wxDateTime ptr) as integer
declare function wxDateTime_GetDay (byval self as wxDateTime ptr) as ushort
declare function wxDateTime_GetHour (byval self as wxDateTime ptr) as ushort
declare function wxDateTime_GetMinute (byval self as wxDateTime ptr) as ushort
declare function wxDateTime_GetSecond (byval self as wxDateTime ptr) as ushort
declare function wxDateTime_GetMillisecond (byval self as wxDateTime ptr) as ushort

#endif
