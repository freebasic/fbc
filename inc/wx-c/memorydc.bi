#Ifndef __memorydc_bi__
#Define __memorydc_bi__

#Include Once "common.bi"


' class wxMemoryDC
Declare Function wxMemoryDC_ctor WXCALL Alias "wxMemoryDC_ctor" () As wxMemoryDC Ptr
Declare Function wxMemoryDC_ctorByDC WXCALL Alias "wxMemoryDC_ctorByDC" (dc As wxDC Ptr) As wxMemoryDC Ptr
Declare Sub wxMemoryDC_SelectObject WXCALL Alias "wxMemoryDC_SelectObject" (self As wxMemoryDC Ptr, bitmap As wxBitmap Ptr)

' class wxBufferedDC
Declare Function wxBufferedDC_ctor WXCALL Alias "wxBufferedDC_ctor" () As wxBufferedDC Ptr
Declare Function wxBufferedDC_ctorByBitmap WXCALL Alias "wxBufferedDC_ctorByBitmap" (dc As wxDC Ptr, bitmap As wxBitmap Ptr) As wxBufferedDC Ptr
Declare Function wxBufferedDC_ctorBySize WXCALL Alias "wxBufferedDC_ctorBySize" (dc As wxDC Ptr, area   As wxSize   Ptr) As wxBufferedDC Ptr
Declare Sub wxBufferedDC_InitByBitmap WXCALL Alias "wxBufferedDC_InitByBitmap" (self As wxBufferedDC Ptr, dc As wxDC Ptr, bitmap As wxBitmap Ptr)
Declare Sub wxBufferedDC_InitBySize WXCALL Alias "wxBufferedDC_InitBySize" (self As wxBufferedDC Ptr, dc As wxDC Ptr, area   As wxSize   Ptr)
Declare Sub wxBufferedDC_UnMask WXCALL Alias "wxBufferedDC_UnMask" (self As wxBufferedDC Ptr)

' class wxBufferedPaintDC
Declare Function wxBufferedPaintDC_ctor WXCALL Alias "wxBufferedPaintDC_ctor" (win As wxWindow Ptr, buffer As wxBitmap Ptr=WX_NULL) As wxBufferedPaintDC Ptr

#EndIf ' __memorydc_bi__

