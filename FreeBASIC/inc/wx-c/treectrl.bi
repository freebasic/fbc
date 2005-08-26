''
''
'' treectrl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __treectrl_bi__
#define __treectrl_bi__

#include once "wx-c/wx.bi"


type Virtual_OnCompareItems as function (byval as wxTreeItemId ptr, byval as wxTreeItemId ptr) as integer

declare function wxTreeCtrl_Create cdecl alias "wxTreeCtrl_Create" (byval self as wxTreeCtrl ptr, byval parent as wxWindow ptr, byval id as integer, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval val as wxValidator ptr, byval name as zstring ptr) as integer
declare function wxTreeCtrl_GetDefaultStyle cdecl alias "wxTreeCtrl_GetDefaultStyle" () as integer
declare function wxTreeCtrl_GetIndent cdecl alias "wxTreeCtrl_GetIndent" (byval self as wxTreeCtrl ptr) as uinteger
declare sub wxTreeCtrl_SetIndent cdecl alias "wxTreeCtrl_SetIndent" (byval self as wxTreeCtrl ptr, byval indent as uinteger)
declare function wxTreeCtrl_GetSpacing cdecl alias "wxTreeCtrl_GetSpacing" (byval self as wxTreeCtrl ptr) as uinteger
declare sub wxTreeCtrl_SetSpacing cdecl alias "wxTreeCtrl_SetSpacing" (byval self as wxTreeCtrl ptr, byval indent as uinteger)
declare function wxTreeCtrl_GetStateImageList cdecl alias "wxTreeCtrl_GetStateImageList" (byval self as wxTreeCtrl ptr) as wxImageList ptr
declare sub wxTreeCtrl_SetStateImageList cdecl alias "wxTreeCtrl_SetStateImageList" (byval self as wxTreeCtrl ptr, byval imageList as wxImageList ptr)
declare function wxTreeCtrl_GetImageList cdecl alias "wxTreeCtrl_GetImageList" (byval self as wxTreeCtrl ptr) as wxImageList ptr
declare sub wxTreeCtrl_SetImageList cdecl alias "wxTreeCtrl_SetImageList" (byval self as wxTreeCtrl ptr, byval imageList as wxImageList ptr)
declare sub wxTreeCtrl_SetItemImage cdecl alias "wxTreeCtrl_SetItemImage" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval image as integer, byval which as wxTreeItemIcon)
declare function wxTreeCtrl_GetItemImage cdecl alias "wxTreeCtrl_GetItemImage" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval which as wxTreeItemIcon) as integer
declare sub wxTreeCtrl_DeleteAllItems cdecl alias "wxTreeCtrl_DeleteAllItems" (byval self as wxTreeCtrl ptr)
declare sub wxTreeCtrl_DeleteChildren cdecl alias "wxTreeCtrl_DeleteChildren" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare sub wxTreeCtrl_Delete cdecl alias "wxTreeCtrl_Delete" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare sub wxTreeCtrl_Unselect cdecl alias "wxTreeCtrl_Unselect" (byval self as wxTreeCtrl ptr)
declare sub wxTreeCtrl_UnselectAll cdecl alias "wxTreeCtrl_UnselectAll" (byval self as wxTreeCtrl ptr)
declare sub wxTreeCtrl_SelectItem cdecl alias "wxTreeCtrl_SelectItem" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare function wxTreeCtrl_GetSelection cdecl alias "wxTreeCtrl_GetSelection" (byval self as wxTreeCtrl ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_IsSelected cdecl alias "wxTreeCtrl_IsSelected" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as integer
declare function wxTreeCtrl_GetSelections cdecl alias "wxTreeCtrl_GetSelections" (byval self as wxTreeCtrl ptr) as wxArrayTreeItemIds ptr
declare sub wxTreeCtrl_SetItemText cdecl alias "wxTreeCtrl_SetItemText" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval text as zstring ptr)
declare function wxTreeCtrl_GetItemText cdecl alias "wxTreeCtrl_GetItemText" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxString ptr
declare sub wxTreeCtrl_SetItemData cdecl alias "wxTreeCtrl_SetItemData" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval data as wxTreeItemData ptr)
declare function wxTreeCtrl_GetItemData cdecl alias "wxTreeCtrl_GetItemData" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxTreeItemData ptr
declare sub wxTreeCtrl_SetItemHasChildren cdecl alias "wxTreeCtrl_SetItemHasChildren" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval has as integer)
declare function wxTreeCtrl_HitTest cdecl alias "wxTreeCtrl_HitTest" (byval self as wxTreeCtrl ptr, byval pt as wxPoint ptr, byval flags as integer ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetItemParent cdecl alias "wxTreeCtrl_GetItemParent" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetMyCookie cdecl alias "wxTreeCtrl_GetMyCookie" (byval self as _TreeCtrl ptr) as any ptr
declare sub wxTreeCtrl_SetMyCookie cdecl alias "wxTreeCtrl_SetMyCookie" (byval self as _TreeCtrl ptr, byval newval as any ptr)
declare function wxTreeCtrl_GetFirstChild cdecl alias "wxTreeCtrl_GetFirstChild" (byval self as _TreeCtrl ptr, byval item as wxTreeItemId ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetNextChild cdecl alias "wxTreeCtrl_GetNextChild" (byval self as _TreeCtrl ptr, byval item as wxTreeItemId ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetLastChild cdecl alias "wxTreeCtrl_GetLastChild" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetNextSibling cdecl alias "wxTreeCtrl_GetNextSibling" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetPrevSibling cdecl alias "wxTreeCtrl_GetPrevSibling" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetFirstVisibleItem cdecl alias "wxTreeCtrl_GetFirstVisibleItem" (byval self as wxTreeCtrl ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetNextVisible cdecl alias "wxTreeCtrl_GetNextVisible" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetPrevVisible cdecl alias "wxTreeCtrl_GetPrevVisible" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_PrependItem cdecl alias "wxTreeCtrl_PrependItem" (byval self as wxTreeCtrl ptr, byval parent as wxTreeItemId ptr, byval text as zstring ptr, byval image as integer, byval selectedImage as integer, byval data as wxTreeItemData ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_InsertItem cdecl alias "wxTreeCtrl_InsertItem" (byval self as wxTreeCtrl ptr, byval parent as wxTreeItemId ptr, byval idPrevious as wxTreeItemId ptr, byval text as zstring ptr, byval image as integer, byval selectedImage as integer, byval data as wxTreeItemData ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_InsertItem2 cdecl alias "wxTreeCtrl_InsertItem2" (byval self as wxTreeCtrl ptr, byval parent as wxTreeItemId ptr, byval before as integer, byval text as zstring ptr, byval image as integer, byval selectedImage as integer, byval data as wxTreeItemData ptr) as wxTreeItemId ptr
declare sub wxTreeCtrl_Expand cdecl alias "wxTreeCtrl_Expand" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare sub wxTreeCtrl_Collapse cdecl alias "wxTreeCtrl_Collapse" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare sub wxTreeCtrl_CollapseAndReset cdecl alias "wxTreeCtrl_CollapseAndReset" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare sub wxTreeCtrl_Toggle cdecl alias "wxTreeCtrl_Toggle" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare sub wxTreeCtrl_EnsureVisible cdecl alias "wxTreeCtrl_EnsureVisible" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare sub wxTreeCtrl_ScrollTo cdecl alias "wxTreeCtrl_ScrollTo" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare function wxTreeCtrl_GetChildrenCount cdecl alias "wxTreeCtrl_GetChildrenCount" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval recursively as integer) as integer
declare function wxTreeCtrl_GetCount cdecl alias "wxTreeCtrl_GetCount" (byval self as wxTreeCtrl ptr) as integer
declare function wxTreeCtrl_IsVisible cdecl alias "wxTreeCtrl_IsVisible" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as integer
declare function wxTreeCtrl_ItemHasChildren cdecl alias "wxTreeCtrl_ItemHasChildren" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as integer
declare function wxTreeCtrl_IsExpanded cdecl alias "wxTreeCtrl_IsExpanded" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as integer
declare function wxTreeCtrl_GetRootItem cdecl alias "wxTreeCtrl_GetRootItem" (byval self as wxTreeCtrl ptr) as wxTreeItemId ptr
declare function wxTreeCtrl_GetItemTextColour cdecl alias "wxTreeCtrl_GetItemTextColour" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxColour ptr
declare function wxTreeCtrl_GetItemBackgroundColour cdecl alias "wxTreeCtrl_GetItemBackgroundColour" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxColour ptr
declare function wxTreeCtrl_GetItemFont cdecl alias "wxTreeCtrl_GetItemFont" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as wxFont ptr
declare sub wxTreeCtrl_SetItemBold cdecl alias "wxTreeCtrl_SetItemBold" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval bold as integer)
declare sub wxTreeCtrl_SetItemTextColour cdecl alias "wxTreeCtrl_SetItemTextColour" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval col as wxColour ptr)
declare sub wxTreeCtrl_SetItemBackgroundColour cdecl alias "wxTreeCtrl_SetItemBackgroundColour" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval col as wxColour ptr)
declare sub wxTreeCtrl_SetItemFont cdecl alias "wxTreeCtrl_SetItemFont" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval font as wxFont ptr)
declare sub wxTreeCtrl_EditLabel cdecl alias "wxTreeCtrl_EditLabel" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare function wxTreeCtrl_GetBoundingRect cdecl alias "wxTreeCtrl_GetBoundingRect" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval rect as wxRect ptr, byval textOnly as integer) as integer
declare function wxTreeCtrl_IsBold cdecl alias "wxTreeCtrl_IsBold" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr) as integer
declare sub wxTreeCtrl_SetItemSelectedImage cdecl alias "wxTreeCtrl_SetItemSelectedImage" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr, byval selImage as integer)
declare sub wxTreeCtrl_ToggleItemSelection cdecl alias "wxTreeCtrl_ToggleItemSelection" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)
declare sub wxTreeCtrl_UnselectItem cdecl alias "wxTreeCtrl_UnselectItem" (byval self as wxTreeCtrl ptr, byval item as wxTreeItemId ptr)

declare function wxTreeItemId cdecl alias "wxTreeItemId_ctor" () as wxTreeItemId ptr
declare function wxTreeItemId_ctor2 cdecl alias "wxTreeItemId_ctor2" (byval pItem as any ptr) as wxTreeItemId ptr
declare sub wxTreeItemId_dtor cdecl alias "wxTreeItemId_dtor" (byval self as wxTreeItemId ptr)
declare sub wxTreeItemId_RegisterDisposable cdecl alias "wxTreeItemId_RegisterDisposable" (byval self as _TreeItemId ptr, byval onDispose as Virtual_Dispose)
declare function wxTreeItemId_Equal cdecl alias "wxTreeItemId_Equal" (byval item1 as wxTreeItemId ptr, byval item2 as wxTreeItemId ptr) as integer
declare function wxTreeItemId_IsOk cdecl alias "wxTreeItemId_IsOk" (byval self as wxTreeItemId ptr) as integer
declare function wxTreeEvent cdecl alias "wxTreeEvent_ctor" (byval commandType as wxEventType, byval id as integer) as wxTreeEvent ptr
declare function wxTreeEvent_GetItem cdecl alias "wxTreeEvent_GetItem" (byval self as wxTreeEvent ptr) as wxTreeItemId ptr
declare sub wxTreeEvent_SetItem cdecl alias "wxTreeEvent_SetItem" (byval self as wxTreeEvent ptr, byval item as wxTreeItemId ptr)
declare function wxTreeEvent_GetOldItem cdecl alias "wxTreeEvent_GetOldItem" (byval self as wxTreeEvent ptr) as wxTreeItemId ptr
declare sub wxTreeEvent_SetOldItem cdecl alias "wxTreeEvent_SetOldItem" (byval self as wxTreeEvent ptr, byval item as wxTreeItemId ptr)
declare sub wxTreeEvent_GetPoint cdecl alias "wxTreeEvent_GetPoint" (byval self as wxTreeEvent ptr, byval pt as wxPoint ptr)
declare sub wxTreeEvent_SetPoint cdecl alias "wxTreeEvent_SetPoint" (byval self as wxTreeEvent ptr, byval pt as wxPoint ptr)
declare function wxTreeEvent_GetKeyEvent cdecl alias "wxTreeEvent_GetKeyEvent" (byval self as wxTreeEvent ptr) as wxKeyEvent ptr
declare function wxTreeEvent_GetKeyCode cdecl alias "wxTreeEvent_GetKeyCode" (byval self as wxTreeEvent ptr) as integer
declare sub wxTreeEvent_SetKeyEvent cdecl alias "wxTreeEvent_SetKeyEvent" (byval self as wxTreeEvent ptr, byval evt as wxKeyEvent ptr)
declare function wxTreeEvent_GetLabel cdecl alias "wxTreeEvent_GetLabel" (byval self as wxTreeEvent ptr) as wxString ptr
declare sub wxTreeEvent_SetLabel cdecl alias "wxTreeEvent_SetLabel" (byval self as wxTreeEvent ptr, byval label as zstring ptr)
declare function wxTreeEvent_IsEditCancelled cdecl alias "wxTreeEvent_IsEditCancelled" (byval self as wxTreeEvent ptr) as integer
declare sub wxTreeEvent_SetEditCanceled cdecl alias "wxTreeEvent_SetEditCanceled" (byval self as wxTreeEvent ptr, byval editCancelled as integer)
declare sub wxTreeEvent_Veto cdecl alias "wxTreeEvent_Veto" (byval self as wxTreeEvent ptr)
declare sub wxTreeEvent_Allow cdecl alias "wxTreeEvent_Allow" (byval self as wxTreeEvent ptr)
declare function wxTreeEvent_IsAllowed cdecl alias "wxTreeEvent_IsAllowed" (byval self as wxTreeEvent ptr) as integer
declare sub wxTreeEvent_SetToolTip cdecl alias "wxTreeEvent_SetToolTip" (byval self as wxTreeEvent ptr, byval toolTip as zstring ptr)

declare function wxTreeItemData cdecl alias "wxTreeItemData_ctor" () as wxTreeItemData ptr
declare sub wxTreeItemData_dtor cdecl alias "wxTreeItemData_dtor" (byval self as wxTreeItemData ptr)
declare sub wxTreeItemData_RegisterDisposable cdecl alias "wxTreeItemData_RegisterDisposable" (byval self as _TreeItemData ptr, byval onDispose as Virtual_Dispose)
declare function wxTreeItemData_GetId cdecl alias "wxTreeItemData_GetId" (byval self as wxTreeItemData ptr) as wxTreeItemId ptr
declare sub wxTreeItemData_SetId cdecl alias "wxTreeItemData_SetId" (byval self as wxTreeItemData ptr, byval param as wxTreeItemId ptr)

declare function wxTreeItemAttr cdecl alias "wxTreeItemAttr_ctor" () as wxTreeItemAttr ptr
declare function wxTreeItemAttr_ctor2 cdecl alias "wxTreeItemAttr_ctor2" (byval colText as wxColour ptr, byval colBack as wxColour ptr, byval font as wxFont ptr) as wxTreeItemAttr ptr
declare sub wxTreeItemAttr_dtor cdecl alias "wxTreeItemAttr_dtor" (byval self as wxTreeItemAttr ptr)
declare sub wxTreeItemAttr_RegisterDisposable cdecl alias "wxTreeItemAttr_RegisterDisposable" (byval self as _TreeItemAttr ptr, byval onDispose as Virtual_Dispose)
declare sub wxTreeItemAttr_SetTextColour cdecl alias "wxTreeItemAttr_SetTextColour" (byval self as wxTreeItemAttr ptr, byval colText as wxColour ptr)
declare sub wxTreeItemAttr_SetBackgroundColour cdecl alias "wxTreeItemAttr_SetBackgroundColour" (byval self as wxTreeItemAttr ptr, byval colBack as wxColour ptr)
declare sub wxTreeItemAttr_SetFont cdecl alias "wxTreeItemAttr_SetFont" (byval self as wxTreeItemAttr ptr, byval font as wxFont ptr)
declare function wxTreeItemAttr_HasTextColour cdecl alias "wxTreeItemAttr_HasTextColour" (byval self as wxTreeItemAttr ptr) as integer
declare function wxTreeItemAttr_HasBackgroundColour cdecl alias "wxTreeItemAttr_HasBackgroundColour" (byval self as wxTreeItemAttr ptr) as integer
declare function wxTreeItemAttr_HasFont cdecl alias "wxTreeItemAttr_HasFont" (byval self as wxTreeItemAttr ptr) as integer
declare function wxTreeItemAttr_GetTextColour cdecl alias "wxTreeItemAttr_GetTextColour" (byval self as wxTreeItemAttr ptr) as wxColour ptr
declare function wxTreeItemAttr_GetBackgroundColour cdecl alias "wxTreeItemAttr_GetBackgroundColour" (byval self as wxTreeItemAttr ptr) as wxColour ptr
declare function wxTreeItemAttr_GetFont cdecl alias "wxTreeItemAttr_GetFont" (byval self as wxTreeItemAttr ptr) as wxFont ptr

declare function wxArrayTreeItemIds cdecl alias "wxArrayTreeItemIds_ctor" () as wxArrayTreeItemIds ptr
declare sub wxArrayTreeItemIds_dtor cdecl alias "wxArrayTreeItemIds_dtor" (byval self as wxArrayTreeItemIds ptr)
declare sub wxArrayTreeItemIds_RegisterDisposable cdecl alias "wxArrayTreeItemIds_RegisterDisposable" (byval self as _ArrayTreeItemIds ptr, byval onDispose as Virtual_Dispose)
declare sub wxArrayTreeItemIds_Add cdecl alias "wxArrayTreeItemIds_Add" (byval self as wxArrayTreeItemIds ptr, byval toadd as wxTreeItemId ptr)
declare function wxArrayTreeItemIds_Item cdecl alias "wxArrayTreeItemIds_Item" (byval self as wxArrayTreeItemIds ptr, byval num as integer) as wxTreeItemId ptr
declare function wxArrayTreeItemIds_GetCount cdecl alias "wxArrayTreeItemIds_GetCount" (byval self as wxArrayTreeItemIds ptr) as integer

#endif
