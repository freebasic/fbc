#Ifndef __document_bi__
#Define __document_bi__

#Include Once "common.bi"

'class wxDocument
Declare Function wxDocument_ctor WXCALL Alias "wxDocument_ctor" (parent As wxDocument Ptr) As wxDocument Ptr
Declare Sub wxDocument_SetFilename WXCALL Alias "wxDocument_SetFilename" (self As wxDocument Ptr, filename As wxString Ptr, notifyViews As wxBool)
Declare Function wxDocument_GetFilename WXCALL Alias "wxDocument_GetFilename" (self As wxDocument Ptr) As wxString Ptr
Declare Sub wxDocument_SetTitle WXCALL Alias "wxDocument_SetTitle" (self As wxDocument Ptr, title As wxString Ptr)
Declare Function wxDocument_GetTitle WXCALL Alias "wxDocument_GetTitle" (self As wxDocument Ptr) As wxString Ptr
Declare Sub wxDocument_SetDocumentName WXCALL Alias "wxDocument_SetDocumentName" (self As wxDocument Ptr, nam As wxString Ptr)
Declare Function wxDocument_GetDocumentName WXCALL Alias "wxDocument_GetDocumentName" (self As wxDocument Ptr) As wxString Ptr
Declare Function wxDocument_GetDocumentSaved WXCALL Alias "wxDocument_GetDocumentSaved" (self As wxDocument Ptr) As wxBool
Declare Sub wxDocument_SetDocumentSaved WXCALL Alias "wxDocument_SetDocumentSaved" (self As wxDocument Ptr, saved As wxBool)
Declare Function wxDocument_Close WXCALL Alias "wxDocument_Close" (self As wxDocument Ptr) As wxBool
Declare Function wxDocument_Save WXCALL Alias "wxDocument_Save" (self As wxDocument Ptr) As wxBool
Declare Function wxDocument_SaveAs WXCALL Alias "wxDocument_SaveAs" (self As wxDocument Ptr) As wxBool
Declare Function wxDocument_Revert WXCALL Alias "wxDocument_Revert" (self As wxDocument Ptr) As wxBool
Declare Function wxDocument_GetCommandProcessor WXCALL Alias "wxDocument_GetCommandProcessor" (self As wxDocument Ptr) As wxCommandProcessor Ptr
Declare Sub wxDocument_SetCommandProcessor WXCALL Alias "wxDocument_SetCommandProcessor" (self As wxDocument Ptr, cp As wxCommandProcessor Ptr)
Declare Function wxDocument_DeleteContents WXCALL Alias "wxDocument_DeleteContents" (self As wxDocument Ptr) As wxBool
Declare Function wxDocument_Draw WXCALL Alias "wxDocument_Draw" (self As wxDocument Ptr, dc As wxDC Ptr) As wxBool
Declare Function wxDocument_IsModified WXCALL Alias "wxDocument_IsModified" (self As wxDocument Ptr) As wxBool
Declare Sub wxDocument_Modify WXCALL Alias "wxDocument_Modify" (self As wxDocument Ptr,  modify As wxBool)
Declare Function wxDocument_AddView WXCALL Alias "wxDocument_AddView" (self As wxDocument Ptr, v As wxView Ptr) As wxBool
Declare Function wxDocument_RemoveView WXCALL Alias "wxDocument_RemoveView" (self As wxDocument Ptr, v As wxView Ptr) As wxBool
Declare Function wxDocument_GetViews WXCALL Alias "wxDocument_GetViews" (self As wxDocument Ptr) As wxList Ptr
Declare Function wxDocument_GetFirstView WXCALL Alias "wxDocument_GetFirstView" (self As wxDocument Ptr) As wxView Ptr
Declare Sub wxDocument_UpdateAllViews WXCALL Alias "wxDocument_UpdateAllViews" (self As wxDocument Ptr, sender As wxView Ptr, hint As wxObject Ptr)
Declare Sub wxDocument_NotifyClosing WXCALL Alias "wxDocument_NotifyClosing" (self As wxDocument Ptr)
Declare Function wxDocument_DeleteAllViews WXCALL Alias "wxDocument_DeleteAllViews" (self As wxDocument Ptr) As wxBool

' class wxDocManager
Declare Function wxDocument_GetDocumentManager WXCALL Alias "wxDocument_GetDocumentManager" (self As wxDocument Ptr) As wxDocManager Ptr
' clas wxDocTemplate
Declare Function wxDocument_GetDocumentTemplate WXCALL Alias "wxDocument_GetDocumentTemplate" (self As wxDocument Ptr) As wxDocTemplate Ptr
Declare Sub wxDocument_SetDocumentTemplate WXCALL Alias "wxDocument_SetDocumentTemplate" (self As wxDocument Ptr, template As wxDocTemplate Ptr)
Declare Function wxDocument_GetPrintableName WXCALL Alias "wxDocument_GetPrintableName" (self As wxDocument Ptr, nam As wxString Ptr) As wxBool
Declare Function wxDocument_GetDocumentWindow WXCALL Alias "wxDocument_GetDocumentWindow" (self As wxDocument Ptr) As wxWindow Ptr

#EndIf ' __document_bi__

