#Ifndef __palettechangedevent_bi__
#Define __palettechangedevent_bi__

#Include Once "common.bi"

Declare Function wxPaletteChangedEvent_ctor WXCALL Alias "wxPaletteChangedEvent_ctor" (typ As wxEventType) As wxPaletteChangedEvent Ptr
Declare Sub wxPaletteChangedEvent_SetChangedWindow WXCALL Alias "wxPaletteChangedEvent_SetChangedWindow" (self As wxPaletteChangedEvent Ptr, win As wxWindow Ptr)
Declare Function wxPaletteChangedEvent_GetChangedWindow WXCALL Alias "wxPaletteChangedEvent_GetChangedWindow" (self As wxPaletteChangedEvent Ptr) As wxWindow Ptr

#EndIf ' __palettechangedevent_bi__

