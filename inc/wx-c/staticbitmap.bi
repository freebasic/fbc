#Ifndef __staticbitmap_bi__
#Define __staticbitmap_bi__

#Include Once "common.bi"

Declare Function wxStaticBitmap_ctor WXCALL Alias "wxStaticBitmap_ctor" () As wxStaticBitmap Ptr 
Declare Function wxStaticBitmap_Create WXCALL Alias "wxStaticBitmap_Create" (self As wxStaticBitmap Ptr, _
                           parent  As wxWindow       Ptr     , _
                           id      As  wxWindowID         = -1, _
                           bitmap  As wxBitmap       Ptr     , _
                           x       As  wxInt              = -1, _
                           y       As  wxInt              = -1, _
                           w       As  wxInt              = -1, _
                           h       As  wxInt              = -1, _
                           style   As  wxUInt             =  0, _
                           nameArg As wxString       Ptr = WX_NULL) As wxBool
Declare Sub wxStaticBitmap_dtor WXCALL Alias "wxStaticBitmap_dtor" (self As wxStaticBitmap Ptr)
Declare Sub wxStaticBitmap_SetIcon WXCALL Alias "wxStaticBitmap_SetIcon" (self As wxStaticBitmap Ptr, icon As wxIcon Ptr)
Declare Sub wxStaticBitmap_SetBitmap WXCALL Alias "wxStaticBitmap_SetBitmap" (self As wxStaticBitmap Ptr, bitmap As wxBitmap Ptr)
Declare Function wxStaticBitmap_GetBitmap WXCALL Alias "wxStaticBitmap_GetBitmap" (self As wxStaticBitmap Ptr) As wxBitmap Ptr

#EndIf ' __staticbitmap_bi__

