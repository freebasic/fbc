''
''
'' printdialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_printdialog_bi__
#define __wxc_printdialog_bi__

#include once "wx.bi"


declare function wxPageSetupDialog alias "wxPageSetupDialog_ctor" (byval parent as wxWindow ptr, byval data as wxPageSetupData ptr) as wxPageSetupDialog ptr
declare function wxPageSetupDialog_GetPageSetupData (byval self as wxPageSetupDialog ptr) as wxPageSetupData ptr

declare function wxPrintDialog alias "wxPrintDialog_ctor" (byval parent as wxWindow ptr, byval data as wxPrintDialogData ptr) as wxPrintDialog ptr
declare function wxPrintDialog_ctorPrintData (byval parent as wxWindow ptr, byval data as wxPrintData ptr) as wxPrintDialog ptr
declare function wxPrintDialog_ShowModal (byval self as wxPrintDialog ptr) as integer
declare function wxPrintDialog_GetPrintData (byval self as wxPrintDialog ptr) as wxPrintData ptr
declare function wxPrintDialog_GetPrintDialogData (byval self as wxPrintDialog ptr) as wxPrintDialogData ptr
declare function wxPrintDialog_GetPrintDC (byval self as wxPrintDialog ptr) as wxDC ptr

#endif
