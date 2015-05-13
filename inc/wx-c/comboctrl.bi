#Ifndef __comboctrl_bi__
#Define __comboctrl_bi__

#Include Once "common.bi"

Type CallInit                As Sub      WXCALL 
Type CallCreate              As Function WXCALL (parent As wxWindow Ptr) As wxBool
Type CallOnPopup             As Sub      WXCALL 
Type CallOnDismiss           As Sub      WXCALL 
Type CallSetStringValue      As Sub      WXCALL (stringValue As wxString Ptr)
Type CallGetStringValue      As Function WXCALL As wxString Ptr
Type CallPaintComboControl   As Sub      WXCALL (dc As wxDC Ptr, x As wxInt, y As wxInt, w As wxInt, h As wxInt)
Type CallOnComboKeyEvent     As Sub      WXCALL (keyEvent As wxKeyEvent Ptr)
Type CallOnComboDoubleClick  As Sub      WXCALL 
Type CallGetAdjustedSize     As Sub      WXCALL (w As wxInt Ptr, h As wxInt Ptr, minWidth As wxInt, prefHeight As wxInt, maxHeight As wxInt)
Type CallLazyCreate          As Function WXCALL As wxBool
Type CallGetControl          As Function WXCALL As wxWindow Ptr

Type CallOnButtonClick       As Sub      WXCALL

Declare Function wxComboPopup_ctor WXCALL Alias "wxComboPopup_ctor" () As wxComboPopup Ptr
Declare Sub wxComboPopup_dtor WXCALL Alias "wxComboPopup_dtor" (self As wxComboPopup Ptr)
Declare Function wxComboPopup_ComboControl WXCALL Alias "wxComboPopup_ComboControl" (self As wxComboPopup Ptr) As wxWindow Ptr
Declare Sub wxComboPopup_PaintComboControl WXCALL Alias "wxComboPopup_PaintComboControl" (self As wxComboPopup Ptr, dc As wxDC Ptr, x As wxInt, y As wxInt, w As wxInt, h As wxInt)
Declare Sub wxComboPopup_GetAdjustedSize WXCALL Alias "wxComboPopup_GetAdjustedSize" (self As wxComboPopup Ptr,w As wxInt Ptr, h As wxInt Ptr, minWidth As wxInt, prefHeight As wxInt, maxHeight As wxInt)
Declare Sub wxComboPopup_Dismiss WXCALL Alias "wxComboPopup_Dismiss" (self As wxComboPopup Ptr)
Declare Function wxComboPopup_IsCreated WXCALL Alias "wxComboPopup_IsCreated" (self As wxComboPopup Ptr) As wxBool
Declare Sub wxComboPopup_RegisterVirtual WXCALL Alias "wxComboPopup_RegisterVirtual" ( _
								  self As wxComboPopup Ptr, _
                                  on_Dispose              As Virtual_Dispose, _
                                  call_Init               As CallInit, _
                                  call_Create             As CallCreate, _
                                  call_OnPopup            As CallOnPopup, _
                                  call_OnDismiss          As CallOnDismiss, _
                                  call_SetStringValue     As CallSetStringValue, _
                                  call_GetStringValueas   As CallGetStringValue, _
                                  call_PaintComboControl  As CallPaintComboControl, _
                                  call_OnComboKeyEvent    As CallOnComboKeyEvent, _
                                  call_OnComboDoubleClick As CallOnComboDoubleClick, _
                                  call_GetAdjustedSize    As CallGetAdjustedSize, _
                                  call_LazyCreate         As CallLazyCreate)
Declare Function wxComboCtrl_ctor WXCALL Alias "wxComboCtrl_ctor" () As wxComboCtrl Ptr
Declare Sub wxComboCtrl_Create WXCALL Alias "wxComboCtrl_Create" ( _
						self    As wxComboCtrl Ptr, _
                        parent  As wxWindow    Ptr, _
                        id      As  wxWindowID      = -1, _
                        value   As wxString    Ptr     , _
                        x       As  wxInt           = -1, _
                        y       As  wxInt           = -1, _
                        w       As  wxInt           = -1, _
                        h       As  wxInt           = -1, _
                        style   As  wxUInt          = -1, _
                        nameArg As wxString    Ptr = WX_NULL)
Declare Sub wxComboCtrl_ShowPopup WXCALL Alias "wxComboCtrl_ShowPopup" (self As wxComboCtrl Ptr)
Declare Sub wxComboCtrl_HidePopup WXCALL Alias "wxComboCtrl_HidePopup" (self As wxComboCtrl Ptr)
Declare Sub wxComboCtrl_OnButtonClick WXCALL Alias "wxComboCtrl_OnButtonClick" (self As wxComboCtrl Ptr)
Declare Function wxComboCtrl_IsPopupShown WXCALL Alias "wxComboCtrl_IsPopupShown" (self As wxComboCtrl Ptr) As wxBool
Declare Function wxComboCtrl_GetPopupControl WXCALL Alias "wxComboCtrl_GetPopupControl" (self As wxComboCtrl Ptr) As wxComboPopup Ptr
Declare Function wxComboCtrl_GetPopupWindow WXCALL Alias "wxComboCtrl_GetPopupWindow" (self As wxComboCtrl Ptr) As wxWindow Ptr
Declare Function wxComboCtrl_GetTextCtrl WXCALL Alias "wxComboCtrl_GetTextCtrl" (self As wxComboCtrl Ptr) As wxTextCtrl Ptr
Declare Function wxComboCtrl_GetButton WXCALL Alias "wxComboCtrl_GetButton" (self As wxComboCtrl Ptr) As wxWindow Ptr
Declare Function wxComboCtrl_Enable WXCALL Alias "wxComboCtrl_Enable" (self As wxComboCtrl Ptr, enable As wxBool) As wxBool
Declare Function wxComboCtrl_Show WXCALL Alias "wxComboCtrl_Show" (self As wxComboCtrl Ptr, enable As wxBool) As wxBool
Declare Sub wxComboCtrl_SetFont WXCALL Alias "wxComboCtrl_SetFont" (self As wxComboCtrl Ptr, font As wxFont Ptr)
Declare Sub wxComboCtrl_SetPopupControl WXCALL Alias "wxComboCtrl_SetPopupControl" (self As wxComboCtrl Ptr, ctrl As wxComboPopup Ptr)
Declare Function wxComboCtrl_GetValue WXCALL Alias "wxComboCtrl_GetValue" (self As wxComboCtrl Ptr) As wxString Ptr
Declare Sub wxComboCtrl_SetValue WXCALL Alias "wxComboCtrl_SetValue" (self As wxComboCtrl Ptr, stringValue As wxString Ptr)
Declare Sub wxComboCtrl_RegisterVirtual WXCALL Alias "wxComboCtrl_RegisterVirtual" (self As wxComboCtrl Ptr, on_ButtonClick As CallOnButtonClick)
Declare Sub wxComboCtrl_Copy WXCALL Alias "wxComboCtrl_Copy" (self As wxComboCtrl Ptr)
Declare Sub wxComboCtrl_Cut WXCALL Alias "wxComboCtrl_Cut" (self As wxComboCtrl Ptr)
Declare Sub wxComboCtrl_Paste WXCALL Alias "wxComboCtrl_Paste" (self As wxComboCtrl Ptr)
Declare Sub wxComboCtrl_SetInsertionPoint WXCALL Alias "wxComboCtrl_SetInsertionPoint" (self As wxComboCtrl Ptr, position As wxInt)
Declare Sub wxComboCtrl_SetInsertionPointEnd WXCALL Alias "wxComboCtrl_SetInsertionPointEnd" (self As wxComboCtrl Ptr)
Declare Function wxComboCtrl_GetInsertionPoint WXCALL Alias "wxComboCtrl_GetInsertionPoint" (self As wxComboCtrl Ptr) As wxInt
Declare Function wxComboCtrl_GetLastPosition WXCALL Alias "wxComboCtrl_GetLastPosition" (self As wxComboCtrl Ptr) As wxInt
Declare Sub wxComboCtrl_Replace WXCALL Alias "wxComboCtrl_Replace" (self As wxComboCtrl Ptr, ifrom As wxInt, ito As wxInt, value As wxString Ptr)
Declare Sub wxComboCtrl_Remove WXCALL Alias "wxComboCtrl_Remove" (self As wxComboCtrl Ptr, ifrom As wxInt, ito As wxInt)
Declare Sub wxComboCtrl_SetSelection WXCALL Alias "wxComboCtrl_SetSelection" (self As wxComboCtrl Ptr, ifrom As wxInt, ito As wxInt)
Declare Sub wxComboCtrl_Undo WXCALL Alias "wxComboCtrl_Undo" (self As wxComboCtrl Ptr)

#EndIf ' __comboctrl_bi__

