#Ifndef __findreplacedialog_bi__
#Define __findreplacedialog_bi__

#Include Once "common.bi"

' class wxFindReplaceDialog
Declare Function wxFindReplaceDialog_ctor WXCALL Alias "wxFindReplaceDialog_ctor" () As wxFindReplaceDialog Ptr
Declare Function wxFindReplaceDialog_Create WXCALL Alias "wxFindReplaceDialog_Create" (self   As wxFindReplaceDialog Ptr, _
                                parent As wxWindow Ptr, _
                                pData  As wxFindReplaceData Ptr, _
                                title  As wxString Ptr, _
                                style  As wxUInt) As wxBool
Declare Function wxFindReplaceDialog_GetData WXCALL Alias "wxFindReplaceDialog_GetData" (self As wxFindReplaceDialog Ptr) As wxFindReplaceData Ptr
Declare Sub wxFindReplaceDialog_SetData WXCALL Alias "wxFindReplaceDialog_SetData" (self As wxFindReplaceDialog Ptr, pData As wxFindReplaceData Ptr)

' class wxFindDialogEvent
Declare Function wxFindDialogEvent_ctor WXCALL Alias "wxFindDialogEvent_ctor" (commandType As wxEventType, id As wxInt) As wxFindDialogEvent Ptr
Declare Sub wxFindDialogEvent_SetFlags WXCALL Alias "wxFindDialogEvent_SetFlags" (self As wxFindDialogEvent Ptr, flags As wxInt)
Declare Function wxFindDialogEvent_GetFlags WXCALL Alias "wxFindDialogEvent_GetFlags" (self As wxFindDialogEvent Ptr) As wxInt
Declare Sub wxFindDialogEvent_SetFindString WXCALL Alias "wxFindDialogEvent_SetFindString" (self As wxFindDialogEvent Ptr, string_ As wxString Ptr)
Declare Function wxFindDialogEvent_GetFindString WXCALL Alias "wxFindDialogEvent_GetFindString" (self As wxFindDialogEvent Ptr) As wxString Ptr
Declare Sub wxFindDialogEvent_SetReplaceString WXCALL Alias "wxFindDialogEvent_SetReplaceString" (self As wxFindDialogEvent Ptr, string_ As wxString Ptr)
Declare Function wxFindDialogEvent_GetReplaceString WXCALL Alias "wxFindDialogEvent_GetReplaceString" (self As wxFindDialogEvent Ptr) As wxString Ptr
Declare Function wxFindDialogEvent_GetDialog WXCALL Alias "wxFindDialogEvent_GetDialog" (self As wxFindDialogEvent Ptr) As wxFindReplaceDialog Ptr

' class wxFindReplaceData
Declare Function wxFindReplaceData_ctor WXCALL Alias "wxFindReplaceData_ctor" (flag As wxUInt) As wxFindReplaceData Ptr
Declare Sub wxFindReplaceData_SetFindString WXCALL Alias "wxFindReplaceData_SetFindString" (self As wxFindReplaceData Ptr, string_ As wxString Ptr)
Declare Function wxFindReplaceData_GetFindString WXCALL Alias "wxFindReplaceData_GetFindString" (self As wxFindReplaceData Ptr) As wxString Ptr
Declare Sub wxFindReplaceData_SetReplaceString WXCALL Alias "wxFindReplaceData_SetReplaceString" (self As wxFindReplaceData Ptr, string_ As wxString Ptr)
Declare Function wxFindReplaceData_GetReplaceString WXCALL Alias "wxFindReplaceData_GetReplaceString" (self As wxFindReplaceData Ptr) As wxString Ptr
Declare Sub wxFindReplaceData_SetFlags WXCALL Alias "wxFindReplaceData_SetFlags" (self As wxFindReplaceData Ptr, flags As wxUint)
Declare Function wxFindReplaceData_GetFlags WXCALL Alias "wxFindReplaceData_GetFlags" (self As wxFindReplaceData Ptr) As wxUInt

#EndIf ' __findreplacedialog_bi__

