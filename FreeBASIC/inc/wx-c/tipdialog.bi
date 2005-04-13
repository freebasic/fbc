''
''
'' tipdialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __tipdialog_bi__
#define __tipdialog_bi__

#include once "wx-c/wx.bi"


declare function wxTipProvider_GetCurrentTip cdecl alias "wxTipProvider_GetCurrentTip" () as integer
declare function wxCreateFileTipProvider_func cdecl alias "wxCreateFileTipProvider_func" (byval filename as string, byval currentTip as integer) as wxTipProvider ptr
declare function wxShowTip_func cdecl alias "wxShowTip_func" (byval parent as wxWindow ptr, byval tipProvider as wxTipProvider ptr, byval showAtStartup as integer) as integer

#endif
