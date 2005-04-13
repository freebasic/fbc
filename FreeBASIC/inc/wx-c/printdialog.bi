''
''
'' printdialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __printdialog_bi__
#define __printdialog_bi__

#include once "wx-c/wx.bi"


declare function wxPageSetupDialog cdecl alias "wxPageSetupDialog_ctor" (byval parent as wxWindow ptr, byval data as wxPageSetupData ptr) as wxPageSetupDialog ptr
declare function wxPageSetupDialog_GetPageSetupData cdecl alias "wxPageSetupDialog_GetPageSetupData" (byval self as wxPageSetupDialog ptr) as wxPageSetupData ptr

declare function wxPrintDialog cdecl alias "wxPrintDialog_ctor" (byval parent as wxWindow ptr, byval data as wxPrintDialogData ptr) as wxPrintDialog ptr
declare function wxPrintDialog_ctorPrintData cdecl alias "wxPrintDialog_ctorPrintData" (byval parent as wxWindow ptr, byval data as wxPrintData ptr) as wxPrintDialog ptr
declare function wxPrintDialog_ShowModal cdecl alias "wxPrintDialog_ShowModal" (byval self as wxPrintDialog ptr) as integer
declare function wxPrintDialog_GetPrintData cdecl alias "wxPrintDialog_GetPrintData" (byval self as wxPrintDialog ptr) as wxPrintData ptr
declare function wxPrintDialog_GetPrintDialogData cdecl alias "wxPrintDialog_GetPrintDialogData" (byval self as wxPrintDialog ptr) as wxPrintDialogData ptr
declare function wxPrintDialog_GetPrintDC cdecl alias "wxPrintDialog_GetPrintDC" (byval self as wxPrintDialog ptr) as wxDC ptr

#endif
