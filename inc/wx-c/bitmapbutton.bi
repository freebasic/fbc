#Ifndef __bitmapbutton_bi__
#Define __bitmapbutton_bi__

#Include Once "common.bi"

Type Virtual_OnSetBitmap As Sub WXCALL

' class wxBitmapButton
Declare Function wxBitmapButton_ctor WXCALL Alias "wxBitmapButton_ctor" () As wxBitmapButton Ptr
Declare Sub wxBitmapButton_RegisterVirtual WXCALL Alias "wxBitmapButton_RegisterVirtual" (self As wxBitmapButton Ptr, onSetBitmap As Virtual_OnSetBitmap)
Declare Function wxBitmapButton_Create WXCALL Alias "wxBitmapButton_Create" ( _
									  self      As wxBitmapButton Ptr     , _
                                      parent    As wxWindow       Ptr     , _
                                      id        As  wxWindowID         = -1, _
                                      bitmap    As wxBitmap       Ptr     , _
                                      x         As  wxInt              = -1, _
                                      y         As  wxInt              = -1, _
                                      w         As  wxInt              = -1, _
                                      h         As  wxInt              = -1, _
                                      style     As  wxUInt             =  0, _
                                      validator As wxValidator    Ptr = WX_NULL, _
                                      nameArg   As wxString       Ptr = WX_NULL) As wxBool
Declare Sub wxBitmapButton_OnSetBitmap WXCALL Alias "wxBitmapButton_OnSetBitmap" (self As wxBitmapButton Ptr)
Declare Sub wxBitmapButton_SetLabel WXCALL Alias "wxBitmapButton_SetLabel" (self As wxBitmapButton Ptr, label As wxString Ptr)
Declare Function wxBitmapButton_GetLabel WXCALL Alias "wxBitmapButton_GetLabel" (self As wxBitmapButton Ptr) As wxString Ptr
Declare Function wxBitmapButton_Enable WXCALL Alias "wxBitmapButton_Enable" (self As wxBitmapButton Ptr, enable As wxBool) As wxBool
Declare Sub wxBitmapButton_SetBitmapLabel WXCALL Alias "wxBitmapButton_SetBitmapLabel" (self As wxBitmapButton Ptr, bitmapLabel As wxBitmap Ptr)
Declare Function wxBitmapButton_GetBitmapLabel WXCALL Alias "wxBitmapButton_GetBitmapLabel" (self As wxBitmapButton Ptr) As wxBitmap Ptr
Declare Sub wxBitmapButton_SetBitmapSelected WXCALL Alias "wxBitmapButton_SetBitmapSelected" (self As wxBitmapButton Ptr, bitmapSelected As wxBitmap Ptr)
Declare Function wxBitmapButton_GetBitmapSelected WXCALL Alias "wxBitmapButton_GetBitmapSelected" (self As wxBitmapButton Ptr) As wxBitmap Ptr
Declare Sub wxBitmapButton_SetBitmapDisabled WXCALL Alias "wxBitmapButton_SetBitmapDisabled" (self As wxBitmapButton Ptr, bitmapDisabled As wxBitmap Ptr)
Declare Function wxBitmapButton_GetBitmapDisabled WXCALL Alias "wxBitmapButton_GetBitmapDisabled" (self As wxBitmapButton Ptr) As wxBitmap Ptr
Declare Sub wxBitmapButton_SetBitmapFocus WXCALL Alias "wxBitmapButton_SetBitmapFocus" (self As wxBitmapButton Ptr, bitmapFocus As wxBitmap Ptr)
Declare Function wxBitmapButton_GetBitmapFocus WXCALL Alias "wxBitmapButton_GetBitmapFocus" (self As wxBitmapButton Ptr) As wxBitmap Ptr
Declare Sub wxBitmapButton_SetDefault WXCALL Alias "wxBitmapButton_SetDefault" (self As wxBitmapButton Ptr)
Declare Sub wxBitmapButton_SetMargins WXCALL Alias "wxBitmapButton_SetMargins" (self As wxBitmapButton Ptr, x As wxInt, y As wxInt)
Declare Function wxBitmapButton_GetMarginX WXCALL Alias "wxBitmapButton_GetMarginX" (self As wxBitmapButton Ptr) As wxInt
Declare Function wxBitmapButton_GetMarginY WXCALL Alias "wxBitmapButton_GetMarginY" (self As wxBitmapButton Ptr) As wxInt

#EndIf ' __bitmapbutton_bi__

