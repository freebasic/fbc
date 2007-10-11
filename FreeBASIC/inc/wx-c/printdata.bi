''
''
'' printdata -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_printdata_bi__
#define __wxc_printdata_bi__

#include once "wx.bi"

declare function wxPageSetupDialogData alias "wxPageSetupDialogData_ctor" () as wxPageSetupDialogData ptr
declare function wxPageSetupDialogData_ctorPrintSetup (byval dialogData as wxPageSetupDialogData ptr) as wxPageSetupDialogData ptr
declare function wxPageSetupDialogData_ctorPrintData (byval printData as wxPrintData ptr) as wxPageSetupDialogData ptr
declare sub wxPageSetupDialogData_GetPaperSize (byval self as wxPageSetupDialogData ptr, byval size as wxSize ptr)
declare function wxPageSetupDialogData_GetPaperId (byval self as wxPageSetupDialogData ptr) as wxPaperSize
declare sub wxPageSetupDialogData_GetMinMarginTopLeft (byval self as wxPageSetupDialogData ptr, byval pt as wxPoint ptr)
declare sub wxPageSetupDialogData_GetMinMarginBottomRight (byval self as wxPageSetupDialogData ptr, byval pt as wxPoint ptr)
declare sub wxPageSetupDialogData_GetMarginTopLeft (byval self as wxPageSetupDialogData ptr, byval pt as wxPoint ptr)
declare sub wxPageSetupDialogData_GetMarginBottomRight (byval self as wxPageSetupDialogData ptr, byval pt as wxPoint ptr)
declare function wxPageSetupDialogData_GetDefaultMinMargins (byval self as wxPageSetupDialogData ptr) as integer
declare function wxPageSetupDialogData_GetEnableMargins (byval self as wxPageSetupDialogData ptr) as integer
declare function wxPageSetupDialogData_GetEnableOrientation (byval self as wxPageSetupDialogData ptr) as integer
declare function wxPageSetupDialogData_GetEnablePaper (byval self as wxPageSetupDialogData ptr) as integer
declare function wxPageSetupDialogData_GetEnablePrinter (byval self as wxPageSetupDialogData ptr) as integer
declare function wxPageSetupDialogData_GetDefaultInfo (byval self as wxPageSetupDialogData ptr) as integer
declare function wxPageSetupDialogData_GetEnableHelp (byval self as wxPageSetupDialogData ptr) as integer
declare function wxPageSetupDialogData_Ok (byval self as wxPageSetupDialogData ptr) as integer
declare sub wxPageSetupDialogData_SetPaperSizeSize (byval self as wxPageSetupDialogData ptr, byval sz as wxSize ptr)
declare sub wxPageSetupDialogData_SetPaperId (byval self as wxPageSetupDialogData ptr, byval id as wxPaperSize)
declare sub wxPageSetupDialogData_SetPaperSize (byval self as wxPageSetupDialogData ptr, byval id as wxPaperSize)
declare sub wxPageSetupDialogData_SetMinMarginTopLeft (byval self as wxPageSetupDialogData ptr, byval pt as wxPoint ptr)
declare sub wxPageSetupDialogData_SetMinMarginBottomRight (byval self as wxPageSetupDialogData ptr, byval pt as wxPoint ptr)
declare sub wxPageSetupDialogData_SetMarginTopLeft (byval self as wxPageSetupDialogData ptr, byval pt as wxPoint ptr)
declare sub wxPageSetupDialogData_SetMarginBottomRight (byval self as wxPageSetupDialogData ptr, byval pt as wxPoint ptr)
declare sub wxPageSetupDialogData_SetDefaultMinMargins (byval self as wxPageSetupDialogData ptr, byval flag as integer)
declare sub wxPageSetupDialogData_SetDefaultInfo (byval self as wxPageSetupDialogData ptr, byval flag as integer)
declare sub wxPageSetupDialogData_EnableMargins (byval self as wxPageSetupDialogData ptr, byval flag as integer)
declare sub wxPageSetupDialogData_EnableOrientation (byval self as wxPageSetupDialogData ptr, byval flag as integer)
declare sub wxPageSetupDialogData_EnablePaper (byval self as wxPageSetupDialogData ptr, byval flag as integer)
declare sub wxPageSetupDialogData_EnablePrinter (byval self as wxPageSetupDialogData ptr, byval flag as integer)
declare sub wxPageSetupDialogData_EnableHelp (byval self as wxPageSetupDialogData ptr, byval flag as integer)
declare sub wxPageSetupDialogData_CalculateIdFromPaperSize (byval self as wxPageSetupDialogData ptr)
declare sub wxPageSetupDialogData_CalculatePaperSizeFromId (byval self as wxPageSetupDialogData ptr)
declare function wxPageSetupDialogData_GetPrintData (byval self as wxPageSetupDialogData ptr) as wxPrintData ptr
declare sub wxPageSetupDialogData_SetPrintData (byval self as wxPageSetupDialogData ptr, byval printData as wxPrintData ptr)
declare function wxPrintDialogData alias "wxPrintDialogData_ctor" () as wxPrintDialogData ptr
declare function wxPrintDialogData_ctorDialogData (byval dialogData as wxPrintDialogData ptr) as wxPrintDialogData ptr
declare function wxPrintDialogData_ctorPrintData (byval printData as wxPrintData ptr) as wxPrintDialogData ptr
declare function wxPrintDialogData_GetFromPage (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetToPage (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetMinPage (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetMaxPage (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetNoCopies (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetAllPages (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetSelection (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetCollate (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetPrintToFile (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetSetupDialog (byval self as wxPrintDialogData ptr) as integer
declare sub wxPrintDialogData_SetFromPage (byval self as wxPrintDialogData ptr, byval v as integer)
declare sub wxPrintDialogData_SetToPage (byval self as wxPrintDialogData ptr, byval v as integer)
declare sub wxPrintDialogData_SetMinPage (byval self as wxPrintDialogData ptr, byval v as integer)
declare sub wxPrintDialogData_SetMaxPage (byval self as wxPrintDialogData ptr, byval v as integer)
declare sub wxPrintDialogData_SetNoCopies (byval self as wxPrintDialogData ptr, byval v as integer)
declare sub wxPrintDialogData_SetAllPages (byval self as wxPrintDialogData ptr, byval flag as integer)
declare sub wxPrintDialogData_SetSelection (byval self as wxPrintDialogData ptr, byval flag as integer)
declare sub wxPrintDialogData_SetCollate (byval self as wxPrintDialogData ptr, byval flag as integer)
declare sub wxPrintDialogData_SetPrintToFile (byval self as wxPrintDialogData ptr, byval flag as integer)
declare sub wxPrintDialogData_SetSetupDialog (byval self as wxPrintDialogData ptr, byval flag as integer)
declare sub wxPrintDialogData_EnablePrintToFile (byval self as wxPrintDialogData ptr, byval flag as integer)
declare sub wxPrintDialogData_EnableSelection (byval self as wxPrintDialogData ptr, byval flag as integer)
declare sub wxPrintDialogData_EnablePageNumbers (byval self as wxPrintDialogData ptr, byval flag as integer)
declare sub wxPrintDialogData_EnableHelp (byval self as wxPrintDialogData ptr, byval flag as integer)
declare function wxPrintDialogData_GetEnablePrintToFile (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetEnableSelection (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetEnablePageNumbers (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetEnableHelp (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_Ok (byval self as wxPrintDialogData ptr) as integer
declare function wxPrintDialogData_GetPrintData (byval self as wxPrintDialogData ptr) as wxPrintData ptr
declare sub wxPrintDialogData_SetPrintData (byval self as wxPrintDialogData ptr, byval printData as wxPrintData ptr)
declare function wxPrintData alias "wxPrintData_ctor" () as wxPrintData ptr
declare function wxPrintData_ctorPrintData (byval printData as wxPrintData ptr) as wxPrintData ptr
declare function wxPrintData_GetNoCopies (byval self as wxPrintData ptr) as integer
declare function wxPrintData_GetCollate (byval self as wxPrintData ptr) as integer
declare function wxPrintData_GetOrientation (byval self as wxPrintData ptr) as integer
declare function wxPrintData_Ok (byval self as wxPrintData ptr) as integer
declare function wxPrintData_GetPrinterName (byval self as wxPrintData ptr) as wxString ptr
declare function wxPrintData_GetColour (byval self as wxPrintData ptr) as integer
declare function wxPrintData_GetDuplex (byval self as wxPrintData ptr) as wxDuplexMode
declare function wxPrintData_GetPaperId (byval self as wxPrintData ptr) as wxPaperSize
declare sub wxPrintData_GetPaperSize (byval self as wxPrintData ptr, byval size as wxSize ptr)
declare function wxPrintData_GetQuality (byval self as wxPrintData ptr) as wxPrintQuality
declare sub wxPrintData_SetNoCopies (byval self as wxPrintData ptr, byval v as integer)
declare sub wxPrintData_SetCollate (byval self as wxPrintData ptr, byval flag as integer)
declare sub wxPrintData_SetOrientation (byval self as wxPrintData ptr, byval orient as integer)
declare sub wxPrintData_SetPrinterName (byval self as wxPrintData ptr, byval name as zstring ptr)
declare sub wxPrintData_SetColour (byval self as wxPrintData ptr, byval colour as integer)
declare sub wxPrintData_SetDuplex (byval self as wxPrintData ptr, byval duplex as wxDuplexMode)
declare sub wxPrintData_SetPaperId (byval self as wxPrintData ptr, byval sizeId as wxPaperSize)
declare sub wxPrintData_SetPaperSize (byval self as wxPrintData ptr, byval sz as wxSize ptr)
declare sub wxPrintData_SetQuality (byval self as wxPrintData ptr, byval quality as wxPrintQuality)
declare function wxPrintData_GetPrinterCommand (byval self as wxPrintData ptr) as wxString ptr
declare function wxPrintData_GetPrinterOptions (byval self as wxPrintData ptr) as wxString ptr
declare function wxPrintData_GetPreviewCommand (byval self as wxPrintData ptr) as wxString ptr
declare function wxPrintData_GetFilename (byval self as wxPrintData ptr) as wxString ptr
declare function wxPrintData_GetFontMetricPath (byval self as wxPrintData ptr) as wxString ptr
declare function wxPrintData_GetPrinterScaleX (byval self as wxPrintData ptr) as double
declare function wxPrintData_GetPrinterScaleY (byval self as wxPrintData ptr) as double
declare function wxPrintData_GetPrinterTranslateX (byval self as wxPrintData ptr) as integer
declare function wxPrintData_GetPrinterTranslateY (byval self as wxPrintData ptr) as integer
declare function wxPrintData_GetPrintMode (byval self as wxPrintData ptr) as wxPrintMode
declare sub wxPrintData_SetPrinterCommand (byval self as wxPrintData ptr, byval command as zstring ptr)
declare sub wxPrintData_SetPrinterOptions (byval self as wxPrintData ptr, byval options as zstring ptr)
declare sub wxPrintData_SetPreviewCommand (byval self as wxPrintData ptr, byval command as zstring ptr)
declare sub wxPrintData_SetFilename (byval self as wxPrintData ptr, byval filename as zstring ptr)
declare sub wxPrintData_SetFontMetricPath (byval self as wxPrintData ptr, byval path as zstring ptr)
declare sub wxPrintData_SetPrinterScaleX (byval self as wxPrintData ptr, byval x as double)
declare sub wxPrintData_SetPrinterScaleY (byval self as wxPrintData ptr, byval y as double)
declare sub wxPrintData_SetPrinterScaling (byval self as wxPrintData ptr, byval x as double, byval y as double)
declare sub wxPrintData_SetPrinterTranslateX (byval self as wxPrintData ptr, byval x as integer)
declare sub wxPrintData_SetPrinterTranslateY (byval self as wxPrintData ptr, byval y as integer)
declare sub wxPrintData_SetPrinterTranslation (byval self as wxPrintData ptr, byval x as integer, byval y as integer)
declare sub wxPrintData_SetPrintMode (byval self as wxPrintData ptr, byval printMode as wxPrintMode)

#endif
