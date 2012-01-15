#Ifndef __display_bi__
#Define __display_bi__

#Include Once "common.bi"

#Ifdef USE_WX_DISPLAY

' class wxDisplay
Declare Function wxDisplay_ctor WXCALL Alias "wxDisplay_ctor" (index As wxInt) As wxDisplay Ptr
Declare Sub wxDisplay_RegisterOnDispose WXCALL Alias "wxDisplay_RegisterOnDispose" (self As wxDisplay Ptr, on_dispose As Virtual_Dispose)
Declare Function wxDisplay_GetCount WXCALL Alias "wxDisplay_GetCount" () As wxInt
Declare Function wxDisplay_GetFromPoint WXCALL Alias "wxDisplay_GetFromPoint" (p As wxPoint Ptr) As wxInt
Declare Function wxDisplay_GetFromWindow WXCALL Alias "wxDisplay_GetFromWindow" (win As wxWindow Ptr) As wxInt
Declare Sub wxDisplay_GetGeometry WXCALL Alias "wxDisplay_GetGeometry" (self As wxDisplay Ptr, x As wxInt Ptr, y As wxInt Ptr, w As wxInt Ptr, h As wxInt Ptr)
Declare Function wxDisplay_GetName WXCALL Alias "wxDisplay_GetName" (self As wxDisplay Ptr) As wxString Ptr
Declare Function wxDisplay_IsPrimary WXCALL Alias "wxDisplay_IsPrimary" (self As wxDisplay Ptr) As wxBool
Declare Sub wxDisplay_GetCurrentMode WXCALL Alias "wxDisplay_GetCurrentMode" (self As wxDisplay Ptr, w  As wxInt Ptr, h As wxInt Ptr, bpp As wxInt Ptr, freq As wxInt Ptr)

' class wxArrayVideoModes
Declare Function wxDisplay_GetModes WXCALL Alias "wxDisplay_GetModes" (self As wxDisplay Ptr, mode As wxVideoMode) As wxArrayVideoModes Ptr
Declare Function wxArrayVideoModes_Count WXCALL Alias "wxArrayVideoModes_Count" (self As wxArrayVideoModes Ptr) As wxInt
Declare Sub wxArrayVideoModes_Item WXCALL Alias "wxArrayVideoModes_Item" (self As wxArrayVideoModes Ptr, index As wxInt, w As wxInt Ptr, h As wxInt Ptr, bpp As wxInt Ptr, freq As wxInt Ptr)
Declare Sub wxArrayVideoModes_Delete WXCALL Alias "wxArrayVideoModes_Delete" (self As wxArrayVideoModes Ptr)
Declare Function wxDisplay_ChangeMode WXCALL Alias "wxDisplay_ChangeMode" (self As wxDisplay Ptr, mode As wxVideoMode) As wxBool
Declare Sub wxDisplay_ResetMode WXCALL Alias "wxDisplay_ResetMode" (self As wxDisplay Ptr)

#EndIf ' USE_WX_DISPLAY

#EndIf ' __display_bi__


