#Ifndef __slider_bi__
#Define __slider_bi__

#Include Once "common.bi"

Declare Function wxSlider_ctor WXCALL Alias "wxSlider_ctor" () As wxSlider Ptr
Declare Function wxSlider_Create WXCALL Alias "wxSlider_Create" (self As wxSlider Ptr, _
                     parent    As wxWindow Ptr         , _
                     id        As  wxWindowID      =  -1, _
                     value     As  wxInt           =   0, _
                     minValue  As  wxInt           =   0, _
                     maxValue  As  wxInt           = 100, _
                     x         As  wxInt           =  -1, _
                     y         As  wxInt           =  -1, _
                     w         As  wxInt           =  -1, _
                     h         As  wxInt           =  -1, _
                     style     As  wxUInt          =   0, _
                     validator As wxValidator Ptr = WX_NULL, _
                     nameArg   As wxString    Ptr = WX_NULL) As wxBool
Declare Function wxSlider_GetValue WXCALL Alias "wxSlider_GetValue" (self As wxSlider Ptr) As wxInt
Declare Sub wxSlider_SetValue WXCALL Alias "wxSlider_SetValue" (self As wxSlider Ptr, value As wxInt)
Declare Sub wxSlider_SetRange WXCALL Alias "wxSlider_SetRange" (self As wxSlider Ptr, minValue As wxInt, maxValue As wxInt)
Declare Function wxSlider_GetMin WXCALL Alias "wxSlider_GetMin" (self As wxSlider Ptr) As wxInt
Declare Function wxSlider_GetMax WXCALL Alias "wxSlider_GetMax" (self As wxSlider Ptr) As wxInt
Declare Sub wxSlider_SetLineSize WXCALL Alias "wxSlider_SetLineSize" (self As wxSlider Ptr, lineSize As wxInt)
Declare Sub wxSlider_SetPageSize WXCALL Alias "wxSlider_SetPageSize" (self As wxSlider Ptr, pageSize As wxInt)
Declare Function wxSlider_GetLineSize WXCALL Alias "wxSlider_GetLineSize" (self As wxSlider Ptr) As wxInt
Declare Function wxSlider_GetPageSize WXCALL Alias "wxSlider_GetPageSize" (self As wxSlider Ptr) As wxInt
Declare Sub wxSlider_SetThumbLength WXCALL Alias "wxSlider_SetThumbLength" (self As wxSlider Ptr, lenPixels As wxInt)
Declare Function wxSlider_GetThumbLength WXCALL Alias "wxSlider_GetThumbLength" (self As wxSlider Ptr) As wxInt
Declare Sub wxSlider_SetTickFreq WXCALL Alias "wxSlider_SetTickFreq" (self As wxSlider Ptr, n As wxInt, ipos As wxInt)
Declare Function wxSlider_GetTickFreq WXCALL Alias "wxSlider_GetTickFreq" (self As wxSlider Ptr) As wxInt
Declare Sub wxSlider_ClearTicks WXCALL Alias "wxSlider_ClearTicks" (self As wxSlider Ptr)
Declare Sub wxSlider_SetTick WXCALL Alias "wxSlider_SetTick" (self As wxSlider Ptr, tickPos As wxInt)
Declare Sub wxSlider_ClearSel WXCALL Alias "wxSlider_ClearSel" (self As wxSlider Ptr)
Declare Function wxSlider_GetSelEnd WXCALL Alias "wxSlider_GetSelEnd" (self As wxSlider Ptr) As wxInt
Declare Function wxSlider_GetSelStart WXCALL Alias "wxSlider_GetSelStart" (self As wxSlider Ptr) As wxInt
Declare Sub wxSlider_SetSelection WXCALL Alias "wxSlider_SetSelection" (self As wxSlider Ptr, min As wxInt, max As wxInt)

#EndIf ' __slider_bi__

