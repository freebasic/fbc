#Ifndef __pen_bi__
#Define __pen_bi__

#Include Once "common.bi"

' class wxPen
Declare Function wxPen_ctor WXCALL Alias "wxPen_ctor" (col As wxColour Ptr, penWidth As wxInt = 1, style As wxUInt = wxPenStyle.wxSOLID) As wxPen Ptr
Declare Function wxPen_ctorByName WXCALL Alias "wxPen_ctorByName" (nam As wxString Ptr, penWidth As wxInt = 1, style As wxUint = wxPenStyle.wxSOLID) As wxPen Ptr
Declare Sub wxPen_dtor WXCALL Alias "wxPen_dtor" (self As wxPen Ptr)
Declare Function wxPen_clone WXCALL Alias "wxPen_clone" (other As wxPen Ptr) As wxPen Ptr
Declare Function wxPen_Ok WXCALL Alias "wxPen_Ok" (self As wxPen Ptr) As wxBool
Declare Sub wxPen_Set WXCALL Alias "wxPen_Set" (self As wxPen Ptr, src As wxPen Ptr)
Declare Sub wxPen_SetWidth WXCALL Alias "wxPen_SetWidth" (self As wxPen Ptr, penWidth As wxInt)
Declare Function wxPen_GetWidth WXCALL Alias "wxPen_GetWidth" (self As wxPen Ptr) As wxInt
Declare Sub wxPen_SetColour WXCALL Alias "wxPen_SetColour" (self As wxPen Ptr, col As wxColour Ptr)
Declare Function wxPen_GetColour WXCALL Alias "wxPen_GetColour" (self As wxPen Ptr) As wxColour Ptr
Declare Sub wxPen_SetCap WXCALL Alias "wxPen_SetCap" (self As wxPen Ptr, cap As wxCapStyle)
Declare Function wxPen_GetCap WXCALL Alias "wxPen_GetCap" (self As wxPen Ptr) As wxCapStyle
Declare Sub wxPen_SetJoin WXCALL Alias "wxPen_SetJoin" (self As wxPen Ptr, join As wxJoinStyle)
Declare Function wxPen_GetJoin WXCALL Alias "wxPen_GetJoin" (self As wxPen Ptr) As wxJoinStyle
Declare Sub wxPen_SetStyle WXCALL Alias "wxPen_SetStyle" (self As wxPen Ptr, style As wxPenStyle)
Declare Function wxPen_GetStyle WXCALL Alias "wxPen_GetStyle" (self As wxPen Ptr) As wxPenStyle

#EndIf ' __pen_bi__

