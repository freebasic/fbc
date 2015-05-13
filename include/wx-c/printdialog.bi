#Ifndef __printdialog_bi__
#Define __printdialog_bi__

#Include Once "common.bi"

' class wxPageSetupDialog
Declare Function wxPageSetupDialog_ctor WXCALL Alias "wxPageSetupDialog_ctor" (parent As wxWindow Ptr,setupdata As wxPageSetupData Ptr) As wxPageSetupDialog Ptr
Declare Function wxPageSetupDialog_GetPageSetupData WXCALL Alias "wxPageSetupDialog_GetPageSetupData" (self As wxPageSetupDialog Ptr) As wxPageSetupData Ptr
Declare Function wxPageSetupDialog_ShowModal WXCALL Alias "wxPageSetupDialog_ShowModal" (self As wxPageSetupDialog Ptr) As wxInt

' class wxPrintDialog
Declare Function wxPrintDialog_ctor WXCALL Alias "wxPrintDialog_ctor" (parent As wxWindow Ptr, dialogdata As wxPrintDialogData Ptr) As wxPrintDialog Ptr
Declare Function wxPrintDialog_ctorPrintData WXCALL Alias "wxPrintDialog_ctorPrintData" (parent As wxWindow Ptr, printdata As wxPrintData Ptr) As wxPrintDialog Ptr
Declare Function wxPrintDialog_ShowModal WXCALL Alias "wxPrintDialog_ShowModal" (self As wxPrintDialog Ptr) As wxInt
Declare Function wxPrintDialog_GetPrintData WXCALL Alias "wxPrintDialog_GetPrintData" (self As wxPrintDialog Ptr) As wxPrintData Ptr
Declare Function wxPrintDialog_GetPrintDialogData WXCALL Alias "wxPrintDialog_GetPrintDialogData" (self As wxPrintDialog Ptr) As wxPrintDialogData Ptr
Declare Function wxPrintDialog_GetPrintDC WXCALL Alias "wxPrintDialog_GetPrintDC" (self As wxPrintDialog Ptr) As wxDC Ptr

' todo: is it a GTK only dialog ?
#Ifdef __FB_LINUX__
Declare Function wxPrintSetupDialog_ctorPrintData WXCALL Alias "wxPrintSetupDialog_ctorPrintData" (parent As wxWindow Ptr, printdata As wxPrintData Ptr) As wxPrintSetupDialog Ptr
Declare Function wxPrintSetupDialog_ctor WXCALL Alias "wxPrintSetupDialog_ctor" (parent As wxWindow Ptr, setupdata As wxPrintSetupData Ptr) As wxPrintSetupDialog Ptr
Declare Sub wxPrintSetupDialog_Init WXCALL Alias "wxPrintSetupDialog_Init" (self As wxPrintSetupDialog Ptr, printdata As wxPrintData Ptr)
Declare Function wxPrintSetupDialog_TransferDataFromWindow WXCALL Alias "wxPrintSetupDialog_TransferDataFromWindow" (self As wxPrintSetupDialog Ptr) As wxBool 
Declare Function wxPrintSetupDialog_TransferDataToWindow WXCALL Alias "wxPrintSetupDialog_TransferDataToWindow" (self As wxPrintSetupDialog Ptr) As wxBool
Declare Function wxPrintSetupDialog_GetPrintData WXCALL Alias "wxPrintSetupDialog_GetPrintData" (self As wxPrintSetupDialog Ptr) As wxPrintData Ptr
#EndIf ' __FB_LINUX__

#EndIf '__printdialog_bi__


