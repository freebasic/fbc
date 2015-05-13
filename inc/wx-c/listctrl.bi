#Ifndef __listctrl_bi__
#Define __listctrl_bi__

#Include Once "common.bi"

Type Callback_OnGetItemText        As Function WXCALL (item As wxInt, col As wxInt) As _DisposableStringBox Ptr
Type Callback_OnGetItemImage       As Function WXCALL (item As wxInt) As wxInt
Type Callback_OnGetItemColumnImage As Function WXCALL (item As wxInt, column As wxInt) As wxInt
Type Callback_OnGetItemAttr        As Function WXCALL (item As wxInt) As wxListItemAttr Ptr
Type wxListCtrlCompare             As Function WXCALL (item1 As wxInt, item2 As wxInt, sortData As wxInt) As wxInt


' class wxListItemAttr
Declare Function wxListItemAttr_ctor WXCALL Alias "wxListItemAttr_ctor" () As wxListItemAttr Ptr
Declare Function wxListItemAttr_ctor2 WXCALL Alias "wxListItemAttr_ctor2" (colTxt As wxColour Ptr, bg As wxColour Ptr, font As wxFont Ptr) As wxListItemAttr Ptr
Declare Sub wxListItemAttr_dtor WXCALL Alias "wxListItemAttr_dtor" (self As wxListItemAttr Ptr)
Declare Sub wxListItemAttr_RegisterDisposable WXCALL Alias "wxListItemAttr_RegisterDisposable" (self As wxListItemAttr Ptr, on_dispose As Virtual_Dispose)
Declare Sub wxListItemAttr_SetTextColour WXCALL Alias "wxListItemAttr_SetTextColour" (self As wxListItemAttr Ptr, fg As wxColour Ptr)
Declare Function wxListItemAttr_GetTextColour WXCALL Alias "wxListItemAttr_GetTextColour" (self As wxListItemAttr Ptr) As wxColour Ptr
Declare Sub wxListItemAttr_SetBackgroundColour WXCALL Alias "wxListItemAttr_SetBackgroundColour" (self As wxListItemAttr Ptr, bg As wxColour Ptr)
Declare Function wxListItemAttr_GetBackgroundColour WXCALL Alias "wxListItemAttr_GetBackgroundColour" (self As wxListItemAttr Ptr) As wxColour Ptr
Declare Sub wxListItemAttr_SetFont WXCALL Alias "wxListItemAttr_SetFont" (self As wxListItemAttr Ptr, font As wxFont Ptr)
Declare Function wxListItemAttr_GetFont WXCALL Alias "wxListItemAttr_GetFont" (self As wxListItemAttr Ptr) As wxFont Ptr 
Declare Function wxListItemAttr_HasTextColour WXCALL Alias "wxListItemAttr_HasTextColour" (self As wxListItemAttr Ptr) As wxBool
Declare Function wxListItemAttr_HasBackgroundColour WXCALL Alias "wxListItemAttr_HasBackgroundColour" (self As wxListItemAttr Ptr) As wxBool
Declare Function wxListItemAttr_HasFont WXCALL Alias "wxListItemAttr_HasFont" (self As wxListItemAttr Ptr) As wxBool

' class wxListCtrl
Declare Function wxListCtrl_ctor WXCALL Alias "wxListCtrl_ctor" () As wxListCtrl Ptr
Declare Function wxListCtrl_Create WXCALL Alias "wxListCtrl_Create" (self As wxListCtrl Ptr, _
                       parent    As wxWindow    Ptr     , _
                       id        As  wxWindowID      = -1, _
                       x         As  wxInt           = -1, _
                       y         As  wxInt           = -1, _
                       w         As  wxInt           = -1, _
                       h         As  wxInt           = -1, _
                       style     As  wxUInt          =  0, _
                       validator As wxValidator Ptr = WX_NULL, _
                       nameArg   As wxString    Ptr = WX_NULL) As wxBool
Declare Sub wxListCtrl_dtor WXCALL Alias "wxListCtrl_dtor" (self As wxListCtrl Ptr)
Declare Sub wxListCtrl_RegisterVirtual WXCALL Alias "wxListCtrl_RegisterVirtual" (self As wxListCtrl Ptr, _
                                OnGetItemText        As Callback_OnGetItemText, _
                                OnGetItemImage       As Callback_OnGetItemImage, _
                                OnGetItemColumnImage As Callback_OnGetItemColumnImage, _
                                OnGetItemAttr        As Callback_OnGetItemAttr)
Declare Function wxListCtrl_SetColumn WXCALL Alias "wxListCtrl_SetColumn" (self As wxListCtrl Ptr, column As wxInt, item As wxListItem Ptr) As wxBool
Declare Function wxListCtrl_GetColumn WXCALL Alias "wxListCtrl_GetColumn" (self As wxListCtrl Ptr, column As wxInt, item As wxListItem Ptr) As wxBool
Declare Function wxListCtrl_SetColumnWidth WXCALL Alias "wxListCtrl_SetColumnWidth" (self As wxListCtrl Ptr, column As wxInt, w As wxInt) As wxBool
Declare Function wxListCtrl_GetColumnWidth WXCALL Alias "wxListCtrl_GetColumnWidth" (self As wxListCtrl Ptr, column As wxInt) As wxInt
Declare Function wxListCtrl_SetItem WXCALL Alias "wxListCtrl_SetItem" (self As wxListCtrl Ptr, item As wxListItem Ptr) As wxBool
Declare Function wxListCtrl_GetItem WXCALL Alias "wxListCtrl_GetItem" (self As wxListCtrl Ptr, item As wxListItem Ptr) As wxBool
Declare Function wxListCtrl_SetItemState WXCALL Alias "wxListCtrl_SetItemState" (self As wxListCtrl Ptr, item As wxInt, state As wxInt, stateMask As wxInt) As wxBool
Declare Function wxListCtrl_GetItemState WXCALL Alias "wxListCtrl_GetItemState" (self As wxListCtrl Ptr, item As wxInt, stateMask As wxInt) As wxInt
Declare Function wxListCtrl_SetItemData WXCALL Alias "wxListCtrl_SetItemData" (self As wxListCtrl Ptr, item As wxInt, pClientData As wxClientData Ptr) As wxBool
Declare Function wxListCtrl_GetItemData WXCALL Alias "wxListCtrl_GetItemData" (self As wxListCtrl Ptr, item As wxInt) As Any Ptr
Declare Sub wxListCtrl_SetItemTextColour WXCALL Alias "wxListCtrl_SetItemTextColour" (self As wxListCtrl Ptr, item As wxInt, col As wxColour Ptr)
Declare Function wxListCtrl_GetItemTextColour WXCALL Alias "wxListCtrl_GetItemTextColour" (self As wxListCtrl Ptr, item As wxInt) As wxColour Ptr
Declare Sub wxListCtrl_SetItemText WXCALL Alias "wxListCtrl_SetItemText" (self As wxListCtrl Ptr, item As wxInt, txt As wxString Ptr)
Declare Function wxListCtrl_GetItemText WXCALL Alias "wxListCtrl_GetItemText" (self As wxListCtrl Ptr, item As wxInt) As wxString Ptr
Declare Function wxListCtrl_SetItemPosition WXCALL Alias "wxListCtrl_SetItemPosition" (self As wxListCtrl Ptr, item As wxInt, p As wxPoint Ptr) As wxBool
Declare Function wxListCtrl_GetItemPosition WXCALL Alias "wxListCtrl_GetItemPosition" (self As wxListCtrl Ptr, item As wxInt, p As wxPoint Ptr) As wxBool
Declare Sub wxListCtrl_SetItemCount WXCALL Alias "wxListCtrl_SetItemCount" (self As wxListCtrl Ptr, count As wxInt)
Declare Function wxListCtrl_GetItemCount WXCALL Alias "wxListCtrl_GetItemCount" (self As wxListCtrl Ptr) As wxInt
Declare Sub wxListCtrl_SetItemBackgroundColour WXCALL Alias "wxListCtrl_SetItemBackgroundColour" (self As wxListCtrl Ptr, item As wxInt, col As wxColour Ptr)
Declare Function wxListCtrl_GetItemBackgroundColour WXCALL Alias "wxListCtrl_GetItemBackgroundColour" (self As wxListCtrl Ptr, item As wxInt) As wxColour Ptr
Declare Sub wxListCtrl_SetImageList WXCALL Alias "wxListCtrl_SetImageList" (self As wxListCtrl Ptr, imageList As wxImageList Ptr, witch As wxInt)
Declare Function wxListCtrl_GetImageList WXCALL Alias "wxListCtrl_GetImageList" (self As wxListCtrl Ptr, witch As wxInt) As wxImageList Ptr
Declare Sub wxListCtrl_SetTextColour WXCALL Alias "wxListCtrl_SetTextColour" (self As wxListCtrl Ptr, col As wxColour Ptr)
Declare Function wxListCtrl_GetTextColour WXCALL Alias "wxListCtrl_GetTextColour" (self As wxListCtrl Ptr) As wxColour Ptr
Declare Function wxListCtrl_SetItemData2 WXCALL Alias "wxListCtrl_SetItemData2" (self As wxListCtrl Ptr, item As wxInt, iData As wxInt) As wxBool
Declare Function wxListCtrl_GetItemRect WXCALL Alias "wxListCtrl_GetItemRect" (self As wxListCtrl Ptr, item As wxInt, r As wxRect Ptr, iCode As wxInt) As wxBool
Declare Function wxListCtrl_GetCountPerPage WXCALL Alias "wxListCtrl_GetCountPerPage" (self As wxListCtrl Ptr) As wxInt
Declare Function wxListCtrl_SetItem_By_Row_Col WXCALL Alias "wxListCtrl_SetItem_By_Row_Col" (self As wxListCtrl Ptr, index As wxInt, column As wxInt, label As wxString Ptr, ImageID As wxInt) As wxInt
Declare Function wxListCtrl_SetTextImageItem WXCALL Alias "wxListCtrl_SetTextImageItem" (self As wxListCtrl Ptr, index As wxInt, column As wxInt, label As wxString Ptr, ImageID As wxInt) As wxInt
Declare Function wxListCtrl_SetItemImage WXCALL Alias "wxListCtrl_SetItemImage" (self As wxListCtrl Ptr, item As wxInt, imageID As wxInt, selImageID As wxInt) As wxBool
Declare Function wxListCtrl_GetColumnCount WXCALL Alias "wxListCtrl_GetColumnCount" (self As wxListCtrl Ptr) As wxInt
Declare Function wxListCtrl_GetSelectedItemCount WXCALL Alias "wxListCtrl_GetSelectedItemCount" (self As wxListCtrl Ptr) As wxInt
Declare Function wxListCtrl_GetTopItem WXCALL Alias "wxListCtrl_GetTopItem" (self As wxListCtrl Ptr) As wxInt
Declare Sub wxListCtrl_SetSingleStyle WXCALL Alias "wxListCtrl_SetSingleStyle" (self As wxListCtrl Ptr, style As wxUInt, bAdd As wxBool)
Declare Sub wxListCtrl_SetWindowStyleFlag WXCALL Alias "wxListCtrl_SetWindowStyleFlag" (self As wxListCtrl Ptr, style As wxUInt)
Declare Function wxListCtrl_GetNextItem WXCALL Alias "wxListCtrl_GetNextItem" (self As wxListCtrl Ptr, item As wxInt, geometry As wxInt, state As wxInt) As wxInt
Declare Sub wxListCtrl_AssignImageList WXCALL Alias "wxListCtrl_AssignImageList" (self As wxListCtrl Ptr, imageList As wxImageList Ptr, witch As wxInt)
Declare Function wxListCtrl_Arrange WXCALL Alias "wxListCtrl_Arrange" (self As wxListCtrl Ptr, flag As wxInt) As wxBool
Declare Sub wxListCtrl_ClearAll WXCALL Alias "wxListCtrl_ClearAll" (self As wxListCtrl Ptr)
Declare Function wxListCtrl_DeleteItem WXCALL Alias "wxListCtrl_DeleteItem" (self As wxListCtrl Ptr, item As wxInt) As wxBool
Declare Function wxListCtrl_DeleteAllItems WXCALL Alias "wxListCtrl_DeleteAllItems" (self As wxListCtrl Ptr) As wxBool
Declare Function wxListCtrl_DeleteAllColumns WXCALL Alias "wxListCtrl_DeleteAllColumns" (self As wxListCtrl Ptr) As wxBool
Declare Function wxListCtrl_DeleteColumn WXCALL Alias "wxListCtrl_DeleteColumn" (self As wxListCtrl Ptr, column As wxInt) As wxBool
Declare Sub wxListCtrl_EditLabel WXCALL Alias "wxListCtrl_EditLabel" (self As wxListCtrl Ptr, item As wxInt)
Declare Function wxListCtrl_EnsureVisible WXCALL Alias "wxListCtrl_EnsureVisible" (self As wxListCtrl Ptr, item As wxInt) As wxBool
Declare Function wxListCtrl_FindItem WXCALL Alias "wxListCtrl_FindItem" (self As wxListCtrl Ptr, iStart As wxInt, txt As wxString Ptr, partial As wxBool) As wxInt
Declare Function wxListCtrl_FindItemData WXCALL Alias "wxListCtrl_FindItemData" (self As wxListCtrl Ptr, iStart As wxInt, iData As wxInt) As wxInt
Declare Function wxListCtrl_FindItemPoint WXCALL Alias "wxListCtrl_FindItemPoint" (self As wxListCtrl Ptr, iStart As wxInt, pt As wxPoint Ptr, iDir As wxInt) As wxInt
Declare Function wxListCtrl_HitTest WXCALL Alias "wxListCtrl_HitTest" (self As wxListCtrl Ptr, pt As wxPoint Ptr, flag As wxInt) As wxInt
Declare Function wxListCtrl_InsertItem WXCALL Alias "wxListCtrl_InsertItem" (self As wxListCtrl Ptr, item As wxListItem Ptr) As wxInt
Declare Function wxListCtrl_InsertTextItem WXCALL Alias "wxListCtrl_InsertTextItem" (self As wxListCtrl Ptr, index As wxInt, label As wxString Ptr) As wxInt
Declare Function wxListCtrl_InsertImageItem WXCALL Alias "wxListCtrl_InsertImageItem" (self As wxListCtrl Ptr, index As wxInt, imageID As wxInt) As wxInt
Declare Function wxListCtrl_InsertTextImageItem WXCALL Alias "wxListCtrl_InsertTextImageItem" (self As wxListCtrl Ptr, index As wxInt, label As wxString Ptr, imageID As wxInt) As wxInt
Declare Function wxListCtrl_InsertColumn WXCALL Alias "wxListCtrl_InsertColumn" (self As wxListCtrl Ptr, column As wxInt, item As wxListItem Ptr) As wxInt
Declare Function wxListCtrl_InsertTextColumn WXCALL Alias "wxListCtrl_InsertTextColumn" (self As wxListCtrl Ptr, column As wxInt, heading As wxString Ptr, iFormat As wxInt, w As wxInt) As wxInt
Declare Function wxListCtrl_ScrollList WXCALL Alias "wxListCtrl_ScrollList" (self As wxListCtrl Ptr, dx As wxInt, dy As wxInt) As wxBool
Declare Function wxListCtrl_SortItems WXCALL Alias "wxListCtrl_SortItems" (self As wxListCtrl Ptr, Comaprefunc As wxListCtrlCompare, iData As wxInt) As wxBool
Declare Sub wxListCtrl_GetViewRect WXCALL Alias "wxListCtrl_GetViewRect" (self As wxListCtrl Ptr, r As wxRect Ptr)
Declare Sub wxListCtrl_RefreshItem WXCALL Alias "wxListCtrl_RefreshItem" (self As wxListCtrl Ptr, item As wxInt)
Declare Sub wxListCtrl_RefreshItems WXCALL Alias "wxListCtrl_RefreshItems" (self As wxListCtrl Ptr, itemFrom As wxInt, itemTo As wxInt)

' class wxListItem
Declare Function wxListItem_ctor WXCALL Alias "wxListItem_ctor" () As wxListItem Ptr
Declare Sub wxListItem_SetAlign WXCALL Alias "wxListItem_SetAlign" (self As wxListItem Ptr, iAlign As wxInt)
Declare Function wxListItem_GetAlign WXCALL Alias "wxListItem_GetAlign" (self As wxListItem Ptr) As wxInt
Declare Sub wxListItem_SetBackgroundColour WXCALL Alias "wxListItem_SetBackgroundColour" (self As wxListItem Ptr, col As wxColour Ptr)
Declare Function wxListItem_GetBackgroundColour WXCALL Alias "wxListItem_GetBackgroundColour" (self As wxListItem Ptr) As wxColour Ptr
Declare Sub wxListItem_SetColumn WXCALL Alias "wxListItem_SetColumn" (self As wxListItem Ptr, column As wxInt)
Declare Function wxListItem_GetColumn WXCALL Alias "wxListItem_GetColumn" (self As wxListItem Ptr) As wxInt
Declare Sub wxListItem_SetData WXCALL Alias "wxListItem_SetData" (self As wxListItem Ptr, pClientData As wxClientData Ptr)
Declare Function wxListItem_GetData WXCALL Alias "wxListItem_GetData" (self As wxListItem Ptr) As Any Ptr
Declare Sub wxListItem_SetFont WXCALL Alias "wxListItem_SetFont" (self As wxListItem Ptr, font As wxFont Ptr)
Declare Function wxListItem_GetFont WXCALL Alias "wxListItem_GetFont" (self As wxListItem Ptr) As wxFont Ptr
Declare Sub wxListItem_SetId WXCALL Alias "wxListItem_SetId" (self As wxListItem Ptr, id As wxInt)
Declare Function wxListItem_GetId WXCALL Alias "wxListItem_GetId" (self As wxListItem Ptr) As wxInt
Declare Sub wxListItem_SetImage WXCALL Alias "wxListItem_SetImage" (self As wxListItem Ptr, imageID As wxInt)
Declare Function wxListItem_GetImage WXCALL Alias "wxListItem_GetImage" (self As wxListItem Ptr) As wxInt
Declare Sub wxListItem_SetMask WXCALL Alias "wxListItem_SetMask" (self As wxListItem Ptr, iMask As wxInt)
Declare Function wxListItem_GetMask WXCALL Alias "wxListItem_GetMask" (self As wxListItem Ptr) As wxInt
Declare Sub wxListItem_SetState WXCALL Alias "wxListItem_SetState" (self As wxListItem Ptr, state As wxInt)
Declare Function wxListItem_GetState WXCALL Alias "wxListItem_GetState" (self As wxListItem Ptr) As wxInt
Declare Sub wxListItem_SetText WXCALL Alias "wxListItem_SetText" (self As wxListItem Ptr, txt As wxString Ptr)
Declare Function wxListItem_GetText WXCALL Alias "wxListItem_GetText" (self As wxListItem Ptr) As wxString Ptr
Declare Sub wxListItem_SetTextColour WXCALL Alias "wxListItem_SetTextColour" (self As wxListItem Ptr, col As wxColour Ptr)
Declare Function wxListItem_GetTextColour WXCALL Alias "wxListItem_GetTextColour" (self As wxListItem Ptr) As wxColour Ptr
Declare Sub wxListItem_SetWidth WXCALL Alias "wxListItem_SetWidth" (self As wxListItem Ptr, w As wxInt)
Declare Function wxListItem_GetWidth WXCALL Alias "wxListItem_GetWidth" (self As wxListItem Ptr) As wxInt
Declare Sub wxListItem_SetStateMask WXCALL Alias "wxListItem_SetStateMask" (self As wxListItem Ptr, stateMask As wxInt)
Declare Function wxListItem_GetAttributes WXCALL Alias "wxListItem_GetAttributes" (self As wxListItem Ptr) As wxListItemAttr Ptr
Declare Function wxListItem_HasAttributes WXCALL Alias "wxListItem_HasAttributes" (self As wxListItem Ptr) As wxBool
Declare Sub wxListItem_Clear WXCALL Alias "wxListItem_Clear" (self As wxListItem Ptr)
Declare Sub wxListItem_ClearAttributes WXCALL Alias "wxListItem_ClearAttributes" (self As wxListItem Ptr)

' class wxListEvent
Declare Function wxListEvent_ctor WXCALL Alias "wxListEvent_ctor" (typ As wxEventType, id As wxInt) As wxListEvent Ptr
Declare Function wxListEvent_GetCacheFrom WXCALL Alias "wxListEvent_GetCacheFrom" (self As wxListEvent Ptr) As wxInt
Declare Function wxListEvent_GetCacheTo WXCALL Alias "wxListEvent_GetCacheTo" (self As wxListEvent Ptr) As wxInt
Declare Function wxListEvent_GetKeyCode WXCALL Alias "wxListEvent_GetKeyCode" (self As wxListEvent Ptr) As wxInt
Declare Function wxListEvent_GetIndex WXCALL Alias "wxListEvent_GetIndex" (self As wxListEvent Ptr) As wxInt
Declare Function wxListEvent_GetColumn WXCALL Alias "wxListEvent_GetColumn" (self As wxListEvent Ptr) As wxInt
Declare Function wxListEvent_IsEditCancelled WXCALL Alias "wxListEvent_IsEditCancelled" (self As wxListEvent Ptr) As wxBool
Declare Sub wxListEvent_SetEditCanceled WXCALL Alias "wxListEvent_SetEditCanceled" (self As wxListEvent Ptr, cancled As wxBool)
Declare Function wxListEvent_GetLabel WXCALL Alias "wxListEvent_GetLabel" (self As wxListEvent Ptr) As wxString Ptr
Declare Sub wxListEvent_GetPoint WXCALL Alias "wxListEvent_GetPoint" (self As wxListEvent Ptr, pt As wxPoint Ptr)
Declare Function wxListEvent_GetImage WXCALL Alias "wxListEvent_GetImage" (self As wxListEvent Ptr) As wxInt
Declare Function wxListEvent_GetText WXCALL Alias "wxListEvent_GetText" (self As wxListEvent Ptr) As wxString Ptr
Declare Function wxListEvent_GetMask WXCALL Alias "wxListEvent_GetMask" (self As wxListEvent Ptr) As wxInt
Declare Function wxListEvent_GetItem WXCALL Alias "wxListEvent_GetItem" (self As wxListEvent Ptr) As wxListItem Ptr
Declare Function wxListEvent_GetData WXCALL Alias "wxListEvent_GetData" (self As wxListEvent Ptr) As Any Ptr
Declare Sub wxListEvent_Veto WXCALL Alias "wxListEvent_Veto" (self As wxListEvent Ptr)
Declare Sub wxListEvent_Allow WXCALL Alias "wxListEvent_Allow" (self As wxListEvent Ptr)
Declare Function wxListEvent_IsAllowed WXCALL Alias "wxListEvent_IsAllowed" (self As wxListEvent Ptr) As wxBool

' class wxListView
Declare Function wxListView_ctor WXCALL Alias "wxListView_ctor" () As wxListView Ptr
Declare Function wxListView_Create WXCALL Alias "wxListView_Create" (self As wxListView Ptr, _
                       parent    As wxWindow    Ptr     , _
                       id        As  wxWindowID      = -1, _
                       x         As  wxInt           = -1, _
                       y         As  wxInt           = -1, _
                       w         As  wxInt           = -1, _
                       h         As  wxInt           = -1, _
                       style     As  wxUInt          =  0, _
                       validator As wxValidator Ptr = WX_NULL, _
                       nameArg   As wxString    Ptr = WX_NULL) As wxBool
Declare Sub wxListView_Select WXCALL Alias "wxListView_Select" (self As wxListView Ptr, n As wxInt, bSelect As wxBool)
Declare Sub wxListView_Focus WXCALL Alias "wxListView_Focus" (self As wxListView Ptr, index As wxInt)
Declare Function wxListView_GetFocusedItem WXCALL Alias "wxListView_GetFocusedItem" (self As wxListView Ptr) As wxInt
Declare Function wxListView_GetNextSelected WXCALL Alias "wxListView_GetNextSelected" (self As wxListView Ptr, item As wxInt) As wxInt
Declare Function wxListView_GetFirstSelected WXCALL Alias "wxListView_GetFirstSelected" (self As wxListView Ptr) As wxInt
Declare Function wxListView_IsSelected WXCALL Alias "wxListView_IsSelected" (self As wxListView Ptr, index As wxInt) As wxInt
Declare Sub wxListView_SetColumnImage WXCALL Alias "wxListView_SetColumnImage" (self As wxListView Ptr, column As wxInt, imageID As wxInt)
Declare Sub wxListView_ClearColumnImage WXCALL Alias "wxListView_ClearColumnImage" (self As wxListView Ptr, column As wxInt)

#EndIf ' __listctrl_bi__

