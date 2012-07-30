#Ifndef __listbook_bi__
#Define __listbook_bi__

#Include Once "common.bi"

Declare Function wxListbook_ctor WXCALL Alias "wxListbook_ctor" () As wxListbook Ptr
Declare Function wxListbook_Create WXCALL Alias "wxListbook_Create" (self As wxListbook Ptr, _
                       parent  As wxWindow   Ptr, _
                       id      As  wxWindowID   = -1, _
                       x       As  wxInt        = -1,_
                       y       As  wxInt        = -1, _
                       w       As  wxInt        = -1, _
                       h       As  wxInt        = -1, _
                       style   As  wxUInt       =  0, _
                       nameArg As wxString Ptr = WX_NULL) As wxBool
Declare Function wxListbook_GetSelection WXCALL Alias "wxListbook_GetSelection" (self As wxListbook Ptr) As wxInt
Declare Function wxListbook_SetPageText WXCALL Alias "wxListbook_SetPageText" (self As wxListbook Ptr, n As size_t, txt As wxString Ptr) As wxBool
Declare Function wxListbook_GetPageText WXCALL Alias "wxListbook_GetPageText" (self As wxListbook Ptr, n As size_t) As wxString Ptr
Declare Function wxListbook_GetPageImage WXCALL Alias "wxListbook_GetPageImage" (self As wxListbook Ptr, n As size_t) As wxInt
Declare Function wxListbook_SetPageImage WXCALL Alias "wxListbook_SetPageImage" (self As wxListbook Ptr, n As size_t, imageId As wxInt) As wxBool
Declare Sub wxListbook_CalcSizeFromPage WXCALL Alias "wxListbook_CalcSizeFromPage" (self As wxListbook Ptr, w As wxInt, h As wxInt, retW As wxInt Ptr, retH As wxInt Ptr)
Declare Function wxListbook_InsertPage WXCALL Alias "wxListbook_InsertPage" (self As wxListbook Ptr, n As size_t, page As wxWindow Ptr, txt As wxString Ptr, bSelecte As wxBool, ImageID As wxInt) As wxBool
Declare Function wxListbook_SetSelection WXCALL Alias "wxListbook_SetSelection" (self As wxListbook Ptr, n As size_t) As wxInt
Declare Sub wxListbook_SetImageList WXCALL Alias "wxListbook_SetImageList" (self As wxListbook Ptr, imageList As wxImageList Ptr)
Declare Function wxListbook_IsVertical WXCALL Alias "wxListbook_IsVertical" (self As wxListbook Ptr) As wxBool
Declare Function wxListbook_GetPageCount WXCALL Alias "wxListbook_GetPageCount" (self As wxListbook Ptr) As wxInt
Declare Function wxListbook_GetPage WXCALL Alias "wxListbook_GetPage" (self As wxListbook Ptr, n As size_t) As wxWindow Ptr
Declare Sub wxListbook_AssignImageList WXCALL Alias "wxListbook_AssignImageList" (self As wxListbook Ptr, imageList As wxImageList Ptr)
Declare Function wxListbook_GetImageList WXCALL Alias "wxListbook_GetImageList" (self As wxListbook Ptr) As wxImageList Ptr
Declare Sub wxListbook_SetPageSize WXCALL Alias "wxListbook_SetPageSize" (self As wxListbook Ptr, size As wxSize Ptr)
Declare Function wxListbook_DeletePage WXCALL Alias "wxListbook_DeletePage" (self As wxListbook Ptr, page As wxInt) As wxBool
Declare Function wxListbook_RemovePage WXCALL Alias "wxListbook_RemovePage" (self As wxListbook Ptr, page As wxInt) As wxBool
Declare Function wxListbook_DeleteAllPages WXCALL Alias "wxListbook_DeleteAllPages" (self As wxListbook Ptr) As wxBool
Declare Function wxListbook_AddPage WXCALL Alias "wxListbook_AddPage" (self As wxListbook Ptr, page As wxWindow Ptr, txt As wxString Ptr, bSelecte As wxBool, ImageID As wxInt) As wxBool
Declare Sub wxListbook_AdvanceSelection WXCALL Alias "wxListbook_AdvanceSelection" (self As wxListbook Ptr, forward As wxBool)

' class wxListbookEvent
Declare Function wxListbookEvent_ctor WXCALL Alias "wxListbookEvent_ctor" (typ As wxEventType, id As wxInt, nSel As wxInt, nOldSel As wxInt) As wxListbookEvent Ptr
Declare Function wxListbookEvent_GetSelection WXCALL Alias "wxListbookEvent_GetSelection" (self As wxListbookEvent Ptr) As wxInt
Declare Sub wxListbookEvent_SetSelection WXCALL Alias "wxListbookEvent_SetSelection" (self As wxListbookEvent Ptr, nSel As wxInt)
Declare Function wxListbookEvent_GetOldSelection WXCALL Alias "wxListbookEvent_GetOldSelection" (self As wxListbookEvent Ptr) As wxInt
Declare Sub wxListbookEvent_SetOldSelection WXCALL Alias "wxListbookEvent_SetOldSelection" (self As wxListbookEvent Ptr, nOldSel As wxInt)
Declare Sub wxListbookEvent_Veto WXCALL Alias "wxListbookEvent_Veto" (self As wxListbookEvent Ptr)
Declare Sub wxListbookEvent_Allow WXCALL Alias "wxListbookEvent_Allow" (self As wxListbookEvent Ptr)
Declare Function wxListbookEvent_IsAllowed WXCALL Alias "wxListbookEvent_IsAllowed" (self As wxListbookEvent Ptr) As wxBool

#EndIf ' __listbook_bi__

