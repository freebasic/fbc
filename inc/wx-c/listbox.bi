#Ifndef __listbox_bi__
#Define __listbox_bi__

#Include Once "common.bi"

' class wxListBox
Declare Function wxListBox_ctor WXCALL Alias "wxListBox_ctor" () As wxListBox Ptr
Declare Sub wxListBox_dtor WXCALL Alias "wxListBox_dtor" (self As wxListBox Ptr)
Declare Function wxListBox_Create WXCALL Alias "wxListBox_Create" (self As wxListBox Ptr, _
                      parent    As wxWindow      Ptr, _
                      id        As  wxWindowID        = -1, _
                      pos       As  wxPoint      Ptr     , _
                      size      As  wxSize       Ptr     , _
                      items     As wxArrayString Ptr = WX_NULL, _
                      style     As  wxUInt            =  0, _
                      validator As wxValidator   Ptr = WX_NULL, _
                      nameArg   As wxString      Ptr = WX_NULL) As wxBool
Declare Sub wxListBox_SetSingleString WXCALL Alias "wxListBox_SetSingleString" (self As wxListBox Ptr, n As wxInt, s As wxString Ptr)
Declare Function wxListBox_GetSingleString WXCALL Alias "wxListBox_GetSingleString" (self As wxListBox Ptr, index As wxInt) As wxString Ptr
Declare Sub wxListBox_SetSelection WXCALL Alias "wxListBox_SetSelection" (self As wxListBox Ptr, n As wxInt, DoSelect As wxBool)
Declare Function wxListBox_GetSelection WXCALL Alias "wxListBox_GetSelection" (self As wxListBox Ptr) As wxInt
Declare Function wxListBox_GetSelections WXCALL Alias "wxListBox_GetSelections" (self As wxListBox Ptr) As wxArrayInt Ptr
Declare Sub wxListBox_InsertItems WXCALL Alias "wxListBox_InsertItems" (self As wxListBox Ptr, items As wxArrayString Ptr, pos_ As wxInt)
Declare Sub wxListBox_Set WXCALL Alias "wxListBox_Set" (self As wxListBox Ptr, items As wxArrayString Ptr, clientData As wxClientData Ptr Ptr)
Declare Sub wxListBox_Select WXCALL Alias "wxListBox_Select" (self As wxListBox Ptr, n As wxInt)
Declare Sub wxListBox_Deselect WXCALL Alias "wxListBox_Deselect" (self As wxListBox Ptr, n As wxInt)
Declare Sub wxListBox_DeselectAll WXCALL Alias "wxListBox_DeselectAll" (self As wxListBox Ptr, itemToLeaveSelected As wxInt)
Declare Sub wxListBox_SetFirstItem WXCALL Alias "wxListBox_SetFirstItem" (self As wxListBox Ptr, n As wxInt)
Declare Sub wxListBox_SetFirstItemText WXCALL Alias "wxListBox_SetFirstItemText" (self As wxListBox Ptr, txt As wxString Ptr)
Declare Function wxListBox_HasMultipleSelection WXCALL Alias "wxListBox_HasMultipleSelection" (self As wxListBox Ptr) As wxBool
Declare Function wxListBox_IsSorted WXCALL Alias "wxListBox_IsSorted" (self As wxListBox Ptr) As wxBool
Declare Sub wxListBox_Command WXCALL Alias "wxListBox_Command" (self As wxListBox Ptr, commandEvent As wxCommandEvent Ptr)
Declare Function wxListBox_GetStringSelection WXCALL Alias "wxListBox_GetStringSelection" (self As wxListBox Ptr) As wxString Ptr

' class wxCheckListBox
Declare Function wxCheckListBox_ctor1 WXCALL Alias "wxCheckListBox_ctor1" () As wxCheckListBox Ptr
Declare Function wxCheckListBox_ctor2 WXCALL Alias "wxCheckListBox_ctor2" (parent As wxWindow Ptr, _
                          id        As  wxWindowID       =-1, _
                       	  pos       As  wxPoint      Ptr     , _
                       	  size      As  wxSize       Ptr     , _
                          choices   As wxArrayString Ptr, _
                          style     As  wxUint           = 0, _
                          validator As wxValidator   Ptr = WX_NULL, _
                          nameArg   As wxString      Ptr = WX_NULL) As wxCheckListBox Ptr
Declare Function wxCheckListBox_IsChecked WXCALL Alias "wxCheckListBox_IsChecked" (self As wxCheckListBox Ptr, index As wxInt) As wxBool
Declare Sub wxCheckListBox_Check WXCALL Alias "wxCheckListBox_Check" (self As wxCheckListBox Ptr, index As wxInt, check As wxBool)
Declare Function wxCheckListBox_GetItemHeight WXCALL Alias "wxCheckListBox_GetItemHeight" (self As wxCheckListBox Ptr) As wxInt

#EndIf ' __listbox_bi__

