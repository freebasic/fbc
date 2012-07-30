#Ifndef __imagelist_bi__
#Define __imagelist_bi__

#Include Once "common.bi"

Declare Function wxImageList_ctor WXCALL Alias "wxImageList_ctor" (w As wxInt, h As wxInt, mask As wxBool, initialColour As wxInt) As wxImageList Ptr
Declare Function wxImageList_ctor2 WXCALL Alias "wxImageList_ctor2" () As wxImageList Ptr
Declare Function wxImageList_AddBitmap1 WXCALL Alias "wxImageList_AddBitmap1" (self As wxImageList Ptr, bitmap As wxBitmap Ptr, mask As wxBitmap Ptr) As wxInt
Declare Function wxImageList_AddBitmap WXCALL Alias "wxImageList_AddBitmap" (self As wxImageList Ptr, bitmap As wxBitmap Ptr, mask As wxColour Ptr) As wxInt
Declare Function wxImageList_AddIcon WXCALL Alias "wxImageList_AddIcon" (self As wxImageList Ptr, icon As wxIcon Ptr) As wxInt
Declare Function wxImageList_GetImageCount WXCALL Alias "wxImageList_GetImageCount" (self As wxImageList Ptr) As wxInt
Declare Function wxImageList_Draw WXCALL Alias "wxImageList_Draw" (self As wxImageList Ptr, index As wxInt, dc As wxDC Ptr, x As wxInt, y As wxInt, flag As wxInt, solidbg As wxBool) As wxBool
Declare Function wxImageList_Create WXCALL Alias "wxImageList_Create" (self As wxImageList Ptr, w As wxInt, h As wxInt, mask As wxBool, initialColour As wxInt) As wxBool
Declare Function wxImageList_Replace WXCALL Alias "wxImageList_Replace" (self As wxImageList Ptr, index As wxInt, bitmap As wxBitmap Ptr) As wxBool
Declare Function wxImageList_Remove WXCALL Alias "wxImageList_Remove" (self As wxImageList Ptr, index As wxInt) As wxBool
Declare Function wxImageList_RemoveAll WXCALL Alias "wxImageList_RemoveAll" (self As wxImageList Ptr) As wxBool
Declare Function wxImageList_GetBitmap WXCALL Alias "wxImageList_GetBitmap" (self As wxImageList Ptr, index As wxInt) As wxBitmap Ptr
Declare Function wxImageList_GetSize WXCALL Alias "wxImageList_GetSize" (self As wxImageList Ptr, index As wxInt, w As wxInt Ptr, h As wxInt Ptr) As wxBool

#EndIf ' __imagelist_bi__

