#Ifndef __commandevent_bi__
#Define __commandevent_bi__

#Include Once "common.bi"

Declare Function wxCommandEvent_CTor WXCALL Alias "wxCommandEvent_CTor" (typ As wxInt, id As wxInt) As wxCommandEvent Ptr
Declare Function wxCommandEvent_GetSelection WXCALL Alias "wxCommandEvent_GetSelection" (self As wxCommandEvent Ptr) As wxInt
Declare Sub wxCommandEvent_SetString WXCALL Alias "wxCommandEvent_SetString" (self As wxCommandEvent Ptr, value As wxString Ptr)
Declare Function wxCommandEvent_GetString WXCALL Alias "wxCommandEvent_GetString" (self As wxCommandEvent Ptr) As wxString Ptr
Declare Function wxCommandEvent_IsChecked WXCALL Alias "wxCommandEvent_IsChecked" (self As wxCommandEvent Ptr) As wxBool
Declare Function wxCommandEvent_IsSelection WXCALL Alias "wxCommandEvent_IsSelection" (self As wxCommandEvent Ptr) As wxBool
Declare Function wxCommandEvent_GetInt WXCALL Alias "wxCommandEvent_GetInt" (self As wxCommandEvent Ptr) As wxInt
Declare Sub wxCommandEvent_SetClientObject WXCALL Alias "wxCommandEvent_SetClientObject" (self As wxCommandEvent Ptr, pClientObject  As wxClientData Ptr)
Declare Function wxCommandEvent_GetClientObject WXCALL Alias "wxCommandEvent_GetClientObject" (self As wxCommandEvent Ptr) As wxClientData Ptr
Declare Sub wxCommandEvent_SetExtraLong WXCALL Alias "wxCommandEvent_SetExtraLong" (self As wxCommandEvent Ptr, extLong As wxInt)
Declare Function wxCommandEvent_GetExtraLong WXCALL Alias "wxCommandEvent_GetExtraLong" (self As wxCommandEvent Ptr) As wxInt

#EndIf ' __commandevent_bi__

