''
''
'' printdata -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __printdata_bi__
#define __printdata_bi__

#include once "wx-c/wx.bi"

declare function wxPageSetupDialogData cdecl alias "wxPageSetupDialogData_ctor" () as wxPageSetupDialogData ptr
declare function wxPageSetupDialogData_ctorPrintSetup cdecl alias "wxPageSetupDialogData_ctorPrintSetup" (byval dialogData as wxPageSetupDialogData ptr) as wxPageSetupDialogData ptr
declare function wxPageSetupDialogData_ctorPrintData cdecl alias "wxPageSetupDialogData_ctorPrintData" (byval printData as wxPrintData ptr) as wxPageSetupDialogData ptr
declare sub wxPageSetupDialogData_GetPaperSize cdecl alias "wxPageSetupDialogData_GetPaperSize" (byval self as wxPageSetupDialogData ptr, byval size as wxSize ptr)
declare function wxPageSetupDialogData_GetPaperId cdecl alias "wxPageSetupDialogData_GetPaperId" (byval self as wxPageSetupDialogData ptr) as wxPaperSize
declare sub wxPageSetupDialogData_GetMinMarginTopLeft cdecl alias "wxPageSetupDialogData_GetMinMarginTopLeft" (byval self as wxPageSetupDialogData ptr, byval pt as wxPoint ptr)
declare sub wxPageSetupDialogData_GetMinMarginBottomRight cdecl alias "wxPageSetupDialogData_GetMinMarginBottomRight" (byval self as wxPageSetupDialogData ptr, byval pt as wxPoint ptr)
declare sub wxPageSetupDialogData_GetMarginTopLeft cdecl alias "wxPageSetupDialogData_GetMarginTopLeft" (byval self as wxPageSetupDialogData ptr, byval pt as wxPoint ptr)
declare sub wxPageSetupDialogData_GetMarginBottomRight cdecl alias "wxPageSetupDialogData_GetMarginBottomRight" (byval self as wxPageSetupDialogData ptr, byval pt as wxPoint ptr)
declare function wxPageSetupDialogData_GetDefaultMinMargins cdecl alias "wxPageSetupDialogData_GetDefaultMinMargins" (byval self as wxPageSetupDialogData ptr) as integer
declare function wxPageSetupDialogData_GetEnableMargins cdecl alias "wxPageSetupDialogData_GetEnableMargins" (byval self as wxPageSetupDialogData ptr) as integer
declare function wxPageSetupDialogData_GetEnableOrientation cdecl alias "wxPageSetupDialogData_GetEnableOrientation" (byval self as wxPageSetupDialogData ptr) as integer
declare function wxPageSetupDialogData_GetEnablePaper cdecl alias "wxPageSetupDialogData_GetEnablePaper" (byval self as wxPageSetupDialogData ptr) as integer
declare function wxPageSetupDialogData_GetEnablePrinter cdecl alias "wxPageSetupDialogData_GetEnablePrinter" (byval self as wxPageSetupDialogData ptr) as integer
declare function wxPageSetupDialogData_GetDefaultInfo cdecl alias "wxPageSetupDialogData_GetDefaultInfo" (byval self as wxPageSetupDialogData ptr) as integer
declare function wxPageSetupDialogData_GetEnableHelp cdecl alias "wxPageSetupDialogData_GetEnableHelp" (byval self as wxPageSetupDialogData ptr) as integer
declare function wxPageSetupDialogData_Ok cdecl alias "wxPageSetupDialogData_Ok" (byval self as wxPageSetupDialogData ptr) as integer
declare sub wxPageSetupDialogData_SetPaperSizeSize cdecl alias "wxPageSetupDialogData_SetPaperSizeSize" (byval self as wxPageSetupDialogData ptr, byval sz as wxSize ptr)
declare sub wxPageSetupDialogData_SetPaperId cdecl alias "wxPageSetupDialogData_SetPaperId" (byval self as wxPageSetupDialogData ptr, byval id as wxPaperSize)
declare sub wxPageSetupDialogData_SetPaperSize cdecl alias "wxPageSetupDialogData_SetPaperSize" (byval self as wxPageSetupDialogData ptr, byval id as wxPaperSize)
declare sub wxPageSetupDialogData_SetMinMarginTopLeft cdecl alias "wxPageSetupDialogData_SetMinMarginTopLeft" (byval self as wxPageSetupDialogData ptr, byval pt as wxPoint ptr)
declare sub wxPageSetupDialogData_SetMinMarginBottomRight cdecl alias "wxPageSetupDialogData_SetMinMarginBottomRight" (byval self as wxPageSetupDialogData ptr, byval pt as wxPoint ptr)
declare sub wxPageSetupDialogData_SetMarginTopLeft cdecl alias "wxPageSetupDialogData_SetMarginTopLeft" (byval self as wxPageSetupDialogData ptr, byval pt as wxPoint ptr)
declare sub wxPageSetupDialogData_SetMarginBottomRight cdecl alias "wxPageSetupDialogData_SetMarginBottomRight" (byval self as wxPageSetupDialogData ptr, byval pt as wxPoint ptr)
declare sub wxPageSetupDialogData_SetDefaultMinMargins cdecl alias "wxPageSetupDialogData_SetDefaultMinMargins" (byval self as wxPageSetupDialogData ptr, byval flag as integer)
declare sub wxPageSetupDialogData_SetDefaultInfo cdecl alias "wxPageSetupDialogData_SetDefaultInfo" (byval self as wxPageSetupDialogData ptr, byval flag as integer)
declare sub wxPageSetupDialogData_EnableMargins cdecl alias "wxPageSetupDialogData_EnableMargins" (byval self as wxPageSetupDialogData ptr, byval flag as integer)
declare sub wxPageSetupDialogData_EnableOrientation cdecl alias "wxPageSetupDialogData_EnableOrientation" (byval self as wxPageSetupDialogData ptr, byval flag as integer)
declare sub wxPageSetupDialogData_EnablePaper cdecl alias "wxPageSetupDialogData_EnablePaper" (byval self as wxPageSetupDialogData ptr, byval flag as integer)
declare sub wxPageSetupDialogData_EnablePrinter cdecl alias "wxPageSetupDialogData_EnablePrinter" (byval self as wxPageSetupDialogData ptr, byval flag as integer)
declare sub wxPageSetupDialogData_EnableHelp cdecl alias "wxPageSetupDialogData_EnableHelp" (byval self as wxPageSetupDialogData ptr, byval flag as integer)
declare sub wxPageSetupDialogData_CalculateIdFromPaperSize cdecl alias "wxPageSetupDialogData_CalculateIdFromPaperSize" (byval self as wxPageSetupDialogData ptr)
declare sub wxPageSetupDialogData_CalculatePaperSizeFromId cdecl alias "wxPageSetupDialogData_CalculatePaperSizeFromId" (byval self as wxPageSetupDialogData ptr)
declare function wxPageSetupDialogData_GetPrintData cdecl alias "wxPageSetupDialogData_GetPrintData" (byval self as wxPageSetupDialogData ptr) as wxPrintData ptr
declare sub wxPageSetupDialogData_SetPrintData cdecl alias "wxPageSetupDialogData_SetPrintData" (byval self as wxPageSetupDialogData ptr, byval printData as wxPrintData ptr)
declare function wxPrintDialogData cdecl alias "wxPrintDialogData_ctor" () as wxPrintDialogData ptr
declare function wxPrintDialogData_ctorDialogData cdecl alias "wxPrintDialogData_ctorDialogData" (byval dialogData as wxPrintDialogData ptr) as wxPrintDialogData ptr
declare function wxPrintDialogData_ctorPrintData cdecl alias "wxPrintDialogData_ctorPrintData" (byval printData as wxPrintData ptr) as wxPrintDialogData ptr
declare function wxPrintDialogData_GetFromPage cdecl alias "wxPrintDialogData_GetFromPage" (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetToPage cdecl alias "wxPrintDialogData_GetToPage" (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetMinPage cdecl alias "wxPrintDialogData_GetMinPage" (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetMaxPage cdecl alias "wxPrintDialogData_GetMaxPage" (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetNoCopies cdecl alias "wxPrintDialogData_GetNoCopies" (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetAllPages cdecl alias "wxPrintDialogData_GetAllPages" (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetSelection cdecl alias "wxPrintDialogData_GetSelection" (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetCollate cdecl alias "wxPrintDialogData_GetCollate" (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetPrintToFile cdecl alias "wxPrintDialogData_GetPrintToFile" (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetSetupDialog cdecl alias "wxPrintDialogData_GetSetupDialog" (byval self as wxPrintDialogData ptr) as integer
declare sub wxPrintDialogData_SetFromPage cdecl alias "wxPrintDialogData_SetFromPage" (byval self as wxPrintDialogData ptr, byval v as integer)
declare sub wxPrintDialogData_SetToPage cdecl alias "wxPrintDialogData_SetToPage" (byval self as wxPrintDialogData ptr, byval v as integer)
declare sub wxPrintDialogData_SetMinPage cdecl alias "wxPrintDialogData_SetMinPage" (byval self as wxPrintDialogData ptr, byval v as integer)
declare sub wxPrintDialogData_SetMaxPage cdecl alias "wxPrintDialogData_SetMaxPage" (byval self as wxPrintDialogData ptr, byval v as integer)
declare sub wxPrintDialogData_SetNoCopies cdecl alias "wxPrintDialogData_SetNoCopies" (byval self as wxPrintDialogData ptr, byval v as integer)
declare sub wxPrintDialogData_SetAllPages cdecl alias "wxPrintDialogData_SetAllPages" (byval self as wxPrintDialogData ptr, byval flag as integer)
declare sub wxPrintDialogData_SetSelection cdecl alias "wxPrintDialogData_SetSelection" (byval self as wxPrintDialogData ptr, byval flag as integer)
declare sub wxPrintDialogData_SetCollate cdecl alias "wxPrintDialogData_SetCollate" (byval self as wxPrintDialogData ptr, byval flag as integer)
declare sub wxPrintDialogData_SetPrintToFile cdecl alias "wxPrintDialogData_SetPrintToFile" (byval self as wxPrintDialogData ptr, byval flag as integer)
declare sub wxPrintDialogData_SetSetupDialog cdecl alias "wxPrintDialogData_SetSetupDialog" (byval self as wxPrintDialogData ptr, byval flag as integer)
declare sub wxPrintDialogData_EnablePrintToFile cdecl alias "wxPrintDialogData_EnablePrintToFile" (byval self as wxPrintDialogData ptr, byval flag as integer)
declare sub wxPrintDialogData_EnableSelection cdecl alias "wxPrintDialogData_EnableSelection" (byval self as wxPrintDialogData ptr, byval flag as integer)
declare sub wxPrintDialogData_EnablePageNumbers cdecl alias "wxPrintDialogData_EnablePageNumbers" (byval self as wxPrintDialogData ptr, byval flag as integer)
declare sub wxPrintDialogData_EnableHelp cdecl alias "wxPrintDialogData_EnableHelp" (byval self as wxPrintDialogData ptr, byval flag as integer)
declare function wxPrintDialogData_GetEnablePrintToFile cdecl alias "wxPrintDialogData_GetEnablePrintToFile" (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetEnableSelection cdecl alias "wxPrintDialogData_GetEnableSelection" (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetEnablePageNumbers cdecl alias "wxPrintDialogData_GetEnablePageNumbers" (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetEnableHelp cdecl alias "wxPrintDialogData_GetEnableHelp" (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_Ok cdecl alias "wxPrintDialogData_Ok" (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetPrintData cdecl alias "wxPrintDialogData_GetPrintData" (byval self as wxPrintDialogData ptr) as wxPrintData ptr
declare sub wxPrintDialogData_SetPrintData cdecl alias "wxPrintDialogData_SetPrintData" (byval self as wxPrintDialogData ptr, byval printData as wxPrintData ptr)
declare function wxPrintData cdecl alias "wxPrintData_ctor" () as wxPrintData ptr
declare function wxPrintData_ctorPrintData cdecl alias "wxPrintData_ctorPrintData" (byval printData as wxPrintData ptr) as wxPrintData ptr
declare function wxPrintData_GetNoCopies cdecl alias "wxPrintData_GetNoCopies" (byval self as wxPrintData ptr) as integer
declare function wxPrintData_GetCollate cdecl alias "wxPrintData_GetCollate" (byval self as wxPrintData ptr) as integer
declare function wxPrintData_GetOrientation cdecl alias "wxPrintData_GetOrientation" (byval self as wxPrintData ptr) as integer
declare function wxPrintData_Ok cdecl alias "wxPrintData_Ok" (byval self as wxPrintData ptr) as integer
declare function wxPrintData_GetPrinterName cdecl alias "wxPrintData_GetPrinterName" (byval self as wxPrintData ptr) as wxString ptr
declare function wxPrintData_GetColour cdecl alias "wxPrintData_GetColour" (byval self as wxPrintData ptr) as integer
declare function wxPrintData_GetDuplex cdecl alias "wxPrintData_GetDuplex" (byval self as wxPrintData ptr) as wxDuplexMode
declare function wxPrintData_GetPaperId cdecl alias "wxPrintData_GetPaperId" (byval self as wxPrintData ptr) as wxPaperSize
declare sub wxPrintData_GetPaperSize cdecl alias "wxPrintData_GetPaperSize" (byval self as wxPrintData ptr, byval size as wxSize ptr)
declare function wxPrintData_GetQuality cdecl alias "wxPrintData_GetQuality" (byval self as wxPrintData ptr) as wxPrintQuality
declare sub wxPrintData_SetNoCopies cdecl alias "wxPrintData_SetNoCopies" (byval self as wxPrintData ptr, byval v as integer)
declare sub wxPrintData_SetCollate cdecl alias "wxPrintData_SetCollate" (byval self as wxPrintData ptr, byval flag as integer)
declare sub wxPrintData_SetOrientation cdecl alias "wxPrintData_SetOrientation" (byval self as wxPrintData ptr, byval orient as integer)
declare sub wxPrintData_SetPrinterName cdecl alias "wxPrintData_SetPrinterName" (byval self as wxPrintData ptr, byval name as zstring ptr)
declare sub wxPrintData_SetColour cdecl alias "wxPrintData_SetColour" (byval self as wxPrintData ptr, byval colour as integer)
declare sub wxPrintData_SetDuplex cdecl alias "wxPrintData_SetDuplex" (byval self as wxPrintData ptr, byval duplex as wxDuplexMode)
declare sub wxPrintData_SetPaperId cdecl alias "wxPrintData_SetPaperId" (byval self as wxPrintData ptr, byval sizeId as wxPaperSize)
declare sub wxPrintData_SetPaperSize cdecl alias "wxPrintData_SetPaperSize" (byval self as wxPrintData ptr, byval sz as wxSize ptr)
declare sub wxPrintData_SetQuality cdecl alias "wxPrintData_SetQuality" (byval self as wxPrintData ptr, byval quality as wxPrintQuality)
declare function wxPrintData_GetPrinterCommand cdecl alias "wxPrintData_GetPrinterCommand" (byval self as wxPrintData ptr) as wxString ptr
declare function wxPrintData_GetPrinterOptions cdecl alias "wxPrintData_GetPrinterOptions" (byval self as wxPrintData ptr) as wxString ptr
declare function wxPrintData_GetPreviewCommand cdecl alias "wxPrintData_GetPreviewCommand" (byval self as wxPrintData ptr) as wxString ptr
declare function wxPrintData_GetFilename cdecl alias "wxPrintData_GetFilename" (byval self as wxPrintData ptr) as wxString ptr
declare function wxPrintData_GetFontMetricPath cdecl alias "wxPrintData_GetFontMetricPath" (byval self as wxPrintData ptr) as wxString ptr
declare function wxPrintData_GetPrinterScaleX cdecl alias "wxPrintData_GetPrinterScaleX" (byval self as wxPrintData ptr) as double
declare function wxPrintData_GetPrinterScaleY cdecl alias "wxPrintData_GetPrinterScaleY" (byval self as wxPrintData ptr) as double
declare function wxPrintData_GetPrinterTranslateX cdecl alias "wxPrintData_GetPrinterTranslateX" (byval self as wxPrintData ptr) as integer
declare function wxPrintData_GetPrinterTranslateY cdecl alias "wxPrintData_GetPrinterTranslateY" (byval self as wxPrintData ptr) as integer
declare function wxPrintData_GetPrintMode cdecl alias "wxPrintData_GetPrintMode" (byval self as wxPrintData ptr) as wxPrintMode
declare sub wxPrintData_SetPrinterCommand cdecl alias "wxPrintData_SetPrinterCommand" (byval self as wxPrintData ptr, byval command as zstring ptr)
declare sub wxPrintData_SetPrinterOptions cdecl alias "wxPrintData_SetPrinterOptions" (byval self as wxPrintData ptr, byval options as zstring ptr)
declare sub wxPrintData_SetPreviewCommand cdecl alias "wxPrintData_SetPreviewCommand" (byval self as wxPrintData ptr, byval command as zstring ptr)
declare sub wxPrintData_SetFilename cdecl alias "wxPrintData_SetFilename" (byval self as wxPrintData ptr, byval filename as zstring ptr)
declare sub wxPrintData_SetFontMetricPath cdecl alias "wxPrintData_SetFontMetricPath" (byval self as wxPrintData ptr, byval path as zstring ptr)
declare sub wxPrintData_SetPrinterScaleX cdecl alias "wxPrintData_SetPrinterScaleX" (byval self as wxPrintData ptr, byval x as double)
declare sub wxPrintData_SetPrinterScaleY cdecl alias "wxPrintData_SetPrinterScaleY" (byval self as wxPrintData ptr, byval y as double)
declare sub wxPrintData_SetPrinterScaling cdecl alias "wxPrintData_SetPrinterScaling" (byval self as wxPrintData ptr, byval x as double, byval y as double)
declare sub wxPrintData_SetPrinterTranslateX cdecl alias "wxPrintData_SetPrinterTranslateX" (byval self as wxPrintData ptr, byval x as integer)
declare sub wxPrintData_SetPrinterTranslateY cdecl alias "wxPrintData_SetPrinterTranslateY" (byval self as wxPrintData ptr, byval y as integer)
declare sub wxPrintData_SetPrinterTranslation cdecl alias "wxPrintData_SetPrinterTranslation" (byval self as wxPrintData ptr, byval x as integer, byval y as integer)
declare sub wxPrintData_SetPrintMode cdecl alias "wxPrintData_SetPrintMode" (byval self as wxPrintData ptr, byval printMode as wxPrintMode)

#endif
