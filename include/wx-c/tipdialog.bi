''
''
'' tipdialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_tipdialog_bi__
#define __wxc_tipdialog_bi__

#include once "wx.bi"


declare function wxTipProvider_GetCurrentTip () as integer
declare function wxCreateFileTipProvider_func (byval filename as zstring ptr, byval currentTip as integer) as wxTipProvider ptr
declare function wxShowTip_func (byval parent as wxWindow ptr, byval tipProvider as wxTipProvider ptr, byval showAtStartup as integer) as integer

#endif
