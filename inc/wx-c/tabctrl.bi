#Ifndef __tabctrl_bi__
#Define __tabctrl_bi__

#Ifdef __FB_WIN32__

#Include Once "common.bi"

Declare Function wxTabCtrl_ctor2 WXCALL Alias "wxTabCtrl_ctor2" (parent As wxWindow Ptr, id As wxWindowID, x As wxInt, y As wxInt, w As wxInt, h As wxInt, style As wxInt, nameArg As wxString Ptr) As wxTabCtrl Ptr
Declare Function wxTabCtrl_Create WXCALL Alias "wxTabCtrl_Create" (self As wxTabCtrl Ptr, parent As wxWindow Ptr, id As wxWindowID, x As wxInt, y As wxInt, w As wxInt, h As wxInt, style As wxInt, nameArg As wxString Ptr) As wxBool
Declare Function wxTabCtrl_GetSelection WXCALL Alias "wxTabCtrl_GetSelection" (self As wxTabCtrl Ptr) As wxInt
Declare Function wxTabCtrl_GetCurFocus WXCALL Alias "wxTabCtrl_GetCurFocus" (self As wxTabCtrl Ptr) As wxInt
Declare Function wxTabCtrl_GetImageList WXCALL Alias "wxTabCtrl_GetImageList" (self As wxTabCtrl Ptr) As wxImageList Ptr
Declare Function wxTabCtrl_GetItemCount WXCALL Alias "wxTabCtrl_GetItemCount" (self As wxTabCtrl Ptr) As wxInt
Declare Function wxTabCtrl_GetItemRect WXCALL Alias "wxTabCtrl_GetItemRect" (self As wxTabCtrl Ptr, item As wxInt, r As wxRect Ptr) As wxBool
Declare Function wxTabCtrl_GetRowCount WXCALL Alias "wxTabCtrl_GetRowCount" (self As wxTabCtrl Ptr) As wxInt
Declare Function wxTabCtrl_GetItemText WXCALL Alias "wxTabCtrl_GetItemText" (self As wxTabCtrl Ptr, item As wxInt) As wxString Ptr
Declare Function wxTabCtrl_GetItemImage WXCALL Alias "wxTabCtrl_GetItemImage" (self As wxTabCtrl Ptr, item As wxInt) As wxInt
Declare Function wxTabCtrl_GetItemData WXCALL Alias "wxTabCtrl_GetItemData" (self As wxTabCtrl Ptr, item As wxInt) As Any Ptr
Declare Function wxTabCtrl_SetSelection WXCALL Alias "wxTabCtrl_SetSelection" (self As wxTabCtrl Ptr, item As wxInt) As wxInt
Declare Sub wxTabCtrl_SetImageList WXCALL Alias "wxTabCtrl_SetImageList" (self As wxTabCtrl Ptr, imageList As wxImageList Ptr)
Declare Function wxTabCtrl_SetItemText WXCALL Alias "wxTabCtrl_SetItemText" (self As wxTabCtrl Ptr, item As wxInt, txt As wxString Ptr) As wxBool
Declare Function wxTabCtrl_SetItemImage WXCALL Alias "wxTabCtrl_SetItemImage" (self As wxTabCtrl Ptr, item As wxInt, image As wxInt) As wxBool
Declare Function wxTabCtrl_SetItemData WXCALL Alias "wxTabCtrl_SetItemData" (self As wxTabCtrl Ptr, item As wxInt, pData As Any Ptr) As wxBool
Declare Sub wxTabCtrl_SetItemSize WXCALL Alias "wxTabCtrl_SetItemSize" (self As wxTabCtrl Ptr, size As wxSize Ptr)
Declare Sub wxTabCtrl_SetPadding WXCALL Alias "wxTabCtrl_SetPadding" (self As wxTabCtrl Ptr, padding As wxSize Ptr)
Declare Function wxTabCtrl_DeleteAllItems WXCALL Alias "wxTabCtrl_DeleteAllItems" (self As wxTabCtrl Ptr) As wxBool
Declare Function wxTabCtrl_DeleteItem WXCALL Alias "wxTabCtrl_DeleteItem" (self As wxTabCtrl Ptr, item As wxInt) As wxBool
Declare Function wxTabCtrl_HitTest WXCALL Alias "wxTabCtrl_HitTest" (self As wxTabCtrl Ptr, pt As wxPoint Ptr, flags As wxInt Ptr) As wxInt
Declare Function wxTabCtrl_InsertItem WXCALL Alias "wxTabCtrl_InsertItem" (self As wxTabCtrl Ptr, item As wxInt, txt As wxString Ptr, imageId As wxInt, pData As Any Ptr) As wxBool
Declare Function wxTabEvent_ctor WXCALL Alias "wxTabEvent_ctor" (typ As wxEventType, id As wxInt, nSel As wxInt, nOldSel As wxInt) As wxTabEvent Ptr
Declare Function wxTabEvent_GetSelection WXCALL Alias "wxTabEvent_GetSelection" (self As wxTabEvent Ptr) As wxInt
Declare Sub wxTabEvent_SetSelection WXCALL Alias "wxTabEvent_SetSelection" (self As wxTabEvent Ptr, nSel As wxInt)
Declare Function wxTabEvent_GetOldSelection WXCALL Alias "wxTabEvent_GetOldSelection" (self As wxTabEvent Ptr) As wxInt
Declare Sub wxTabEvent_SetOldSelection WXCALL Alias "wxTabEvent_SetOldSelection" (self As wxTabEvent Ptr, nOldSel As wxInt)
Declare Sub wxTabEvent_Veto WXCALL Alias "wxTabEvent_Veto" (self As wxTabEvent Ptr)
Declare Sub wxTabEvent_Allow WXCALL Alias "wxTabEvent_Allow" (self As wxTabEvent Ptr)
Declare Function wxTabEvent_IsAllowed WXCALL Alias "wxTabEvent_IsAllowed" (self As wxTabEvent Ptr) As wxBool

#EndIf '__FB_WIN32__
 
#EndIf ' __tabctrl_bi__

