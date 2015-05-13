#Ifndef __taskbaricon_bi__
#Define __taskbaricon_bi__

#Include Once "common.bi"

Type wxTaskBarIcon_CreatePopupMenuHandler As Function WXCALL As wxMenu Ptr

Declare Function wxTaskBarIcon_ctor WXCALL Alias "wxTaskBarIcon_ctor" () As wxTaskBarIcon Ptr
Declare Sub wxTaskBarIcon_dtor WXCALL Alias "wxTaskBarIcon_dtor" (self As wxTaskBarIcon Ptr)
Declare Sub wxTaskBarIcon_RegisterVirtuals WXCALL Alias "wxTaskBarIcon_RegisterVirtuals" (self As wxTaskBarIcon Ptr, handler As wxTaskBarIcon_CreatePopupMenuHandler)
Declare Function wxTaskBarIcon_IsOk WXCALL Alias "wxTaskBarIcon_IsOk" (self As wxTaskBarIcon Ptr) As wxBool
Declare Function wxTaskBarIcon_IsIconInstalled WXCALL Alias "wxTaskBarIcon_IsIconInstalled" (self As wxTaskBarIcon Ptr) As wxBool
Declare Function wxTaskBarIcon_SetIcon WXCALL Alias "wxTaskBarIcon_SetIcon" (self As wxTaskBarIcon Ptr, icon As wxIcon Ptr, tooltip As wxString Ptr) As wxBool
Declare Function wxTaskBarIcon_RemoveIcon WXCALL Alias "wxTaskBarIcon_RemoveIcon" (self As wxTaskBarIcon Ptr) As wxBool
Declare Function wxTaskBarIcon_PopupMenu WXCALL Alias "wxTaskBarIcon_PopupMenu" (self As wxTaskBarIcon Ptr, menu As wxMenu Ptr) As wxBool

#EndIf ' __taskbaricon_bi__







