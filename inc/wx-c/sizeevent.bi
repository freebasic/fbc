#Ifndef __sizeevent_bi__
#Define __sizeevent_bi__

#Include Once "common.bi"

Declare Function wxSizeEvent_ctor WXCALL Alias "wxSizeEvent_ctor" () As wxSizeEvent Ptr
Declare Function wxSizeEvent_ctor2 WXCALL Alias "wxSizeEvent_ctor2" (w As wxInt, h As wxInt, id As wxInt) As wxSizeEvent Ptr
Declare Sub wxSizeEvent_GetSize WXCALL Alias "wxSizeEvent_GetSize" (self As wxSizeEvent Ptr, size As wxSize Ptr)

#EndIf ' __sizeevent_bi__

