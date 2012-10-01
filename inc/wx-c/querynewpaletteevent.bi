#Ifndef __querynewpaletteevent_bi__
#Define __querynewpaletteevent_bi__

#Include Once "common.bi"

Declare Function wxQueryNewPaletteEvent_ctor WXCALL Alias "wxQueryNewPaletteEvent_ctor" (typ As wxEventType) As wxQueryNewPaletteEvent Ptr
Declare Function wxQueryNewPaletteEvent_GetPaletteRealized WXCALL Alias "wxQueryNewPaletteEvent_GetPaletteRealized" (self As wxQueryNewPaletteEvent Ptr) As wxBool
Declare Sub wxQueryNewPaletteEvent_SetPaletteRelized WXCALL Alias "wxQueryNewPaletteEvent_SetPaletteRelized" (self As wxQueryNewPaletteEvent Ptr, realized As wxBool)

#EndIf ' __querynewpaletteevent_bi__

