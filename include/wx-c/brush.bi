#Ifndef __brush_bi__
#Define __brush_bi__

#Include Once "common.bi"

' class wxBrush
Declare Function wxBrush_ctor WXCALL Alias "wxBrush_ctor" () As wxBrush Ptr
Declare Function wxBrush_Ok WXCALL Alias "wxBrush_Ok" (self As wxBrush Ptr) As wxBool
Declare Sub wxBrush_SetStyle WXCALL Alias "wxBrush_SetStyle" (self As wxBrush Ptr, style As wxInt)
Declare Function wxBrush_GetStyle WXCALL Alias "wxBrush_GetStyle" (self As wxBrush Ptr) As wxInt
Declare Sub wxBrush_SetStipple WXCALL Alias "wxBrush_SetStipple" (self As wxBrush Ptr, bitmapStipple As wxBitmap Ptr)
Declare Function wxBrush_GetStipple WXCALL Alias "wxBrush_GetStipple" (self As wxBrush Ptr) As wxBitmap Ptr 
Declare Sub wxBrush_SetColour WXCALL Alias "wxBrush_SetColour" (self As wxBrush Ptr, col As wxColour Ptr)
Declare Function wxBrush_GetColour WXCALL Alias "wxBrush_GetColour" (self As wxBrush Ptr) As wxColour Ptr

#EndIf ' __brush_bi__

