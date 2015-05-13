#Ifndef __navigationkeyevent_bi__
#Define __navigationkeyevent_bi__

#Include Once "common.bi"

Declare Function wxNavigationKeyEvent_ctor WXCALL Alias "wxNavigationKeyEvent_ctor" () As wxNavigationKeyEvent Ptr
Declare Function wxNavigationKeyEvent_GetDirection WXCALL Alias "wxNavigationKeyEvent_GetDirection" (self As wxNavigationKeyEvent Ptr) As wxBool
Declare Sub wxNavigationKeyEvent_SetDirection WXCALL Alias "wxNavigationKeyEvent_SetDirection" (self As wxNavigationKeyEvent Ptr, bForward As wxBool)
Declare Function wxNavigationKeyEvent_IsWindowChange WXCALL Alias "wxNavigationKeyEvent_IsWindowChange" (self As wxNavigationKeyEvent Ptr) As wxBool
Declare Sub wxNavigationKeyEvent_SetWindowChange WXCALL Alias "wxNavigationKeyEvent_SetWindowChange" (self As wxNavigationKeyEvent Ptr, bIs As wxBool)
Declare Function wxNavigationKeyEvent_GetCurrentFocus WXCALL Alias "wxNavigationKeyEvent_GetCurrentFocus" (self As wxNavigationKeyEvent Ptr) As wxWindow Ptr
Declare Sub wxNavigationKeyEvent_SetCurrentFocus WXCALL Alias "wxNavigationKeyEvent_SetCurrentFocus" (self As wxNavigationKeyEvent Ptr, win As wxWindow Ptr)
Declare Sub wxNavigationKeyEvent_SetFlags WXCALL Alias "wxNavigationKeyEvent_SetFlags" (self As wxNavigationKeyEvent Ptr, flags As wxInt)

#EndIf ' __navigationkeyevent_bi__

