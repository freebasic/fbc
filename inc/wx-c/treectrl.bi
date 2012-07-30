#Ifndef __treectrl_bi__
#Define __treectrl_bi__

#Include Once "common.bi"

Type Virtual_OnCompareItems As Function WXCALL (ti1 As wxTreeItemId Ptr, t21 As wxTreeItemId Ptr) As wxInt

' class wxTreeCtrl
Declare Function wxTreeCtrl_ctor WXCALL Alias "wxTreeCtrl_ctor" () As wxTreeCtrl Ptr
Declare Function wxTreeCtrl_Create WXCALL Alias "wxTreeCtrl_Create" ( _
					   self      As wxTreeCtrl Ptr, _
                       parent    As wxWindow   Ptr, _
                       id        As  wxInt      = -1, _
                       pos       As  wxPoint   Ptr, _
                       size      As  wxSize    Ptr, _
                       style     As  wxUInt     =  0, _
                       validator As wxValidator Ptr = WX_NULL, _
                       nameArg   As wxString    Ptr = WX_NULL) As wxBool
Declare Sub wxTreeCtrl_RegisterVirtual WXCALL Alias "wxTreeCtrl_RegisterVirtual" (self As wxTreeCtrl Ptr, on_CompareItems As Virtual_OnCompareItems)
Declare Function wxTreeCtrl_OnCompareItems WXCALL Alias "wxTreeCtrl_OnCompareItems" (self As wxTreeCtrl Ptr, item1 As wxTreeItemId Ptr, item2 As wxTreeItemId Ptr) As wxInt
Declare Sub wxTreeCtrl_SortChildren WXCALL Alias "wxTreeCtrl_SortChildren" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr)
Declare Function wxTreeCtrl_AddRoot WXCALL Alias "wxTreeCtrl_AddRoot" (self As wxTreeCtrl Ptr, txt As wxString Ptr , image As wxInt, selectImage As wxInt, itemData As wxTreeItemData Ptr) As wxTreeItemId Ptr
Declare Function wxTreeCtrl_AppendItem WXCALL Alias "wxTreeCtrl_AppendItem" (self As wxTreeCtrl Ptr, parent As wxTreeItemId Ptr, txt As wxString Ptr , image As wxInt, selectImage As wxInt, itemData As wxTreeItemData Ptr) As wxTreeItemId Ptr
Declare Sub wxTreeCtrl_AssignImageList WXCALL Alias "wxTreeCtrl_AssignImageList" (self As wxTreeCtrl Ptr, imgList As wxImageList Ptr)
Declare Sub wxTreeCtrl_AssignStateImageList WXCALL Alias "wxTreeCtrl_AssignStateImageList" (self As wxTreeCtrl Ptr, imgList As wxImageList Ptr)
Declare Function wxTreeCtrl_GetDefaultStyle WXCALL Alias "wxTreeCtrl_GetDefaultStyle" () As wxInt
Declare Function wxTreeCtrl_GetIndent WXCALL Alias "wxTreeCtrl_GetIndent" (self As wxTreeCtrl Ptr) As wxUInt
Declare Sub wxTreeCtrl_SetIndent WXCALL Alias "wxTreeCtrl_SetIndent" (self As wxTreeCtrl Ptr, indent As wxUInt)
Declare Function wxTreeCtrl_GetSpacing WXCALL Alias "wxTreeCtrl_GetSpacing" (self As wxTreeCtrl Ptr) As wxUInt
Declare Sub wxTreeCtrl_SetSpacing WXCALL Alias "wxTreeCtrl_SetSpacing" (self As wxTreeCtrl Ptr, indent As wxUInt)
Declare Function wxTreeCtrl_GetStateImageList WXCALL Alias "wxTreeCtrl_GetStateImageList" (self As wxTreeCtrl Ptr) As wxImageList Ptr
Declare Sub wxTreeCtrl_SetStateImageList WXCALL Alias "wxTreeCtrl_SetStateImageList" (self As wxTreeCtrl Ptr, imgList As wxImageList Ptr)
Declare Function wxTreeCtrl_GetImageList WXCALL Alias "wxTreeCtrl_GetImageList" (self As wxTreeCtrl Ptr) As wxImageList Ptr
Declare Sub wxTreeCtrl_SetImageList WXCALL Alias "wxTreeCtrl_SetImageList" (self As wxTreeCtrl Ptr, imgList As wxImageList Ptr)
Declare Sub wxTreeCtrl_SetItemImage WXCALL Alias "wxTreeCtrl_SetItemImage" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr, image As wxInt, which As wxTreeItemIcon Ptr)
Declare Function wxTreeCtrl_GetItemImage WXCALL Alias "wxTreeCtrl_GetItemImage" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr, which As wxTreeItemIcon Ptr) As wxInt
Declare Sub wxTreeCtrl_DeleteAllItems WXCALL Alias "wxTreeCtrl_DeleteAllItems" (self As wxTreeCtrl Ptr)
Declare Sub wxTreeCtrl_DeleteChildren WXCALL Alias "wxTreeCtrl_DeleteChildren" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr)
Declare Sub wxTreeCtrl_Delete WXCALL Alias "wxTreeCtrl_Delete" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr)
Declare Sub wxTreeCtrl_Unselect WXCALL Alias "wxTreeCtrl_Unselect" (self As wxTreeCtrl Ptr)
Declare Sub wxTreeCtrl_UnselectAll WXCALL Alias "wxTreeCtrl_UnselectAll" (self As wxTreeCtrl Ptr)
Declare Sub wxTreeCtrl_SelectItem WXCALL Alias "wxTreeCtrl_SelectItem" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr)
Declare Function wxTreeCtrl_GetSelection WXCALL Alias "wxTreeCtrl_GetSelection" (self As wxTreeCtrl Ptr) As wxTreeItemId Ptr
Declare Function wxTreeCtrl_IsSelected WXCALL Alias "wxTreeCtrl_IsSelected" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr) As wxBool
Declare Function wxTreeCtrl_GetSelections WXCALL Alias "wxTreeCtrl_GetSelections" (self As wxTreeCtrl Ptr) As wxArrayTreeItemIds Ptr
Declare Sub wxTreeCtrl_SetItemText WXCALL Alias "wxTreeCtrl_SetItemText" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr, txt As wxString Ptr )
Declare Function wxTreeCtrl_GetItemText WXCALL Alias "wxTreeCtrl_GetItemText" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr) As wxString Ptr
Declare Sub wxTreeCtrl_SetItemData WXCALL Alias "wxTreeCtrl_SetItemData" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr, itemData As wxTreeItemData Ptr)
Declare Function wxTreeCtrl_GetItemData WXCALL Alias "wxTreeCtrl_GetItemData" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr) As wxTreeItemData Ptr
Declare Sub wxTreeCtrl_SetItemHasChildren WXCALL Alias "wxTreeCtrl_SetItemHasChildren" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr, has As wxBool)
Declare Function wxTreeCtrl_HitTest WXCALL Alias "wxTreeCtrl_HitTest" (self As wxTreeCtrl Ptr, pt As wxPoint Ptr, pFlags As wxInt Ptr) As wxTreeItemId Ptr
Declare Function wxTreeCtrl_GetItemParent WXCALL Alias "wxTreeCtrl_GetItemParent" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr) As wxTreeItemId Ptr
Declare Function wxTreeCtrl_GetMyCookie WXCALL Alias "wxTreeCtrl_GetMyCookie" (self As wxTreeCtrl Ptr) As Any Ptr
Declare Sub wxTreeCtrl_SetMyCookie WXCALL Alias "wxTreeCtrl_SetMyCookie" (self As wxTreeCtrl Ptr, newval As Any Ptr)
Declare Function wxTreeCtrl_GetFirstChild WXCALL Alias "wxTreeCtrl_GetFirstChild" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr) As wxTreeItemId Ptr
Declare Function wxTreeCtrl_GetNextChild WXCALL Alias "wxTreeCtrl_GetNextChild" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr) As wxTreeItemId Ptr
Declare Function wxTreeCtrl_GetLastChild WXCALL Alias "wxTreeCtrl_GetLastChild" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr) As wxTreeItemId Ptr
Declare Function wxTreeCtrl_GetNextSibling WXCALL Alias "wxTreeCtrl_GetNextSibling" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr) As wxTreeItemId Ptr
Declare Function wxTreeCtrl_GetPrevSibling WXCALL Alias "wxTreeCtrl_GetPrevSibling" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr) As wxTreeItemId Ptr
Declare Function wxTreeCtrl_GetFirstVisibleItem WXCALL Alias "wxTreeCtrl_GetFirstVisibleItem" (self As wxTreeCtrl Ptr) As wxTreeItemId Ptr
Declare Function wxTreeCtrl_GetNextVisible WXCALL Alias "wxTreeCtrl_GetNextVisible" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr) As wxTreeItemId Ptr
Declare Function wxTreeCtrl_GetPrevVisible WXCALL Alias "wxTreeCtrl_GetPrevVisible" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr) As wxTreeItemId Ptr
Declare Function wxTreeCtrl_PrependItem WXCALL Alias "wxTreeCtrl_PrependItem" (self As wxTreeCtrl Ptr, parent As wxTreeItemId Ptr, txt As wxString Ptr , image As wxInt, selectedImage As wxInt, itemData As wxTreeItemData Ptr) As wxTreeItemId Ptr
Declare Function wxTreeCtrl_InsertItem WXCALL Alias "wxTreeCtrl_InsertItem" (self As wxTreeCtrl Ptr, parent As wxTreeItemId Ptr, prevItem As wxTreeItemId Ptr, txt As wxString Ptr , image As wxInt, selectedImage As wxInt, itemData As wxTreeItemData Ptr) As wxTreeItemId Ptr
Declare Function wxTreeCtrl_InsertItem2 WXCALL Alias "wxTreeCtrl_InsertItem2" (self As wxTreeCtrl Ptr, parent As wxTreeItemId Ptr, before As size_t , txt As wxString Ptr , image As wxInt, selectedImage As wxInt, itemData As wxTreeItemData Ptr) As wxTreeItemId Ptr
Declare Sub wxTreeCtrl_Expand WXCALL Alias "wxTreeCtrl_Expand" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr)
Declare Sub wxTreeCtrl_Collapse WXCALL Alias "wxTreeCtrl_Collapse" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr)
Declare Sub wxTreeCtrl_CollapseAndReset WXCALL Alias "wxTreeCtrl_CollapseAndReset" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr)
Declare Sub wxTreeCtrl_Toggle WXCALL Alias "wxTreeCtrl_Toggle" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr)
Declare Sub wxTreeCtrl_EnsureVisible WXCALL Alias "wxTreeCtrl_EnsureVisible" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr)
Declare Sub wxTreeCtrl_ScrollTo WXCALL Alias "wxTreeCtrl_ScrollTo" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr)
Declare Function wxTreeCtrl_GetChildrenCount WXCALL Alias "wxTreeCtrl_GetChildrenCount" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr, recursively As wxBool) As wxInt
Declare Function wxTreeCtrl_GetCount WXCALL Alias "wxTreeCtrl_GetCount" (self As wxTreeCtrl Ptr) As wxInt
Declare Function wxTreeCtrl_IsVisible WXCALL Alias "wxTreeCtrl_IsVisible" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr) As wxBool
Declare Function wxTreeCtrl_ItemHasChildren WXCALL Alias "wxTreeCtrl_ItemHasChildren" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr) As wxBool
Declare Function wxTreeCtrl_IsExpanded WXCALL Alias "wxTreeCtrl_IsExpanded" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr) As wxBool
Declare Function wxTreeCtrl_GetRootItem WXCALL Alias "wxTreeCtrl_GetRootItem" (self As wxTreeCtrl Ptr) As wxTreeItemId Ptr
Declare Function wxTreeCtrl_GetItemTextColour WXCALL Alias "wxTreeCtrl_GetItemTextColour" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr) As wxColour Ptr
Declare Function wxTreeCtrl_GetItemBackgroundColour WXCALL Alias "wxTreeCtrl_GetItemBackgroundColour" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr) As wxColour Ptr
Declare Function wxTreeCtrl_GetItemFont WXCALL Alias "wxTreeCtrl_GetItemFont" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr) As wxFont Ptr
Declare Sub wxTreeCtrl_SetItemBold WXCALL Alias "wxTreeCtrl_SetItemBold" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr, bols As wxBool)
Declare Sub wxTreeCtrl_SetItemTextColour WXCALL Alias "wxTreeCtrl_SetItemTextColour" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr, col As wxColour Ptr)
Declare Sub wxTreeCtrl_SetItemBackgroundColour WXCALL Alias "wxTreeCtrl_SetItemBackgroundColour" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr, col As wxColour Ptr)
Declare Sub wxTreeCtrl_SetItemFont WXCALL Alias "wxTreeCtrl_SetItemFont" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr, font As wxFont Ptr)
Declare Sub wxTreeCtrl_EditLabel WXCALL Alias "wxTreeCtrl_EditLabel" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr)
Declare Function wxTreeCtrl_GetBoundingRect WXCALL Alias "wxTreeCtrl_GetBoundingRect" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr, r As wxRect Ptr, txtOnly As wxBool) As wxBool
Declare Function wxTreeCtrl_IsBold WXCALL Alias "wxTreeCtrl_IsBold" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr) As wxBool
Declare Sub wxTreeCtrl_SetItemSelectedImage WXCALL Alias "wxTreeCtrl_SetItemSelectedImage" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr, selectImage As wxInt)
Declare Sub wxTreeCtrl_ToggleItemSelection WXCALL Alias "wxTreeCtrl_ToggleItemSelection" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr)
Declare Sub wxTreeCtrl_UnselectItem WXCALL Alias "wxTreeCtrl_UnselectItem" (self As wxTreeCtrl Ptr, item As wxTreeItemId Ptr)

' class wxTreeItemId
Declare Function wxTreeItemId_ctor WXCALL Alias "wxTreeItemId_ctor" () As wxTreeItemId Ptr
Declare Function wxTreeItemId_ctor2 WXCALL Alias "wxTreeItemId_ctor2" (pItem As Any Ptr) As wxTreeItemId Ptr
Declare Sub wxTreeItemId_dtor WXCALL Alias "wxTreeItemId_dtor" (self As wxTreeItemId Ptr)
Declare Sub wxTreeItemId_RegisterDisposable WXCALL Alias "wxTreeItemId_RegisterDisposable" (self As wxTreeItemId Ptr, on_Dispose As Virtual_Dispose)
Declare Function wxTreeItemId_Equal WXCALL Alias "wxTreeItemId_Equal" (item1 As wxTreeItemId Ptr, item2 As wxTreeItemId Ptr) As wxBool
Declare Function wxTreeItemId_IsOk WXCALL Alias "wxTreeItemId_IsOk" (self As wxTreeItemId Ptr) As wxBool
Declare Function wxTreeItemId_AsLong WXCALL Alias "wxTreeItemId_AsLong" (self As wxTreeItemId Ptr) As size_t

' class wxTreeEvent
Declare Function wxTreeEvent_ctor WXCALL Alias "wxTreeEvent_ctor" (typ As wxEventType, id As wxInt) As wxTreeEvent Ptr
Declare Function wxTreeEvent_GetItem WXCALL Alias "wxTreeEvent_GetItem" (self As wxTreeEvent Ptr) As wxTreeItemId Ptr
Declare Sub wxTreeEvent_SetItem WXCALL Alias "wxTreeEvent_SetItem" (self As wxTreeEvent Ptr, item As wxTreeItemId Ptr)
Declare Function wxTreeEvent_GetOldItem WXCALL Alias "wxTreeEvent_GetOldItem" (self As wxTreeEvent Ptr) As wxTreeItemId Ptr
Declare Sub wxTreeEvent_SetOldItem WXCALL Alias "wxTreeEvent_SetOldItem" (self As wxTreeEvent Ptr, item As wxTreeItemId Ptr)
Declare Sub wxTreeEvent_GetPoint WXCALL Alias "wxTreeEvent_GetPoint" (self As wxTreeEvent Ptr, pt As wxPoint Ptr)
Declare Sub wxTreeEvent_SetPoint WXCALL Alias "wxTreeEvent_SetPoint" (self As wxTreeEvent Ptr, pt As wxPoint Ptr)
Declare Function wxTreeEvent_GetKeyEvent WXCALL Alias "wxTreeEvent_GetKeyEvent" (self As wxTreeEvent Ptr) As wxKeyEvent Ptr
Declare Function wxTreeEvent_GetKeyCode WXCALL Alias "wxTreeEvent_GetKeyCode" (self As wxTreeEvent Ptr) As wxInt
Declare Sub wxTreeEvent_SetKeyEvent WXCALL Alias "wxTreeEvent_SetKeyEvent" (self As wxTreeEvent Ptr, event As wxKeyEvent Ptr)
Declare Function wxTreeEvent_GetLabel WXCALL Alias "wxTreeEvent_GetLabel" (self As wxTreeEvent Ptr) As wxString Ptr
Declare Sub wxTreeEvent_SetLabel WXCALL Alias "wxTreeEvent_SetLabel" (self As wxTreeEvent Ptr, label As wxString Ptr)
Declare Function wxTreeEvent_IsEditCancelled WXCALL Alias "wxTreeEvent_IsEditCancelled" (self As wxTreeEvent Ptr) As wxBool
Declare Sub wxTreeEvent_SetEditCanceled WXCALL Alias "wxTreeEvent_SetEditCanceled" (self As wxTreeEvent Ptr, editCancelled As wxBool)
Declare Sub wxTreeEvent_Veto WXCALL Alias "wxTreeEvent_Veto" ( self As wxTreeEvent Ptr)
Declare Sub wxTreeEvent_Allow WXCALL Alias "wxTreeEvent_Allow" ( self As wxTreeEvent Ptr)
Declare Function wxTreeEvent_IsAllowed WXCALL Alias "wxTreeEvent_IsAllowed" ( self As wxTreeEvent Ptr) As wxBool
Declare Sub wxTreeEvent_SetToolTip WXCALL Alias "wxTreeEvent_SetToolTip" (self As wxTreeEvent Ptr, toolTip As wxString Ptr)

'class wxTreeItemData
Declare Function wxTreeItemData_ctor WXCALL Alias "wxTreeItemData_ctor" () As wxTreeItemData Ptr
Declare Sub wxTreeItemData_dtor WXCALL Alias "wxTreeItemData_dtor" (self As wxTreeItemData Ptr)
Declare Sub wxTreeItemData_RegisterDisposable WXCALL Alias "wxTreeItemData_RegisterDisposable" (self As wxTreeItemData Ptr, on_Dispose As Virtual_Dispose)
Declare Function wxTreeItemData_GetId WXCALL Alias "wxTreeItemData_GetId" (self As wxTreeItemData Ptr) As wxTreeItemId Ptr
Declare Sub wxTreeItemData_SetId WXCALL Alias "wxTreeItemData_SetId" (self As wxTreeItemData Ptr, param As wxTreeItemId Ptr)

' class wxTreeItemAttr
Declare Function wxTreeItemAttr_ctor WXCALL Alias "wxTreeItemAttr_ctor" () As wxTreeItemAttr Ptr
Declare Function wxTreeItemAttr_ctor2 WXCALL Alias "wxTreeItemAttr_ctor2" (colTxt As wxColour Ptr, bg As wxColour Ptr, font As wxFont Ptr) As wxTreeItemAttr Ptr
Declare Sub wxTreeItemAttr_dtor WXCALL Alias "wxTreeItemAttr_dtor" (self As wxTreeItemAttr Ptr)
Declare Sub wxTreeItemAttr_RegisterDisposable WXCALL Alias "wxTreeItemAttr_RegisterDisposable" (self As wxTreeItemAttr Ptr,on_Dispose As Virtual_Dispose)
Declare Sub wxTreeItemAttr_SetTextColour WXCALL Alias "wxTreeItemAttr_SetTextColour" (self As wxTreeItemAttr Ptr, colTxt As wxColour Ptr)
Declare Sub wxTreeItemAttr_SetBackgroundColour WXCALL Alias "wxTreeItemAttr_SetBackgroundColour" (self As wxTreeItemAttr Ptr, bg As wxColour Ptr)
Declare Sub wxTreeItemAttr_SetFont WXCALL Alias "wxTreeItemAttr_SetFont" (self As wxTreeItemAttr Ptr, font As wxFont Ptr)
Declare Function wxTreeItemAttr_HasTextColour WXCALL Alias "wxTreeItemAttr_HasTextColour" (self As wxTreeItemAttr Ptr) As wxBool
Declare Function wxTreeItemAttr_HasBackgroundColour WXCALL Alias "wxTreeItemAttr_HasBackgroundColour" (self As wxTreeItemAttr Ptr) As wxBool
Declare Function wxTreeItemAttr_HasFont WXCALL Alias "wxTreeItemAttr_HasFont" (self As wxTreeItemAttr Ptr) As wxBool
Declare Function wxTreeItemAttr_GetTextColour WXCALL Alias "wxTreeItemAttr_GetTextColour" (self As wxTreeItemAttr Ptr) As wxColour Ptr
Declare Function wxTreeItemAttr_GetBackgroundColour WXCALL Alias "wxTreeItemAttr_GetBackgroundColour" (self As wxTreeItemAttr Ptr)As wxColour Ptr
Declare Function wxTreeItemAttr_GetFont WXCALL Alias "wxTreeItemAttr_GetFont" (self As wxTreeItemAttr Ptr)As wxFont Ptr

' class wxArrayTreeItemIds
Declare Function wxArrayTreeItemIds_ctor WXCALL Alias "wxArrayTreeItemIds_ctor" () As wxArrayTreeItemIds Ptr
Declare Sub wxArrayTreeItemIds_dtor WXCALL Alias "wxArrayTreeItemIds_dtor" (self As wxArrayTreeItemIds Ptr)
Declare Sub wxArrayTreeItemIds_RegisterDisposable WXCALL Alias "wxArrayTreeItemIds_RegisterDisposable" (self As wxArrayTreeItemIds Ptr, on_Dispose As Virtual_Dispose)
Declare Sub wxArrayTreeItemIds_Add WXCALL Alias "wxArrayTreeItemIds_Add" (self As wxArrayTreeItemIds Ptr, addID As wxTreeItemId Ptr)
Declare Function wxArrayTreeItemIds_Item WXCALL Alias "wxArrayTreeItemIds_Item" (self As wxArrayTreeItemIds Ptr, num As size_t) As wxTreeItemId Ptr
Declare Function wxArrayTreeItemIds_GetCount WXCALL Alias "wxArrayTreeItemIds_GetCount" (self As wxArrayTreeItemIds Ptr) As wxInt

#EndIf ' __treectrl_bi__

