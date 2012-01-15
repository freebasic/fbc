#Ifndef __textctrl_bi__
#Define __textctrl_bi__

#Include Once "common.bi"

' class wxTextAttr
Declare Function wxTextAttr_ctor WXCALL Alias "wxTextAttr_ctor" (fg As wxColour Ptr, bg As wxColour Ptr, font As wxFont Ptr, alignment As wxTextAttrAlignment) As wxTextAttr Ptr 
Declare Function wxTextAttr_ctor2 WXCALL Alias "wxTextAttr_ctor2" () As wxTextAttr Ptr
Declare Sub wxTextAttr_dtor WXCALL Alias "wxTextAttr_dtor" (self As wxTextAttr Ptr)
Declare Sub wxTextAttr_Init WXCALL Alias "wxTextAttr_Init" (self As wxTextAttr Ptr)
Declare Sub wxTextAttr_SetTextColour WXCALL Alias "wxTextAttr_SetTextColour" (self As wxTextAttr Ptr, fg As wxColour Ptr)
Declare Function wxTextAttr_GetTextColour WXCALL Alias "wxTextAttr_GetTextColour" (self As wxTextAttr Ptr) As wxColour Ptr
Declare Sub wxTextAttr_SetBackgroundColour WXCALL Alias "wxTextAttr_SetBackgroundColour" (self As wxTextAttr Ptr, bg As wxColour Ptr)
Declare Sub wxTextAttr_SetFont WXCALL Alias "wxTextAttr_SetFont" (self As wxTextAttr Ptr, font As wxFont Ptr)
Declare Function wxTextAttr_HasTextColour WXCALL Alias "wxTextAttr_HasTextColour" (self As wxTextAttr Ptr) As wxBool
Declare Function wxTextAttr_HasBackgroundColour WXCALL Alias "wxTextAttr_HasBackgroundColour" (self As wxTextAttr Ptr) As wxBool
Declare Function wxTextAttr_HasFont WXCALL Alias "wxTextAttr_HasFont" (self As wxTextAttr Ptr) As wxBool
Declare Function wxTextAttr_HasAlignment WXCALL Alias "wxTextAttr_HasAlignment" (self As wxTextAttr Ptr) As wxBool
Declare Function wxTextAttr_HasTabs WXCALL Alias "wxTextAttr_HasTabs" (self As wxTextAttr Ptr) As wxBool
Declare Function wxTextAttr_HasLeftIndent WXCALL Alias "wxTextAttr_HasLeftIndent" (self As wxTextAttr Ptr) As wxBool
Declare Function wxTextAttr_HasRightIndent WXCALL Alias "wxTextAttr_HasRightIndent" (self As wxTextAttr Ptr) As wxBool
Declare Function wxTextAttr_HasFlag WXCALL Alias "wxTextAttr_HasFlag" (self As wxTextAttr Ptr, uFlag As wxUInt) As wxBool
Declare Function wxTextAttr_IsDefault WXCALL Alias "wxTextAttr_IsDefault" (self As wxTextAttr Ptr) As wxBool
Declare Sub wxTextAttr_SetAlignment WXCALL Alias "wxTextAttr_SetAlignment" (self As wxTextAttr Ptr, alignment As wxTextAttrAlignment)
Declare Function wxTextAttr_GetAlignment WXCALL Alias "wxTextAttr_GetAlignment" (self As wxTextAttr Ptr) As wxTextAttrAlignment
Declare Function wxTextAttr_GetBackgroundColour WXCALL Alias "wxTextAttr_GetBackgroundColour" (self As wxTextAttr Ptr) As wxColour Ptr
Declare Function wxTextAttr_GetFont WXCALL Alias "wxTextAttr_GetFont" (self As wxTextAttr Ptr) As wxFont Ptr
Declare Function wxTextAttr_GetLeftIndent WXCALL Alias "wxTextAttr_GetLeftIndent" (self As wxTextAttr Ptr) As wxInt
Declare Function wxTextAttr_GetLeftSubIndent WXCALL Alias "wxTextAttr_GetLeftSubIndent" (self As wxTextAttr Ptr) As wxInt
Declare Sub wxTextAttr_SetTabs WXCALL Alias "wxTextAttr_SetTabs" (self As wxTextAttr Ptr, tabs As wxArrayInt Ptr)
Declare Function wxTextAttr_GetTabs WXCALL Alias "wxTextAttr_GetTabs" (self As wxTextAttr Ptr) As wxArrayInt Ptr
Declare Sub wxTextAttr_SetLeftIndent WXCALL Alias "wxTextAttr_SetLeftIndent" (self As wxTextAttr Ptr, indent As wxInt, subIndent As wxInt)
Declare Sub wxTextAttr_SetRightIndent WXCALL Alias "wxTextAttr_SetRightIndent" (self As wxTextAttr Ptr, indent As wxInt)
Declare Function wxTextAttr_GetRightIndent WXCALL Alias "wxTextAttr_GetRightIndent" (self As wxTextAttr Ptr) As wxInt
Declare Sub wxTextAttr_SetFlags WXCALL Alias "wxTextAttr_SetFlags" (self As wxTextAttr Ptr, flags As wxInt)
Declare Function wxTextAttr_GetFlags WXCALL Alias "wxTextAttr_GetFlags" (self As wxTextAttr Ptr) As wxInt

' class wxTextCtrl
Declare Function wxTextCtrl_ctor WXCALL Alias "wxTextCtrl_ctor" () As wxTextCtrl Ptr
Declare Function wxTextCtrl_Create WXCALL Alias "wxTextCtrl_Create" (self As wxTextCtrl Ptr, _
                       parent    As wxWindow    Ptr          , _
                       id        As  wxWindowID      = -1     , _
                       valueArg  As wxString Ptr    = WX_NULL, _
                       x         As  wxInt           = -1     , _
                       y         As  wxInt           = -1     , _
                       w         As  wxInt           = -1     , _
                       h         As  wxInt           = -1     , _
                       style     As  wxUInt          =  0     , _
                       validator As wxValidator Ptr = WX_NULL, _
                       nameArg   As wxString    Ptr = WX_NULL) As wxBool
Declare Function wxTextCtrl_Enable WXCALL Alias "wxTextCtrl_Enable" (self As wxTextCtrl Ptr, enable As wxBool) As wxBool
Declare Sub wxTextCtrl_OnDropFiles WXCALL Alias "wxTextCtrl_OnDropFiles" (self As wxTextCtrl Ptr, event As wxDropFilesEvent Ptr)
Declare Function wxTextCtrl_SetFont WXCALL Alias "wxTextCtrl_SetFont" (self As wxTextCtrl Ptr, font As wxFont Ptr) As wxBool
Declare Function wxTextCtrl_SetForegroundColour WXCALL Alias "wxTextCtrl_SetForegroundColour" (self As wxTextCtrl Ptr, col As wxColour Ptr) As wxBool
Declare Function wxTextCtrl_SetBackgroundColour WXCALL Alias "wxTextCtrl_SetBackgroundColour" (self As wxTextCtrl Ptr, col As wxColour Ptr) As wxBool
Declare Sub wxTextCtrl_Freeze WXCALL Alias "wxTextCtrl_Freeze" (self As wxTextCtrl Ptr)
Declare Sub wxTextCtrl_Thaw WXCALL Alias "wxTextCtrl_Thaw" (self As wxTextCtrl Ptr)
Declare Function wxTextCtrl_ScrollLines WXCALL Alias "wxTextCtrl_ScrollLines" (self As wxTextCtrl Ptr, lines As wxInt) As wxBool
Declare Function wxTextCtrl_ScrollPages WXCALL Alias "wxTextCtrl_ScrollPages" (self As wxTextCtrl Ptr, pages As wxInt) As wxBool
Declare Sub wxTextCtrl_MarkDirty WXCALL Alias "wxTextCtrl_MarkDirty" (self As wxTextCtrl Ptr)
Declare Function wxTextCtrl_HitTest WXCALL Alias "wxTextCtrl_HitTest" (self As wxTextCtrl Ptr, pt As wxPoint Ptr, iPos As wxInt Ptr) As wxTextCtrlHitTestResult
Declare Function wxTextCtrl_HitTest2 WXCALL Alias "wxTextCtrl_HitTest2" (self As wxTextCtrl Ptr, pt As wxPoint Ptr, col As wxTextCoord Ptr, row As wxTextCoord Ptr) As wxTextCtrlHitTestResult
Declare Function wxTextCtrl_GetValue WXCALL Alias "wxTextCtrl_GetValue" (self As wxTextCtrl Ptr) As wxString Ptr
Declare Sub wxTextCtrl_SetValue WXCALL Alias "wxTextCtrl_SetValue" (self As wxTextCtrl Ptr, value As wxString Ptr)
Declare Function wxTextCtrl_GetRange WXCALL Alias "wxTextCtrl_GetRange" (self As wxTextCtrl Ptr, iFrom As wxInt, iTo As wxInt) As wxString Ptr
Declare Function wxTextCtrl_GetLineLength WXCALL Alias "wxTextCtrl_GetLineLength" (self As wxTextCtrl Ptr, lineNo As wxInt) As wxInt
Declare Function wxTextCtrl_GetLineText WXCALL Alias "wxTextCtrl_GetLineText" (self As wxTextCtrl Ptr, lineNo As wxInt) As wxString Ptr
Declare Function wxTextCtrl_GetNumberOfLines WXCALL Alias "wxTextCtrl_GetNumberOfLines" (self As wxTextCtrl Ptr) As wxInt
Declare Function wxTextCtrl_IsModified WXCALL Alias "wxTextCtrl_IsModified" (self As wxTextCtrl Ptr) As wxBool
Declare Function wxTextCtrl_IsEditable WXCALL Alias "wxTextCtrl_IsEditable" (self As wxTextCtrl Ptr) As wxBool
Declare Function wxTextCtrl_IsSingleLine WXCALL Alias "wxTextCtrl_IsSingleLine" (self As wxTextCtrl Ptr) As wxBool
Declare Function wxTextCtrl_IsMultiLine WXCALL Alias "wxTextCtrl_IsMultiLine" (self As wxTextCtrl Ptr) As wxBool
Declare Sub wxTextCtrl_GetSelection WXCALL Alias "wxTextCtrl_GetSelection" (self As wxTextCtrl Ptr, iFrom As wxInt Ptr, iTo As wxInt Ptr)
Declare Function wxTextCtrl_GetStringSelection WXCALL Alias "wxTextCtrl_GetStringSelection" (self As wxTextCtrl Ptr) As wxString Ptr
Declare Sub wxTextCtrl_Clear WXCALL Alias "wxTextCtrl_Clear" (self As wxTextCtrl Ptr)
Declare Sub wxTextCtrl_Replace WXCALL Alias "wxTextCtrl_Replace" (self As wxTextCtrl Ptr, iFrom As wxInt, iTo As wxInt, value As wxString Ptr)
Declare Sub wxTextCtrl_Remove WXCALL Alias "wxTextCtrl_Remove" (self As wxTextCtrl Ptr, iFrom As wxInt, iTo As wxInt)
Declare Function wxTextCtrl_LoadFile WXCALL Alias "wxTextCtrl_LoadFile" (self As wxTextCtrl Ptr, fileName As wxString Ptr) As wxBool
Declare Function wxTextCtrl_SaveFile WXCALL Alias "wxTextCtrl_SaveFile" (self As wxTextCtrl Ptr, fileName As wxString Ptr) As wxBool
Declare Sub wxTextCtrl_DiscardEdits WXCALL Alias "wxTextCtrl_DiscardEdits" (self As wxTextCtrl Ptr)
Declare Sub wxTextCtrl_SetMaxLength WXCALL Alias "wxTextCtrl_SetMaxLength" (self As wxTextCtrl Ptr, maxLength As wxInt)
Declare Sub wxTextCtrl_WriteText WXCALL Alias "wxTextCtrl_WriteText" (self As wxTextCtrl Ptr, txt As wxString Ptr)
Declare Sub wxTextCtrl_AppendText WXCALL Alias "wxTextCtrl_AppendText" (self As wxTextCtrl Ptr, txt As wxString Ptr)
Declare Function wxTextCtrl_EmulateKeyPress WXCALL Alias "wxTextCtrl_EmulateKeyPress" (self As wxTextCtrl Ptr, event As wxKeyEvent Ptr) As wxBool
Declare Function wxTextCtrl_SetStyle WXCALL Alias "wxTextCtrl_SetStyle" (self As wxTextCtrl Ptr, iStart As wxInt, iEnd As wxInt, style As wxTextAttr Ptr) As wxBool
Declare Function wxTextCtrl_GetStyle WXCALL Alias "wxTextCtrl_GetStyle" (self As wxTextCtrl Ptr, position As wxInt, style As wxTextAttr Ptr) As wxBool
Declare Function wxTextCtrl_SetDefaultStyle WXCALL Alias "wxTextCtrl_SetDefaultStyle" (self As wxTextCtrl Ptr, style As wxTextAttr Ptr) As wxBool
Declare Function wxTextCtrl_GetDefaultStyle WXCALL Alias "wxTextCtrl_GetDefaultStyle" (self As wxTextCtrl Ptr) As wxTextAttr Ptr
Declare Function wxTextCtrl_XYToPosition WXCALL Alias "wxTextCtrl_XYToPosition" (self As wxTextCtrl Ptr, x As wxInt, y As wxInt) As wxInt
Declare Function wxTextCtrl_PositionToXY WXCALL Alias "wxTextCtrl_PositionToXY" (self As wxTextCtrl Ptr, iPos As wxInt, x As wxInt Ptr, y As wxInt Ptr) As wxBool
Declare Sub wxTextCtrl_ShowPosition WXCALL Alias "wxTextCtrl_ShowPosition" (self As wxTextCtrl Ptr, iPos As wxInt)
Declare Sub wxTextCtrl_Copy WXCALL Alias "wxTextCtrl_Copy" (self As wxTextCtrl Ptr)
Declare Sub wxTextCtrl_Cut WXCALL Alias "wxTextCtrl_Cut" (self As wxTextCtrl Ptr)
Declare Sub wxTextCtrl_Paste WXCALL Alias "wxTextCtrl_Paste" (self As wxTextCtrl Ptr)
Declare Function wxTextCtrl_CanCopy WXCALL Alias "wxTextCtrl_CanCopy" (self As wxTextCtrl Ptr) As wxBool
Declare Function wxTextCtrl_CanCut WXCALL Alias "wxTextCtrl_CanCut" (self As wxTextCtrl Ptr) As wxBool
Declare Function wxTextCtrl_CanPaste WXCALL Alias "wxTextCtrl_CanPaste" (self As wxTextCtrl Ptr) As wxBool
Declare Sub wxTextCtrl_Undo WXCALL Alias "wxTextCtrl_Undo" (self As wxTextCtrl Ptr)
Declare Sub wxTextCtrl_Redo WXCALL Alias "wxTextCtrl_Redo" (self As wxTextCtrl Ptr)
Declare Function wxTextCtrl_CanUndo WXCALL Alias "wxTextCtrl_CanUndo" (self As wxTextCtrl Ptr) As wxBool
Declare Function wxTextCtrl_CanRedo WXCALL Alias "wxTextCtrl_CanRedo" (self As wxTextCtrl Ptr) As wxBool
Declare Sub wxTextCtrl_SetInsertionPoint WXCALL Alias "wxTextCtrl_SetInsertionPoint" (self As wxTextCtrl Ptr, iPos As wxInt)
Declare Sub wxTextCtrl_SetInsertionPointEnd WXCALL Alias "wxTextCtrl_SetInsertionPointEnd" (self As wxTextCtrl Ptr)
Declare Function wxTextCtrl_GetInsertionPoint WXCALL Alias "wxTextCtrl_GetInsertionPoint" (self As wxTextCtrl Ptr) As wxInt
Declare Function wxTextCtrl_GetLastPosition WXCALL Alias "wxTextCtrl_GetLastPosition" (self As wxTextCtrl Ptr) As wxInt
Declare Sub wxTextCtrl_SetSelection WXCALL Alias "wxTextCtrl_SetSelection" (self As wxTextCtrl Ptr, iFrom As wxInt, iTo As wxInt)
Declare Sub wxTextCtrl_SelectAll WXCALL Alias "wxTextCtrl_SelectAll" (self As wxTextCtrl Ptr)
Declare Sub wxTextCtrl_SetEditable WXCALL Alias "wxTextCtrl_SetEditable" (self As wxTextCtrl Ptr, editable As wxBool)

' class wxTextUrlEvent
Declare Function wxTextUrlEvent_ctor WXCALL Alias "wxTextUrlEvent_ctor" (id As wxInt, mouseEvent As wxMouseEvent Ptr, iStart As wxInt, iEnd As wxInt) As wxTextUrlEvent Ptr
Declare Function wxTextUrlEvent_GetURLStart WXCALL Alias "wxTextUrlEvent_GetURLStart" (self As wxTextUrlEvent Ptr) As wxInt
Declare Function wxTextUrlEvent_GetURLEnd WXCALL Alias "wxTextUrlEvent_GetURLEnd" (self As wxTextUrlEvent Ptr) As wxInt

#EndIf ' __textctrl_bi__

