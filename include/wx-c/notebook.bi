#Ifndef __notebook_bi__
#Define __notebook_bi__

#Include Once "common.bi"

Declare Function wxNotebook_ctor WXCALL Alias "wxNotebook_ctor" () As wxNotebook Ptr
Declare Function wxNotebook_Create WXCALL Alias "wxNotebook_Create" (self As wxNotebook Ptr, _
                       parent  As wxWindow   Ptr     , _
                       id      As  wxWindowID     = -1, _
                       x       As  wxInt          = -1, _
                       y       As  wxInt          = -1, _
                       w       As  wxInt          = -1, _
                       h       As  wxInt          = -1, _
                       style   As  wxUInt         =  0, _
                       nameArg As wxString   Ptr = WX_NULL) As wxBool
Declare Function wxNotebook_AddPage WXCALL Alias "wxNotebook_AddPage" (self As wxNotebook Ptr, page As wxNotebookPage Ptr, txt As wxString Ptr, bSelect As wxBool, imageID As wxInt) As wxBool
Declare Sub wxNotebook_SetImageList WXCALL Alias "wxNotebook_SetImageList" (self As wxNotebookBase Ptr, imageList As wxImageList Ptr)
Declare Function wxNotebook_GetPageCount WXCALL Alias "wxNotebook_GetPageCount" (self As wxNotebook Ptr) As wxInt
Declare Function wxNotebook_GetPage WXCALL Alias "wxNotebook_GetPage" (self As wxNotebook Ptr, nPage As wxInt) As wxNotebookPage Ptr
Declare Function wxNotebook_GetSelection WXCALL Alias "wxNotebook_GetSelection" (self As wxNotebook Ptr) As wxInt
Declare Function wxNotebook_SetPageText WXCALL Alias "wxNotebook_SetPageText" (self As wxNotebook Ptr, nPage As wxInt, txt As wxString Ptr) As wxBool
Declare Function wxNotebook_GetPageText WXCALL Alias "wxNotebook_GetPageText" (self As wxNotebook Ptr, nPage As wxInt) As wxString Ptr
Declare Sub wxNotebook_AssignImageList WXCALL Alias "wxNotebook_AssignImageList" (self As wxNotebook Ptr, imageList As wxImageList Ptr)
Declare Function wxNotebook_GetImageList WXCALL Alias "wxNotebook_GetImageList" (self As wxNotebook Ptr) As wxImageList Ptr
Declare Function wxNotebook_GetPageImage WXCALL Alias "wxNotebook_GetPageImage" (self As wxNotebook Ptr, nPage As wxInt) As wxInt
Declare Function wxNotebook_SetPageImage WXCALL Alias "wxNotebook_SetPageImage" (self As wxNotebook Ptr, nPage As wxInt, nImage As wxInt) As wxBool
Declare Function wxNotebook_GetRowCount WXCALL Alias "wxNotebook_GetRowCount" (self As wxNotebook Ptr) As wxInt
Declare Sub wxNotebook_SetPageSize WXCALL Alias "wxNotebook_SetPageSize" (self As wxNotebook Ptr, size As wxSize Ptr)
Declare Sub wxNotebook_SetPadding WXCALL Alias "wxNotebook_SetPadding" (self As wxNotebook Ptr, padding As wxSize Ptr)
Declare Sub wxNotebook_SetTabSize WXCALL Alias "wxNotebook_SetTabSize" (self As wxNotebook Ptr, size As wxSize Ptr)
Declare Function wxNotebook_DeletePage WXCALL Alias "wxNotebook_DeletePage" (self As wxNotebook Ptr, nPage As wxInt) As wxBool
Declare Function wxNotebook_RemovePage WXCALL Alias "wxNotebook_RemovePage" (self As wxNotebook Ptr, nPage As wxInt) As wxBool
Declare Function wxNotebook_DeleteAllPages WXCALL Alias "wxNotebook_DeleteAllPages" (self As wxNotebook Ptr) As wxBool
Declare Function wxNotebook_InsertPage WXCALL Alias "wxNotebook_InsertPage" (self As wxNotebook Ptr, nPage As wxInt, page As wxNotebookPage Ptr, txt As wxString Ptr, bSelect As wxBool, imageID As wxInt) As wxBool
Declare Function wxNotebook_SetSelection WXCALL Alias "wxNotebook_SetSelection" (self As wxNotebook Ptr, nPage As wxInt) As wxInt
Declare Sub wxNotebook_AdvanceSelection WXCALL Alias "wxNotebook_AdvanceSelection" (self As wxNotebook Ptr, bForward As wxBool)

' class  wxNoteBookEvent
Declare Function wxNotebookEvent_ctor WXCALL Alias "wxNotebookEvent_ctor" (typ As wxEventType, id As wxInt, nSel As wxInt, nOldSel As wxInt) As wxNoteBookEvent Ptr
Declare Function wxNotebookEvent_GetSelection WXCALL Alias "wxNotebookEvent_GetSelection" (self As wxNoteBookEvent Ptr) As wxInt
Declare Sub wxNotebookEvent_SetSelection WXCALL Alias "wxNotebookEvent_SetSelection" (self As wxNoteBookEvent Ptr, nSel As wxInt)
Declare Function wxNotebookEvent_GetOldSelection WXCALL Alias "wxNotebookEvent_GetOldSelection" (self As wxNoteBookEvent Ptr) As wxInt
Declare Sub wxNotebookEvent_SetOldSelection WXCALL Alias "wxNotebookEvent_SetOldSelection" (self As wxNoteBookEvent Ptr, nOldSel As wxInt)

#EndIf ' __notebook_bi__

