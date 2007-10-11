''
''
'' treectrl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_treectrl_bi__
#define __wxc_treectrl_bi__

#include once "wx.bi"


type Virtual_OnCompareItems as function WXCALL (byval as wxTreeItemId ptr, byval as wxTreeItemId ptr) as integer

declare function wxTreeCtrl_Create (byval self as wxTreeCtrl ptr, byval parent as wxWindow ptr, byval id as integer, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval val as wxValidator ptr, byval name as zstring ptr) as integer
declare function wxTreeCtrl_GetDefaultStyle () as integer
declare function wxTreeCtrl_GetIndent (byval self as wxTreeCtrl ptr) as uinteger
declare sub wxTreeCtrl_SetIndent (byval self as wxTreeCtrl ptr, byval indent as uinteger)
declare function wxTreeCtrl_GetSpacing (byval self as wxTreeCtrl ptr) as uinteger
declare sub wxTreeCtrl_SetSpacing (byval self as wxTreeCtrl ptr, byval indent as uinteger)
declare function wxTreeCtrl_GetStateImageList (byval self as wxTreeCtrl ptr) as wxImageList ptr
declare sub wxTreeCtrl_SetStateImageList (byval self as wxTreeCtrl ptr, byval imageList as wxImageList ptr)
declare function wxTreeCtrl_GetImageList (byval self as wxTreeCtrl ptr) as wxImageList ptr
declare sub wxTreeCtrl_SetImageList (byval self as wxTreeCtrl ptr, byval imageList as wxImageList ptr)
declare sub wxTreeCtrl_SetItemImage (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval image as integer, byval which as wxTreeItemIcon)
declare function wxTreeCtrl_GetItemImage (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval which as wxTreeItemIcon) as integer
declare sub wxTreeCtrl_DeleteAllItems (byval self as wxTreeCtrl ptr)
declare sub wxTreeCtrl_DeleteChildren (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare sub wxTreeCtrl_Delete (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare sub wxTreeCtrl_Unselect (byval self as wxTreeCtrl ptr)
declare sub wxTreeCtrl_UnselectAll (byval self as wxTreeCtrl ptr)
declare sub wxTreeCtrl_SelectItem (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare function wxTreeCtrl_GetSelection (byval self as wxTreeCtrl ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_IsSelected (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as integer
declare function wxTreeCtrl_GetSelections (byval self as wxTreeCtrl ptr) as wxArrayTreeItemIds ptr
declare sub wxTreeCtrl_SetItemText (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval text as zstring ptr)
declare function wxTreeCtrl_GetItemText (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxString ptr
declare sub wxTreeCtrl_SetItemData (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval data as wxTreeItemData ptr)
declare function wxTreeCtrl_GetItemData (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxTreeItemData ptr
declare sub wxTreeCtrl_SetItemHasChildren (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval has as integer)
declare function wxTreeCtrl_HitTest (byval self as wxTreeCtrl ptr, byval pt as wxPoint ptr, byval flags as integer ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetItemParent (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetMyCookie (byval self as _TreeCtrl ptr) as any ptr
declare sub wxTreeCtrl_SetMyCookie (byval self as _TreeCtrl ptr, byval newval as any ptr)
declare function wxTreeCtrl_GetFirstChild (byval self as _TreeCtrl ptr, byval item as wxTreeItemId ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetNextChild (byval self as _TreeCtrl ptr, byval item as wxTreeItemId ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetLastChild (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetNextSibling (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetPrevSibling (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetFirstVisibleItem (byval self as wxTreeCtrl ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetNextVisible (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetPrevVisible (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_PrependItem (byval self as wxTreeCtrl ptr, byval parent as wxTreeItemId ptr, byval text as zstring ptr, byval image as integer, byval selectedImage as integer, byval data as wxTreeItemData ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_InsertItem (byval self as wxTreeCtrl ptr, byval parent as wxTreeItemId ptr, byval idPrevious as wxTreeItemId ptr, byval text as zstring ptr, byval image as integer, byval selectedImage as integer, byval data as wxTreeItemData ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_InsertItem2 (byval self as wxTreeCtrl ptr, byval parent as wxTreeItemId ptr, byval before as integer, byval text as zstring ptr, byval image as integer, byval selectedImage as integer, byval data as wxTreeItemData ptr) as wxTreeItemId ptr
declare sub wxTreeCtrl_Expand (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare sub wxTreeCtrl_Collapse (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare sub wxTreeCtrl_CollapseAndReset (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare sub wxTreeCtrl_Toggle (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare sub wxTreeCtrl_EnsureVisible (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare sub wxTreeCtrl_ScrollTo (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare function wxTreeCtrl_GetChildrenCount (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval recursively as integer) as integer
declare function wxTreeCtrl_GetCount (byval self as wxTreeCtrl ptr) as integer
declare function wxTreeCtrl_IsVisible (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as integer
declare function wxTreeCtrl_ItemHasChildren (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as integer
declare function wxTreeCtrl_IsExpanded (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as integer
declare function wxTreeCtrl_GetRootItem (byval self as wxTreeCtrl ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetItemTextColour (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxColour ptr
declare function wxTreeCtrl_GetItemBackgroundColour (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxColour ptr
declare function wxTreeCtrl_GetItemFont (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxFont ptr
declare sub wxTreeCtrl_SetItemBold (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval bold as integer)
declare sub wxTreeCtrl_SetItemTextColour (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval col as wxColour ptr)
declare sub wxTreeCtrl_SetItemBackgroundColour (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval col as wxColour ptr)
declare sub wxTreeCtrl_SetItemFont (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval font as wxFont ptr)
declare sub wxTreeCtrl_EditLabel (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare function wxTreeCtrl_GetBoundingRect (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval rect as wxRect ptr, byval textOnly as integer) as integer
declare function wxTreeCtrl_IsBold (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as integer
declare sub wxTreeCtrl_SetItemSelectedImage (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval selImage as integer)
declare sub wxTreeCtrl_ToggleItemSelection (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare sub wxTreeCtrl_UnselectItem (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)

declare function wxTreeItemId alias "wxTreeItemId_ctor" () as wxTreeItemId ptr
declare function wxTreeItemId_ctor2 (byval pItem as any ptr) as wxTreeItemId ptr
declare sub wxTreeItemId_dtor (byval self as wxTreeItemId ptr)
declare sub wxTreeItemId_RegisterDisposable (byval self as _TreeItemId ptr, byval onDispose as Virtual_Dispose)
declare function wxTreeItemId_Equal (byval item1 as wxTreeItemId ptr, byval item2 as wxTreeItemId ptr) as integer
declare function wxTreeItemId_IsOk (byval self as wxTreeItemId ptr) as integer
declare function wxTreeEvent alias "wxTreeEvent_ctor" (byval commandType as wxEventType, byval id as integer) as wxTreeEvent ptr
declare function wxTreeEvent_GetItem (byval self as wxTreeEvent ptr) as wxTreeItemId ptr
declare sub wxTreeEvent_SetItem (byval self as wxTreeEvent ptr, byval item as wxTreeItemId ptr)
declare function wxTreeEvent_GetOldItem (byval self as wxTreeEvent ptr) as wxTreeItemId ptr
declare sub wxTreeEvent_SetOldItem (byval self as wxTreeEvent ptr, byval item as wxTreeItemId ptr)
declare sub wxTreeEvent_GetPoint (byval self as wxTreeEvent ptr, byval pt as wxPoint ptr)
declare sub wxTreeEvent_SetPoint (byval self as wxTreeEvent ptr, byval pt as wxPoint ptr)
declare function wxTreeEvent_GetKeyEvent (byval self as wxTreeEvent ptr) as wxKeyEvent ptr
declare function wxTreeEvent_GetKeyCode (byval self as wxTreeEvent ptr) as integer
declare sub wxTreeEvent_SetKeyEvent (byval self as wxTreeEvent ptr, byval evt as wxKeyEvent ptr)
declare function wxTreeEvent_GetLabel (byval self as wxTreeEvent ptr) as wxString ptr
declare sub wxTreeEvent_SetLabel (byval self as wxTreeEvent ptr, byval label as zstring ptr)
declare function wxTreeEvent_IsEditCancelled (byval self as wxTreeEvent ptr) as integer
declare sub wxTreeEvent_SetEditCanceled (byval self as wxTreeEvent ptr, byval editCancelled as integer)
declare sub wxTreeEvent_Veto (byval self as wxTreeEvent ptr)
declare sub wxTreeEvent_Allow (byval self as wxTreeEvent ptr)
declare function wxTreeEvent_IsAllowed (byval self as wxTreeEvent ptr) as integer
declare sub wxTreeEvent_SetToolTip (byval self as wxTreeEvent ptr, byval toolTip as zstring ptr)

declare function wxTreeItemData alias "wxTreeItemData_ctor" () as wxTreeItemData ptr
declare sub wxTreeItemData_dtor (byval self as wxTreeItemData ptr)
declare sub wxTreeItemData_RegisterDisposable (byval self as _TreeItemData ptr, byval onDispose as Virtual_Dispose)
declare function wxTreeItemData_GetId (byval self as wxTreeItemData ptr) as wxTreeItemId ptr
declare sub wxTreeItemData_SetId (byval self as wxTreeItemData ptr, byval param as wxTreeItemId ptr)

declare function wxTreeItemAttr alias "wxTreeItemAttr_ctor" () as wxTreeItemAttr ptr
declare function wxTreeItemAttr_ctor2 (byval colText as wxColour ptr, byval colBack as wxColour ptr, byval font as wxFont ptr) as wxTreeItemAttr ptr
declare sub wxTreeItemAttr_dtor (byval self as wxTreeItemAttr ptr)
declare sub wxTreeItemAttr_RegisterDisposable (byval self as _TreeItemAttr ptr, byval onDispose as Virtual_Dispose)
declare sub wxTreeItemAttr_SetTextColour (byval self as wxTreeItemAttr ptr, byval colText as wxColour ptr)
declare sub wxTreeItemAttr_SetBackgroundColour (byval self as wxTreeItemAttr ptr, byval colBack as wxColour ptr)
declare sub wxTreeItemAttr_SetFont (byval self as wxTreeItemAttr ptr, byval font as wxFont ptr)
declare function wxTreeItemAttr_HasTextColour (byval self as wxTreeItemAttr ptr) as integer
declare function wxTreeItemAttr_HasBackgroundColour (byval self as wxTreeItemAttr ptr) as integer
declare function wxTreeItemAttr_HasFont (byval self as wxTreeItemAttr ptr) as integer
declare function wxTreeItemAttr_GetTextColour (byval self as wxTreeItemAttr ptr) as wxColour ptr
declare function wxTreeItemAttr_GetBackgroundColour (byval self as wxTreeItemAttr ptr) as wxColour ptr
declare function wxTreeItemAttr_GetFont (byval self as wxTreeItemAttr ptr) as wxFont ptr

declare function wxArrayTreeItemIds alias "wxArrayTreeItemIds_ctor" () as wxArrayTreeItemIds ptr
declare sub wxArrayTreeItemIds_dtor (byval self as wxArrayTreeItemIds ptr)
declare sub wxArrayTreeItemIds_RegisterDisposable (byval self as _ArrayTreeItemIds ptr, byval onDispose as Virtual_Dispose)
declare sub wxArrayTreeItemIds_Add (byval self as wxArrayTreeItemIds ptr, byval toadd as wxTreeItemId ptr)
declare function wxArrayTreeItemIds_Item (byval self as wxArrayTreeItemIds ptr, byval num as integer) as wxTreeItemId ptr
declare function wxArrayTreeItemIds_GetCount (byval self as wxArrayTreeItemIds ptr) as integer

#endif
