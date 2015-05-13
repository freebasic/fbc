#Ifndef __helpdata_bi__
#Define __helpdata_bi__

#Include Once "common.bi"

' class wxHtmlHelpData
Declare Function wxHtmlHelpData_ctor WXCALL Alias "wxHtmlHelpData_ctor" () As wxHtmlHelpData Ptr
Declare Sub wxHtmlHelpData_SetVirtualDispose WXCALL Alias "wxHtmlHelpData_SetVirtualDispose" (self As wxHtmlHelpData Ptr, on_dispose As Virtual_Dispose)
Declare Sub wxHtmlHelpData_SetTempDir WXCALL Alias "wxHtmlHelpData_SetTempDir" (self As wxHtmlHelpData Ptr, path As wxString Ptr)
Declare Function wxHtmlHelpData_AddBook WXCALL Alias "wxHtmlHelpData_AddBook" (self As wxHtmlHelpData Ptr, book As wxString Ptr) As wxbool
Declare Function wxHtmlHelpData_FindPageByName WXCALL Alias "wxHtmlHelpData_FindPageByName" (self As wxHtmlHelpData Ptr, page As wxString Ptr) As wxString Ptr
Declare Function wxHtmlHelpData_FindPageById WXCALL Alias "wxHtmlHelpData_FindPageById" (self As wxHtmlHelpData Ptr, id As wxInt) As wxString Ptr

' class wxHtmlBookRecArray (NOTE: that this does not return a copy but the value itself.)
Declare Function wxHtmlHelpData_GetBookRecArray WXCALL Alias "wxHtmlHelpData_GetBookRecArray" (self As wxHtmlHelpData Ptr) As wxHtmlBookRecArray Ptr
Declare Function wxHtmlBookRecords_GetCount WXCALL Alias "wxHtmlBookRecords_GetCount" (self As wxHtmlBookRecArray Ptr) As wxInt
Declare Function wxHtmlBookRecords_GetItem WXCALL Alias "wxHtmlBookRecords_GetItem" (self As wxHtmlBookRecArray Ptr, index As wxInt) As wxHtmlBookRecord Ptr

' class wxHtmlBookRecord
Declare Function wxHtmlBookrecord_GetBookFile WXCALL Alias "wxHtmlBookrecord_GetBookFile" (self As wxHtmlBookRecord Ptr) As wxString Ptr
Declare Function wxHtmlBookrecord_GetTitle WXCALL Alias "wxHtmlBookrecord_GetTitle" (self As wxHtmlBookRecord Ptr) As wxString Ptr
Declare Function wxHtmlBookrecord_GetStart WXCALL Alias "wxHtmlBookrecord_GetStart" (self As wxHtmlBookRecord Ptr) As wxString Ptr
Declare Function wxHtmlBookrecord_GetBasePath WXCALL Alias "wxHtmlBookrecord_GetBasePath" (self As wxHtmlBookRecord Ptr) As wxString Ptr
Declare Function wxHtmlBookrecord_GetFullPath WXCALL Alias "wxHtmlBookrecord_GetFullPath" (self As wxHtmlBookRecord Ptr, page As wxString Ptr) As wxString Ptr
Declare Function wxHtmlBookrecord_GetContentsStart WXCALL Alias "wxHtmlBookrecord_GetContentsStart" (self As wxHtmlBookRecord Ptr) As wxInt
Declare Function wxHtmlBookrecord_GetContentsEnd WXCALL Alias "wxHtmlBookrecord_GetContentsEnd" (self As wxHtmlBookRecord Ptr) As wxInt

' class wxHtmlHelpDataItems
Declare Function wxHtmlHelpData_BooksCount WXCALL Alias "wxHtmlHelpData_BooksCount" (self As wxHtmlHelpData Ptr) As wxInt
Declare Function wxHtmlHelpData_GetContentsArray WXCALL Alias "wxHtmlHelpData_GetContentsArray" (self As wxHtmlHelpData Ptr) As wxHtmlHelpDataItems Ptr
Declare Function wxHtmlHelpData_ContentsCount WXCALL Alias "wxHtmlHelpData_ContentsCount" (self As wxHtmlHelpData Ptr) As wxInt
Declare Function wxHtmlHelpData_GetIndexArray WXCALL Alias "wxHtmlHelpData_GetIndexArray" (self As wxHtmlHelpData Ptr) As wxHtmlHelpDataItems Ptr
Declare Function wxHtmlHelpDataItems_GetCount WXCALL Alias "wxHtmlHelpDataItems_GetCount" (self As wxHtmlHelpDataItems Ptr) As wxInt
Declare Sub wxHtmlHelpDataItems_SetVirtualDispose WXCALL Alias "wxHtmlHelpDataItems_SetVirtualDispose" (self As wxHtmlHelpDataItems Ptr, on_dispose As Virtual_Dispose)
Declare Function wxHtmlHelpDataItems_GetItem WXCALL Alias "wxHtmlHelpDataItems_GetItem" (self As wxHtmlHelpDataItems Ptr, index As wxInt) As wxHtmlHelpDataItem Ptr

' class wxHtmlHelpDataItem
Declare Function wxHtmlHelpDataItem_ctor WXCALL Alias "wxHtmlHelpDataItem_ctor" () As wxHtmlHelpDataItem Ptr
Declare Sub wxHtmlHelpDataItem_SetVirtualDispose WXCALL Alias "wxHtmlHelpDataItem_SetVirtualDispose" (self As wxHtmlHelpDataItem Ptr, on_dispose As Virtual_Dispose)
Declare Function wxHtmlHelpDataItem_GetLevel WXCALL Alias "wxHtmlHelpDataItem_GetLevel" (self As wxHtmlHelpDataItem Ptr) As wxInt
Declare Function wxHtmlHelpDataItem_GetParent WXCALL Alias "wxHtmlHelpDataItem_GetParent" (self As wxHtmlHelpDataItem Ptr) As wxHtmlHelpDataItem Ptr
Declare Function wxHtmlHelpDataItem_GetId WXCALL Alias "wxHtmlHelpDataItem_GetId" (self As wxHtmlHelpDataItem Ptr) As wxInt
Declare Function wxHtmlHelpDataItem_GetName WXCALL Alias "wxHtmlHelpDataItem_GetName" (self As wxHtmlHelpDataItem Ptr) As wxString Ptr
Declare Function wxHtmlHelpDataItem_GetPage WXCALL Alias "wxHtmlHelpDataItem_GetPage" (self As wxHtmlHelpDataItem Ptr) As wxString Ptr
Declare Function wxHtmlHelpDataItem_GetBook WXCALL Alias "wxHtmlHelpDataItem_GetBook" (self As wxHtmlHelpDataItem Ptr) As wxHtmlBookRecord Ptr
Declare Function wxHtmlHelpDataItem_GetFullPath WXCALL Alias "wxHtmlHelpDataItem_GetFullPath" (self As wxHtmlHelpDataItem Ptr) As wxString Ptr
Declare Function wxHtmlHelpDataItem_GetIndentedName WXCALL Alias "wxHtmlHelpDataItem_GetIndentedName" (self As wxHtmlHelpDataItem Ptr) As wxString Ptr

' class wxHtmlSearchStatus
Declare Function wxHtmlSearchStatus_CTor WXCALL Alias "wxHtmlSearchStatus_CTor" (pHelpData As wxHtmlHelpData Ptr, keyword As wxString Ptr, searchCaseSensitive As wxBool, searchWholeWords As wxBool, book As wxString Ptr) As wxHtmlSearchStatus Ptr
Declare Function wxHtmlSearchStatus_Search WXCALL Alias "wxHtmlSearchStatus_Search" (self As wxHtmlSearchStatus Ptr) As wxBool
Declare Function wxHtmlSearchStatus_IsActive WXCALL Alias "wxHtmlSearchStatus_IsActive" (self As wxHtmlSearchStatus Ptr) As wxBool
Declare Function wxHtmlSearchStatus_GetCurIndex WXCALL Alias "wxHtmlSearchStatus_GetCurIndex" (self As wxHtmlSearchStatus Ptr) As wxInt
Declare Function wxHtmlSearchStatus_GetMaxIndex WXCALL Alias "wxHtmlSearchStatus_GetMaxIndex" (self As wxHtmlSearchStatus Ptr) As wxInt
Declare Function wxHtmlSearchStatus_GetName WXCALL Alias "wxHtmlSearchStatus_GetName" (self As wxHtmlSearchStatus Ptr) As wxString Ptr
Declare Function wxHtmlSearchStatus_GetCurItem WXCALL Alias "wxHtmlSearchStatus_GetCurItem" (self As wxHtmlSearchStatus Ptr) As wxHtmlHelpDataItem Ptr

#EndIf ' __helpdata_bi__

