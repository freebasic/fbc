#Ifndef __evthandler_bi__
#Define __evthandler_bi__

#Include Once "common.bi"

Type EventListener As Sub WXCALL (event As wxEvent Ptr, iListener As wxInt)
Declare Sub wxEvtHandler_proxy WXCALL Alias "wxEvtHandler_proxy" (self As wxWidget Ptr, listener As EventListener)
Declare Sub wxEvtHandler_Connect WXCALL Alias "wxEvtHandler_Connect" (self As wxWidget Ptr, evtType As wxInt, id As wxInt=-1, lastId As wxInt=-1, iListener As wxInt=0)
Declare Sub wxEvtHandler_ProcessEvent WXCALL Alias "wxEvtHandler_ProcessEvent" (self As wxWidget Ptr, event As wxEvent Ptr)
Declare Sub wxEvtHandler_AddPendingEvent WXCALL Alias "wxEvtHandler_AddPendingEvent" (self As wxWidget Ptr, event As wxEvent Ptr)

#EndIf ' __evthandler_bi__

