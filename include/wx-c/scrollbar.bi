#Ifndef __scrollbar_bi__
#Define __scrollbar_bi__

#Include Once "common.bi"

Declare Function wxScrollBar_ctor WXCALL Alias "wxScrollBar_ctor" () As wxScrollBar Ptr
Declare Function wxScrollBar_Create WXCALL Alias "wxScrollBar_Create" (self As wxScrollBar Ptr, _
                        parent    As wxWindow    Ptr     , _
                        id        As  wxWindowID      = -1, _
                        x         As  wxInt           = -1, _
                        y         As  wxInt           = -1, _
                        w         As  wxInt           = -1, _
                        h         As  wxInt           = -1, _
                        style     As  wxUint          =  0, _
                        validator As wxValidator Ptr = WX_NULL, _
                        nameArg   As wxString    Ptr = WX_NULL) As wxBool
Declare Function wxScrollBar_GetThumbPosition WXCALL Alias "wxScrollBar_GetThumbPosition" (self As wxScrollBar Ptr) As wxInt
Declare Function wxScrollBar_GetThumbSize WXCALL Alias "wxScrollBar_GetThumbSize" (self As wxScrollBar Ptr) As wxInt
Declare Function wxScrollBar_GetPageSize WXCALL Alias "wxScrollBar_GetPageSize" (self As wxScrollBar Ptr) As wxInt
Declare Function wxScrollBar_GetRange WXCALL Alias "wxScrollBar_GetRange" (self As wxScrollBar Ptr) As wxInt
Declare Function wxScrollBar_IsVertical WXCALL Alias "wxScrollBar_IsVertical" (self As wxScrollBar Ptr) As wxBool
Declare Sub wxScrollBar_SetThumbPosition WXCALL Alias "wxScrollBar_SetThumbPosition" (self As wxScrollBar Ptr, viewStart As wxInt)
Declare Sub wxScrollBar_SetScrollbar WXCALL Alias "wxScrollBar_SetScrollbar" (self As wxScrollBar Ptr, position As wxInt, thumbSize As wxInt, range As wxInt, pageSize As wxInt, refresh As wxBool)

#EndIf ' __scrollbar_bi__

