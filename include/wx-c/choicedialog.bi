#Ifndef __choicedialog_bi__
#Define __choicedialog_bi__

#Include Once "common.bi"

' class wxSingleChoiceDialog
Declare Function wxSingleChoiceDialog_ctor WXCALL Alias "wxSingleChoiceDialog_ctor" ( _
							   parent     As wxWindow      Ptr, _
                               messageArg As wxString      Ptr, _
                               captionArg As wxString      Ptr, _
                               pChoices   As wxArrayString Ptr, _
                               clientData As Any        Ptr Ptr, _
                               style      As  wxUInt           , _
                               x          As  wxInt            , _
                               y          As  wxInt) As wxSingleChoiceDialog Ptr
Declare Sub wxSingleChoiceDialog_dtor WXCALL Alias "wxSingleChoiceDialog_dtor" (self As wxSingleChoiceDialog Ptr)
Declare Sub wxSingleChoiceDialog_SetSelection WXCALL Alias "wxSingleChoiceDialog_SetSelection" (self As wxSingleChoiceDialog Ptr, sel As wxInt)
Declare Function wxSingleChoiceDialog_GetSelection WXCALL Alias "wxSingleChoiceDialog_GetSelection" (self As wxSingleChoiceDialog Ptr) As wxInt
Declare Function wxSingleChoiceDialog_GetStringSelection WXCALL Alias "wxSingleChoiceDialog_GetStringSelection" (self As wxSingleChoiceDialog Ptr) As wxString Ptr
Declare Function wxSingleChoiceDialog_GetSelectionClientData WXCALL Alias "wxSingleChoiceDialog_GetSelectionClientData" (self As wxSingleChoiceDialog Ptr) As Any Ptr

' class wxMultiChoiceDialog
Declare Function wxMultiChoiceDialog_ctor WXCALL Alias "wxMultiChoiceDialog_ctor" ( _
							  parent     As wxWindow      Ptr, _
                              messageArg As wxString      Ptr, _
                              captionArg As wxString      Ptr, _
                              pChoices   As wxArrayString Ptr, _
                              style      As  wxInt            , _
                              x          As  wxInt            , _
                              y          As  wxInt) As wxMultiChoiceDialog Ptr
Declare Sub wxMultiChoiceDialog_dtor WXCALL Alias "wxMultiChoiceDialog_dtor" (self As wxMultiChoiceDialog Ptr)
Declare Sub wxMultiChoiceDialog_SetSelections WXCALL Alias "wxMultiChoiceDialog_SetSelections" (self As wxMultiChoiceDialog Ptr, sel As wxInt Ptr, numsel As wxInt)
Declare Function wxMultiChoiceDialog_GetSelections WXCALL Alias "wxMultiChoiceDialog_GetSelections" (self As wxMultiChoiceDialog Ptr) As wxArrayInt Ptr
Declare Function wxGetSingleChoice_func WXCALL Alias "wxGetSingleChoice_func" ( _
								 messageArg As wxString      Ptr, _
                                 captionArg As wxString      Ptr, _
                                 pChoices   As wxArrayString Ptr, _
                                 parent     As wxWindow      Ptr, _
                                 x          As  wxInt            , _
                                 y          As  wxInt            , _
                                 center     As  wxBool           , _
                                 w          As  wxInt            , _
                                 h          As  wxInt) As wxString Ptr
Declare Function wxGetSingleChoiceIndex_func WXCALL Alias "wxGetSingleChoiceIndex_func" ( _
								 messageArg As wxString      Ptr, _
                                 captionArg As wxString      Ptr, _
                                 pChoices   As wxArrayString Ptr, _
                                 parent     As wxWindow      Ptr, _
                                 x          As  wxInt            , _
                                 y          As  wxInt            , _
                                 center     As  wxBool           , _
                                 w          As  wxInt            , _
                                 h          As  wxInt) As wxInt

#EndIf ' __choicedialog_bi__

