''
''
'' listctrl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_listctrl_bi__
#define __wxc_listctrl_bi__

#include once "wx.bi"

type wxListCtrlCompare as function WXCALL (byval item1 as integer, byval item2 as integer, byval sortData as integer) as integer


declare function wxListCtrl alias "wxListCtrl_ctor" () as wxListCtrl ptr
declare function wxListCtrl_Create (byval self as wxListCtrl ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as integer
declare sub wxListCtrl_dtor (byval self as wxListCtrl ptr)
declare function wxListCtrl_GetColumn (byval self as wxListCtrl ptr, byval col as integer, byval item as wxListItem ptr) as integer
declare function wxListCtrl_SetColumn (byval self as wxListCtrl ptr, byval col as integer, byval item as wxListItem ptr) as integer
declare function wxListCtrl_GetColumnWidth (byval self as wxListCtrl ptr, byval col as integer) as integer
declare function wxListCtrl_SetColumnWidth (byval self as wxListCtrl ptr, byval col as integer, byval width as integer) as integer
declare function wxListCtrl_GetCountPerPage (byval self as wxListCtrl ptr) as integer
declare function wxListCtrl_GetItem (byval self as wxListCtrl ptr, byval info as wxListItem ptr, byval retval as integer ptr) as wxListItem ptr
declare function wxListCtrl_SetItem (byval self as wxListCtrl ptr, byval info as wxListItem ptr) as integer
declare function wxListCtrl_SetItem_By_Row_Col (byval self as wxListCtrl ptr, byval index as integer, byval col as integer, byval label as zstring ptr, byval imageId as integer) as integer
declare function wxListCtrl_SetTextImageItem (byval self as wxListCtrl ptr, byval index as integer, byval col as integer, byval label as zstring ptr, byval imageId as integer) as integer
declare function wxListCtrl_GetItemState (byval self as wxListCtrl ptr, byval item as integer, byval stateMask as integer) as integer
declare function wxListCtrl_SetItemState (byval self as wxListCtrl ptr, byval item as integer, byval state as integer, byval stateMask as integer) as integer
declare function wxListCtrl_SetItemImage (byval self as wxListCtrl ptr, byval item as integer, byval image as integer, byval selImage as integer) as integer
declare function wxListCtrl_GetItemText (byval self as wxListCtrl ptr, byval item as integer) as wxString ptr
declare sub wxListCtrl_SetItemText (byval self as wxListCtrl ptr, byval item as integer, byval str as zstring ptr)
declare function wxListCtrl_GetItemData (byval self as wxListCtrl ptr, byval item as integer) as any ptr
declare function wxListCtrl_SetItemData (byval self as wxListCtrl ptr, byval item as integer, byval data as any ptr) as integer
declare function wxListCtrl_SetItemData2 (byval self as wxListCtrl ptr, byval item as integer, byval data as integer) as integer
declare function wxListCtrl_GetItemRect (byval self as wxListCtrl ptr, byval item as integer, byval rect as wxRect ptr, byval code as integer) as integer
declare function wxListCtrl_GetItemPosition (byval self as wxListCtrl ptr, byval item as integer, byval pos as wxPoint ptr) as integer
declare function wxListCtrl_SetItemPosition (byval self as wxListCtrl ptr, byval item as integer, byval pos as wxPoint ptr) as integer
declare function wxListCtrl_GetItemCount (byval self as wxListCtrl ptr) as integer
declare function wxListCtrl_GetColumnCount (byval self as wxListCtrl ptr) as integer
declare sub wxListCtrl_SetItemTextColour (byval self as wxListCtrl ptr, byval item as integer, byval col as wxColour ptr)
declare function wxListCtrl_GetItemTextColour (byval self as wxListCtrl ptr, byval item as integer) as wxColour ptr
declare sub wxListCtrl_SetItemBackgroundColour (byval self as wxListCtrl ptr, byval item as integer, byval col as wxColour ptr)
declare function wxListCtrl_GetItemBackgroundColour (byval self as wxListCtrl ptr, byval item as integer) as wxColour ptr
declare function wxListCtrl_GetSelectedItemCount (byval self as wxListCtrl ptr) as integer
declare function wxListCtrl_GetTextColour (byval self as wxListCtrl ptr) as wxColour ptr
declare sub wxListCtrl_SetTextColour (byval self as wxListCtrl ptr, byval col as wxColour ptr)
declare function wxListCtrl_GetTopItem (byval self as wxListCtrl ptr) as integer
declare sub wxListCtrl_SetSingleStyle (byval self as wxListCtrl ptr, byval style as integer, byval add as integer)
declare sub wxListCtrl_SetWindowStyleFlag (byval self as wxListCtrl ptr, byval style as integer)
declare function wxListCtrl_GetNextItem (byval self as wxListCtrl ptr, byval item as integer, byval geometry as integer, byval state as integer) as integer
declare function wxListCtrl_GetImageList (byval self as wxListCtrl ptr, byval which as integer) as wxImageList ptr
declare sub wxListCtrl_SetImageList (byval self as wxListCtrl ptr, byval imageList as wxImageList ptr, byval which as integer)
declare sub wxListCtrl_AssignImageList (byval self as wxListCtrl ptr, byval imageList as wxImageList ptr, byval which as integer)
declare function wxListCtrl_Arrange (byval self as wxListCtrl ptr, byval flag as integer) as integer
declare sub wxListCtrl_ClearAll (byval self as wxListCtrl ptr)
declare function wxListCtrl_DeleteItem (byval self as wxListCtrl ptr, byval item as integer) as integer
declare function wxListCtrl_DeleteAllItems (byval self as wxListCtrl ptr) as integer
declare function wxListCtrl_DeleteAllColumns (byval self as wxListCtrl ptr) as integer
declare function wxListCtrl_DeleteColumn (byval self as wxListCtrl ptr, byval col as integer) as integer
declare sub wxListCtrl_SetItemCount (byval self as wxListCtrl ptr, byval count as integer)
declare sub wxListCtrl_EditLabel (byval self as wxListCtrl ptr, byval item as integer)
declare function wxListCtrl_EnsureVisible (byval self as wxListCtrl ptr, byval item as integer) as integer
declare function wxListCtrl_FindItem (byval self as wxListCtrl ptr, byval start as integer, byval str as zstring ptr, byval partial as integer) as integer
declare function wxListCtrl_FindItemData (byval self as wxListCtrl ptr, byval start as integer, byval data as integer) as integer
declare function wxListCtrl_FindItemPoint (byval self as wxListCtrl ptr, byval start as integer, byval pt as wxPoint ptr, byval direction as integer) as integer
declare function wxListCtrl_HitTest (byval self as wxListCtrl ptr, byval point as wxPoint ptr, byval flags as integer) as integer
declare function wxListCtrl_InsertItem (byval self as wxListCtrl ptr, byval info as wxListItem ptr) as integer
declare function wxListCtrl_InsertTextItem (byval self as wxListCtrl ptr, byval index as integer, byval label as zstring ptr) as integer
declare function wxListCtrl_InsertImageItem (byval self as wxListCtrl ptr, byval index as integer, byval imageIndex as integer) as integer
declare function wxListCtrl_InsertTextImageItem (byval self as wxListCtrl ptr, byval index as integer, byval label as zstring ptr, byval imageIndex as integer) as integer
declare function wxListCtrl_InsertColumn (byval self as wxListCtrl ptr, byval col as integer, byval info as wxListItem ptr) as integer
declare function wxListCtrl_InsertTextColumn (byval self as wxListCtrl ptr, byval col as integer, byval heading as zstring ptr, byval format as integer, byval width as integer) as integer
declare function wxListCtrl_ScrollList (byval self as wxListCtrl ptr, byval dx as integer, byval dy as integer) as integer
declare function wxListCtrl_SortItems (byval self as wxListCtrl ptr, byval fn as wxListCtrlCompare, byval data as integer) as integer
declare sub wxListCtrl_GetViewRect (byval self as wxListCtrl ptr, byval rect as wxRect ptr)
declare sub wxListCtrl_RefreshItem (byval self as wxListCtrl ptr, byval item as integer)
declare sub wxListCtrl_RefreshItems (byval self as wxListCtrl ptr, byval itemFrom as integer, byval itemTo as integer)
declare function wxListItem alias "wxListItem_ctor" () as wxListItem ptr
declare sub wxListItem_Clear (byval self as wxListItem ptr)
declare sub wxListItem_ClearAttributes (byval self as wxListItem ptr)
declare function wxListItem_GetAlign (byval self as wxListItem ptr) as integer
declare function wxListItem_GetBackgroundColour (byval self as wxListItem ptr) as wxColour ptr
declare function wxListItem_GetColumn (byval self as wxListItem ptr) as integer
declare function wxListItem_GetData (byval self as wxListItem ptr) as any ptr
declare function wxListItem_GetFont (byval self as wxListItem ptr) as wxFont ptr
declare function wxListItem_GetId (byval self as wxListItem ptr) as integer
declare function wxListItem_GetImage (byval self as wxListItem ptr) as integer
declare function wxListItem_GetMask (byval self as wxListItem ptr) as integer
declare function wxListItem_GetState (byval self as wxListItem ptr) as integer
declare function wxListItem_GetText (byval self as wxListItem ptr) as wxString ptr
declare function wxListItem_GetTextColour (byval self as wxListItem ptr) as wxColour ptr
declare function wxListItem_GetWidth (byval self as wxListItem ptr) as integer
declare sub wxListItem_SetAlign (byval self as wxListItem ptr, byval align as integer)
declare sub wxListItem_SetBackgroundColour (byval self as wxListItem ptr, byval col as wxColour ptr)
declare sub wxListItem_SetColumn (byval self as wxListItem ptr, byval col as integer)
declare sub wxListItem_SetData (byval self as wxListItem ptr, byval data as any ptr)
declare sub wxListItem_SetFont (byval self as wxListItem ptr, byval font as wxFont ptr)
declare sub wxListItem_SetId (byval self as wxListItem ptr, byval id as integer)
declare sub wxListItem_SetImage (byval self as wxListItem ptr, byval image as integer)
declare sub wxListItem_SetMask (byval self as wxListItem ptr, byval mask as integer)
declare sub wxListItem_SetState (byval self as wxListItem ptr, byval state as integer)
declare sub wxListItem_SetStateMask (byval self as wxListItem ptr, byval stateMask as integer)
declare sub wxListItem_SetText (byval self as wxListItem ptr, byval text as zstring ptr)
declare sub wxListItem_SetTextColour (byval self as wxListItem ptr, byval col as wxColour ptr)
declare sub wxListItem_SetWidth (byval self as wxListItem ptr, byval width as integer)
declare function wxListItem_GetAttributes (byval self as wxListItem ptr) as wxListItemAttr ptr
declare function wxListItem_HasAttributes (byval self as wxListItem ptr) as integer
declare function wxListEvent alias "wxListEvent_ctor" (byval commandType as wxEventType, byval id as integer) as wxListEvent ptr
declare function wxListEvent_GetCacheFrom (byval self as wxListEvent ptr) as integer
declare function wxListEvent_GetCacheTo (byval self as wxListEvent ptr) as integer
declare function wxListEvent_GetKeyCode (byval self as wxListEvent ptr) as integer
declare function wxListEvent_GetIndex (byval self as wxListEvent ptr) as integer
declare function wxListEvent_GetColumn (byval self as wxListEvent ptr) as integer
declare function wxListEvent_IsEditCancelled (byval self as wxListEvent ptr) as integer
declare sub wxListEvent_SetEditCanceled (byval self as wxListEvent ptr, byval editCancelled as integer)
declare function wxListEvent_GetLabel (byval self as wxListEvent ptr) as wxString ptr
declare sub wxListEvent_GetPoint (byval self as wxListEvent ptr, byval pt as wxPoint ptr)
declare function wxListEvent_GetImage (byval self as wxListEvent ptr) as integer
declare function wxListEvent_GetText (byval self as wxListEvent ptr) as wxString ptr
declare function wxListEvent_GetMask (byval self as wxListEvent ptr) as integer
declare function wxListEvent_GetItem (byval self as wxListEvent ptr) as wxListItem ptr
declare function wxListEvent_GetData (byval self as wxListEvent ptr) as integer
declare sub wxListEvent_Veto (byval self as wxListEvent ptr)
declare sub wxListEvent_Allow (byval self as wxListEvent ptr)
declare function wxListEvent_IsAllowed (byval self as wxListEvent ptr) as integer

declare function wxListView alias "wxListView_ctor" () as wxListView ptr
declare function wxListView_Create (byval self as wxListCtrl ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as integer
declare sub wxListView_Select (byval self as wxListView ptr, byval n as integer, byval on as integer)
declare sub wxListView_Focus (byval self as wxListView ptr, byval index as integer)
declare function wxListView_GetFocusedItem (byval self as wxListView ptr) as integer
declare function wxListView_GetNextSelected (byval self as wxListView ptr, byval item as integer) as integer
declare function wxListView_GetFirstSelected (byval self as wxListView ptr) as integer
declare function wxListView_IsSelected (byval self as wxListView ptr, byval index as integer) as integer
declare sub wxListView_SetColumnImage (byval self as wxListView ptr, byval col as integer, byval image as integer)
declare sub wxListView_ClearColumnImage (byval self as wxListView ptr, byval col as integer)

declare function wxListItemAttr alias "wxListItemAttr_ctor" () as wxListItemAttr ptr
declare function wxListItemAttr_ctor2 (byval colText as wxColour ptr, byval colBack as wxColour ptr, byval font as wxFont ptr) as wxListItemAttr ptr
declare sub wxListItemAttr_dtor (byval self as wxListItemAttr ptr)
declare sub wxListItemAttr_RegisterDisposable (byval self as _ListItemAttr ptr, byval onDispose as Virtual_Dispose)
declare sub wxListItemAttr_SetTextColour (byval self as wxListItemAttr ptr, byval colText as wxColour ptr)
declare sub wxListItemAttr_SetBackgroundColour (byval self as wxListItemAttr ptr, byval colBack as wxColour ptr)
declare sub wxListItemAttr_SetFont (byval self as wxListItemAttr ptr, byval font as wxFont ptr)
declare function wxListItemAttr_HasTextColour (byval self as wxListItemAttr ptr) as integer
declare function wxListItemAttr_HasBackgroundColour (byval self as wxListItemAttr ptr) as integer
declare function wxListItemAttr_HasFont (byval self as wxListItemAttr ptr) as integer
declare function wxListItemAttr_GetTextColour (byval self as wxListItemAttr ptr) as wxColour ptr
declare function wxListItemAttr_GetBackgroundColour (byval self as wxListItemAttr ptr) as wxColour ptr
declare function wxListItemAttr_GetFont (byval self as wxListItemAttr ptr) as wxFont ptr

#endif
