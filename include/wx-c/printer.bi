#Ifndef __printer_bi__
#Define __printer_bi__

#Include Once "common.bi"

' Virtual method delegate pointer types
Type Virtual_NoParams        As Sub      WXCALL 
Type Virtual_ParamsInt       As Function WXCALL (As wxInt) As wxBool
Type Virtual_OnBeginDocument As Function WXCALL (startPage As wxInt, endPage As wxInt) As wxBool
Type Virtual_GetPageInfo     As Sub      WXCALL (minPage As wxInt Ptr, maxPage As wxInt Ptr, pageFrom As wxInt Ptr, pageTo As wxInt Ptr)

' class wxPrinter
Declare Function wxPrinter_ctor WXCALL Alias "wxPrinter_ctor" (dialogdata As wxPrintDialogData Ptr) As wxPrinter Ptr
Declare Function wxPrinter_CreateAbortWindow WXCALL Alias "wxPrinter_CreateAbortWindow" (self As wxPrinter Ptr, parent As wxWindow Ptr, printout As wxPrintout Ptr) As wxWindow Ptr
Declare Sub wxPrinter_ReportError WXCALL Alias "wxPrinter_ReportError" (self As wxPrinter Ptr, parent As wxWindow Ptr, printout As wxPrintout Ptr, message As wxString Ptr)
Declare Function wxPrinter_GetPrintDialogData WXCALL Alias "wxPrinter_GetPrintDialogData" (self As wxPrinter Ptr) As wxPrintDialogData Ptr
Declare Function wxPrinter_GetAbort WXCALL Alias "wxPrinter_GetAbort" (self As wxPrinter Ptr) As wxBool
Declare Function wxPrinter_GetLastError WXCALL Alias "wxPrinter_GetLastError" (self As wxPrinter Ptr) As wxPrinterError
Declare Function wxPrinter_Setup WXCALL Alias "wxPrinter_Setup" (self As wxPrinter Ptr, parent As wxWindow Ptr) As wxBool
Declare Function wxPrinter_Print WXCALL Alias "wxPrinter_Print" (self As wxPrinter Ptr, parent As wxWindow Ptr, printout As wxPrintout Ptr, prompt As wxBool) As wxBool
Declare Function wxPrinter_PrintDialog WXCALL Alias "wxPrinter_PrintDialog" (self As wxPrinter Ptr, parent As wxWindow Ptr) As wxDC Ptr

' class wxPrintout
Declare Function wxPrintout_ctor WXCALL Alias "wxPrintout_ctor" (titleArg As wxString Ptr) As wxPrintout Ptr
Declare Sub wxPrintout_RegisterVirtual WXCALL Alias "wxPrintout_RegisterVirtual" (self As wxPrintout Ptr, _
                                onBeginDocument   As Virtual_OnBeginDocument, _
                                onEndDocument     As Virtual_NoParams , _
                                onBeginPrinting   As Virtual_NoParams , _
                                onEndPrinting     As Virtual_NoParams ,_
                                onPreparePrinting As Virtual_NoParams, _
                                hasPage           As Virtual_ParamsInt,_
                                onPrintPage       As Virtual_ParamsInt, _
                                getPageInfo       As Virtual_GetPageInfo)
Declare Function wxPrintout_OnBeginDocument WXCALL Alias "wxPrintout_OnBeginDocument" (self As wxPrintout Ptr, startPage As wxInt, endPage As wxInt) As wxBool
Declare Sub wxPrintout_OnEndDocument WXCALL Alias "wxPrintout_OnEndDocument" (self As wxPrintout Ptr)
Declare Sub wxPrintout_OnBeginPrinting WXCALL Alias "wxPrintout_OnBeginPrinting" (self As wxPrintout Ptr)
Declare Sub wxPrintout_OnEndPrinting WXCALL Alias "wxPrintout_OnEndPrinting" (self As wxPrintout Ptr)
Declare Sub wxPrintout_OnPreparePrinting WXCALL Alias "wxPrintout_OnPreparePrinting" (self As wxPrintout Ptr)
Declare Function wxPrintout_HasPage WXCALL Alias "wxPrintout_HasPage" (self As wxPrintout Ptr, page As wxInt) As wxBool
Declare Sub wxPrintout_GetPageInfo WXCALL Alias "wxPrintout_GetPageInfo" (self As wxPrintout Ptr, minPage As wxInt Ptr, maxPage As wxInt Ptr, pageFrom As wxInt Ptr, pageTo As wxInt Ptr)
Declare Function wxPrintout_GetTitle WXCALL Alias "wxPrintout_GetTitle" (self As wxPrintout Ptr) As wxString Ptr
Declare Function wxPrintout_GetDC WXCALL Alias "wxPrintout_GetDC" (self As wxPrintout Ptr) As wxDC Ptr
Declare Sub wxPrintout_SetDC WXCALL Alias "wxPrintout_SetDC" (self As wxPrintout Ptr, dc As wxDC Ptr)
Declare Sub wxPrintout_SetPageSizePixels WXCALL Alias "wxPrintout_SetPageSizePixels" (self As wxPrintout Ptr, w As wxInt, h As wxInt)
Declare Sub wxPrintout_GetPageSizePixels WXCALL Alias "wxPrintout_GetPageSizePixels" (self As wxPrintout Ptr, w As wxInt Ptr, h As wxInt Ptr)
Declare Sub wxPrintout_SetPageSizeMM WXCALL Alias "wxPrintout_SetPageSizeMM" (self As wxPrintout Ptr, w As wxInt, h As wxInt)
Declare Sub wxPrintout_GetPageSizeMM WXCALL Alias "wxPrintout_GetPageSizeMM" (self As wxPrintout Ptr, w As wxInt Ptr, h As wxInt Ptr)
Declare Sub wxPrintout_SetPPIScreen WXCALL Alias "wxPrintout_SetPPIScreen" (self As wxPrintout Ptr, x As wxInt, y As wxInt)
Declare Sub wxPrintout_GetPPIScreen WXCALL Alias "wxPrintout_GetPPIScreen" (self As wxPrintout Ptr, x As wxInt Ptr, y As wxInt Ptr)
Declare Sub wxPrintout_SetPPIPrinter WXCALL Alias "wxPrintout_SetPPIPrinter" (self As wxPrintout Ptr, x As wxInt, y As wxInt)
Declare Sub wxPrintout_GetPPIPrinter WXCALL Alias "wxPrintout_GetPPIPrinter" (self As wxPrintout Ptr, x As wxInt Ptr, y As wxInt Ptr)
Declare Function wxPrintout_IsPreview WXCALL Alias "wxPrintout_IsPreview" (self As wxPrintout Ptr) As wxBool
Declare Sub wxPrintout_SetIsPreview WXCALL Alias "wxPrintout_SetIsPreview" (self As wxPrintout Ptr, flag As wxBool)

#EndIf ' __printer_bi__

