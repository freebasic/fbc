#Ifndef __printdata_bi__
#Define __printdata_bi__

#Include Once "common.bi"

Declare Function wxPageSetupDialogData_ctor WXCALL Alias "wxPageSetupDialogData_ctor" () As wxPageSetupDialogData Ptr
Declare Function wxPageSetupDialogData_ctorPrintSetup WXCALL Alias "wxPageSetupDialogData_ctorPrintSetup" (dialogData As wxPageSetupDialogData Ptr) As wxPageSetupDialogData Ptr
Declare Function wxPageSetupDialogData_ctorPrintData WXCALL Alias "wxPageSetupDialogData_ctorPrintData" (printData As wxPrintData Ptr) As wxPageSetupDialogData Ptr
Declare Sub wxPageSetupDialogData_SetPaperSize WXCALL Alias "wxPageSetupDialogData_SetPaperSize" (self As wxPageSetupDialogData Ptr, id As wxPaperSize)
Declare Sub wxPageSetupDialogData_GetPaperSize WXCALL Alias "wxPageSetupDialogData_GetPaperSize" (self As wxPageSetupDialogData Ptr, size As wxSize Ptr)
Declare Sub wxPageSetupDialogData_SetPaperId WXCALL Alias "wxPageSetupDialogData_SetPaperId" (self As wxPageSetupDialogData Ptr, id As wxPaperSize)
Declare Function wxPageSetupDialogData_GetPaperId WXCALL Alias "wxPageSetupDialogData_GetPaperId" (self As wxPageSetupDialogData Ptr) As wxPaperSize Ptr
Declare Sub wxPageSetupDialogData_SetMinMarginTopLeft WXCALL Alias "wxPageSetupDialogData_SetMinMarginTopLeft" (self As wxPageSetupDialogData Ptr, pt As wxPoint Ptr)
Declare Sub wxPageSetupDialogData_GetMinMarginTopLeft WXCALL Alias "wxPageSetupDialogData_GetMinMarginTopLeft" (self As wxPageSetupDialogData Ptr, pt As wxPoint Ptr)
Declare Sub wxPageSetupDialogData_SetMinMarginBottomRight WXCALL Alias "wxPageSetupDialogData_SetMinMarginBottomRight" (self As wxPageSetupDialogData Ptr, pt As wxPoint Ptr)
Declare Sub wxPageSetupDialogData_GetMinMarginBottomRight WXCALL Alias "wxPageSetupDialogData_GetMinMarginBottomRight" (self As wxPageSetupDialogData Ptr, pt As wxPoint Ptr)
Declare Sub wxPageSetupDialogData_SetMarginTopLeft WXCALL Alias "wxPageSetupDialogData_SetMarginTopLeft" (self As wxPageSetupDialogData Ptr, pt As wxPoint Ptr)
Declare Sub wxPageSetupDialogData_GetMarginTopLeft WXCALL Alias "wxPageSetupDialogData_GetMarginTopLeft" (self As wxPageSetupDialogData Ptr, pt As wxPoint Ptr)
Declare Sub wxPageSetupDialogData_SetMarginBottomRight WXCALL Alias "wxPageSetupDialogData_SetMarginBottomRight" (self As wxPageSetupDialogData Ptr, pt As wxPoint Ptr)
Declare Sub wxPageSetupDialogData_GetMarginBottomRight WXCALL Alias "wxPageSetupDialogData_GetMarginBottomRight" (self As wxPageSetupDialogData Ptr, pt As wxPoint Ptr)
Declare Sub wxPageSetupDialogData_SetDefaultMinMargins WXCALL Alias "wxPageSetupDialogData_SetDefaultMinMargins" (self As wxPageSetupDialogData Ptr, flag As wxBool)
Declare Function wxPageSetupDialogData_GetDefaultMinMargins WXCALL Alias "wxPageSetupDialogData_GetDefaultMinMargins" (self As wxPageSetupDialogData Ptr) As wxBool
Declare Sub wxPageSetupDialogData_EnableMargins WXCALL Alias "wxPageSetupDialogData_EnableMargins" (self As wxPageSetupDialogData Ptr, flag As wxBool)
Declare Function wxPageSetupDialogData_GetEnableMargins WXCALL Alias "wxPageSetupDialogData_GetEnableMargins" (self As wxPageSetupDialogData Ptr) As wxBool
Declare Sub wxPageSetupDialogData_EnableOrientation WXCALL Alias "wxPageSetupDialogData_EnableOrientation" (self As wxPageSetupDialogData Ptr, flag As wxBool)
Declare Function wxPageSetupDialogData_GetEnableOrientation WXCALL Alias "wxPageSetupDialogData_GetEnableOrientation" (self As wxPageSetupDialogData Ptr) As wxBool
Declare Sub wxPageSetupDialogData_EnablePaper WXCALL Alias "wxPageSetupDialogData_EnablePaper" (self As wxPageSetupDialogData Ptr, flag As wxBool)
Declare Function wxPageSetupDialogData_GetEnablePaper WXCALL Alias "wxPageSetupDialogData_GetEnablePaper" (self As wxPageSetupDialogData Ptr) As wxBool
Declare Sub wxPageSetupDialogData_EnablePrinter WXCALL Alias "wxPageSetupDialogData_EnablePrinter" (self As wxPageSetupDialogData Ptr, flag As wxBool)
Declare Function wxPageSetupDialogData_GetEnablePrinter WXCALL Alias "wxPageSetupDialogData_GetEnablePrinter" (self As wxPageSetupDialogData Ptr) As wxBool
Declare Sub wxPageSetupDialogData_SetDefaultInfo WXCALL Alias "wxPageSetupDialogData_SetDefaultInfo" (self As wxPageSetupDialogData Ptr, flag As wxBool)
Declare Function wxPageSetupDialogData_GetDefaultInfo WXCALL Alias "wxPageSetupDialogData_GetDefaultInfo" (self As wxPageSetupDialogData Ptr) As wxBool
Declare Sub wxPageSetupDialogData_EnableHelp WXCALL Alias "wxPageSetupDialogData_EnableHelp" (self As wxPageSetupDialogData Ptr, flag As wxBool)
Declare Function wxPageSetupDialogData_GetEnableHelp WXCALL Alias "wxPageSetupDialogData_GetEnableHelp" (self As wxPageSetupDialogData Ptr) As wxBool
Declare Sub wxPageSetupDialogData_SetPrintData WXCALL Alias "wxPageSetupDialogData_SetPrintData" (self As wxPageSetupDialogData Ptr, pd As wxPrintData Ptr)
Declare Function wxPageSetupDialogData_GetPrintData WXCALL Alias "wxPageSetupDialogData_GetPrintData" (self As wxPageSetupDialogData Ptr) As wxPrintData Ptr
Declare Function wxPageSetupDialogData_Ok WXCALL Alias "wxPageSetupDialogData_Ok" (self As wxPageSetupDialogData Ptr) As wxBool
Declare Sub wxPageSetupDialogData_SetPaperSizeSize WXCALL Alias "wxPageSetupDialogData_SetPaperSizeSize" (self As wxPageSetupDialogData Ptr, size As wxSize Ptr)
Declare Sub wxPageSetupDialogData_CalculateIdFromPaperSize WXCALL Alias "wxPageSetupDialogData_CalculateIdFromPaperSize" (self As wxPageSetupDialogData Ptr)
Declare Sub wxPageSetupDialogData_CalculatePaperSizeFromId WXCALL Alias "wxPageSetupDialogData_CalculatePaperSizeFromId" (self As wxPageSetupDialogData Ptr)

' class wxPrintDialogData
Declare Function wxPrintDialogData_ctor WXCALL Alias "wxPrintDialogData_ctor" () As wxPrintDialogData Ptr
Declare Function wxPrintDialogData_ctorDialogData WXCALL Alias "wxPrintDialogData_ctorDialogData" (dialogData As wxPrintDialogData Ptr) As wxPrintDialogData Ptr
Declare Function wxPrintDialogData_ctorPrintData WXCALL Alias "wxPrintDialogData_ctorPrintData" (pd As wxPrintData Ptr) As wxPrintDialogData Ptr
Declare Function wxPrintDialogData_GetFromPage WXCALL Alias "wxPrintDialogData_GetFromPage" (self As wxPrintDialogData Ptr) As wxInt
Declare Function wxPrintDialogData_Ok WXCALL Alias "wxPrintDialogData_Ok" (self As wxPrintDialogData Ptr) As wxBool
Declare Sub wxPrintDialogData_SetToPage WXCALL Alias "wxPrintDialogData_SetToPage" (self As wxPrintDialogData Ptr, iValue As wxInt)
Declare Function wxPrintDialogData_GetToPage WXCALL Alias "wxPrintDialogData_GetToPage" (self As wxPrintDialogData Ptr) As wxInt
Declare Sub wxPrintDialogData_SetMinPage WXCALL Alias "wxPrintDialogData_SetMinPage" (self As wxPrintDialogData Ptr, iValue As wxInt)
Declare Function wxPrintDialogData_GetMinPage WXCALL Alias "wxPrintDialogData_GetMinPage" (self As wxPrintDialogData Ptr) As wxInt
Declare Sub wxPrintDialogData_SetMaxPage WXCALL Alias "wxPrintDialogData_SetMaxPage" (self As wxPrintDialogData Ptr, iValue As wxInt)
Declare Function wxPrintDialogData_GetMaxPage WXCALL Alias "wxPrintDialogData_GetMaxPage" (self As wxPrintDialogData Ptr) As wxInt
Declare Sub wxPrintDialogData_SetNoCopies WXCALL Alias "wxPrintDialogData_SetNoCopies" (self As wxPrintDialogData Ptr, iValue As wxInt)
Declare Function wxPrintDialogData_GetNoCopies WXCALL Alias "wxPrintDialogData_GetNoCopies" (self As wxPrintDialogData Ptr) As wxInt
Declare Sub wxPrintDialogData_SetAllPages WXCALL Alias "wxPrintDialogData_SetAllPages" (self As wxPrintDialogData Ptr, flag As wxBool)
Declare Function wxPrintDialogData_GetAllPages WXCALL Alias "wxPrintDialogData_GetAllPages" (self As wxPrintDialogData Ptr) As wxBool
Declare Sub wxPrintDialogData_SetSelection WXCALL Alias "wxPrintDialogData_SetSelection" (self As wxPrintDialogData Ptr, flag As wxBool)
Declare Function wxPrintDialogData_GetSelection WXCALL Alias "wxPrintDialogData_GetSelection" (self As wxPrintDialogData Ptr) As wxBool
Declare Sub wxPrintDialogData_SetCollate WXCALL Alias "wxPrintDialogData_SetCollate" (self As wxPrintDialogData Ptr, flag As wxBool)
Declare Function wxPrintDialogData_GetCollate WXCALL Alias "wxPrintDialogData_GetCollate" (self As wxPrintDialogData Ptr) As wxBool
Declare Sub wxPrintDialogData_SetPrintToFile WXCALL Alias "wxPrintDialogData_SetPrintToFile" (self As wxPrintDialogData Ptr, flag As wxBool)
Declare Function wxPrintDialogData_GetPrintToFile WXCALL Alias "wxPrintDialogData_GetPrintToFile" (self As wxPrintDialogData Ptr) As wxBool
Declare Sub wxPrintDialogData_EnablePrintToFile WXCALL Alias "wxPrintDialogData_EnablePrintToFile" (self As wxPrintDialogData Ptr, flag As wxBool)
Declare Function wxPrintDialogData_GetEnablePrintToFile WXCALL Alias "wxPrintDialogData_GetEnablePrintToFile" (self As wxPrintDialogData Ptr) As wxBool
Declare Sub wxPrintDialogData_EnableSelection WXCALL Alias "wxPrintDialogData_EnableSelection" (self As wxPrintDialogData Ptr, flag As wxBool)
Declare Function wxPrintDialogData_GetEnableSelection WXCALL Alias "wxPrintDialogData_GetEnableSelection" (self As wxPrintDialogData Ptr) As wxBool
Declare Sub wxPrintDialogData_EnablePageNumbers WXCALL Alias "wxPrintDialogData_EnablePageNumbers" (self As wxPrintDialogData Ptr, flag As wxBool)
Declare Function wxPrintDialogData_GetEnablePageNumbers WXCALL Alias "wxPrintDialogData_GetEnablePageNumbers" (self As wxPrintDialogData Ptr) As wxBool
Declare Sub wxPrintDialogData_EnableHelp WXCALL Alias "wxPrintDialogData_EnableHelp" (self As wxPrintDialogData Ptr, flag As wxBool)
Declare Function wxPrintDialogData_GetEnableHelp WXCALL Alias "wxPrintDialogData_GetEnableHelp" (self As wxPrintDialogData Ptr) As wxBool
Declare Sub wxPrintDialogData_SetPrintData WXCALL Alias "wxPrintDialogData_SetPrintData" (self As wxPrintDialogData Ptr, pd As wxPrintData Ptr)
Declare Function wxPrintDialogData_GetPrintData WXCALL Alias "wxPrintDialogData_GetPrintData" (self As wxPrintDialogData Ptr) As wxPrintData Ptr
Declare Sub wxPrintDialogData_SetFromPage WXCALL Alias "wxPrintDialogData_SetFromPage" (self As wxPrintDialogData Ptr, iValue As wxInt)

' class wxPrintData
Declare Function wxPrintData_ctor WXCALL Alias "wxPrintData_ctor" () As wxPrintData Ptr
Declare Function wxPrintData_ctorPrintData WXCALL Alias "wxPrintData_ctorPrintData" (pd As wxPrintData Ptr) As wxPrintData Ptr
Declare Function wxPrintData_Ok WXCALL Alias "wxPrintData_Ok" (self As wxPrintData Ptr) As wxBool
Declare Sub wxPrintData_SetNoCopies WXCALL Alias "wxPrintData_SetNoCopies" (self As wxPrintData Ptr, nCopies As wxInt)
Declare Function wxPrintData_GetNoCopies WXCALL Alias "wxPrintData_GetNoCopies" (self As wxPrintData Ptr) As wxInt
Declare Sub wxPrintData_SetCollate WXCALL Alias "wxPrintData_SetCollate" (self As wxPrintData Ptr, flag As wxBool)
Declare Function wxPrintData_GetCollate WXCALL Alias "wxPrintData_GetCollate" (self As wxPrintData Ptr) As wxBool
Declare Sub wxPrintData_SetOrientation WXCALL Alias "wxPrintData_SetOrientation" (self As wxPrintData Ptr, orient As wxPrintingOrientation)
Declare Function wxPrintData_GetOrientation WXCALL Alias "wxPrintData_GetOrientation" (self As wxPrintData Ptr) As wxPrintingOrientation
Declare Sub wxPrintData_SetPrinterName WXCALL Alias "wxPrintData_SetPrinterName" (self As wxPrintData Ptr, nam As wxString Ptr)
Declare Function wxPrintData_GetPrinterName WXCALL Alias "wxPrintData_GetPrinterName" (self As wxPrintData Ptr) As wxString Ptr
Declare Sub wxPrintData_SetColour WXCALL Alias "wxPrintData_SetColour" (self As wxPrintData Ptr, flag As wxBool)
Declare Function wxPrintData_GetColour WXCALL Alias "wxPrintData_GetColour" (self As wxPrintData Ptr) As wxBool
Declare Sub wxPrintData_SetDuplex WXCALL Alias "wxPrintData_SetDuplex" (self As wxPrintData Ptr, dup As wxDuplexMode)
Declare Function wxPrintData_GetDuplex WXCALL Alias "wxPrintData_GetDuplex" (self As wxPrintData Ptr) As wxDuplexMode
Declare Sub wxPrintData_SetPaperId WXCALL Alias "wxPrintData_SetPaperId" (self As wxPrintData Ptr, id As wxPaperSize)
Declare Function wxPrintData_GetPaperId WXCALL Alias "wxPrintData_GetPaperId" (self As wxPrintData Ptr) As wxPaperSize
Declare Sub wxPrintData_SetPaperSize WXCALL Alias "wxPrintData_SetPaperSize" (self As wxPrintData Ptr, size As wxSize Ptr)
Declare Sub wxPrintData_GetPaperSize WXCALL Alias "wxPrintData_GetPaperSize" (self As wxPrintData Ptr, size As wxSize Ptr)
Declare Sub wxPrintData_SetQuality WXCALL Alias "wxPrintData_SetQuality" (self As wxPrintData Ptr, qual As wxPrintQuality)
Declare Function wxPrintData_GetQuality WXCALL Alias "wxPrintData_GetQuality" (self As wxPrintData Ptr) As wxPrintQuality
Declare Sub wxPrintData_SetFilename WXCALL Alias "wxPrintData_SetFilename" (self As wxPrintData Ptr, filename As wxString Ptr)
Declare Function wxPrintData_GetFilename WXCALL Alias "wxPrintData_GetFilename" (self As wxPrintData Ptr) As wxString Ptr
Declare Function wxPrintData_GetPrintMode WXCALL Alias "wxPrintData_GetPrintMode" (self As wxPrintData Ptr) As wxPrintMode

#EndIf ' __printdata_bi__

