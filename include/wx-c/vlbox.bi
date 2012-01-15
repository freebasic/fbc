#Ifndef __vlbox_bi__
#Define __vlbox_bi__

#Include Once "common.bi"

Type Virtual_voidDcRectSizeT As Sub      WXCALL (As wxDC Ptr, As wxRect Ptr, As size_t)
Type Virtual_IntInt          As Function WXCALL (As wxInt) As wxInt 

Declare Function wxVListBox_ctor WXCALL Alias "wxVListBox_ctor" (parent As wxWindow Ptr, _
                     id      As wxWindowID    = -1, _
                     x       As  wxInt        = -1, _
                     y       As  wxInt        = -1, _
                     w       As  wxInt        = -1, _
                     h       As  wxInt        = -1, _
                     style   As  wxUInt       =  0, _
                     nameArg As wxString Ptr = WX_NULL) As wxVListBox Ptr
Declare Sub wxVListBox_RegisterVirtual WXCALL Alias "wxVListBox_RegisterVirtual" (self As wxVListBox Ptr, _
                                on_DrawItem       As Virtual_voidDcRectSizeT, _
                                on_MeasureItem    As Virtual_IntInt, _
                                on_DrawSeparator  As Virtual_voidDcRectSizeT, _
                                on_DrawBackground As Virtual_voidDcRectSizeT, _
                                on_GetLineHeight  As Virtual_IntInt )
Declare Function wxVListBox_Create WXCALL Alias "wxVListBox_Create" (self As wxVListBox Ptr, _
                       parent  As wxWindow   Ptr          , _
                       id      As  wxWindowID     = -1     , _
                       x       As  wxInt          = -1     , _
                       y       As  wxInt          = -1     , _
                       w       As  wxInt          = -1     , _
                       h       As  wxInt          = -1     , _
                       style   As  wxUInt         =  0     , _
                       nameArg As wxString   Ptr = WX_NULL) As wxBool
Declare Sub wxVListBox_OnDrawSeparator WXCALL Alias "wxVListBox_OnDrawSeparator" (self As wxVListBox Ptr, dc As wxDC Ptr, r As wxRect Ptr, n As wxInt)
Declare Sub wxVListBox_OnDrawBackground WXCALL Alias "wxVListBox_OnDrawBackground" (self As wxVListBox Ptr, dc As wxDC Ptr, r As wxRect Ptr, n As wxInt)
Declare Function wxVListBox_OnGetLineHeight WXCALL Alias "wxVListBox_OnGetLineHeight" (self As wxVListBox Ptr, line_ As wxInt) As wxCoord
Declare Function wxVListBox_GetItemCount WXCALL Alias "wxVListBox_GetItemCount" (self As wxVListBox Ptr) As wxInt
Declare Function wxVListBox_HasMultipleSelection WXCALL Alias "wxVListBox_HasMultipleSelection" (self As wxVListBox Ptr) As wxBool
Declare Function wxVListBox_GetSelection WXCALL Alias "wxVListBox_GetSelection" (self As wxVListBox Ptr) As wxInt
Declare Function wxVListBox_IsCurrent WXCALL Alias "wxVListBox_IsCurrent" (self As wxVListBox Ptr, item As wxInt) As wxBool
Declare Function wxVListBox_IsSelected WXCALL Alias "wxVListBox_IsSelected" (self As wxVListBox Ptr, item As wxInt) As wxBool
Declare Function wxVListBox_GetSelectedCount WXCALL Alias "wxVListBox_GetSelectedCount" (self As wxVListBox Ptr) As wxInt
Declare Function wxVListBox_GetFirstSelected WXCALL Alias "wxVListBox_GetFirstSelected" (self As wxVListBox Ptr, cocki As wxLong Ptr) As wxInt
Declare Function wxVListBox_GetNextSelected WXCALL Alias "wxVListBox_GetNextSelected" (self As wxVListBox Ptr, cocki As wxLong Ptr) As wxInt
Declare Sub wxVListBox_GetMargins WXCALL Alias "wxVListBox_GetMargins" (self As wxVListBox Ptr, pt As wxPoint Ptr)
Declare Function wxVListBox_GetSelectionBackground WXCALL Alias "wxVListBox_GetSelectionBackground" (self As wxVListBox Ptr) As wxColour Ptr
Declare Sub wxVListBox_SetItemCount WXCALL Alias "wxVListBox_SetItemCount" (self As wxVListBox Ptr, count As wxInt)
Declare Sub wxVListBox_Clear WXCALL Alias "wxVListBox_Clear" (self As wxVListBox Ptr)
Declare Sub wxVListBox_SetSelection WXCALL Alias "wxVListBox_SetSelection" (self As wxVListBox Ptr, selection As wxInt)
Declare Function wxVListBox_Select WXCALL Alias "wxVListBox_Select" (self As wxVListBox Ptr, item As wxInt, select_ As wxBool) As wxBool
Declare Function wxVListBox_SelectRange WXCALL Alias "wxVListBox_SelectRange" (self As wxVListBox Ptr, from As wxInt, to_ As wxInt) As wxBool
Declare Sub wxVListBox_Toggle WXCALL Alias "wxVListBox_Toggle" (self As wxVListBox Ptr, item As wxInt)
Declare Function wxVListBox_SelectAll WXCALL Alias "wxVListBox_SelectAll" (self As wxVListBox Ptr) As wxBool
Declare Function wxVListBox_DeselectAll WXCALL Alias "wxVListBox_DeselectAll" (self As wxVListBox Ptr) As wxBool
Declare Sub wxVListBox_SetMargins WXCALL Alias "wxVListBox_SetMargins" (self As wxVListBox Ptr, pt As wxPoint Ptr)
Declare Sub wxVListBox_SetMargins2 WXCALL Alias "wxVListBox_SetMargins2" (self As wxVListBox Ptr, x As wxInt, y As wxInt)
Declare Sub wxVListBox_SetSelectionBackground WXCALL Alias "wxVListBox_SetSelectionBackground" (self As wxVListBox Ptr, col As wxColour Ptr)

#EndIf ' __vlbox_bi__

