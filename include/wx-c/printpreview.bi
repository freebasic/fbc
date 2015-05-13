#Ifndef __printpreview_bi__
#Define __printpreview_bi__

#Include Once "common.bi"

' class wxPrintPreview
Declare Function wxPrintPreview_ctor WXCALL Alias "wxPrintPreview_ctor" (printout As wxPrintout Ptr, printouForPrinting As wxPrintout Ptr, dialogdata As wxPrintDialogData Ptr) As wxPrintPreview Ptr
Declare Function wxPrintPreview_ctorPrintData WXCALL Alias "wxPrintPreview_ctorPrintData" (printout As wxPrintout Ptr, printoutForPrinting As wxPrintout Ptr, pd As wxPrintData Ptr) As wxPrintPreview Ptr
Declare Function wxPrintPreview_SetCurrentPage WXCALL Alias "wxPrintPreview_SetCurrentPage" (self As wxPrintPreview Ptr, page As wxInt) As wxBool
Declare Function wxPrintPreview_GetCurrentPage WXCALL Alias "wxPrintPreview_GetCurrentPage" (self As wxPrintPreview Ptr) As wxInt
Declare Sub wxPrintPreview_SetPrintout WXCALL Alias "wxPrintPreview_SetPrintout" (self As wxPrintPreview Ptr, printout As wxPrintout Ptr)
Declare Function wxPrintPreview_GetPrintout WXCALL Alias "wxPrintPreview_GetPrintout" (self As wxPrintPreview Ptr) As wxPrintout Ptr
Declare Function wxPrintPreview_GetPrintoutForPrinting WXCALL Alias "wxPrintPreview_GetPrintoutForPrinting" (self As wxPrintPreview Ptr) As wxPrintout Ptr 
Declare Sub wxPrintPreview_SetFrame WXCALL Alias "wxPrintPreview_SetFrame" (self As wxPrintPreview Ptr, frame As wxFrame Ptr)
Declare Sub wxPrintPreview_SetCanvas WXCALL Alias "wxPrintPreview_SetCanvas" (self As wxPrintPreview Ptr, canvas As wxPreviewCanvas Ptr)
Declare Function wxPrintPreview_GetFrame WXCALL Alias "wxPrintPreview_GetFrame" (self As wxPrintPreview Ptr) As wxFrame Ptr
Declare Function wxPrintPreview_GetCanvas WXCALL Alias "wxPrintPreview_GetCanvas" (self As wxPrintPreview Ptr) As wxWindow Ptr
Declare Function wxPrintPreview_PaintPage WXCALL Alias "wxPrintPreview_PaintPage" (self As wxPrintPreview Ptr, canvas As wxPreviewCanvas Ptr, dc As wxDC Ptr) As wxBool
Declare Function wxPrintPreview_DrawBlankPage WXCALL Alias "wxPrintPreview_DrawBlankPage" (self As wxPrintPreview Ptr, canvas As wxPreviewCanvas Ptr, dc As wxDC Ptr) As wxBool
Declare Function wxPrintPreview_RenderPage WXCALL Alias "wxPrintPreview_RenderPage" (self As wxPrintPreview Ptr, page As wxInt) As wxBool
Declare Function wxPrintPreview_GetPrintDialogData WXCALL Alias "wxPrintPreview_GetPrintDialogData" (self As wxPrintPreview Ptr) As wxPrintDialogData Ptr
Declare Sub wxPrintPreview_SetZoom WXCALL Alias "wxPrintPreview_SetZoom" (self As wxPrintPreview Ptr, percent As wxInt)
Declare Function wxPrintPreview_GetZoom WXCALL Alias "wxPrintPreview_GetZoom" (self As wxPrintPreview Ptr) As wxInt
Declare Function wxPrintPreview_GetMaxPage WXCALL Alias "wxPrintPreview_GetMaxPage" (self As wxPrintPreview Ptr) As wxInt
Declare Function wxPrintPreview_GetMinPage WXCALL Alias "wxPrintPreview_GetMinPage" (self As wxPrintPreview Ptr) As wxInt
Declare Function wxPrintPreview_Ok WXCALL Alias "wxPrintPreview_Ok" (self As wxPrintPreview Ptr) As wxBool
Declare Sub wxPrintPreview_SetOk WXCALL Alias "wxPrintPreview_SetOk" (self As wxPrintPreview Ptr, ok As wxBool)
Declare Function wxPrintPreview_Print WXCALL Alias "wxPrintPreview_Print" (self As wxPrintPreview Ptr, interactive As wxBool) As wxBool
Declare Sub wxPrintPreview_DetermineScaling WXCALL Alias "wxPrintPreview_DetermineScaling" (self As wxPrintPreview Ptr)

' class wxPreviewFrame
Declare Function wxPreviewFrame_ctor WXCALL Alias "wxPreviewFrame_ctor" (preview As wxPrintPreviewBase Ptr, parent As wxFrame Ptr, titleArg As wxString Ptr, x As wxInt, y As wxInt, w As wxInt, h As wxInt, style As wxUInt, nameArg As wxString Ptr) As wxPreviewFrame Ptr
Declare Sub wxPreviewFrame_Initialize WXCALL Alias "wxPreviewFrame_Initialize" (self As wxPreviewFrame Ptr)
Declare Sub wxPreviewFrame_CreateCanvas WXCALL Alias "wxPreviewFrame_CreateCanvas" (self As wxPreviewFrame Ptr)
Declare Sub wxPreviewFrame_CreateControlBar WXCALL Alias "wxPreviewFrame_CreateControlBar" (self As wxPreviewFrame Ptr)

' class wxPreviewCanvas
Declare Function wxPreviewCanvas_ctor WXCALL Alias "wxPreviewCanvas_ctor" (preview As wxPrintPreviewBase Ptr, _
                          parent  As wxWindow Ptr     , _
                          x       As  wxInt        = -1, _
                          y       As  wxInt        = -1, _
                          w       As  wxInt        = -1, _
                          h       As  wxInt        = -1, _
                          style   As  wxUInt       =  0, _
                          nameArg As wxString Ptr = WX_NULL) As wxPreviewCanvas Ptr

#EndIf ' __printpreview_bi__

