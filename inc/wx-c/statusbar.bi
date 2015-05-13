#Ifndef __statusbar_bi__
#Define __statusbar_bi__

#Include Once "common.bi"

' class wxStatusBar
Declare Function wxStatusBar_ctor WXCALL Alias "wxStatusBar_ctor" () As wxStatusBar Ptr
Declare Function wxStatusBar_Create WXCALL Alias "wxStatusBar_Create" (self As wxStatusBar Ptr, _
                        parent  As wxWindow Ptr, _
                        id      As  wxWindowID, _
                        style   As  wxUInt, _
                        nameArg As wxString Ptr) As wxBool
Declare Sub wxStatusBar_SetFieldsCount WXCALL Alias "wxStatusBar_SetFieldsCount" (self As wxStatusBar Ptr, number As wxInt, iwidths As wxInt Ptr)
Declare Function wxStatusBar_GetFieldRect WXCALL Alias "wxStatusBar_GetFieldRect" (self As wxStatusBar Ptr, i As wxInt, r As wxRect Ptr) As wxBool
Declare Function wxStatusBar_GetBorderY WXCALL Alias "wxStatusBar_GetBorderY" (self As wxStatusBar Ptr) As wxInt
Declare Function wxStatusBar_GetStatusText WXCALL Alias "wxStatusBar_GetStatusText" (self As wxStatusBar Ptr, number As wxInt) As wxString Ptr
Declare Function wxStatusBar_GetBorderX WXCALL Alias "wxStatusBar_GetBorderX" (self As wxStatusBar Ptr) As wxInt
Declare Sub wxStatusBar_SetStatusText WXCALL Alias "wxStatusBar_SetStatusText" (self As wxStatusBar Ptr, txt As wxString Ptr, number As wxInt)
Declare Sub wxStatusBar_SetStatusWidths WXCALL Alias "wxStatusBar_SetStatusWidths" (self As wxStatusBar Ptr, n As wxInt, widths_field As wxInt Ptr)
Declare Function wxStatusBar_GetFieldsCount WXCALL Alias "wxStatusBar_GetFieldsCount" (self As wxStatusBar Ptr) As wxInt
Declare Sub wxStatusBar_PopStatusText WXCALL Alias "wxStatusBar_PopStatusText" (self As wxStatusBar Ptr, field_ As wxInt)
Declare Sub wxStatusBar_PushStatusText WXCALL Alias "wxStatusBar_PushStatusText" (self As wxStatusBar Ptr, txt As wxString Ptr, field_ As wxInt)
Declare Sub wxStatusBar_SetMinHeight WXCALL Alias "wxStatusBar_SetMinHeight" (self As wxStatusBar Ptr,  h As wxInt)
Declare Sub wxStatusBar_SetStatusStyles WXCALL Alias "wxStatusBar_SetStatusStyles" (self As wxStatusBar Ptr, n As wxInt, styles As wxInt Ptr)

#EndIf ' __statusbar_bi__

