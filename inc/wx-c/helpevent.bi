#Ifndef __helpevent_bi__
#Define __helpevent_bi__

#Include Once "common.bi"

Declare Function wxHelpEvent_ctor WXCALL Alias "wxHelpEvent_ctor" (typ As wxEventType) As wxHelpEvent Ptr
Declare Sub wxHelpEvent_SetPosition WXCALL Alias "wxHelpEvent_SetPosition" (self As wxHelpEvent Ptr, pt As wxPoint Ptr)
Declare Sub wxHelpEvent_GetPosition WXCALL Alias "wxHelpEvent_GetPosition" (self As wxHelpEvent Ptr, pt As wxPoint Ptr)
Declare Sub wxHelpEvent_SetLink WXCALL Alias "wxHelpEvent_SetLink" (self As wxHelpEvent Ptr, link As wxString Ptr)
Declare Function wxHelpEvent_GetLink WXCALL Alias "wxHelpEvent_GetLink" (self As wxHelpEvent Ptr) As wxString Ptr
Declare Sub wxHelpEvent_SetTarget WXCALL Alias "wxHelpEvent_SetTarget" (self As wxHelpEvent Ptr, target As wxString Ptr)
Declare Function wxHelpEvent_GetTarget WXCALL Alias "wxHelpEvent_GetTarget" (self As wxHelpEvent Ptr) As wxString Ptr

#EndIf ' __helpevent_bi__

